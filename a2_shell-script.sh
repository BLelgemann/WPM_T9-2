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

#   less 2020-05-23-Article_list_dirty.tsv

# Dabei stelle ich fest, dass die Spalten 5 (ISSN) und 12 (Date) die für mich
# relevanten sind. 

# Außerdem stelle ich fest, dass die Informationen in ein paar Zeilen 
# um 2 Spalten verrutscht sind. Dies muss ich zunächst korrigieren,
# damit ich beim Ausschneiden der Spalten keine relevanten Informationen
# verliere. Die Korrektur nehme ich mit dem befehl "sed" vor,
# mit dem ich die Datei direkt bearbeiten kann: 

cat 2020-05-23-Article_list_dirty.tsv | sed 's/IMPORTANT!\{0,1\}\t\t//' > cleanstep1.tsv


# "s" bestimmt, was ausgetauscht werden soll: 
# Das Wort "IMPORTANT" oder "IMPORTANT!", das in der Zeile steht, 
# wird durch "nichts" - also "//" - ersetzt. "{0,1}" bestimmt, 
# dass das Ausrufezeichen entweder vorhanden sein kann oder nicht.
# Da die Spalten in der tsv-Datei durch Tab-Zeichen - also "\t" - erstellt 
# werden, können diese Zeichen ebenfalls durch "nichts" ersetzt werden.

# Die Ausgabe schaue ich mir im Pager an:
   # less clean_step1.tsv

# Dabei stelle ich fest, dass es Zeilen gibt, in denen am Anfang 
# das Zeichen "#" oder "MAYBE" steht, die aber ansonsten leer sind.
# Mit dem Befehl "grep -v" entferne ich jeweils diese Zeilen und 
# speichere die gefilterten Daten in der neuen Datei "clean_step2.tsv" ab:

cat cleanstep1.tsv | grep -v '^#' | grep -v '^MAYBE' > cleanstep2.tsv

# "grep" greift die gewünschten Zeilen heraus und "-v" negiert diese,
# so dass die Daten ohne diese Zeilen neu abgespeichert werden.
# Das ^-Zeichen gibt an, dass diese Zeichen am Anfang der Zeile stehen.
# Durch das Pipe-Zeichen werden die Befehle miteinander verbunden 
# und nacheinander ausgeführt. 

# Die neue Datei schaue ich mir wieder im Pager an:
   # less clean_step2.tsv

# Anschließend sollen die für mich relevanten Spalten herausgefiltert und 
# die Ergebnisse wieder in einer neuen Datei abgelegt werden. 

cat cleanstep2.tsv | cut -f 5,12 > cleanstep3.tsv

# Die neue Datei schaue ich mir wieder im Pager an:
   # less clean_step3.tsv

# Dabei stelle ich fest, dass in einigen Zeilen das Wort "ISSN" 
# vor der ISSN-Nummer steht, in unterschiedlicher Schreibweise. 
# Dies bereinige ich wieder mit dem Befehl "sed":

cat cleanstep3.tsv | sed 's/issn:*//i' | sed 's/^[ \t]*//' > cleanstep4.tsv

# das *-Zeichen gibt an, dass die Position überall in der Zeile sein kann.
# "i" bestimmt, dass Groß- und Kleinschreibung nicht beachtet wird.
# Mit dem Befehl "sed 's/^[ \t]*//'" werden im Anschluss die übrig 
# gebliebenen Leerzeichen entfernt.

# Die neue Datei schaue ich mir wieder im Pager an:
   # less clean_step4.tsv

# Nun müssen noch die Zeilen sortiert ("sort") werden, damit die 
# Leerzeilen verschwinden, und doppelte Zeilen entfernt werden ("uniq"):

cat cleanstep4.tsv | sort | uniq > cleanstep5.tsv

# Zum Schluss werden die Spaltennamen entfernt und die 
# Datei in ihrer Enddatei gespeichert:

cat cleanstep5.tsv | grep -v '^Date' > 2020-05-23-Dates_and_ISSNs.tsv
