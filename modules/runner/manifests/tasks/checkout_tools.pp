class runner::tasks::checkout_tools($runlevel=0) {
    include packages::mozilla::hgtool
    runner::task {
        "${runlevel}-checkout_tools":
            require => Package["packages::mozilla::hgtool"],
            source  => "puppet:///runner/checkout_tools");
    }
}
