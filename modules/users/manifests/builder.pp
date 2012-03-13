# Set up the builder user - this is 'cltbld' on firefox systems, but flexible
# enough to be anything

class users::builder {
    include config

    if ($config::secrets::builder_pw_hash == '') {
        fail('No builder password hash set')
    }

    if ($config::builder_username == '') {
        fail('No builder username set')
    }

    # XXX should we be setting group explicitly?
    user {
        "$config::builder_username":
            password => $config::secrets::builder_pw_hash,
            shell => "/bin/bash",
            managehome => true,
            comment => "Builder";
    }

    # XXX This is a little bit of a kludge.  We should really
    # be figuring out what the /home/ part is based on the real system
    # instead of specifying it per kernel (OS family)
    case $kernel {
        "Linux": {
            $home_base = "/home/"
        }
        "Darwin": {
            $home_base = "/Users/"
        }
        default: {
            fail('I dont how to figure out the homedir on $kernel')
        }
    }

    $home_dir = "$home_base/$config::builder_username"

    # Manage some configuration files
    file {
        "$home_dir/.ssh":
            ensure => directory,
            mode => 0755,
            owner => "$config::builder_username",
            group => "$config::builder_username";
        "$home_dir/.ssh/config":
            mode => 0644,
            owner => "$config::builder_username",
            group => "$config::builder_username",
            source => "puppet:///modules/users/ssh_config";
        # XXX Authorized keys should be generated from LDAP not a static file
        "$home_dir/.ssh/authorized_keys":
            mode => 0644,
            owner => "$config::builder_username",
            group => "$config::builder_username",
            content => template("users/ssh_authorized_keys.erb");
        "$home_dir/.ssh/known_hosts":
            mode => 0644,
            owner => "$config::builder_username",
            group => "$config::builder_username",
            source => "puppet:///modules/users/ssh_known_hosts";
        "$home_dir/.gitconfig":
            mode => 0644,
            owner => "$config::builder_username",
            group => "$config::builder_username",
            source => "puppet:///modules/users/gitconfig";
        "$home_dir/.hgrc":
            mode => 0644,
            owner => "$config::builder_username",
            group => "$config::builder_username",
            source => "puppet:///modules/users/hgrc";
        "$home_dir/.vimrc":
            mode => 0644,
            owner => "$config::builder_username",
            group => "$config::builder_username",
            source => "puppet:///modules/users/vimrc";
    }
}
