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
                'https://github.com/catlee/runner/archive/master.zip',
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

# Make sure runner runs at boot
class runner::service {
    include runner::settings
    case $::operatingsystem {
        'CentOS': {
            # Which service this relies on
            $initd_required_start = 'network'
            file {
                '/etc/init.d/runner':
                    content => template('runner/runner.initd.erb'),
                    mode    => '0755';
            }
            service {
                'runner':
                    require   => [
                        Python::Virtualenv[$runner::settings::root],
                    ],
                    hasstatus => false,
                    enable    => true;
            }
        }
        default: {
            fail("Unsupported OS ${::operatingsystem}")
        }
    }
}

class runner::settings {
    case $::operatingsystem {
        'CentOS': {
            $root = '/opt/runner'
        }

        default: {
            fail("Unsupported OS ${::operatingsystem}")
        }
    }
    $taskdir = "${root}/tasks.d"
    $configdir = "${root}/config.d"
}

define runner::config($sectionname, $data) {
    include runner::settings
    file {
        "${runner::settings::configdir}/${title}":
            before  => Service['runner'],
            content => template('runner/config.erb');
    }
}

define runner::task($content=undef, $source=undef) {
    include runner::settings
    file {
        "${runner::settings::taskdir}/${title}":
            before  => Service['runner'],
            content => $content,
            source  => $source,
            mode    => '0755';
    }
}
