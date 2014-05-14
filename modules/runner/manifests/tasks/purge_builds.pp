class runner::tasks::purge_builds($runlevel=1) {
    # Requires tools checked out
    include runner::tasks::checkout_tools

    runner::task {
        "${runlevel}-purge_builds":
            source  => "puppet:///modules/runner/purge_builds";
    }
}
