#!/usr/bin/env bash


fichier_urls=$1 # le fichier d'URL en entrée
lignenum=1;
cible="种族歧视"
while read URL || [[ -n $URL ]];
do
	echo "fichier $lignenum est en cours de traitement."
	curl -o ../../aspirations/chinois/ch-$lignenum.html $URL
	w3m $URL > ../../dumps-text/chinois/ch-$lignenum.txt
	grep -E -A3 -B3 $cible ../../dumps-text/chinois/ch-$lignenum.txt > ../../contexte/chinois/ch-$lignenum.txt

	echo "
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Concordances</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
	</head>
			<body>
				<table class="table">
					<thead>
						<tr>
						<th class=\"has-text-right\">Contexte gauche</th>
						<th>Cible</th>
						<th class=\"has-text-left\">Contexte droit</th>
						</tr>
					</thead>
					<tbody>
	" > ../../concordances/chinois/concordance_ch-$lignenum.html
	w3m -cookie $URL | grep -E -o "(\w+|\W+){0,10}$cible(\W+|\w+){0,10}" |sort|uniq | sed -E "s/(.*)($cible)(.*)/<tr><td class="has-text-right">\1<\/td><td class="has-text-centered"><strong>\2<\/strong><\/td><td class="has-text-left">\3<\/td><\/tr>/" >> ../../concordances/chinois/concordance_ch-$lignenum.html
	echo "
	</tbody>
	</table>
	</body>
	</html>
	" >> ../../concordances/chinois/concordance_ch-$lignenum.html
	lignenum=$((lignenum+1));
done < $fichier_urls
exit




