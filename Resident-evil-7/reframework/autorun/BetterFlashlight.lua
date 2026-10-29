if reframework:get_game_name() ~= "re7" then
    re.msg("[Better Flashlight] Only compatible with Resident Evil 7!")
    return
end

local settings_file = "BetterFlashlight.json"
local settings = json.load_file(settings_file) or {}

local defaults = {
    flashlight_on = false,
    brightness = 1.0,
    radius = 1.0,
    range = 1.0,
}

for k, v in pairs(defaults) do
    if settings[k] == nil then
        settings[k] = v
    end
end

local function save()
    json.dump_file(settings_file, settings)
end

local function player()
    local mgr = sdk.get_managed_singleton("app.ObjectManager")
    return mgr and mgr:get_field("PlayerObj")
end

local type_cache = {}
local function component(go, type_name)
    local t = type_cache[type_name] or sdk.typeof(type_name)
    type_cache[type_name] = t
    return t and go:call("getComponent(System.Type)", t)
end

local function flashlight()
    local pl = player()
    if not pl then return nil, nil end

    local hand_light = component(pl, "app.PlayerHandLight")
    if not hand_light then return nil, nil end

    local controller = hand_light:get_field("HandLightPowerController")
    if not controller then return hand_light, nil end

    return hand_light, controller:get_field("_Light")
end

local base_radius, base_cone, base_range, base_intensity

local gamepad_type = sdk.find_type_definition("via.hid.GamePad")
local gamepad_singleton = sdk.get_native_singleton("via.hid.GamePad")
local gamepad_button
local gamepad
local button_down_since
local button_was_toggled = false

pcall(function()
    gamepad_button = via.hid.GamePadButton.Cancel
end)

if not gamepad_button then
    pcall(function()
        local button_type = sdk.find_type_definition("via.hid.GamePadButton")
        if button_type then
            gamepad_button = button_type:get_field("Cancel"):get_data(nil)
        end
    end)
end

re.on_application_entry("UpdateHID", function()
    gamepad = nil

    if gamepad_singleton and gamepad_type then
        pcall(function()
            gamepad = sdk.call_native_func(
                gamepad_singleton,
                gamepad_type,
                "get_LastInputDevice"
            )
        end)

        if not gamepad then
            pcall(function()
                gamepad = sdk.call_native_func(
                    gamepad_singleton,
                    gamepad_type,
                    "get_Device"
                )
            end)
        end
    end
end)

re.on_frame(function()
    local button_down = false
    if gamepad and gamepad_button then
        pcall(function()
            button_down = gamepad:call("isDown", gamepad_button)
        end)
    end

    if button_down then
        button_down_since = button_down_since or os.clock()
        if not button_was_toggled and os.clock() - button_down_since >= 1.0 then
            settings.flashlight_on = not settings.flashlight_on
            save()
            button_was_toggled = true
        end
    else
        button_down_since = nil
        button_was_toggled = false
    end

    local hand_light, light = flashlight()
    if not hand_light then return end

    local on = settings.flashlight_on and 1 or 0
    hand_light.ActionRequest = on
    hand_light.EnterHandLightPowerOnZoneCount = on

    if not light then return end

    base_radius = base_radius or light:call("get_Radius") or 1.7
    base_cone = base_cone or light:call("get_Cone") or 70.0
    base_range = base_range or light:call("get_ReferenceEffectiveRange") or 15.0
    base_intensity = base_intensity or light:call("get_Intensity") or 2000.0

    light:call("set_Radius", base_radius * settings.radius)
    light:call("set_Cone", base_cone * settings.radius)
    light:call("set_ReferenceEffectiveRange", base_range * settings.range)
    light:call("set_Intensity", base_intensity * settings.brightness)
end)

re.on_draw_ui(function()
    if not imgui.tree_node("Better Flashlight") then return end

    imgui.text("Hold Xbox B for toggle the flashlight.")
    imgui.text_colored(settings.flashlight_on and "Currently ON" or "Currently OFF",
        settings.flashlight_on and 0xFF00FF00 or 0xFF888888)

    local changed

    changed, settings.brightness = imgui.slider_float("Brightness", settings.brightness, 0.5, 10.0)
    if changed then save() end

    changed, settings.radius = imgui.slider_float("Radius", settings.radius, 0.5, 10.0)
    if changed then save() end

    changed, settings.range = imgui.slider_float("Range", settings.range, 0.5, 10.0)
    if changed then save() end

    if imgui.button("Reset") then
        settings.brightness = 1.0
        settings.radius = 1.0
        settings.range = 1.0
        save()
    end

    imgui.tree_pop()
end)