# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class buildslave::startup::runner {
    file {
        "/etc/init.d/buildbot":
            ensure => absent,
            notify => Exec['bb-service-delete'];
    }
    exec {
        'bb-delete':
            command => '/sbin/chkconfig --del buildbot',
            refreshonly => true;
    }
}