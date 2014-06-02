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
