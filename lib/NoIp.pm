package NoIp;
use Moose;
use HTTP::Tiny;
use HTTP::Request::Common;
use MIME::Base64 qw|encode_base64|;

has [qw|login password hostname myip|] => ( is => "rw" );
has url_update_noip => ( 
    is      => 'rw', 
    default => sub { 
        'http://dynupdate.no-ip.com/nic/update' 
    } 
);

sub update_ip {
    my ( $self ) = @_; 
    my $ua = HTTP::Tiny->new;
    my $query_str =  POST '',
        [ 
            hostname    => $self->hostname,
            myip        => $self->myip
        ];
    my $auth_b64 = encode_base64( $self->login . ":" . $self->password );
    my $url      = $self->url_update_noip.'?'.$query_str->content;
    my $res      = $ua->request( "GET", $url , {
        headers => {
            Authorization => "Basic " . $auth_b64
        }
    } );
    return $res;
}


1;
