while true; do
ARCHIVO=$(find entrada -maxdepth 1 -type f -print -quit)
  if [ -n "$ARCHIVO" ]; then
    echo "$(cat "$ARCHIVO")" >> "salida/${FILENAME}.txt"
    echo "$(date '+%d/%m/%Y %H:%M:%S') - Procesado archivo $(basename "$ARCHIVO")" >> procesado.log
    mv "$ARCHIVO" procesado
  else
    echo "boca"
    break
  fi
  sleep 5
done &