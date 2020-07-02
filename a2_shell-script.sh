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
#   sed      -> entfernt Zeilen
#   sort     -> sortiert Ergebnisse
#   uniq     ->

# PARAMETER:
#   -n       -> Anzahl von Zeilen
#   -f       -> Spalte bzw. "field"
#   -c       -> zählen
#   -ci      -> Wörter zählen, ohne auf Groß- und Kleinschreibung zu achten
#   -l       -> lange Version
#    >       -> Ergebnisse in eine Datei speichern
#    >>      -> etwas an eine Datei anhängen, ohne diese zu überschreiben
#  (date -I) -> beim speichern der Datei das Datum angeben

# -------------------------------------------------------------------------
# SKRIPT-Erstellung:

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
#  1. in einigen Zeilen steht das Wort "ISSN" vor der ISSN-Nummer
#  2. einige Zeilen enthalten das Wort "eng" und irrelevante Zahlen
#  3. größere Lücken bzw. Leerzeilen zwischen den relevanten Zeilen





