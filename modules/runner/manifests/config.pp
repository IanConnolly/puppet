# config file for runner
define runner::config($sectionname, $data) {
    include runner::settings
    file {
        "${runner::settings::configdir}/${title}":
            before  => Service['runner'],
            content => template('runner/config.erb');
    }
}
