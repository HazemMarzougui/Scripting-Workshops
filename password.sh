#!/bin/bash

version="1"
copyright="Marzougui Hazem"


function afficheHelp {
cat aide.txt
}

function afficheVersion {
echo "Verify Password , Version : $version"
echo "Copyright : $copyright"
}

function verifPass {
    read -p "Enter your password: " password


    if [ ${#password} -lt 8 ]; then
        echo  "Mot de passe est trop court (moins de 8 caractères)"
    else

        if ! [[ "$password" =~ [0-9] ]]; then
            echo  "Le mot de passe doit contenir des lettres et des chiffres"   
    else
   
	if ! [[ $password =~ [@#$%*+=-] ]]; then
    echo "Le mot de passe doit contenir au moins un caractère non alphabétique, numérique et figurant : @, #, $, %, &, *, +, -, =."
    else
     echo "Mot de Passe est valide"
    fi
     fi
      fi
}


function menu() {
  echo "Menu:"
  echo "-v : Afficher le nom des auteurs et version du code."
  echo "-t : Vérification du mot de passe introduit."
  echo "-h : Afficher le help détaillé à partir d’un fichier texte"
  echo "-m : Menu textuel"
}



while  getopts "hvtm" option;
do
case $option in
h) afficheHelp
;;
v) afficheVersion
;;
t) verifPass
;;
m) menu
;;
esac
done
