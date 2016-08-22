#!/usr/bin/python
#GNSS_TRUTH.py
#print  "GNSS_TRUTH"
import sqlite3
import argparse

parser = argparse.ArgumentParser(description='Return information for a point.')
parser.add_argument("Pt_Id", help="The Point ID that you want information on")
args = parser.parse_args()

execfile("/usr/lib/cgi-bin/PositionPlot/db.TRUTH.inc.py")

#print "After Load"

class DB_Class:

    def __init__(self):
        self.conn=None
        pass;

    def open (self):

        try:
           self.conn = sqlite3.connect(databaseFile())
        #   print databaseFile()+ " Open\n"
        except sqlite3.Error:
           print "Error opening db. " + databaseFile() +"\n"
           quit()

        self.conn.row_factory = sqlite3.Row
        self.GNSS   = self.conn.cursor()

    def read_GNSS_Settings (self,Pt_Id):
        query = 'SELECT * FROM GNSS_Truth where Pt_Id="' + str(Pt_Id) + '"'
        self.GNSS.execute(query);
        row = self.GNSS.fetchone()

        if row:
            self.Lat=row["Lat"]
            self.Long=row["Long"]
            self.Height=row["Height"]
            self.Pt_Id=row["Pt_Id"]
            self.Solution=row["Solution"]
            return True
        else:
            return False


#print(args.Pt_Id)

DB=DB_Class()
DB.open()
if DB.read_GNSS_Settings(args.Pt_Id.upper()) :
    print "Lat="+str(DB.Lat)+";Long="+str(DB.Long)+";Height="+str(DB.Height)+";Sol="+str(DB.Solution)
    quit (0)
else:
    quit(1)
#    print "Point " + args.Pt_Id + " is not in the Database"
