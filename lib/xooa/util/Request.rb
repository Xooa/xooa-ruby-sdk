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
    # Util class for requests to API
    class RequestUtil

      # Create a Url with the base url and the path for the request
      #
      # @param url base url for the app
      # @param path path for the request
      # @return url
      def get_url(url, path)

        path = "/#{path}".gsub(/\/+/, '/')
        URI.encode(url + path)
      end

      # Build request to be made to API
      #
      # @param url url for the request
      # @param method request method
      # @options opts options for the request
      # @return TyphoeusRequest
      def build_request(url, method, opts = {})

        method = method.to_sym.downcase
        header_params = opts[:header_params] || {}
        query_params = opts[:query_params] || {}
        body = opts[:body] || {}

        req_opts = {
            :method => method,
            :headers => header_params,
            :params => query_params,
            :body => body
        }

        request = Typhoeus::Request.new(url, req_opts)

        request
      end

      # Get the response for the request
      #
      # @param request request to be submitted to the blockchain
      # @return responseJson
      def get_response(request)

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
          response_body = response.body

          return nil, response.code if response_body.nil? || response_body.empty?

          return response_body, response.code if response.headers['Content-Type'] == 'string'

          begin
            data = JSON.parse(response_body)

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
