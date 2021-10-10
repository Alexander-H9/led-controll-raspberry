#!/bin/bash

 

KEY="AIzaSyDm8KPJCRmszwkD8TS2A2_fIehBwvwyiBc"

URL="https://www.google.com/speech-api/v2/recognize?output=json&lang=de-de&key=$KEY"

echo "Aufnahme... Zum stoppen STRG+C drücken und warten."

arecord -D plughw:1,0 -f cd -t wav -d 0 -c 1 -q -r 44100 | flac - -s -f --best -o file.flac;
#arecord -D plughw:1,0 -f cd -t wav -d 0 -q -r 44100 | flac - -s -f --best --sample-rate 44100 -o file.flac;

echo ""

echo "Ausführen..."

wget -q -U "Mozilla/5.0" --post-file file.flac --header "Content-Type: audio/x-flac; rate=44100" -O - "$URL" >stt.txt

 

echo -n "Google Antwort: "

OUTPUT=$(cat stt.txt  | sed -e 's/[{}]/''/g' | awk -F":" '{print $4}' | awk -F"," '{print $1}' | tr -d '\n')

 

echo $OUTPUT

echo ""

 

rm file.flac  > /dev/null 2>&1

 

strindex() {

  x="${1%%$2*}"

  [[ $x = $1 ]] && echo -1 || echo ${#x}

}

 

# Damit Groß- und Kleinschreibung ignoriert wird.

# Falls wichtig, nächste Zeile auskommentieren

OUTPUT=$(echo $OUTPUT | tr '[:upper:]' '[:lower:]')

 

# Die zu suchende Zeichenkette muss klein geschrieben sein

# (ansonsten den Befehl vorher auskommentieren)

python blink.py "$OUTPUT"

if (($(strindex "$OUTPUT" "licht an") != -1));  then

  # Befehle ausführen, Skripte starten, etc.

  echo "bash: Licht wird eingeschaltet"
  #python blink.py $OUTPUT

fi

if (($(strindex "$OUTPUT" "licht aus") != -1));  then

  echo "bash: Licht wird ausgeschaltet"
  #python blink.py $OUTPUT

fi
