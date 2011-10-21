use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'Config::Mini::WithRegexp',
    VERSION_FROM      => 'lib/Config/Mini/WithRegexp.pm',
    PREREQ_PM         => {
        'Config::Mini' => 0
    }
);
