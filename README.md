# opensprinkler_pi

This module was developed to configure a RaspberryPi running Raspbian for the
OpenSprinker_Pi hardware board and the associated project software.  Some of
the classes are hardware specific to hardware in my deployment. 

The online user manual for the OpenSprinkler Pi  can be found here:

  http://rayshobby.net/?page_id=5874

The module was developed using Puppet 3.6.1.  Puppet and all supporting applications
were repackaged for the raspberrypi using this script:

  http://github.com/ppouliot/rpi-build_puppet.git

## Usage

Currently the following functionality exists:

To install the OSPi application

  class {'opensprinkler_pi::ospi':}

To configure a TP-Link TL-WN725N Wireless adapter

  class {'opensprinkler_pi::wifi':}

To configure the RTC hardware

  class {'opensprinkler_pi::rtc':}

All are currently a work in progress.

ALl work is licensed under an Apache 2.0 License
