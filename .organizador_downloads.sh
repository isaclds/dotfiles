#!/bin/bash
# Pasta que será monitorada
PASTA_DOWNLOADS="$HOME/Downloads"

# Função para mover os arquivos por tipo
organizar() {
    cd "$PASTA_DOWNLOADS" || exit

    # Garante que as pastas de destino existem
    mkdir -p "$PASTA_DOWNLOADS/Imagens" \
             "$PASTA_DOWNLOADS/Logs" \
             "$PASTA_DOWNLOADS/Documentos" \
             "$PASTA_DOWNLOADS/Compactados" \
             "$PASTA_DOWNLOADS/Audios_Videos" \
             "$PASTA_DOWNLOADS/Programas"

    # Imagens
    mv -n *.jpg *.jpeg *.png *.gif *.svg "$HOME/Downloads/Imagens/" 2>/dev/null
    # Logs
    mv -n *CallLog* *CallLog*.* *log* *.*log* *.log "$HOME/Downloads/Logs/" 2>/dev/null
    # Documentos
    mv -n *.pdf *.docx *.xlsx *.pptx *.txt "$HOME/Downloads/Documentos" 2>/dev/null
    # Compactados
    mv -n *.zip *.tar.gz *.tgz *.rar *.7z "$HOME/Downloads/Compactados/" 2>/dev/null
    # Audios/Videos
    mv -n *.mp3 *.mp4 *.wav "$HOME/Downloads/Audios_Videos" 2>/dev/null
    # Programas/Instaladores
    mv -n *.deb *.sh *.run "$HOME/Downloads/Programas/" 2>/dev/null
}

# Executa uma vez ao iniciar
organizar

# Monitora a pasta permanentemente por novos arquivos finalizados
inotifywait -m -e close_write --format '%f' "$PASTA_DOWNLOADS" | while read ARQUIVO
do
    # Aguarda 2 segundos para garantir que o download foi concluído
    sleep 2
    organizar
done
