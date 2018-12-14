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

    class InvokeApi

      attr_accessor :requestUtil

      attr_accessor :logger

      attr_accessor :debugging

      def initialize(appUrl, apiToken, debugging)

        @appUrl = appUrl
        @apiToken = apiToken
        @requestUtil = Xooa::Util::RequestUtil.new
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
      # @param functionName Name of the smart contract function to be invoked
      # @param args the arguments to be passed to the smart contract
      # @param timeout Request timeout in millisecond
      # @return InvokeResponse
      def invoke (functionName, args, timeout = "4000")

        path = "/invoke/{fcn}".sub('{' + 'fcn' + '}', functionName.to_s)

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'false'
        queryParams[:'timeout'] = timeout

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = "["

        if args.respond_to?("each")
          args.each do |argument|

            postBody += "\"" + argument + "\", "

          end
        elsif args.nil?
          postBody = nil
        elsif postBody += "\"" + args + "\", "
        end

        if !postBody.nil?
          postBody = postBody[0..(postBody.size - 3)] + "]"
        end

        begin
          request = requestUtil.buildRequest(url, 'POST', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 200
          return Xooa::Response::InvokeResponse.new(response['txId'], response['payload'])

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
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
      # @param functionName Name of the smart contract function to be invoked
      # @param args the arguments to be passed to the smart contract
      # @return PendingTransactionResponse
      def invokeAsync(functionName, args)

        path = "/invoke/{fcn}".sub('{' + 'fcn' + '}', functionName.to_s)

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'true'

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = "["

        if args.respond_to?("each")
          args.each do |argument|

            postBody += "\"" + argument + "\", "

          end
        elsif args.nil?
          postBody = nil

        elsif postBody += "\"" + args + "\", "
        end

        if !postBody.nil?
          postBody = postBody[0..(postBody.size - 3)] + "]"
        end

        begin
          request = requestUtil.buildRequest(url, 'POST', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 202
          return Xooa::Response::PendingTransactionResponse.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end

    end

  end
end
