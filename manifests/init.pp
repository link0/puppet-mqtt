# == Class: mqtt
#
# This module installs the mosquitto service
#
# === Parameters
#
#
#
# === Examples
#
#   class { 'mqtt':
#   }
#
#
# === Authors
#
# * Dennis de Greef <mailto:github@link0.net>
#
# === License
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Link0 / Dennis de Greef
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
class mqtt(

  $package_name    = $mqtt::params::package_name,
  $package_manage  = $mqtt::params::package_manage,
  $package_ensure  = $mqtt::params::package_ensure,

  $service_name    = $mqtt::params::service_name,
  $service_manage  = $mqtt::params::service_manage,
  $service_enable  = $mqtt::params::service_enable,
  $service_ensure  = $mqtt::params::service_ensure,

  $etc_directory   = $mqtt::params::etc_directory,
  $config          = $mqtt::params::config,
  $config_template = $mqtt::params::config_template,
  $pid_file        = $mqtt::params::pid_file,

  $user            = $mqtt::params::user,
  $bind_address    = $mqtt::params::bind_address,
  $port            = $mqtt::params::port

) inherits mqtt::params {

  validate_string($package_name)
  validate_string($package_ensure)
  validate_bool($package_manage)

  validate_string($service_name)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_bool($service_manage)

  validate_string($etc_directory)
  validate_absolute_path($etc_directory)

  validate_string($pid_file)
  validate_absolute_path($pid_file)

  validate_string($user)
  validate_string($bind_address)
  validate_integer($port)

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'mqtt::begin': } ->
  class { '::mqtt::install': } ->
  class { '::mqtt::config': } ~>
  class { '::mqtt::service': } ->
  anchor { 'mqtt::end': }

}
