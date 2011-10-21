package Config::Mini::WithRegexp;
use strict;
use warnings;

our $VERSION = '0.01_01';

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
=head1 NAME

Config::Mini::WithRegexp

=head1 DESCRIPTION

It is a extension format Config::Mini with supporting regex.

Betta version.

=head1 SYNOPSIS

    # example yours.ini
    [test]
    test = 12
    testre =~ /^(\d+)$/


    # in code
    my $cnf = Config::Mini::WithRegexp->new($file);
    # $cnf similar Config::Mini
    $cnf->regexp_prepare;
    my $test = '123';
    print $test =~ $cnf->section('test')->{testre} ? 1 : 0; # print 1
    $test = '123www';
    print $test =~ $cnf->section('test')->{testre} ? 1 : 0; # print 0

=head1 SOURSE

git@github.com:mrRico/p5-Config-Mini-WithRegexp.git

=head1 SEE ALSO

L<Config::Mini>

=head1 AUTHOR

mr.Rico <catamoose at yandex.ru>

=cut