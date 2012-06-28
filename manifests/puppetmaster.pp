# Stand alone manifest for setting up a puppet master
$extlookup_datadir = "$settings::manifestdir/extlookup"
$extlookup_precedence = ["puppetmaster-config", "default-config", "secrets"]
stage { "packagesetup": before => Stage["main"]; }
include toplevel::server::puppet
