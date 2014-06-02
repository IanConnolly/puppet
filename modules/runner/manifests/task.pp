# a task to be run by runner
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
