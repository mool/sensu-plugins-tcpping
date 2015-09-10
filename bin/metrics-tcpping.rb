#! /usr/bin/env ruby
#
# metrics-tcpping
#
# DESCRIPTION:
#  This plugin pings a tcp port and outputs ping statistics
#
# OUTPUT:
#  <scheme>.duration 0.013854 1441900774
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   ./metrics-tcpping --host <host> --port <port> \
#                     --timeout <timeout> --scheme <scheme>
#
# NOTES:
#
# LICENSE:
#   Copyright 2015 Pablo Gutierrez del Castillo <pablogutierrezdelc@gmail.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE.txt
#   for details.
#

require 'sensu-plugin/check/cli'
require 'socket'
require 'net/ping'

class TCPPingMetrics < Sensu::Plugin::Check::CLI
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.tcpping"

  option :host,
         description: 'Host to ping',
         short: '-h HOST',
         long: '--host HOST',
         default: 'localhost'

  option :port,
         description: 'Port to Ping',
         short: '-p PORT',
         long: '--port PORT',
         default: 80

  option :timeout,
         description: 'Timeout',
         short: '-t TIMEOUT',
         long: '--timeout TIMEOUT',
         default: 5

  def timestamp
    @timestamp ||= Time.now.to_i
  end

  def run
    @check = Net::Ping::TCP.new(config[:host], config[:port], config[:timeout])

    if @check.ping
      puts "#{config[:scheme]}.duration #{@check.duration} #{timestamp}"
      exit 0
    else
      critical "ping error: can't connect to host"
      exit 1
    end
  end
end
