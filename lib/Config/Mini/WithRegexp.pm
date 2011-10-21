package Config::Mini::WithRegexp;
use strict;
use warnings;

our $VERSION = '0.01';

use base 'Config::Mini';
use Scalar::Util qw();

sub regexp_prepare {
    my Config::Mini $self = shift;
    
    $self->{$_} = _regexp_prepare($self->{$_}) for keys %$self;
    
    return $self;
}

sub _regexp_prepare {
    my $token = shift;
    my $type = Scalar::Util::reftype($token);
    unless ($type) {
        unless ($token) {
            return $token;
        } else {
            my $cp = $token; 
            if ($cp =~ s/^~\s*// and $cp) {
                $token = eval('qr'.$cp);
            }
            return $token;
        }
    } else {
        if (Scalar::Util::blessed($token)) {
            # don't touch created object
            return $token;
        } elsif ($type eq 'HASH') {
            $token->{$_} = _regexp_prepare($token->{$_}) for keys %$token;
            return $token; 
        } elsif ($type eq 'ARRAY') {
            $_ = _regexp_prepare($_) for @$token;
            return $token;
        } else {
            return $token;
        }
    }
}

1;
__END__
