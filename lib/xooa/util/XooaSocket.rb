# Ruby SDK for Xooa
#
# Copyright 2018 Xooa
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at:
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License
# for the specific language governing permissions and limitations under the License.
#
# @author Kavi Sarna

require 'socket.io-client-simple'

require 'xooa/util/Request'

module Xooa
  module Util
    # Socket client to create a subscribe connection
    class XooaSocket
      attr_accessor :app_url

      attr_accessor :api_token

      attr_accessor :socket

      # Initialize XooaSocket
      #
      # @param app_url app url
      # @param api_token API Token for app identity
      # @return XooaSocket
      def initialize(app_url, api_token)

        @app_url = app_url
        @api_token = api_token
      end

      # Subscribe to the events from the App
      #
      # @param callback callback method to be invoked upon an event
      def subscribe_events(callback)

        url = Xooa::Util::RequestUtil.new.get_url(app_url, '/subscribe')

        @socket = SocketIO::Client::Simple.connect url

        socket.on :connect do
          puts('connected')

          socket.emit :authenticate, {:api_token => api_token}
        end

        socket.on :authenticated do
          puts('authenticated')
        end

        socket.on :error do
          puts('Error')

          socket.connect
        end

        socket.on :event do |msg|

          puts(msg)

          callback.call(msg)
        end
      end

      # Unsubscribe from all the events
      def unsubscribe
        socket.disconnect
      end
    end

  end
end
