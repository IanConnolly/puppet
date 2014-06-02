# settings for runner
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
