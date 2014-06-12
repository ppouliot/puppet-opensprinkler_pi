# == Class: opensprinkler_pi::rtc
# The rtc puppet class is based on the information found here:
#
#   http://rayshobby.net/mediawiki/index.php?title=Set_Up_RPi,_RTC,_WiFi,_Data_Log
#
# It ensures the RTC drivers are enabled on the raspberrypi device.
#
# === Parameters
#
# [*rtc_kernel_modules*]
#   The names of the modules to be included in the /etc/modules.
#   currently supplied values are organized in the params.pp
#
#
class opensprinkler_pi::rtc (

  $rtc_kernel_modules = $opensprinkler_pi::params::rtc_kernel_modules

) inherits opensprinkler_pi::params {

  file {'/etc/modules':
    ensure  => present,
    content => template("${module_name}/modules.erb"),
  }

  file {'/etc/modprobe.d/raspi-blacklist.conf':
    ensure => present,
  }


  file_line {'blacklist_spi-bcm2708':
    path    => '/etc/modprobe.d/raspi-blacklist.conf',
    line    => "#blacklist spi-bcm2708 ### Puppet Managed ${name} ###",
    match   => 'blacklist spi-bcm2708',
  }

  file_line {'blacklist_i2c-bcm2708':
    path    => '/etc/modprobe.d/raspi-blacklist.conf',
    line    => "#blacklist i2c-bcm2708 ### Puppet Managed ${name} ###",
    match   => 'blacklist i2c-bcm2708',
  }
  package {'i2c-tools':
    ensure => installed,
    require =>[
              File['/etc/modules'], 
              File_line[ 'blacklist_spi-bcm2708',
                         'blacklist_i2c-bcm2708']],
  }

  
  file {'/etc/rc.local':
    ensure  => file,
    content => template("${module_name}/rc.local.erb"),
    require => Package['i2c-tools'],
  }
}
