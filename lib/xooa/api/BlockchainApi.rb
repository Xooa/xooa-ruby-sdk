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

    class BlockChainApi

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


      # Use this endpoint to Get the block number and hashes of current (highest) block in the network
      #
      # @param timeout Request timeout in millisecond
      # @return CurrentBlockResponse
      def getCurrentBlock(timeout = "4000")

        path = '/block/current'

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

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

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
          return Xooa::Response::CurrentBlockResponse.new(response['blockNumber'],
                                                               response['currentBlockHash'],
                                                               response['previousBlockHash'])

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # Use this endpoint to Get the block number and hashes of current (highest) block in the network
      #
      # @return PendingTransactionResponse
      def getCurrentBlockAsync

        path = '/block/current'

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

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

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


      # Use this endpoint to Get the number of transactions and hashes of a specific block in the network
      #
      # @param blockNumber block number for which data is required
      # @param timeout Request timeout in millisecond
      # @return BlockResponse
      def getBlockByNumber(blockNumber, timeout = "4000")

        path = "/block/{BlockNumber}".sub('{' + 'BlockNumber' + '}', blockNumber.to_s)

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

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

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
          return Xooa::Response::BlockResponse.new(response['previous_hash'],
                                                        response['data_hash'],
                                                        response['blockNumber'],
                                                        response['numberOfTransactions'])

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # Use this endpoint to Get the number of transactions and hashes of a specific block in the network
      #
      # @param blockNumber block number for which data is required
      # @return PendingTransactionResponse
      def getBlockByNumberAsync(blockNumber)

        path = "/block/{BlockNumber}".sub('{' + 'BlockNumber' + '}', blockNumber.to_s)

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

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue XXooa::Exception::ooaApiException => xae
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


      # Use this endpoint to Get transaction by transaction id
      #
      # @param transactionId transactionId from a previous transaction
      # @param timeout Request timeout in millisecond
      # @return TransactionResponse
      def getTransactionByTransactionId(transactionId, timeout = "4000")

        path = "/transactions/{TransactionId}".sub('{' + 'TransactionId' + '}', transactionId.to_s)

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

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

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

          txId = response['txid']
          createdAt = response['createdt']
          smartContract = response['smartcontract']
          creatorMspId = response['creator_msp_id']
          endorserMspId = response['endorser_msp_id']
          transactionType = response['type']
          readsets = response['read_set']
          writesets = response['write_set']

          readSets = Array.new(0)

          if readsets.respond_to?("each")
            readsets.each do |readset|
              chaincode = readset['chaincode']
              readsubsets = readset['set']

              readSubSets = Array.new(0)

              if readsubsets.respond_to?("each")
                readsubsets.each do |set|
                  key = set['key']
                  vrsn = set['version']

                  version = Xooa::Response::Version.new(vrsn['block_num'], vrsn['tx_num'])

                  readSubSet = Xooa::Response::ReadSubSet.new(key, version)

                  readSubSets.push(readSubSet)
                end
              end

              readSet = Xooa::Response::ReadSet.new(chaincode, readSubSets)

              readSets.push(readSet)
            end
          end

          writeSets = Array.new(0)

          if writesets.respond_to?("each")
            writesets.each do |writeset|

              chaincode = writeset['chaincode']
              writesubsets = writeset['set']

              writeSubSets = Array.new(0)

              if writesubsets.respond_to?("each")
                writesubsets.each do |set|

                  key = set['key']
                  value = set['value']
                  isDelete = set['is_delete']

                  writeSubSet = Xooa::Response::WriteSubSet.new(key, value, isDelete)

                  writeSubSets.push(writeSubSet)
                end
              end

              writeSet = Xooa::Response::WriteSet.new(chaincode, writeSubSets)

              writeSets.push(writeSet)
            end
          end

          return Xooa::Response::TransactionResponse.new(txId, smartContract, creatorMspId, endorserMspId, transactionType, createdAt, readSets, writeSets)

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # Use this endpoint to Get transaction by transaction id
      #
      # @param transactionId transactionId from a previous transaction
      # @return PendingTransactionResponse
      def getTransactionByTransactionIdAsync(transactionId)

        path = "/transactions/{TransactionId}".sub('{' + 'TransactionId' + '}', transactionId.to_s)

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

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

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
