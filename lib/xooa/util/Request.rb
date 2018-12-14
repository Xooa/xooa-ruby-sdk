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

require 'typhoeus'
require 'json'
require 'uri'

require 'xooa/exception/XooaApiException'

module Xooa
  module Util

    class RequestUtil

      # Create a Url with the base url and the path for the request
      # @param url base url for the app
      # @param path path for the request
      # @return url
      def getUrl(url, path)
        path = "/#{path}".gsub(/\/+/, '/')
        URI.encode(url + path)
      end


      # Build request to be made
      # @param url url for the request
      # @param method request method
      # @options opts options for the request
      # @return TyphoeusRequest
      def buildRequest(url, method, opts = {})

        method = method.to_sym.downcase
        headerParams = opts[:headerParams] || {}
        queryParams = opts[:queryParams] || {}
        body = opts[:body] || {}

        reqOpts = {
            :method => method,
            :headers => headerParams,
            :params => queryParams,
            :body => body
        }

        request = Typhoeus::Request.new(url, reqOpts)

        request
      end


      # Get the response for the request
      # @param request request to be submitted to the blockchain
      # @return responseJson
      def getResponse(request)

        begin

          response = request.run

=begin
            unless response.success?
              if response.timed_out?
                raise Xooa::Exception::XooaApiException.new('0', 'Connection Timed Out')
              elsif response.code == 0
                raise Xooa::Exception::XooaApiException.new('0', :errorMessage => response.return_message)
              else
                raise Xooa::Exception::XooaApiException.new(response.code, response.status_message)
              end
            end
=end

          responseBody = response.body

          return nil, response.code if responseBody.nil? || responseBody.empty?

          return responseBody, response.code if response.headers['Content-Type'] == 'string'

          begin
            data = JSON.parse(responseBody)

          rescue JSON::ParseError => e
            raise Xooa::Exception::XooaApiException.new('0', e.to_s)
          end

          return data, response.code

        rescue Xooa::Exception::XooaApiException => e
          raise e
        rescue StandardError => e
          raise Xooa::Exception::XooaApiException.new('0', e.to_s)
        end

      end

    end

  end
end