use Test::More;
use File::Spec;
use Cwd 'abs_path';

    pass('*' x 10);
    pass('Config::Mini::WithRegexp');
    
    # use
    use_ok('Config::Mini::WithRegexp');
    can_ok('Config::Mini::WithRegexp','new');
    
    # create instance
    my $cnf = Config::Mini::WithRegexp->new(File::Spec->catfile(sub {local @_ = File::Spec->splitpath(abs_path(__FILE__)); $_[$#_] = 'conf.ini'; @_}->()));
    isa_ok($cnf, 'Config::Mini::WithRegexp');
    can_ok($cnf,'section');        
    isa_ok($cnf->section('cgi'), 'CGI::Cookie');
    isa_ok($cnf->section('test'), 'HASH');
    is($cnf->section('test')->{test}, 12, 'check int');
    is($cnf->section('test')->{testre}, '~ /^(\d+)$/', 'check str');
    
    # check new specific
    can_ok($cnf,'regexp_prepare');
    isa_ok($cnf->regexp_prepare, 'Config::Mini::WithRegexp');
    isa_ok($cnf->section('test')->{testre}, 'Regexp');
    my $test = '12';
    is($test =~ $cnf->section('test')->{testre} ? 1 : 0 , 1, 'check re');
    $test = '12www';
    is($test =~ $cnf->section('test')->{testre} ? 1 : 0 , 0, 'check re');
    is($cnf->section('test')->{test}, 12, 'check int');
    
    pass('*' x 10);
    print "\n";
    done_testing;
