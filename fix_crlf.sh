#!/bin/bash

# Verzeichnisse, die geprüft werden sollen
targets=(
  "$HOME/.config/nvim"
  "$HOME/.local/share/nvim"
)

echo "Suche nach Dateien mit Windows-Zeilenenden (CRLF)..."

for dir in "${targets[@]}"; do
  if [ -d "$dir" ]; then
    find "$dir" -type f -exec grep -Il $'\r' {} + | while read -r file; do
      echo "Konvertiere: $file"
      dos2unix "$file"
    done
  else
    echo "Verzeichnis nicht gefunden: $dir"
  fi
done

echo "Fertig."

