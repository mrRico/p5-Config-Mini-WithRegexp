use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'Config::Mini::WithRegexp',
    VERSION_FROM      => 'lib/Config/Mini/WithRegexp.pm',
    PREREQ_PM         => {
        'Config::Mini' => 0
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Config/Mini/WithRegexp.pm',
       AUTHOR         => 'mrrico <mrrico@>') : ()),
);
