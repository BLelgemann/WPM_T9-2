#!/bin/bash

for Tabelle in *csv
do
	echo $Tabelle
	echo --
	head -n 2 $Tabelle
	echo --------------
done