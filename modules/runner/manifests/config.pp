# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
# config file for runner
define runner::config($sectionname, $data) {
    include runner::settings
    file {
        "${runner::settings::configdir}/${title}":
            before  => Service['runner'],
            content => template('runner/config.erb');
    }
}
