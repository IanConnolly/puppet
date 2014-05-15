class runner::tasks::update_shared_repos($runlevel=3) {
    runner::task {
        "${runlevel}-update_shared_repos":
            source  => "puppet:///modules/runner/update_shared_repos";
    }
}
