#!/bin/bash

# Usage: ./c-download-images.sh file-list.txt

echo Images Not Found: > missing-images.txt
echo Images Found: > completed-images.txt

url="http://london.secret.rca.ac.uk/media/images"

while read line
do
	arr=($line)
	cardNum=${arr[0]}
	link=${arr[1]}

	# Fetch the status code
	header=$( curl "$url/$link.jpeg" -w %{http_code} -s --output /dev/null $1)
	echo Card $cardNum: $header

	if [ "$header" = "404000" ] || [ "$header" = "403000" ]; then
		header2=$( curl "$url/$link.jpg" -w %{http_code} -s --output /dev/null $1)
		echo Card $cardNum - 2nd Attempt: $header2

		if [ "$header2" = "404000" ] || [ "$header2" = "403000" ]; then
			echo $cardNum >> missing-images.txt
		else
			echo $cardNum - with no 2015 url >> completed-images.txt
			content="$(curl -s "$url/$link.jpg" -o "images/$cardNum.jpg")"
		fi
	else
		echo $cardNum >> completed-images.txt	
		content="$(curl -s "$url/$link.jpeg" -o "images/$cardNum.jpeg")"
	fi

done < $1
