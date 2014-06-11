# == Class: opensprinkler_pi::wifi
#
# Full description of class opensprinkler_pi here.
# For additional information see the following urls:
# http://laurenthinoul.com/how-to-install-tp-link-tl-wn725n-on-raspberry-pi/
# http://www.raspberrypi.org/forums/viewtopic.php?p=462982

# === Parameters
#
# Document parameters here.
#
# [*wifi_driver_url*]
#   The web location of the folder containing the wifi_driver_files.
#
# [*wifi_driver_file*]
#   A tarball containing the binary driver
#
# [*wifi_driver_module*]
#   The name of the binary module file
#
# [*wifi_driver_home*]
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
class opensprinkler_pi::wifi (
    $wifi_driver_url    = $opensprinkler_pi::params::wifi_driver_url,
    $wifi_driver_file   = $opensprinkler_pi::params::wifi_driver_file,
    $wifi_driver_module = $opensprinkler_pi::params::wifi_driver_module,
    $wifi_driver_home   = $opensprinkler_pi::params::wifi_driver_home,

) inherits opensprinkler_pi::params {

  exec { 'get_wireless_driver':
    command => "/usr/bin/wget -cv ${wifi_driver_url}${wifi_driver_file} -O - | tar xzf -",
    cwd     => $wifi_driver_home,
    creates => "${wifi_driver_home}${wifi_driver_module}",
  }
  file{ "${wifi_driver_home}${wifi_driver_module}":
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Exec['get_wireless_driver'],
  }

  exec { 'install_wireless_driver':
    command => "/sbin/insmod ${wifi_driver_home}${wifi_driver_module}",
    cwd     => $wifi_driver_home,
    require => File["${wifi_driver_home}${wifi_driver_module}"],
    unless  => '/sbin/lsmod |/bin/grep 8188eu',
  }

  file {'/etc/network/interfaces':
    ensure => present,
  }

  file_line {'wifi_interface':
    path    => '/etc/network/interfaces',
    line    => '# This line is managed by Puppet
auto wlan0
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp',
    require => File['/etc/network/interfaces'],
  }
}
