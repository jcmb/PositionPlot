BEGIN {
   FS=",";
   for (i=0;i<=20;i++) {
      Pos[i] = 0;
      HRange[i] = .05;
      VRange[i] = .05;
      Latency[i] = 1;
     }
   Name[0]="Autonomous";
   HRange[0]=5;
   VRange[0]=10;
   Latency[0] = 0;

   Name[1]="RTCM";
   HRange[1]=2;
   VRange[1]=5;
   Latency[1] = 0;

   Name[2]="SBAS";
   HRange[2]=2;
   VRange[2]=5;
   Latency[2] = 0;

   Name[3]="Float";
   Name[4]="Fixed";

   Name[5]="OmniSTAR";
   HRange[5]=.2;
   VRange[5]=.5;
   Latency[5] = 0;

   Name[6]="Net Fixed";
   Name[7]="Net Float";
   Name[8]="Type 8";
   Name[9]="Kalman Auton";
   Name[10]="Kalman DGNSS";
   Name[11]="Type 11";
   Name[12]="Type 12";
   Name[13]="Type 13";
   Name[14]="Type 14";
   Name[15]="RTX";
   Name[16]="Type 16";
   Name[17]="Type 17";
   Name[18]="Type 18";
   
   Max_Index = -1;

#Returns the solution type with the largest count. -1 for no records
if (ARGC == 2 && ARGV[1] !="-1") {
    Max_Index = ARGV[1];
    ARGV[1]="";
    exit
    }
   }

{

Pos[$9]++;
}

END {
 Max = 0;
 for (i=0;i<=20;i++) {
    if (Pos[i] > Max) {
	Max = Pos[i];
        Max_Index = i;
        }
    }
 print "Sol=" Max_Index ";\n";
 print "Sol_Name=\"" Name[Max_Index] "\";\n";
 print "Sol_HRange=" HRange[Max_Index] ";\n";
 print "Sol_VRange=" VRange[Max_Index] ";\n";
 print "Sol_Latency=" Latency[Max_Index] ";\n";
}
