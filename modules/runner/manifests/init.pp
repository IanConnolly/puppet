# runner module
class runner {
    include runner::service
    include runner::settings
    include packages::mozilla::python27

    python::virtualenv {
        $runner::settings::root:
            python   => $packages::mozilla::python27::python,
            require  => Class['packages::mozilla::python27'],
            packages => [
                'runner==1.0',
            ];
    }

    file {
        $runner::settings::taskdir:
            ensure => directory;
        $runner::settings::configdir:
            ensure => directory;
        "${runner::settings::root}/runner.cfg":
            before  => Service['runner'],
            content => template('runner/runner.cfg.erb');
    }
}
