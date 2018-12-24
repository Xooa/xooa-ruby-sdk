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

require 'xooa/util/Request'
require 'xooa/response/CurrentBlockResponse'
require 'xooa/response/BlockResponse'
require 'xooa/response/TransactionResponse'
require 'xooa/response/PendingTransactionResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'

require 'logger'

module Xooa
  module Api
    # Class to provide methods for connecting to BlockChain Api
    class BlockChainApi
      attr_accessor :request_util

      attr_accessor :logger

      attr_accessor :debugging

      # Initializes the BlockChainApi
      #
      # @param app_url URL for the app to invoke
      # @param api_token API Token for the app and the identity
      # @param debugging debug tag
      # @return BlockChainApi
      def initialize(app_url, api_token, debugging)

        @app_url = app_url
        @api_token = api_token
        @request_util = Xooa::Util::RequestUtil.new
        @logger = Logger.new(STDOUT)
        @debugging = debugging
      end


      # Use this endpoint to Get the block number and hashes of current (highest) block in the network
      #
      # @param timeout Request timeout in millisecond
      # @return CurrentBlockResponse
      def get_current_block(timeout = '4000')

        path = '/block/current'

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
          return Xooa::Response::CurrentBlockResponse.new(response['blockNumber'],
                                                          response['currentBlockHash'],
                                                          response['previousBlockHash'])

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # Use this endpoint to Get the block number and hashes of current (highest) block in the network
      #
      # @return PendingTransactionResponse
      def get_current_block_async

        path = '/block/current'

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

        if status_code == 202
          return Xooa::Response::PendingTransactionResponse.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # Use this endpoint to Get the number of transactions and hashes of a specific block in the network
      #
      # @param block_number block number for which data is required
      # @param timeout Request timeout in millisecond
      # @return BlockResponse
      def get_block_by_number(block_number, timeout = "4000")

        path = '/block/{BlockNumber}'.sub('{' + 'BlockNumber' + '}', block_number.to_s)

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
          return Xooa::Response::BlockResponse.new(response['previous_hash'],
                                                   response['data_hash'],
                                                   response['blockNumber'],
                                                   response['numberOfTransactions'])

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # Use this endpoint to Get the number of transactions and hashes of a specific block in the network
      #
      # @param block_number block number for which data is required
      # @return PendingTransactionResponse
      def get_block_by_number_async(block_number)

        path = '/block/{BlockNumber}'.sub('{' + 'BlockNumber' + '}', block_number.to_s)

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

        post_body = nil

        begin
          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

          if debugging
            logger.debug 'Status Code - #{status_code}'
            logger.debug 'Response - #{response}'
          end

        rescue XXooa::Exception::XooaApiException => xae
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


      # Use this endpoint to Get transaction by transaction id
      #
      # @param transaction_id transactionId from a previous transaction
      # @param timeout Request timeout in millisecond
      # @return TransactionResponse
      def get_transaction_by_transaction_id(transaction_id, timeout = '4000')

        path = '/transactions/{TransactionId}'.sub('{' + 'TransactionId' + '}', transaction_id.to_s)

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

          tx_id = response['txid']
          created_at = response['createdt']
          smart_contract = response['smartcontract']
          creator_msp_id = response['creator_msp_id']
          endorser_msp_id = response['endorser_msp_id']
          transaction_type = response['type']
          readsets = response['read_set']
          writesets = response['write_set']

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


      # Use this endpoint to Get transaction by transaction id
      #
      # @param transaction_id transactionId from a previous transaction
      # @return PendingTransactionResponse
      def get_transaction_by_transaction_id_async(transaction_id)

        path = '/transactions/{TransactionId}'.sub('{' + 'TransactionId' + '}', transaction_id.to_s)

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
