# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
# Make sure runner runs at boot
class runner::tasks::buildbot($runlevel=4) {
    #include packages::mozilla::psutil
    include runner

    runner::task {
        "${runlevel}-buildbot.py":
            content  => template('runner/buildbot.py.erb');
    }
}
