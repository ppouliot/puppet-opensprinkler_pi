# == Class: opensprinkler_pi::params
#
# Full description of class opensprinkler_pi here.
#
# === Parameters
#
# Document parameters here.
#
# [*ospi_home*]
#   fects and what it defaults to.
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
#
class opensprinkler_pi::params {

  $ospi_home                   = '/home/pi/OSPi'
  $ospi_source                 = 'https://github.com/Dan-in-CA/OSPi.git'
  $ospi_startup_script         = '/etc/init.d/ospi.sh'
  $ospi_startup_script_content = template("${module_name}/ospi.sh.erb")

  $wifi_driver_url             = 'https://dl.dropboxusercontent.com/u/80256631/'
  $wifi_driver_file            = '8188eu-20140509.tar.gz'
  $wifi_driver_home            = "/lib/modules/${kernelversion}/kernel/drivers/net/wireless/"
  $wifi_driver_module          = '8188eu.ko'

}
