e=0
n=-0
h=-0


set datafile separator ","
set terminal png size 800,600
set grid ytics

set xrange [0:hrange]
set xlabel "Error (m)"
set ylabel "Perecentage"

set title name."Northing Error cumulative"
set output "N_Error_cumulative.png"
plot 'file' using (abs($11-n)) : ((100.0/records)) title "Northing Error" smooth cumulative

set title name."Easting Error cumulative"
set output "E_Error_cumulative.png"
plot 'file' using (abs($12-e)) : ((100.0/records)) title "Easting Error" smooth cumulative

set title name."2D Error cumulative"
set output "2D_Error_cumulative.png"
plot 'file' using (sqrt((($11-n)**2)+(($12-e)**2))) : ((100.0/records)) title "2D" smooth cumulative



set xrange [0:vrange]
set title name."Vertical Error cumulative"
set output "U_Error_cumulative.png"
plot 'file' using (abs($13-h)) : ((100.0/records)) title "Vertical Error" smooth cumulative

set xrange [*:*]

set style data lines
set xlabel "GPS Seconds"

set output "SVs.png"
set title name."SVs Tracked "

set yrange [0:*]
set ylabel "SV's"

plot \
    'file' using ($2):($4) title "Tracked", \
    'file' using ($2):($5) title "Used"

set ylabel "(m)"
set yrange [-hrange:hrange]

set output "N_Error.png"
set title name."Northing Error "
plot 'file' using ($2):($11-n) title "Northing Error"

set title name."Easting Error"
set output "E_Error.png"
plot 'file' using ($2):($12-e) title "Easting Error"

set title name."2D Error"
set output "2D_Error.png"
plot 'file' using ($2):(sqrt((($11-n)**2)+(($12-e)**2))) title "2D"

set yrange [-vrange:vrange]
set title name."Height Error"
set output "U_Error.png"
plot 'file' using ($2):($13-h) title "V Err"

set yrange [0.00:vrange]
set title name."Height ABS Error"
set output "U_abs_Error.png"
plot 'file' using ($2):(abs($13-h)) title "V Err"

set yrange [0.00:D3Range]

set title name."3D Error"
set output "3D_Error.png"
plot \
   'file' using ($2):( sqrt((($13-h)**2) + (($11-n)**2)+(($12-e)**2))) title "3D"

set title name."All Errors"
set output "All_Error.png"
plot \
   'file' using ($2):(sqrt((($11-n)**2)+(($12-e)**2))) title "2D", \
   'file' using ($2):(abs($13-h)) title "V Err", \
   'file' using ($2):( sqrt((($13-h)**2) + (($11-n)**2)+(($12-e)**2))) title "3D"

set yrange [0:hrange]
set title name."2D Error Vs Prec"
set output "2D_Prec.png"
plot  \
   'file' using ($2):(sqrt((($24)**2)+(($24)**2))) title "H Prec", \
   'file' using ($2):(sqrt((($11-n)**2)+(($12-e)**2))) title "2D Err"

set yrange [0:vrange]

set title name."1D Error Vs Prec"
set output "1D_Prec.png"
plot  \
   'file' using ($2):($25) title "V Prec", \
   'file' using ($2):(abs($13-h)) title "V Err"

set yrange [0:hrange]
set title name."2D Error Vs 3*Prec"
set output "2D_3Prec.png"
plot  \
   'file' using ($2):(sqrt((($24)**2)+(($24)**2)*3)) title "H Prec*3", \
   'file' using ($2):(sqrt((($11-n)**2)+(($12-e)**2))) title "2D Err"

set yrange [0:vrange]

set title name."1D Error Vs Prec*3"
set output "1D_3Prec.png"
plot  \
   'file' using ($2):($25*3) title "V Prec*3", \
   'file' using ($2):(abs($13-h)) title "V Err"

set yrange [0:hrange]
set title name."2D Error Vs Sigma"
set output "2D_Sigma.png"
plot  \
   'file' using ($2):(sqrt((($24)**2)+(($24)**2))) title "H Sigma", \
   'file' using ($2):(sqrt((($18-n)**2)+(($17-e)**2))) title "2D Err"


set yrange [0:vrange]

set title name."1D Sigma"
set output "1d_Sigma.png"
plot  \
   'file' using ($2):($25) title "V Sigma"

set title name."1D Sigma * Unit Var"
set output "1d_Sigma_unit.png"
plot  \
   'file' using ($2):($25*sqrt($27)) title "V Sigma"



set yrange [0:hrange]
set title name."2D Sigma"
set output "2d_Sigma.png"
plot  \
   'file' using ($2):(sqrt((($24)**2)+(($24)**2))) title "H Sigma"

set title name."2D Sigma * Unit Var"
set output "2d_Sigma_unit.png"
plot  \
   'file' using ($2):(sqrt((($24)**2)+(($24)**2)*sqrt($27))) title "H Sigma"

set title name."2D Sigma * Unit Var Vs Prec"
set output "2d_Sigma_unit_prec.png"
plot  \
   'file' using ($2):(sqrt((($24)**2)+(($24)**2))) title "H Sigma", \
   'file' using ($2):((sqrt((($24)**2)+(($24)**2)))*sqrt($28)) title "H Sigma Unit Var"

set yrange [0:hrange]

set title name."1D Sigma * Unit Var Vs Prec"
set output "1d_Sigma_unit_prec.png"
plot  \
   'file' using ($2):($25) title "V Prec", \
   'file' using ($2):($25*sqrt($28)) title "V Prec Unit"


set ylabel "(Seconds)"
set yrange [0:10]
set output "Latency.png"
set title name."Latency"
if (latency == 0) set label 1 "Latency not available for this solution type" at 0,5
if (latency == 1) plot 'file' using ($2):($29) title "Latency"
if (latency == 0) plot 0



quit
