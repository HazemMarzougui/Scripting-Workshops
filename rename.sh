#!/bin/bash


function show_usage {
    echo "Usage: rename.sh [-h|--help] [-t] [-T] [-n] [-N] [-d] [-m] [-s] chemin.."
}


function HELP {
    cat HELP.txt
}

function to_lower {
    for file in "$@"
    do
        mv -v "$file" "$(echo "$file" | tr '[:upper:]' '[:lower:]')"
    done
}


function rename_spaces {
    for file in "$@"
    do
        if [[ "$file" == *" "* ]]; then
            mv -v "$file" "${file// /}"
        fi
    done
}


function remove_extension {
    for file in "$@"
    do
        mv -v "$file" "${file%.*}"
    done
}

function to_uppercase() {
    for f in "$@"; do
        mv "$f" "${f^^}"
    done
}

function add_d() {
    for d in "$@"; do
        mv "$d" "${d}_d"
    done
}


function add_extension() {
    local file="$1"
    local extension="$2"
    mv "$file" "${file}.${extension}"
}


while getopts "hvmT:t:n:N:d:s:" option; do
    case $option in
        h | help)
            HELP
            exit;;
        v)
            echo "La version utiliséé est par Marzougui Hazem  1.0  "
            exit;;
        m)
while true
do
            echo "Menu:"
  echo "     1/ Help"
  echo "     2/ Convertir en miniscules"
  echo "     3/ Supprimer les espaces"
  echo "     4/ Enlever l'extension"
  echo "     5/ Convertir en majuscules"
  echo "     6/ Ajouter '_d'"
  echo "     7/ Ajouter une extension"
  echo "     8/ Quitter"
            read -p "Choisissez une option   : " choice
            case $choice in
1)
  HELP;;
2)
  read -p "Nom du fichier ou répoertoire: " file
  to_lower "$file";;
3)
  read -p "Nom du fichier: " file
  rename_spaces "$file";;
4)
  read -p "Nom du fichier: " file
  remove_extension "$file";;
                5)
  read -p "Nom du fichier ou répertoire: " file
                    to_uppercase "$file";;
                6)
  read -p "Nom du répertoire: " file
                    add_d "$file";;
                7)
                    read -p "Nom du fichier: " file
                    read -p "Extension: " extension
                    add_extension "$file" "$extension";;
8)
 exit 1;;
                *)
                    echo "Option invalide";;
            esac
done;;
T)
to_lower "$OPTARG";;
t)
rename_spaces "$OPTARG";;
n)
remove_extension "$OPTARG";;
N)
to_uppercase "$OPTARG";;
d)
add_d "$OPTARG";;
s)
add_extension "${OPTARG%.*}" "${OPTARG##*.}";;
\?)
echo "Option invalide"
show_usage
            exit;;
    esac
done
if [ $OPTIND -eq 1 ]; then show_usage; fi
