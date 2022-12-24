#!/usr/bin/env-bash

if [[ $# -ne 2]]
then 
		echo "Deux argument attendus: <dossier> <langue>"
		exit
fi

folder=$1																			#dumps text OU contextes
basename=$2 																	# nom du fichier html sans extension : en, fr, it, jp, etc. 

echo "<lang=\"$basename\">"											# 

for filepath in $(ls $folder\$basename *.txt) 					#chemin vers le fichier 
do
		# filepath == dumps-texts\fr-1.txt
		#	==> pagename = fr-1
		pagename=$(basename -s .txt $filepath)				#l'argument de page
		echo "<page=\$pagename\">"											# on récupère le nom base
		echo "<text>"

# on récupère les dumps/contextes
# et on écrit à l'intérieur de la balise texte"		
content=$(cat $filepath)
# ordre important  : & en premier
# sinon : < => &lt; => &amp;lt;
content=$(echo $content" | sed 's/&/&amp;/g')
content=$(echo $content" | sed 's/</&lt;/g')
content=$(echo $content" | sed 's/>/&gt;/g')

echo "$content"

		echo "<\text<"
		echo"<\page>§"
done


echo "<\lang>"