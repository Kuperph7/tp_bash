#!/bin/bash

opcion=0

while [ "$opcion" -ne 7 ]
do
    echo "1) Crear entorno"
    echo "2) Correr proceso"
    echo "3) Mostrar alumnos ordenados por padrón"
    echo "4) Mostrar las 10 notas más altas"
    echo "5) Buscar alumno por número de padrón"
    echo "6) Visualizar log"
    echo "7) Salir"

    read -p "Ingrese una opción: " opcion

    case $opcion in
        1)
            if [ ! -d "EPNro1" ]; then
                mkdir EPNro1
                cd EPNro1
                mkdir entrada
                mkdir salida
                mkdir procesado
                cd ..
                mv consolidar.sh EPNro1
                mv ${FILENAME}.txt EPNro1/salida
                echo "Entorno creado correctamente."
            else
                echo "El entorno EPNro1 ya existe."
            fi
            ;;
        2)
            echo "Correr proceso"
            cd EPNro1
            bash consolidar.sh
            cd ..
            ;;
        3)
            if [ -f "EPNro1/salida/${FILENAME}.txt" ]; then
            cd EPNro1/salida/
            sort -n ${FILENAME}.txt
            cd ../..
            else
            echo "No hay archivo"
            fi
            ;;
        4)
            if [ -f "EPNro1/salida/${FILENAME}.txt" ]; then
            cd EPNro1/salida/
            sort -k5,5nr "${FILENAME}.txt" | head -n 10
            cd ../..
            else
            echo "No hay archivo"
            fi
            ;;
        5)
            padron=0
            read -p "Ingrese una padrón: " padron
            if grep -q "^${padron} " "EPNro1/salida/${FILENAME}.txt"; then
                grep "^${padron} " "EPNro1/salida/${FILENAME}.txt"
            else
                echo "El padrón no existe"
            fi
            ;;
        6)
            cd EPNro1
            cat "procesado.log"
            cd ..
            ;;
        7)
            echo "Saliendo..."
            ;;
        *)
            echo "Opción inválida"
            ;;
    esac
done

if [ $1="-d" ]; then
    cd EPNro1
    kill consolidar.sh
    mv consolidar.sh ..
    ## Sacr archivos
    cd ..
    rm EPNro1
fi