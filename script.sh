#!/bin/bash

if [ $# -lt 1 ]; then
echo "Pas d'argument"
exit 1
fi  
for dir in "$@"; do
if [ ! -d "$dir" ]; then
echo "$dir n'est pas un repertoire/fichier valide"
else
echo "les droits d'acces pour $dir sont: $(stat -c '%A' "$dir")"
echo "le groupe propriètaire de $dir est : $(stat -c '%G:%u' "$dir")"
echo "la taille totale occupe de $dir est : $(du  -sh "$dir"| cut -f1)"
echo "la taille occupe par  les fichiers/repertoires cachès est : $(du -sh "$dir"/ .[!.]* | cut  -f1)"
echo " le nombre de fichiers/repertoires non vide   est : $(find  "$dir" -type f | wc -l)"
echo  " le petits fichiers  : $(find "$dir" -type f -size -512k | wc  -l)"
echo " le  gros  fichiers : $(find "$dir" -type f -size +15M | wc -l)"
echo " le nombre de fichiers/repertoires vide est : $(find "$dir" -type f -empty | wc -l)"
echo " le nombre de fichier python est : $(find "$dir" -name "*.py" | wc -l )"
echo " le nombre de fichier html est : $(find "$dir" -name  "*.html" | wc -l )"
echo " les types de fichiers  dans "$dir" : $(find "$dir" -type f -printf "%f\n" | cut -d . -f 2-| sort | uniq -c)"
echo "Nombre de fichiers pour $dir : $(find $dir -type f | wc -l)"
echo "Nombre de répertoires (non vides) pour $dir : $(find $dir -mindepth 1 -type d -not -empty | wc -l)"
echo "Nombre de liens symboliques pour $dir : $(find $dir -type l | wc -l)"
echo "Nombre de petits fichiers (moins de 512ko) pour $dir : $(find $dir -type f -size -512k | wc -l)"
echo "Nombre de gros fichiers (plus de 15 Mo) pour $dir : $(find $dir -type f -size +15M | wc -l)"
echo "Nombre de fichiers vides pour $dir : $(find $dir -type f -empty | wc -l)"
echo "Nombre de répertoires vides pour $dir : $(find $dir -type d -empty | wc -l)"
echo "Nombre de fichiers Python pour $dir : $(find $dir -type f -name '*.py' | wc -l)"
echo "Nombre de fichiers HTML pour $dir : $(find $dir -type f -name '*.html' | wc -l)"
echo "Types de fichiers pour $dir : $(find $dir -type f | cut -d . -f 2- | sort | uniq -c | sort -nr | head -n 5)"
echo "Noms de fichiers et droits d'accès pour $dir :"
ls -l $dir
echo "Noms de fichiers et propriétaires pour $dir :"
ls -l $dir | awk '{print $9,$3}'
echo "Changement de nom du répertoire $dir en minuscule..."
mv $dir $(echo $dir | tr '[:upper:]' '[:lower:]')
echo "Archivage des fichiers dans un fichier tar pour $dir ..."
tar -czvf $dir.tar.gz $dir
echo "Opérations terminées pour $dir."
fi 
done
