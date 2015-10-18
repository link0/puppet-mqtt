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
class mqtt::params {

  $package_name = 'mosquitto'
  $package_manage = true
  $package_ensure = installed

  $etc_directory = $::operatingsystem ? {
    /(?i:FreeBSD)/ => '/usr/local/etc',
    default        => '/etc',
  }

  $service_name = 'mosquitto'
  $service_manage = true
  $service_enable = true
  $service_ensure = running

  $pid_file = '/var/run/mosquitto.pid'
  $config = "${etc_directory}/mosquitto/mosquitto.conf"
  $config_template = 'mqtt/mosquitto.conf.erb'

  $user = 'nobody'
  $bind_address = undef
  $port = 1883

}
