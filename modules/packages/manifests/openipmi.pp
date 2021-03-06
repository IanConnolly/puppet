# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class packages::openipmi {
    case $::operatingsystem {
        CentOS: {
            package {
                [ "OpenIPMI",
                  "ipmitool",
                ]:
                    ensure => latest;
            }
        }
        Ubuntu: {
            package {
                [ "openipmi",
                  "ipmitool",
                ]:
                    ensure => latest;
            }
        }
        default: {
            fail("cannot install on $::operatingsystem")
        }
    }
}
