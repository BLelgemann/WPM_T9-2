#!/bin/bash

# -----------------------------------------------------------------------
# AUFGABE: 
# aus der Datei "2020-05-23-Article_list_dirty.tsv" eine neue 
# Datei "2020-05-23-Dates_and_ISSNs.tsv" erstellen.

# Die neue Datei soll:
# 1. nur die Spalten der ISSN und Veröffentlichungsjahre enthalten
# 2. keine redundanten Zeilen haben

# BEFEHLE:
#   cut      -> arbeitet einzelne Spalten heraus
#   grep     -> greift Zeilen aus Textdateien heraus 
#   sed      -> ermöglicht, Textdateien direkt zu berbeiten
#   sort     -> sortiert Ergebnisse
#   uniq     -> löscht doppelte Zeilen

# -------------------------------------------------------------------------
# SKRIPT:

# Nachdem ich die Originaldatei in meinem git-Repositorium abgespeichert habe,
# schaue ich sie in der Bash mithilfe des folgenden Befehls an: 

less 2020-05-23-Article_list_dirty.tsv

# Dabei stelle ich fest, dass die Spalten 5 (ISSN) und 12 (Date) die für mich
# relevanten sind. Diese filtere ich heraus und lege die Ergebnisse in 
# einer neuen Datei ab:

cat 2020-05-23-Article_list_dirty.tsv | cut -f 5,12 > twocolumns.tsv

# Der Befehl "cat" liest dabei die Ursprungsdatei aus, "cut" schneidet die Spalten  
# aus und ">" speichert die gefilterten Daten in der neuen Datei "twocolumns.tsv" ab.
# Durch das Pipe-Zeichen werden die Befehle miteinander verbunden und nacheinander 
# ausgeführt.

# Die neue Datei schaue ich mir wieder im Pager an:

less twocolumns.tsv

# Dabei stelle ich fest, dass es eine Anzahl von Fehlern in der Auflistung gibt: 
#   1. in einigen Zeilen steht das Wort "ISSN" vor der ISSN-Nummer
#   2. einige Zeilen enthalten in der ersten Spalte das Wort "eng" und in der  
#      zweiten Spalte Zahlen die eindeutig keine ISSN-Nummer darstellen.
#   3. größere Lücken bzw. Leerzeilen zwischen den relevanten Zeilen

# (Fehler Nr.2 deutet darauf hin, dass etwas in den Spalten in der Ursprungsdatei
# verrutscht ist. Dies müsste eigentlich zunächst bereinigt werden, da sonst wichtige 
# Daten verloren gehen, wenn man diese Zeilen einfach bereinigt. Dies kann an
# dieser Stelle aber nicht geleistet werden.)

# Zunächst möchte ich die Spalte ISSN von überflüssigen Wörtern bereinigen. 
# Ich nutze den befehl "sed", um die Datei direkt bearbeiten zu können, 
# nach dem Muster "sed s/wort/andereswort/g".
#  "s" bestimmt das Wort, das ich bereinigen will,
#  "g" ("global") ersetzt dies durch den Wert, der davor steht. 
# Das Ergebnis speichere ich in eine neue Datei.

sed s/ISSN:/ /g;s/Issn:/ /g;s/issn:/ /g twocolumns.tsv > cleanfile_step1.tsv

# Dieser Befehl funktioniert nicht. Die Datei wird zwar angelegt, ist aber leer.
# Der Grund ist, dass ohne einfache Anführungszeichen das zweite und dritte "s"
# und die danach genannten Worte als Verzeichnisse erkannt werden.

sed 's/ISSN:/ /g;s/Issn:/ /g;s/issn:/ /g' twocolumns.tsv > cleanfile_step1.tsv

# Nun wurden die Worte entfernt und das Ergebnis in "cleanfile_step1" abgespeichert.
# Allerdings sind die Zeilen nicht ganz sauber, weil sie durch die Leerzeichen
# eingerückt sind.
# Deshalb werden die Leerstellen am Anfang der Zeile mit 's/^[ \t]*//' entfernt.

sed 's/^[ \t]*//' cleanfile_step1.tsv > cleanfile_step2.tsv

# Nun geht es darum, die Zeilen zu entfernen, die nicht die richtigen Daten enthalten 
# (siehe Fehler Nr. 2). Hierfür benutze ich den Befehl "grep", der die Zeilen aufruft,
# und die Option -v, die die Ausgabe von grep negiert. 
# Das Ergebnis speichere ich in einer weiteren Zwischendatei.

cat cleanfile_step2.tsv | grep eng -v > cleanfile_step3.tsv

# Zum Schluss müssen noch die übrig gebliebenen Leerzeilen entfernt werden.
# Hierfür sortiere ich die Datei mit "sort" und lösche dann doppelte
# Zeilen mit "uniq". (Die Datei muss vor der Verwendung von uniq sortiert 
# werden, weil uniq nur aufeinander folgende doppelte Zeilen entdeckt.)
# Zudem werden mit der Option -n die Zeien nach ihrem numerischen Wert
# sortiert und mit der Option -u  nur Zeilen ausgegeben, die nicht
# mehrfach vorkommen.

sort -n cleanfile_step3.tsv | uniq -u > cleanfile_step4.tsv

# Ich überprüfe das Ergebnis mit "cat".
# Zum Abschluss speichere ich die bereinigte Datei als Enddatei ab.

cp cleanfile_step4.tsv 2020-05-23-Dates_and_ISSNs.tsv