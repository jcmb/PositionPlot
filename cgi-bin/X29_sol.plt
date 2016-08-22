set datafile separator ","
set style data lines
set xlabel "GPS Seconds"
set grid ytics

set terminal png size 800,600 noenhanced
set xlabel "GPS Time"

set xdata time
set timefmt "%s"
set format x "%H:%M"

set yrange [-1:16]
#set ylabel "(Solution Type)"
set title name."Solution Type"
set ytics ( "Autonomous" 0, "RTCM" 1, "SBAS" 2, "Float" 3, "Fixed" 4, "OmniSTAR" 5, "Net Fixed" 6, "Net Float" 7, "Type 8" 8, "Kalman Auto" 9, "Kalman DGNSS" 10, "Type 11" 11, "Type 12" 12, "Type 13" 13, "Type 14" 14, "RTX" 15 ) 
set output "Solution.png"
plot 'file' using ($2):($9) title "Solution"
quit