#!/bin/bash
echo $1 $2 $3 $4 $5 $6 $7 $8 $9
echo $@
#stdbuf -o L ./plot_single_cgi.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 $10&
stdbuf -o L ./plot_single_cgi.sh $@&
disown
