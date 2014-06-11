# == Class: opensprinkler_pi::rtc
#
# Full description of class opensprinkler_pi here.
# For additional information see the following urls:
# http://laurenthinoul.com/how-to-install-tp-link-tl-wn725n-on-raspberry-pi/
# http://www.raspberrypi.org/forums/viewtopic.php?p=462982

# === Parameters
#
# Document parameters here.
#
# [*rtc_driver_url*]
#   The web location of the folder containing the rtc_driver_files.
#
# [*rtc_driver_file*]
#   A tarball containing the binary driver
#
# [*rtc_driver_module*]
#   The name of the binary module file
#
# [*rtc_driver_home*]
#   The place where we will be putting the binary wireless module
#   to allow us to automatically load the driver module.
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
}
