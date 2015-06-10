#!/bin/bash

echo Pages Not Found: > missing-pages.txt

url="http://london.secret.rca.ac.uk/2015/postcards/?filter=number&page="

for i in {1..250}
do
	# Fetch the status code
	header=$( curl "$url$i" -w %{http_code} -s --output /dev/null $1)
	echo Page $i header: $header

	if [ $header -eq 404 ]; then
		echo  - Unable to get page $i
		echo $i >> missing-pages.txt	
	else	
		content="$(curl -s "$url$i" -o "pages/$i.html" )"
	fi

done

