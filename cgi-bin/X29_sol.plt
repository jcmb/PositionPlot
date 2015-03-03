set datafile separator ","
set style data lines
set xlabel "GPS Seconds"
set grid ytics

set terminal png size 800,600

set yrange [-1:10]
#set ylabel "(Solution Type)"
set title name."Solution Type"
set ytics ( "Autonomous" 0, "RTCM" 1, "SBAS" 2, "Float" 3, "Fixed" 4, "OmniSTAR" 5, "Net Fixed" 6, "Net Float" 7, "Type 8" 8, "Kalman Auto" 9, "Old" 10 ) 
set output "Solution.png"
plot 'file' using ($2):($9) title "Solution"
quit