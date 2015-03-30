#!/usr/bin/perl -w

use strict;
use LWP;
use URI;
use Getopt::Long;


sub usage{
	print "Usage: $0 -i id_number -p password\n"
}

my $ID ;
my $PASS ;

die &usage unless GetOptions("id=s"=>\$ID,
	 	   	     "password=s"=>\$PASS,
  		  );
   
die &usage if not defined $ID or  not defined $PASS;

my $main_page = "http://132.72.140.75/F";
my $browser = LWP::UserAgent->new();
my $data_file = "$ENV{'HOME'}/.html/libagent/".$ID.".html";

#first, get the main libraries page.
my $response = $browser->get($main_page);
die "cannot open libraries page" unless $response->is_success();
my $data = $response->content();

#now, enter arrane library.
$data =~ m{<a href=(.*)>\s*Aranne Library};
die "could not find arrane library link" unless $1;
my $arrane_url = $1;
$arrane_url =~ s/amp;//g;

#print "arrane url is:". $arrane_url ."\n";
#now, login to the arrane library
$response = $browser->get($arrane_url);
die "cannot open aranne page" unless $response->is_success();
$data = $response->content();
$data =~ m{<a href=(".*")\s+class.*>\s*Your Library Card};
die "could not find login link" unless $1;
my $login_url = $1;
$login_url =~ s/amp;//g;

#print "login url: ".$login_url ."\n";

#get the login page:
$response = $browser->get($login_url);
die "cannot open login page" unless $response->is_success();
$data = $response->content();


#now, parse the response to get the action of the login form:
$data =~ m{.*action=("http.*")>};
die "cannot find login form action. sorry" unless $1;
my $action_url = $1;

#now, POST the login information:
$response = $browser->post($action_url,
                           [
                            'func' => 'login-session',
                            'login_source' => 'LOGIN-BOR',
                            'bor_library' => 'BGU50',
                            'bor_id' => $ID,
                            'bor_verification' => $PASS,
                            ]);
die "cannot login, sorry" unless $response->is_success() ;
$_ = $response->content() ;
if (/ID or verification field/){
  die "wrong password or id";
}

#now, get the renew loans link:
$data = $response->content();
$data =~ m{(http://dahab.*func=bor-loan)} ||
  die "cannot find the view link $1";

$response = $browser->get($1);
die "cannot open renew page" unless $response->is_success();

#now, get the renew all link:
$data = $response->content();
$data =~ m{(http://dahab.*func=bor-renew-all)} ||
  die "cannot find the renew-all link $1";


#renew, and output the result page:
$response = $browser->get($1);
die "cannot renew " unless $response->is_success();

open DATA_FILE, "> $data_file" or die " cant open output file";
chmod oct('0755'), $data_file;

print DATA_FILE $response->content();

print "http://www.cs.bgu.ac.il/~tzachar/libagent/".$ID.".html\n";
