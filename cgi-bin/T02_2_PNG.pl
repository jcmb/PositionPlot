#!/usr/bin/perl -w
$| = 1;

use CGI qw(param);
use CGI::Carp;
use File::Basename;

use LWP::Simple;

use JCMBSoft_Config;

#print JCMBSoft_Config::TrimbleTools();

sub urldecode {
    my $s = shift;
    $s =~ tr/\+/ /;
    $s =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/eg;
    return $s;
}


$CGI::POST_MAX = 1024 * 120000; # 150mb file max
my $query = new CGI;
my $safe_filename_characters = "a-zA-Z0-9_.-";

my $filename = $query->param('file');
my $file_link = $query->param('file_link');
my $Sol = $query->param('Sol');
my $Point = $query->param('Point');
my $Ant = $query->param('Ant');
my $Fixed_Range = $query->param('Range');

#$file_link="https://www.dropbox.com/s/yjupry9omdvm2og/6343_D5.T02?dl=0";

$Point = "0";
$Ant = "0";

my $project = $query->param('project');
my $Decimate = $query->param('Decimate');

my $TrimbleTools=1;

print $query->header (-charset=>'utf-8' );

if (defined ($project)) {
    if  ($project) {
        $project="/".$project;
        }
    else  {
        $project="";
        }
}
else {
    $project="";
}



if ( !$filename && !$file_link )
{
#    print $query->header ( );
    print "There was a problem uploading your GNSS file, or not file/file url not selected\n";
    exit;
}


if ( !$Sol )
{
#    print $query->header ( );
#    print "There was a problem getting the solution type\n";
#    exit;
    $Sol="-1";
}

if ( !$Point )
{
#    print $query->header ( );
#    print "There was a problem getting the solution type\n";
#    exit;
    $Point="-1";
}

if ( !$Ant )
{
#    print $query->header ( );
#    print "There was a problem getting the solution type\n";
#    exit;
    $Ant="-1";
}

if ( !$Fixed_Range )
{
#    print $query->header ( );
#    print "There was a problem getting the solution type\n";
#    exit;
    $Fixed_Range="0";
}


if ( !$Decimate )
{
#    print $query->header ( );
#    print "There was a problem getting the solution type\n";
#    exit;
    $Decimate="0";
}


#print $filename."\n";

my $file_uploaded=0;
my $file_linked=0;

if ($filename) {
    if ($filename=~m/^.*(\\|\/)(.*)/) {  # strip the remote path and keep the filename                                                                                                                                                      
        $filename=$2;
    }
   $file_uploaded=1

}

if ($file_link){
    $file_linked=1;
#    print "file link<br>";
#    print $file_link;
    $filename=urldecode($file_link);
#    print $filename;

    if ($filename=~m/^.*(\\|\/)(.*)/) {
        # strip the remote path and keep the filename                                                                                                                                                                                       
#       print "matched<br>";                                                                                                                                                                                                                
        $filename=$2;
        if ($filename=~m/^(.*)\?.*/) {
            $filename=$1;
        }

    }
}

my ( $name, $path, $extension ) = fileparse ( $filename, '\..*' );

$name =~ tr/ /_/;
$filename = $name . $extension;

$filename =~ tr/ /_/;
$filename =~ s/[^$safe_filename_characters]//g;

if ( $filename =~ /^([$safe_filename_characters]+)$/ )
{
    $filename = $1;
}
else
{
    die "Filename contains invalid characters";
}

#print "Content-type: text/html\n\n";
print "<html><head><title>Plotting GNSS Data</title>";
print "<base href=\"/results/Position$project/$name/\">";
print "<meta http-equiv=\"refresh\" content=\"30; url=/results/Position$project/$name/\">";
print "</head>";
print "<body><h1>Processing $filename:</h1>\n";

#print $filename."\n";

$upload_file = JCMBSoft_Config::upload_dir().$filename;

if ($file_uploaded) {
    print "Getting uploaded file<br>";
    my $upload_filehandle = $query->upload("file");

#print $upload_file;                                                                                                                                                                                                                        
    if (!open ( UPLOADFILE, ">$upload_file" )) {
        print "\n could not open output file".$upload_file;
        die "$!";
    }
# or die "$!";                                                                                                                                                                                                                              
    binmode UPLOADFILE;

    while ( <$upload_filehandle> )
    {
        print UPLOADFILE;
    }

    close UPLOADFILE;
}
#my $upload_file = "/home8/trimblet/public_html/cgi-bin/tmp/".$filename;
#my $upload_file = $filename;
my $upload_filehandle = $query->upload("file");

close UPLOADFILE;

#Content-type: text/html
#application/vnd.google-earth.kml+xml


if ($file_linked) {
    print "Getting file by url from " . $file_link."<br/>";
    system("curl -L --silent -o $upload_file $file_link")
}


print "Data is being processed: This will normally takes a few seconds but can take longer for very large files.<br>";
print "The report will be at \<a href=\"/results/Position$project/$name\"\>/results/Position$project/$name/\</a\>\n";
#print "The report will not have Summary, Spread or Latitude unless you use the link<br>\n";

#print "bash -c ./start_single.sh \"$upload_file\" \"$extension\" $Sol ";
#print system "./start_single.sh",$upload_file,$extension,$Sol;
print "<p/>Processing will continue if you navigate away from this page<br/>";
print "<pre>\n";


if ($JCMBSoft_Config::TrimbleTools) {
#    print "/bin/bash"," /home8/trimblet/public_html/cgi-bin/PositionPlot/start_single.sh"," ",$upload_file,"*",$extension,"*",$Sol,"*",$Point,"*",$Ant,"*",$TrimbleTools,"*",$Decimate,"*",$project,"*\n";
    print "</body>";
    print "</html>\n";
    exec ("/bin/bash","/home8/trimblet/public_html/cgi-bin/PositionPlot/start_single.sh",$upload_file,$extension,$Sol,$Point,$Ant,$Decimate,$Fixed_Range,$project);
}
else  
   {
   print "./start_single.sh"," ",$upload_file,"*",$extension,"*",$Sol,"*",$Point,"*",$Ant,"*",$Decimate,"*",$project,"*\n";
   system "./start_single.sh",$upload_file,$extension,$Sol,$Point,$Ant,$Decimate,$Fixed_Range,$project;
   }
