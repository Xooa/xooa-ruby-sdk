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

require 'json'
require 'uri'

require 'xooa/util/Request'
require 'xooa/response/InvokeResponse'
require 'xooa/response/PendingTransactionResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'


module Xooa
  module Api
    # Class to provide methods for connecting to Invoke Api
    class InvokeApi
      attr_accessor :requestUtil

      attr_accessor :logger

      attr_accessor :debugging

      # Initializes the InvokeApi
      #
      # @param app_url URL for the app to invoke
      # @param api_token API Token for the app and the identity
      # @param debugging debug tag
      # @return InvokeApi
      def initialize(app_url, api_token, debugging)

        @app_url = app_url
        @api_token = api_token
        @request_util = Xooa::Util::RequestUtil.new
        @logger = Logger.new(STDOUT)
        @debugging = debugging
      end


      # The invoke API endpoint is used for submitting transaction for processing by the blockchain smart contract app
      # when the transaction payload need to be persisted into the Ledger (new block is mined).
      # The endpoint must call a function already defined in your smart contract app which will process the invoke request.
      # The function name is part of the endpoint URL, or can be entered as the fcn parameter when testing using the Sandbox.
      # For example, if testing the sample get-set smart contract app, use ‘set’ (without quotes) as the value for fcn.
      # The function arguments (number of arguments and type) is determined by the smart contract.
      # ]The smart contract is also responsible for arguments validation and exception management.
      # In case of error the smart contract is responsible for returning the proper http error code.
      # When exception happens, and it is not caught by smart contract or if caught and no http status code is returned,
      # the API gateway will return http-status-code 500 to the client app.
      #
      # The payload of Invoke Transaction Response in case of final response is determined by the smart contract app.
      #
      # @param function_name Name of the smart contract function to be invoked
      # @param args the arguments to be passed to the smart contract
      # @param timeout Request timeout in millisecond
      # @return InvokeResponse
      def invoke (function_name, args, timeout = '4000')

        path = '/invoke/{fcn}'.sub('{' + 'fcn' + '}', function_name.to_s)

        url = request_util.get_url(@app_url, path)

        logger.info 'Calling API #{url}'
        if debugging
          logger.debug 'Calling API #{url}'
        end

        query_params = {}
        query_params[:'async'] = 'false'
        query_params[:'timeout'] = timeout

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = '['

        if args.respond_to?('each')
          args.each do |argument|

            post_body += "\"" + argument + "\", "

          end
        elsif args.nil?
          post_body = nil
        elsif
          post_body += "\"" + args + "\", "
        end

        if !post_body.nil?
          post_body = post_body[0..(post_body.size - 3)] + "]"
        end

        begin
          request = request_util.build_request(url, 'POST', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

          if debugging
            logger.debug 'Status Code - #{statusCode}'
            logger.debug 'Response - #{response}'
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if status_code == 200
          return Xooa::Response::InvokeResponse.new(response['txId'], response['payload'])

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # The invoke API endpoint is used for submitting transaction for processing by the blockchain smart contract app
      # when the transaction payload need to be persisted into the Ledger (new block is mined).
      # The endpoint must call a function already defined in your smart contract app which will process the invoke request.
      # The function name is part of the endpoint URL, or can be entered as the fcn parameter when testing using the Sandbox.
      # For example, if testing the sample get-set smart contract app, use ‘set’ (without quotes) as the value for fcn.
      # The function arguments (number of arguments and type) is determined by the smart contract.
      # The smart contract is also responsible for arguments validation and exception management.
      # In case of error the smart contract is responsible for returning the proper http error code.
      # When exception happens, and it is not caught by smart contract or if caught and no http status code is returned,
      # the API gateway will return http-status-code 500 to the client app.
      # The payload of Invoke Transaction Response in case of final response is determined by the smart contract app.
      #
      # @param function_name Name of the smart contract function to be invoked
      # @param args the arguments to be passed to the smart contract
      # @return PendingTransactionResponse
      def invoke_async(function_name, args)

        path = '/invoke/{fcn}'.sub('{' + 'fcn' + '}', function_name.to_s)

        url = request_util.get_url(@app_url, path)

        logger.info 'Calling API #{url}'
        if debugging
          logger.debug 'Calling API #{url}'
        end

        query_params = {}
        query_params[:'async'] = 'true'

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = '['

        if args.respond_to?('each')
          args.each do |argument|

            post_body += "\"" + argument + "\", "

          end
        elsif args.nil?
          post_body = nil

        elsif
          post_body += "\"" + args + "\", "
        end

        if !post_body.nil?
          post_body = post_body[0..(post_body.size - 3)] + "]"
        end

        begin
          request = request_util.build_request(url, 'POST', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

          if debugging
            logger.debug 'Status Code - #{status_code}'
            logger.debug 'Response - #{response}'
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if status_code == 202
          return Xooa::Response::PendingTransactionResponse.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end

    end

  end
end
