#! /bin/bash

E_NO_ARGS=65

USAGE="Usage: $0 Project GNSSFile1 GNSSFile2 .. GNSSFileN"

if [ $# -eq 0 ]  # Must have command-line args to demo script.
then
  echo $USAGE
  exit $E_NO_ARGS
fi

PROJECT=$1
shift

while (( "$#" )); do
    curl  -F project=$PROJECT -F file=@$1 http://gnssplot.eng.trimble.com/cgi-bin/PositionPlot/T02_2_PNG.pl > $1.html
    shift
    open $1.html
done