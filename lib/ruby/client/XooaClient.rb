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

require 'uri'
require 'logger'

require './lib/ruby/client/api/BlockchainApi'
require './lib/ruby/client/api/IdentitiesApi'
require './lib/ruby/client/api/InvokeApi'
require './lib/ruby/client/api/QueryApi'
require './lib/ruby/client/api/ResultApi'
require './lib/ruby/client/util/XooaSocket'

class XooaClient

  attr_accessor :apiToken

  attr_accessor :appUrl

  attr_accessor :debugging

  # Initializes the XooaClient
  #
  # @return XooaClient
=begin
  def initialize
    @appUrl = "https://api.xooa.com/api/v1"
    @apiToken = null
    @debugging = false
  end
=end

  # Initializes the XooaClient
  #
  # @param apiToken API Token for the app and the identity
  # @param appUrl URL for the app to invoke
  # @return XooaClient
  def initialize(apiToken, appUrl = "https://api.xooa.com/api/v1")
    @apiToken = apiToken
    @appUrl = appUrl
    @debugging = false
  end

  # Validate the appUrl and Api Token
  #
  # @return IdentityResponse
  def validate
    IdentitiesApi.new(appUrl, apiToken, debugging).currentIdentity
  end

  # Subscribe to all the events from the App
  #
  # @param callback callback method to be invoked upon an event
  def subscribe(callback)
    block = method(callback)
    @xooaSocket = XooaSocket.new(appUrl, apiToken).subscribeEvents(block)
  end

  # Unsubscribe from all the events
  def unsubscribe
    @xooaSocket.unsubscribe
  end

  # Use this endpoint to Get the block number and hashes of current (highest) block in the network
  # 
  # @param timeout Request timeout in millisecond
  # @return CurrentBlockResponse
  def getCurrentBlock(timeout = "4000")
    BlockChainApi.new(appUrl, apiToken, debugging).getCurrentBlock(timeout)
  end

  # Use this endpoint to Get the block number and hashes of current (highest) block in the network
  # 
  # @return PendingTransactionResponse
  def getCurrentBlockAsync
    BlockChainApi.new(appUrl, apiToken, debugging).getCurrentBlockAsync
  end

  # Use this endpoint to Get the number of transactions and hashes of a specific block in the network
  #
  # @param blockNumber block number for which data is required
  # @param timeout Request timeout in millisecond
  # @return BlockResponse
  def getBlockByNumber(blockNumber, timeout = "4000")
    BlockChainApi.new(appUrl, apiToken, debugging).getBlockByNumber(blockNumber, timeout)
  end

  # Use this endpoint to Get the number of transactions and hashes of a specific block in the network
  #
  # @param blockNumber block number for which data is required
  # @return PendingTransactionResponse
  def getBlockByNumberAsync(blockNumber)
    BlockChainApi.new(appUrl, apiToken, debugging).getBlockByNumberAsync(blockNumber)
  end

  # Use this endpoint to Get transaction by transaction id
  #
  # @param transactionId transactionId from a previous transaction
  # @param timeout Request timeout in millisecond
  # @return TransactionResponse
  def getTransactionByTransactionId(transactionId, timeout = "4000")
    BlockChainApi.new(appUrl, apiToken, debugging).getTransactionByTransactionId(transactionId, timeout)
  end

  # Use this endpoint to Get transaction by transaction id
  #
  # @param transactionId transactionId from a previous transaction
  # @return PendingTransactionResponse
  def getTransactionByTransactionIdAsync(transactionId)
    BlockChainApi.new(appUrl, apiToken, debugging).getTransactionByTransactionIdAsync(transactionId)
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
  # @param timeout Request timeout in millisecond
  # @return InvokeResponse
  def invoke(functionName, args, timeout = "4000")
    InvokeApi.new(appUrl, apiToken, debugging).invoke(functionName, args, timeout)
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
    InvokeApi.new(appUrl, apiToken, debugging).invokeAsync(functionName, args)
  end

  # The query API endpoint is used for querying (reading) a blockchain ledger using smart contract function.
  # The endpoint must call a function already defined in your smart contract app which will process the query request.
  # The function name is part of the endpoint URL, or can be entered as the fcn parameter when testing using the Sandbox.
  # The function arguments (number of arguments and type) is determined by the smart contract.
  # The smart contract is responsible for validation and exception management.
  # In case of error the smart contract is responsible for returning the proper http error code.
  # When exception happens, and it is not caught by smart contract or if caught and no http status code is returned,
  # the API gateway will return http-status-code 500 to the client app.
  # For example, if testing the sample get-set smart contract app, enter ‘get’ (without quotes) as the value for fcn.
  #
  # @param functionName Name of the smart contract function to be invoked
  # @param args the arguments to be passed to the smart contract
  # @param timeout Request timeout in millisecond
  # @return QueryResponse
  def query(functionName, args, timeout = "4000")
    QueryApi.new(appUrl, apiToken, debugging).query(functionName, args, timeout)
  end

  # The query API endpoint is used for querying (reading) a blockchain ledger using smart contract function.
  # The endpoint must call a function already defined in your smart contract app which will process the query request.
  # The function name is part of the endpoint URL, or can be entered as the fcn parameter when testing using the Sandbox.
  # The function arguments (number of arguments and type) is determined by the smart contract.
  # The smart contract is responsible for validation and exception management.
  # In case of error the smart contract is responsible for returning the proper http error code.
  # When exception happens, and it is not caught by smart contract or if caught and no http status code is returned,
  # the API gateway will return http-status-code 500 to the client app.
  # For example, if testing the sample get-set smart contract app, enter ‘get’ (without quotes) as the value for fcn.
  #
  # @param functionName Name of the smart contract function to be invoked
  # @param args the arguments to be passed to the smart contract
  # @return PendingTransactionResponse
  def queryAsync(functionName, args)
    QueryApi.new(appUrl, apiToken, debugging).queryAsync(functionName, args)
  end

  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return QueryResponse
  def getResultForQuery(resultId, timeout = "4000")
    ResultApi.new(appUrl, apiToken, debugging).getResultForQuery(resultId, timeout)
  end

  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return InvokeResponse
  def getResultForInvoke(resultId, timeout = "4000")
    ResultApi.new(appUrl, apiToken, debugging).getResultForInvoke(resultId, timeout)
  end

  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return IdentityResponse
  def getResultForIdentities(resultId, timeout = "4000")
    ResultApi.new(appUrl, apiToken, debugging).getResultForIdentity(resultId, timeout)
  end

  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return CurrentBlockResponse
  def getResultForCurrentBlock(resultId, timeout = "4000")
    ResultApi.new(appUrl, apiToken, debugging).getResultForCurrentBlock(resultId, timeout)
  end

  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return BlockResponse
  def getResultForBlockByNumber(resultId, timeout = "4000")
    ResultApi.new(appUrl, apiToken, debugging).getResultForBlockByNumber(resultId, timeout)
  end

  # This endpoint returns the result of previously submitted api request.
  #
  # @param resultId Returned in previous Query/Invoke/Participant Operation
  # @param timeout Request timeout in millisecond
  # @return TransactionResponse
  def getResultForTransaction(resultId, timeout = "4000")
    ResultApi.new(appUrl, apiToken, debugging).getResultForTransaction(resultId, timeout)
  end

  # This endpoint returns authenticated identity information
  #
  # @param timeout Request timeout in millisecond
  # @return IdentityResponse
  def currentIdentity(timeout = "4000")
    IdentitiesApi.new(appUrl, apiToken, debugging).currentIdentity(timeout)
  end

  # Get all identities from the identity registry
  # Required permission: manage identities (canManageIdentities=true)
  #
  # @param timeout Request timeout in millisecond
  # @return Array[IdentityResponse]
  def getIdentities(timeout = "4000")
    IdentitiesApi.new(appUrl, apiToken, debugging).getIdentities(timeout)
  end

  # The Enroll identity endpoint is used to enroll new identities for the smart contract app.
  # A success response includes the API Token generated for the identity.
  # This API Token can be used to call API End points on behalf of the enrolled identity.
  # This endpoint provides equivalent functionality to adding new identity manually using Xooa console,
  # and identities added using this endpoint will appear, and can be managed, using Xooa console under the identities tab of the smart contract app
  # Required permission: manage identities (canManageIdentities=true)
  #
  # @param identityRequest Identity Request data to create a new identity
  # @param timeout Request timeout in millisecond
  # @return IdentityResponse
  def enrollIdentity(identityRequest, timeout = "4000")
    IdentitiesApi.new(appUrl, apiToken, debugging).enrollIdentity(identityRequest, timeout)
  end

  # The Enroll identity endpoint is used to enroll new identities for the smart contract app.
  # A success response includes the API Token generated for the identity.
  # This API Token can be used to call API End points on behalf of the enrolled identity.
  # This endpoint provides equivalent functionality to adding new identity manually using Xooa console,
  # and identities added using this endpoint will appear, and can be managed, using Xooa console under the identities tab of the smart contract app
  # Required permission: manage identities (canManageIdentities=true)
  #
  # @param identityRequest Identity Request data to create a new identity
  # @return PendingTransactionResponse
  def enrollIdentityAsync(identityRequest)
    IdentitiesApi.new(appUrl, apiToken, debugging).enrollIdentityAsync(identityRequest)
  end

  # Generates new identity API Token
  # Required permission: manage identities (canManageIdentities=true)
  #
  # @param identityId Identity id for which to create a new API Token
  # @param timeout Request timeout in millisecond
  # @return IdentityResponse
  def regenerateIdentityApiToken(identityId, timeout = "4000")
    IdentitiesApi.new(appUrl, apiToken, debugging).regenerateIdentityApiToken(identityId, timeout)
  end

  # Get the specified identity from the identity registry.
  # Required permission: manage identities (canManageIdentities=true)
  #
  # @param identityId Identity id for which to find the Identity details
  # @param timeout Request timeout in millisecond
  # @return IdentityResponse
  def getIdentity(identityId, timeout = "4000")
    IdentitiesApi.new(appUrl, apiToken, debugging).getIdentity(identityId, timeout)
  end

  # Deletes an identity.
  # Required permission: manage identities (canManageIdentities=true)
  #
  # @param identityId Identity id for which to delete the Identity details
  # @param timeout Request timeout in millisecond
  # @return boolean
  def deleteIdentity(identityId, timeout = "4000")
    IdentitiesApi.new(appUrl, apiToken, debugging).deleteIdentity(identityId, timeout)
  end

end
