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
require 'xooa/response/QueryResponse'
require 'xooa/response/BlockResponse'
require 'xooa/response/CurrentBlockResponse'
require 'xooa/response/IdentityResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'

module Xooa
  module Api
    # Class to provide methods for connecting to Result Api
    class ResultApi
      attr_accessor :requestUtil

      attr_accessor :logger

      attr_accessor :debugging

      # Initializes the ResultApi
      #
      # @param app_url URL for the app to invoke
      # @param api_token API Token for the app and the identity
      # @param debugging debug tag
      # @return ResultApi
      def initialize(app_url, api_token, debugging)

        @app_url = app_url
        @api_token = api_token
        @request_util = Xooa::Util::RequestUtil.new
        @logger = Logger.new(STDOUT)
        @debugging = debugging
      end


      # This endpoint returns the result of previously submitted api request.
      #
      # @param result_id Returned in previous Query/Invoke/Participant Operation
      # @param timeout Request timeout in millisecond
      # @return QueryResponse
      def get_result_for_query(result_id, timeout = '4000')

        path = '/results/{ResultId}'.sub('{' + 'ResultId' + '}', result_id.to_s)

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

        post_body = nil

        begin
          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

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

        if status_code == 200
          return Xooa::Response::QueryResponse.new(response['result'])
        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # This endpoint returns the result of previously submitted api request.
      #
      # @param result_id Returned in previous Query/Invoke/Participant Operation
      # @param timeout Request timeout in millisecond
      # @return InvokeResponse
      def get_result_for_invoke(result_id, timeout = "4000")

        path = '/results/{ResultId}'.sub('{' + 'ResultId' + '}', result_id.to_s)

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

        post_body = nil

        begin
          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

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

        if status_code == 200
          result = response['result']
          return Xooa::Response::InvokeResponse.new(result['txId'], result['payload'])

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # This endpoint returns the result of previously submitted api request.
      #
      # @param result_id Returned in previous Query/Invoke/Participant Operation
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def get_result_for_identity(result_id, timeout = "4000")

        path = '/results/{ResultId}'.sub('{' + 'ResultId' + '}', result_id.to_s)

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

        post_body = nil

        begin
          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

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

        if status_code == 200

          result = response['result']

          attributes = result['Attrs']

          attributes_list = Array.new(0)

          if attributes.respond_to?('each')
            attributes.each do |attr|
              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
              attributes_list.push(attribute)
            end
          end

          return Xooa::Response::IdentityResponse.new(result['IdentityName'],
                                                      response['AppName'],
                                                      result['ApiToken'],
                                                      result['Id'],
                                                      result['AppId'],
                                                      result['Access'],
                                                      result['canManageIdentities'],
                                                      result['createdAt'],
                                                      result['updatedAt'],
                                                      attributes_list)

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # This endpoint returns the result of previously submitted api request.
      #
      # @param result_id Returned in previous Query/Invoke/Participant Operation
      # @param timeout Request timeout in millisecond
      # @return CurrentBlockResponse
      def get_result_for_current_block(result_id, timeout = '4000')

        path = '/results/{ResultId}'.sub('{' + 'ResultId' + '}', result_id.to_s)

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

        post_body = nil

        begin
          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

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

        if status_code == 200
          payload = response['result']

          return Xooa::Response::CurrentBlockResponse.new(payload['blockNumber'],
                                                          payload['currentBlockHash'],
                                                          payload['previousBlockHash'])

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # This endpoint returns the result of previously submitted api request.
      #
      # @param result_id Returned in previous Query/Invoke/Participant Operation
      # @param timeout Request timeout in millisecond
      # @return BlockResponse
      def get_result_for_block_by_number(result_id, timeout = '4000')

        path = '/results/{ResultId}'.sub('{' + 'ResultId' + '}', result_id.to_s)

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

        post_body = nil

        begin
          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

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

        if status_code == 200
          payload = response['result']
          return Xooa::Response::BlockResponse.new(payload['previous_hash'],
                                                   payload['data_hash'],
                                                   payload['blockNumber'],
                                                   payload['numberOfTransactions'])

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # This endpoint returns the result of previously submitted api request.
      #
      # @param result_id Returned in previous Query/Invoke/Participant Operation
      # @param timeout Request timeout in millisecond
      # @return TransactionResponse
      def get_result_for_transaction(result_id, timeout = '4000')

        path = '/results/{ResultId}'.sub('{' + 'ResultId' + '}', result_id.to_s)

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

        post_body = nil

        begin

          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

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

        if status_code == 200

          payload = response['result']

          tx_id = payload['txid']
          created_at = payload['createdt']
          smart_contract = payload['smartcontract']
          creator_msp_id = payload['creator_msp_id']
          endorser_msp_id = payload['endorser_msp_id']
          transaction_type = payload['type']
          readsets = payload['read_set']
          writesets = payload['write_set']

          read_sets = Array.new(0)

          if readsets.respond_to?('each')
            readsets.each do |readset|

              chaincode = readset['chaincode']
              readsubsets = readset['set']

              read_sub_sets = Array.new(0)

              if readsubsets.respond_to?('each')
                readsubsets.each do |set|

                  key = set['key']
                  vrsn = set['version']

                  version = Xooa::Response::Version.new(vrsn['block_num'], vrsn['tx_num'])

                  read_sub_set = Xooa::Response::ReadSubSet.new(key, version)

                  read_sub_sets.push(read_sub_set)
                end
              end

              read_set = Xooa::Response::ReadSet.new(chaincode, read_sub_sets)

              read_sets.push(read_set)
            end
          end

          write_sets = Array.new(0)

          if writesets.respond_to?('each')
            writesets.each do |writeset|

              chaincode = writeset['chaincode']
              writesubsets = writeset['set']

              write_sub_sets = Array.new(0)

              if writesubsets.respond_to?('each')
                writesubsets.each do |set|

                  key = set['key']
                  value = set['value']
                  is_delete = set['is_delete']

                  write_sub_set = Xooa::Response::WriteSubSet.new(key, value, is_delete)

                  write_sub_sets.push(write_sub_set)
                end
              end

              write_set = Xooa::Response::WriteSet.new(chaincode, write_sub_sets)

              write_sets.push(write_set)
            end
          end

          return Xooa::Response::TransactionResponse.new(tx_id, smart_contract, creator_msp_id, endorser_msp_id, transaction_type, created_at, read_sets, write_sets)

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end

    end
  end
end
