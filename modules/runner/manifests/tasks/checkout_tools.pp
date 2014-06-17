class runner::tasks::checkout_tools($runlevel=0) {
    include packages::mozilla::hgtool
    file {
        '/tools/checkouts':
             ensure => directory,
             owner  => $::config::builder_username,
             group  => $::config::builder_username;
     }
    runner::task {
        "${runlevel}-checkout_tools":
            require => [
                Class['packages::mozilla::hgtool'],
                File['/tools/checkouts'],
            ],
            source  => 'puppet:///modules/runner/checkout_tools';
    }
}
