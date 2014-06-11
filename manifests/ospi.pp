# == Class: opensprinkler_pi::ospi
#
# This module configures the OSPi python application to run as a 
# service on a RaspberryPi System.   
#
# === Parameters
#
# [*ospi_home*]
#   Location of the OSPi Source on the RaspBerryPi fIlesystem..
#
# [*ospi_source*]
#   Location of the OSPi Source Code respository, defaults the project repository
#   on github.
#
# [*ospi_startup_script*]
#   Location of OSPi initialization script. Currently defaults to "/etc/init.d"
#
# [*ospi_startup_script_content*]
#   Change the content used withing the OSPi startup script or use
#   a different template.
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
#  class { opensprinkler_pi::ospi
#    ospi_home => '/home/pi/OSPi',
#  }
#
# === Authors
#
# Peter J. Pouliot <peter@pouliot.net>
#
# === Copyright
#
# Copyright 2014 Peter J. Pouliot, unless otherwise noted.
#
class opensprinkler_pi::ospi (

  $ospi_home                   = $opensprinkler_pi::params::ospi_home,
  $ospi_source                 = $opensprinkler_pi::params::ospi_source,
  $ospi_startup_script         = $opensprinkler_pi::params::ospi_startup_script,
  $ospi_startup_script_content = $opensprinkler_pi::params::ospi_startup_script_content,

) inherits opensprinkler_pi::params {

  vcsrepo{ $ospi_home :
    ensure   => present,
    source   => $ospi_source,
    provider => 'git',
  }

  file{ $ospi_startup_script:
    ensure  => file,
#    content => template("opensprinkler_pi/templates/ospi.sh.erb"),
    content => $ospi_startup_script_content,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  }

  service {'ospi.sh':
    ensure => running,
    enable => true,
    require => File[ $ospi_startup_script ],
  }
  
}
