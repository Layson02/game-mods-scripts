<a id="english"></a>

# Utility Scripts

**🌐 [Ler em Português](#portugues)**

**↩️ [Main README](../README.md)**

## 📋 Overview

Collection of utility scripts for automating recurring tasks on Windows. The current scripts use **FFmpeg** to compress `.mp4` videos with AMD hardware encoding.

## 🧩 Available Utilities

| Utility | Original Features | My Changes | Version |
| :--- | :--- | :--- | :--- |
| `comprimir_amf.bat` | Compresses `.mp4` files using FFmpeg and saves them in the `Compactados` folder. | Initial version of the video compression script. | 1.0 |
| `comprimir_amf v2.bat` | Compresses `.mp4` files using FFmpeg and saves them in the `Compactados` folder. | Adds a processing counter and a summary listing successfully processed files. | 2.0 |

## 🛠️ Requirements

- [FFmpeg](https://ffmpeg.org/) installed and available in the system `PATH`.
- An AMD GPU with AMF support.
- `.mp4` files in the same folder where the script is executed.

Tested with FFmpeg `2025-09-25-git-9970dc32bf-essentials_build-www.gyan.dev`.

## 📥 Installation and Usage

1. Install FFmpeg and add it to the Windows `PATH`.
2. Copy one of the scripts from the [`ffmpeg`](./ffmpeg/) folder to the folder containing the `.mp4` files.
3. Run the desired `.bat` file.
4. The compressed files will be created in the `Compactados` subfolder.

The scripts use the `hevc_amf` video encoder with a 4 Mbps bitrate and preserve the original audio stream. Existing files are not overwritten.

## ✅ Compatibility

Results may vary according to the FFmpeg version, AMD GPU, driver, and source video. The scripts currently process `.mp4` files and require AMF hardware encoding support.

## 📄 Credits and Licensing

The scripts use [FFmpeg](https://ffmpeg.org/). The repository's general license is available in [LICENSE](../LICENSE).

---

<a id="portugues"></a>

# Scripts Utilitários

**🌐 [Read in English](#english)**

**↩️ [README principal](../README.md)**

## 📋 Visão geral

Coleção de scripts utilitários para automatizar tarefas recorrentes no Windows. Atualmente, os scripts utilizam o **FFmpeg** para compactar vídeos `.mp4` usando codificação por hardware AMD.

## 🧩 Utilitários disponíveis

| Utilitário | Recursos originais | Minhas alterações | Versão |
| :--- | :--- | :--- | :--- |
| `comprimir_amf.bat` | Compacta arquivos `.mp4` usando o FFmpeg e salva os arquivos na pasta `Compactados`. | Versão inicial do script de compactação de vídeos. | 1.0 |
| `comprimir_amf v2.bat` | Compacta arquivos `.mp4` usando o FFmpeg e salva os arquivos na pasta `Compactados`. | Adiciona um contador de processamento e um resumo com os arquivos processados com sucesso. | 2.0 |

## 🛠️ Requisitos

- [FFmpeg](https://ffmpeg.org/) instalado e disponível no `PATH` do sistema.
- GPU AMD com suporte a AMF.
- Arquivos `.mp4` na mesma pasta em que o script for executado.

Testado com o FFmpeg `2025-09-25-git-9970dc32bf-essentials_build-www.gyan.dev`.

## 📥 Instalação e uso

1. Instale o FFmpeg e adicione-o ao `PATH` do Windows.
2. Copie um dos scripts da pasta [`ffmpeg`](./ffmpeg/) para a pasta que contém os arquivos `.mp4`.
3. Execute o arquivo `.bat` desejado.
4. Os arquivos compactados serão criados na subpasta `Compactados`.

Os scripts usam o codificador de vídeo `hevc_amf` com bitrate de 4 Mbps e preservam o áudio original. Arquivos existentes não são sobrescritos.

## ✅ Compatibilidade

Os resultados podem variar de acordo com a versão do FFmpeg, a GPU AMD, o driver e o vídeo de origem. Atualmente, os scripts processam arquivos `.mp4` e exigem suporte à codificação por hardware AMF.

## 📄 Créditos e licenças

Os scripts utilizam o [FFmpeg](https://ffmpeg.org/). A licença geral do repositório está disponível em [LICENSE](../LICENSE).
