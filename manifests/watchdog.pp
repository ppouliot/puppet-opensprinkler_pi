# == Class: opensprinkler_pi::watchdog
# The watchdog puppet class is based on the information found here:
#
#   http://rayshobby.net/mediawiki/index.php?title=Set_Up_RPi,_RTC,_WiFi,_Data_Log
#
# It ensures the watchdog drivers and packages are installed
# and are enabled on the raspberrypi device.
#
# === Parameters
#
# [*watchdog_kernel_modules*]
#   The names of the modules to be included in the /etc/modules.
#   currently supplied values are organized in the params.pp
#
#
class opensprinkler_pi::watchdog (

  $watchdog_kernel_modules = $opensprinkler_pi::params::watchdog_kernel_modules

) inherits opensprinkler_pi::params {

  package {'watchdog':
    ensure => installed,
  }

  file {'/etc/watchdog.conf':
    ensure  => present,
#    require => Package['watchdog'],
  }

  file_line {'watchdog_device_enable-watchdogconf':
    path    => '/etc/watchdog.conf',
    line    => 'watchdog-device        = /dev/watchdog',
    match   => '^#watchdog-device        = /dev/watchdog',
    require => File['/etc/watchdog.conf'],
  }
}
