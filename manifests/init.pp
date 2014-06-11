# == Class: opensprinkler_pi
#
# Full description of class opensprinkler_pi here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { opensprinkler_pi:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class opensprinkler_pi {

  vcsrepo{'/srv/OSPi':
    ensure   => present,
    source   => 'https://github.com/Dan-in-CA/OSPi.git',
    provider => git,
  }
  vcsrepo{'/srv/sprinklers_pi':
    ensure   => present,
    source   => 'https://github.com/rszimm/sprinklers_pi.git',
    provider => git,
  }
  vcsrepo{'/srv/OpenSprinkler-Controller':
    ensure   => present,
    source   => 'https://github.com/salbahra/OpenSprinkler-Controller.git',
    provider => git,
  }
  vcsrepo{'/srv/opensprinkler':
    ensure   => present,
    source   => 'https://github.com/rayshobby/opensprinkler.git',
    provider => git,
  }


}
