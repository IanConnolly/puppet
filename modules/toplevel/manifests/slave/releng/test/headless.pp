# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class toplevel::slave::releng::test::headless inherits toplevel::slave::releng::test {
    include runner::tasks::checkout_tools
    include runner::tasks::purge_builds
    include runner::tasks::update_shared_repos
    class {
        gui:
            on_gpu => false,
            screen_width => 1600,
            screen_height => 1200,
            screen_depth => 32,
            refresh => 60;
    }
}
