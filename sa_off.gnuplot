

set terminal pngcairo size 1600,720 background rgb 'black'
set output "sa_off.png"

#set title 'GPS Selective Available (SA) switch off, 2 May 2000' textcolor rgb 'white'

#set multiplot layout 1,2 title 'GPS Selective Available (SA) switch off, 2 May 2000'
set multiplot layout 1,2 margin 0.1,0.9,0.15,0.9

set label 1 "GPS Selective Availability (SA) switch-off, 04:00 UTC 2 May 2000" center textcolor rgb "white" font "Arial,20" at screen 0.5,0.95
set label 2 'Joe Desbonnet   See https://github.com/jdesbonnet/GPS\_SA\_switch\_off for details.' at screen 0.1,0.05 font ",11" tc rgb "white"
#set label 3 "https://github.com/jdesbonnet/GPS_SA_switch_off" at graph -0.05,-0.10 font ",8" tc rgb "white"

set style fill transparent solid 0.3 noborder
set style fill noborder

set style line 1 linecolor rgb "green"
set style line 2 linecolor rgb "blue"


set border lc rgb 'white'
set key tc rgb 'white'

set grid lc rgb 'white' linewidth 2

PI = 3.14159265359
ER = 6378137

# The 'actual' location of the receiver
refLat = 53.32495
refLon = -6.2596
klon = 111132.854 * cos(PI*refLat/180) 





## https://stackoverflow.com/questions/639695/how-to-convert-latitude-or-longitude-to-meters
## m_per_deg_lat = 111132.954 - 559.822 * cos( 2 * latMid ) + 1.175 * cos( 4 * latMid);
## m_per_deg_lon = 111132.954 * cos ( latMid );




##
## Deviation plot (meters)
##

set origin 0,0
set size 0.5,1
set xrange [-80:80]
set yrange [-80:80]
set xlabel "meters west-east" textcolor rgb "white"
set ylabel "meters south-north" textcolor rgb "white"
plot "< gunzip -c gps_sa_off_pre_transition.dat.gz" using (($5-refLon)*klon):( ($4-refLat) * 111111) linecolor rgb "#2020ff"  \
title 'SA on' \
,"< gunzip -c gps_sa_off_post_transition.dat.gz" using (($5-refLon)*klon):( ($4-refLat) * 111111) linecolor rgb "red"  \
title 'SA off' 


##
## South/North deviation as function of time
##
unset label 2
unset label 3
unset title
set xrange [0:10]
set yrange [-80:80]

set xlabel "Hours UTC, 2 May 2000" textcolor rgb "white"
set ylabel "meters south-north"
unset ylabel
set origin 0.5,0
set size 0.5,0.5
plot "< gunzip -c gps_sa_off_pre_transition.dat.gz" using (($2/3600)-48):( ($4-refLat) * 111111) linecolor rgb "#2020ff"  \
title 'SA on' with lines \
,"< gunzip -c gps_sa_off_post_transition.dat.gz" using (($2/3600)-48):( ($4-refLat) * 111111) linecolor rgb "red"  \
title 'SA off' with lines


set origin 0.5,0.5
set size 0.5,0.5
set ylabel "W/E meters"

#plot "< gunzip -c gps_sa_off_pre_transition.dat.gz" using ($2/3600):(($5-refLon)*klon) linecolor rgb "blue"  \
#title 'SA on' with lines \
#,"< gunzip -c gps_sa_off_post_transition.dat.gz" using ($2/3600):(($5-refLon)*klon) linecolor rgb "red"  \
#title 'SA off' with lines


unset multiplot



#pause -1 
