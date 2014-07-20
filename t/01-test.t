use Test::More;
use NoIp;
use HTTP::Tiny;

my $ua          = HTTP::Tiny->new;
my $res         = $ua->get( "http://checkip.dyndns.org" );
my $ip          = $res->{ content };
( $ip ) =  $ip  =~ m#.+body>Current IP Address: (.+)</body.+#g;
return if ! $ip || $ip eq "";

my $noip = NoIp->new(
    login       => '',
    password    => '',
    myip        => $ip,
    hostname    => ''   
);
use DDP;
warn p $noip->update_ip;

done_testing;
