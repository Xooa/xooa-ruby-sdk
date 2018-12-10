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

require './lib/ruby/client/util/Request'
require './lib/ruby/client/response/InvokeResponse'
require './lib/ruby/client/response/QueryResponse'
require './lib/ruby/client/response/BlockResponse'
require './lib/ruby/client/response/CurrentBlockResponse'
require './lib/ruby/client/response/IdentityResponse'
require './lib/ruby/client/exception/XooaRequestTimeoutException'
require './lib/ruby/client/exception/XooaApiException'


class ResultApi

  attr_accessor :requestUtil

  attr_accessor :logger

  attr_accessor :debugging

  def initialize(appUrl, apiToken, debugging)
    @appUrl = appUrl
    @apiToken = apiToken
    @requestUtil = RequestUtil.new
    @logger = Logger.new(STDOUT)
    @debugging = debugging
  end


  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return QueryResponse
  def getResultForQuery(resultId, timeout = "4000")

    path = "/results/{ResultId}".sub('{' + 'ResultId' + '}', resultId.to_s)

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
      request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams,
                                         :queryParams => queryParams, :body => postBody)

      response, statusCode = requestUtil.getResponse(request)

      if debugging
        logger.debug "Status Code - #{statusCode}"
        logger.debug "Response - #{response}"
      end

    rescue XooaApiException => xae
      logger.error xae
      raise xae
    rescue StandardError => se
      logger.error se
      raise XooaApiException.new('0', se.to_s)
    end

    if statusCode == 200
      return QueryResponse.new(response['result'])
    elsif statusCode == 202
      logger.error response
      raise XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
    else
      logger.error response
      raise XooaApiException.new(statusCode, response)
    end
  end


  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return InvokeResponse
  def getResultForInvoke(resultId, timeout = "4000")

    path = "/results/{ResultId}".sub('{' + 'ResultId' + '}', resultId.to_s)

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
      request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams,
                                         :queryParams => queryParams, :body => postBody)

      response, statusCode = requestUtil.getResponse(request)

      if debugging
        logger.debug "Status Code - #{statusCode}"
        logger.debug "Response - #{response}"
      end

    rescue XooaApiException => xae
      logger.error xae
      raise xae
    rescue StandardError => se
      logger.error se
      raise XooaApiException.new('0', se.to_s)
    end

    if statusCode == 200

      result = response['result']
      return InvokeResponse.new(result['txId'], result['payload'])
    elsif statusCode == 202
      logger.error response
      raise XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
    else
      logger.error response
      raise XooaApiException.new(statusCode, response)
    end
  end


  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return IdentityResponse
  def getResultForIdentity(resultId, timeout = "4000")

    path = "/results/{ResultId}".sub('{' + 'ResultId' + '}', resultId.to_s)

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
      request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams,
                                         :queryParams => queryParams, :body => postBody)

      response, statusCode = requestUtil.getResponse(request)

      if debugging
        logger.debug "Status Code - #{statusCode}"
        logger.debug "Response - #{response}"
      end

    rescue XooaApiException => xae
      logger.error xae
      raise xae
    rescue StandardError => se
      logger.error se
      raise XooaApiException.new('0', se.to_s)
    end

    if statusCode == 200

      puts(response)

      result = response['result']

      attributes = result['Attrs']

      attributesList = Array.new(0)

      if attributes.respond_to?("each") do |attr|
          attribute = Attr.new(attr['name'], attr['value'], attr['ecert'])
          attributesList.push(attribute)
        end
      end

      return IdentityResponse.new(result['IdentityName'],
                                  result['ApiToken'],
                                  result['Id'],
                                  result['AppId'],
                                  result['Access'],
                                  result['canManageIdentities'],
                                  result['createdAt'],
                                  result['updatedAt'],
                                  attributesList)

    elsif statusCode == 202
      logger.error response
      raise XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
    else
      logger.error response
      raise XooaApiException.new(statusCode, response)
    end
  end


  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return CurrentBlockResponse
  def getResultForCurrentBlock(resultId, timeout = "4000")

    path = "/results/{ResultId}".sub('{' + 'ResultId' + '}', resultId.to_s)

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
      request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams,
                                         :queryParams => queryParams, :body => postBody)

      response, statusCode = requestUtil.getResponse(request)

      if debugging
        logger.debug "Status Code - #{statusCode}"
        logger.debug "Response - #{response}"
      end

    rescue XooaApiException => xae
      logger.error xae
      raise xae
    rescue StandardError => se
      logger.error se
      raise XooaApiException.new('0', se.to_s)
    end

    if statusCode == 200
      payload = response['result']
      return CurrentBlockResponse.new(payload['blockNumber'],
                                      payload['currentBlockHash'],
                                      payload['previousBlockHash'])

    elsif statusCode == 202
      logger.error response
      raise XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
    else
      logger.error response
      raise XooaApiException.new(statusCode, response)
    end
  end


  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return BlockResponse
  def getResultForBlockByNumber(resultId, timeout = "4000")

    path = "/results/{ResultId}".sub('{' + 'ResultId' + '}', resultId.to_s)

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
      request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams,
                                         :queryParams => queryParams, :body => postBody)

      response, statusCode = requestUtil.getResponse(request)

      if debugging
        logger.debug "Status Code - #{statusCode}"
        logger.debug "Response - #{response}"
      end

    rescue XooaApiException => xae
      logger.error xae
      raise xae
    rescue StandardError => se
      logger.error se
      raise XooaApiException.new('0', se.to_s)
    end

    if statusCode == 200
      payload = response['result']
      return BlockResponse.new(payload['previous_hash'],
                               payload['data_hash'],
                               payload['blockNumber'],
                               payload['numberOfTransactions'])
    elsif statusCode == 202
      logger.error response
      raise XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
    else
      logger.error response
      raise XooaApiException.new(statusCode, response)
    end
  end


  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return TransactionResponse
  def getResultForTransaction(resultId, timeout = "4000")

    path = "/results/{ResultId}".sub('{' + 'ResultId' + '}', resultId.to_s)

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
      request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams,
                                         :queryParams => queryParams, :body => postBody)

      response, statusCode = requestUtil.getResponse(request)

      if debugging
        logger.debug "Status Code - #{statusCode}"
        logger.debug "Response - #{response}"
      end

    rescue XooaApiException => xae
      logger.error xae
      raise xae
    rescue StandardError => se
      logger.error se
      raise XooaApiException.new('0', se.to_s)
    end

    if statusCode == 200

      payload = response['result']

      txId = payload['txid']
      createdAt = payload['createdt']
      smartContract = payload['smartcontract']
      creatorMspId = payload['creator_msp_id']
      endorserMspId = payload['endorser_msp_id']
      transactionType = payload['type']
      readsets = payload['read_set']
      writesets = payload['write_set']

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

              version = Version.new(vrsn['block_num'], vrsn['tx_num'])

              readSubSet = ReadSubSet.new(key, version)

              readSubSets.push(readSubSet)
            end
          end

          readSet = ReadSet.new(chaincode, readSubSets)

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

              writeSubSet = WriteSubSet.new(key, value, isDelete)

              writeSubSets.push(writeSubSet)
            end
          end

          writeSet = WriteSet.new(chaincode, writeSubSets)

          writeSets.push(writeSet)
        end
      end

      return TransactionResponse.new(txId, smartContract, creatorMspId, endorserMspId, transactionType, createdAt, readSets, writeSets)

    elsif statusCode == 202
      logger.error response
      raise XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
    else
      logger.error response
      raise XooaApiException.new(statusCode, response)
    end
  end

end