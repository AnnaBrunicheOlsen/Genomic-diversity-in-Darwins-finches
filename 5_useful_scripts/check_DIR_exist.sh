cat 120_birds_original.txt | while read -r LINE

do

if [ ! -d "$LINE" ]; 
then
	echo "$LINE doesnt exist"
fi

done

