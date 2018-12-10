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

require './lib/ruby/client/util/Request'

module Util
  class XooaSocket

    attr_accessor :appUrl

    attr_accessor :apiToken

    attr_accessor :socket

    # Initialize XooaSocket
    # @param appUrl app url
    # @param apiToken API Token for app identity
    # @return XooaSocket
    def initialize(appUrl, apiToken)
      @appUrl = appUrl
      @apiToken = apiToken
    end

    # Subscribe to the events from the App
    #
    # @param callback callback method to be invoked upon an event
    def subscribeEvents(allback)

      url = RequestUtil.new.getUrl(appUrl, "/subscribe")

      @socket = SocketIO::Client::Simple.connect url

      socket.on :connect do
        puts("connected")

        socket.emit :authenticate, {:apiToken => apiToken}
      end

      socket.on :authenticated do
        puts("authenticated")
      end

      socket.on :error do
        puts("Error")

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