#!/usr/bin/env bash

#---TRAITEMENT---

fichier_urls=$1
linenum=1;
cible="racial discrimination"
while read -r url || [[ -n $url ]];
do
	echo "fichier $linenum en cours de traitement."
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
				<table>
					<thead>
						<tr>
						<th class=\"has-text-right\">Contexte droit</th>
						<th>Cible</th>
						<th class=\"has-text-left\">Contexte gauche</th>
						</tr>
					</thead>
					<tbody>
	" > cn-$linenum.html
	w3m -cookie $url | grep -E -o "(\w+|\W+){0,10}$cible(\W+|\w+){0,10}" |sort|uniq | sed -E "s/(.*)($cible)(.*)/<tr><td>\1<\/td><td><strong>\2<\/strong><\/td><td>\3<\/td><\/tr>/" >> cn-$linenum.html
	echo "
	</tbody>
	</table>
	</body>
	</html>
	" >> cn-$linenum.html
	linenum=$((linenum+1));
done < $fichier_urls
exit



#

