# Malis19 SS 2020 
### Modul WPM T9 - Data Science (Aufgabe 2)

#### Dozent: Prof. Dr. Konrad Förstner
#### Autorin: Britta Lelgemann
--------------------------------------------------------------------------

### Aufgabe Python-Script:

Das erarbeitete Skript beantwortet folgende Fragen:

* Frage 1: Wieviele E-Books wurden im Jahr 2019 im Vergleich zu physischen Büchern ausgeliehen?
* Frage 2: Wieviele digitale Medien wurden insgesamt im Jahr 2019 im Vergleich zu physischen Medien ausgeliehen?
* Frage 3: Wieviele digitale Medien wurden im April 2019 im Vergleich zu April 2020 ausgeliehen?
* Frage 4: Welches Medium wurde 2019 am meisten ausgeliehen?
* Frage 5: Wie haben sich die Ausleihen über die Jahre 2006 bis 2020 verteilt?

Das Skript beinhaltet Kommentare zur Erstellung. 
Die Datei ist hier abgelegt: https://github.com/BLelgemann/WPM_T9-2/blob/master/a2_python.ipynb

### Aufgabe Shell-Script:

Das Skript ist folgendermaßen aufgebaut:

cat 2020-05-23-Article_list_dirty.tsv | 
sed 's/IMPORTANT!\{0,1\}\t\t//' | 
grep -v '^#' | grep -v '^MAYBE' | 
cut -f 5,12 | 
sed 's/issn:*//i' |
sed 's/^[ \t]*//' | 
grep -v '^Date' > 2020-05-23-Dates_and_ISSNs.tsv

Die Erstellung des Skripts mit den einzelnen Zwischenschritten wird in folgender Datei beschrieben:
https://github.com/BLelgemann/WPM_T9-2/blob/master/a2_shell-script.sh
Diese Datei kann zudem als Skript ausgeführt werden.
