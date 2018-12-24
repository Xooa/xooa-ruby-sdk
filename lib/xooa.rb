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

require 'xooa/api/BlockchainApi'
require 'xooa/api/IdentitiesApi'
require 'xooa/api/InvokeApi'
require 'xooa/api/QueryApi'
require 'xooa/api/ResultApi'
require 'xooa/util/XooaSocket'

module Xooa
  # Base class for Xooa Sdk which provides all the methods exposed by the sdk.
  class XooaClient
    attr_accessor :api_token

    attr_accessor :app_url

    attr_accessor :debugging

    # Initializes the XooaClient
    #
    # @param api_token API Token for the app and the identity
    # @param app_url URL for the app to invoke
    # @return XooaClient
    def initialize(api_token = '', app_url = 'https://api.xooa.com/api/v1')

      @api_oken = api_token
      @app_url = app_url
      @debugging = false
    end

    # Validate the appUrl and Api Token
    #
    # @return IdentityResponse
    #
    def validate

      Xooa::Api::IdentitiesApi.new(app_url, api_token, debugging).current_identity
    end

    # Subscribe to all the events from the App
    #
    # @param callback callback method to be invoked upon an event
    def subscribe(callback)

      block = method(callback)
      @xooaSocket = Xooa::Util::XooaSocket.new(app_url, api_token).subscribe_events(block)
    end

    # Unsubscribe from all the events
    def unsubscribe

      @xooaSocket.unsubscribe
    end

    # Use this endpoint to Get the block number and hashes of current (highest) block in the network
    #
    # @param timeout Request timeout in millisecond
    # @return CurrentBlockResponse
    def get_current_block(timeout = '4000')

      Xooa::Api::BlockChainApi.new(app_url, api_token, debugging).get_current_block(timeout)
    end

    # Use this endpoint to Get the block number and hashes of current (highest) block in the network
    #
    # @return PendingTransactionResponse
    def get_current_block_async

      Xooa::Api::BlockChainApi.new(app_url, api_token, debugging).get_current_block_async
    end

    # Use this endpoint to Get the number of transactions and hashes of a specific block in the network
    #
    # @param block_number block number for which data is required
    # @param timeout Request timeout in millisecond
    # @return BlockResponse
    def get_block_by_number(block_number, timeout = '4000')

      Xooa::Api::BlockChainApi.new(app_url, api_token, debugging).get_block_by_number(block_number, timeout)
    end

    # Use this endpoint to Get the number of transactions and hashes of a specific block in the network
    #
    # @param block_number block number for which data is required
    # @return PendingTransactionResponse
    def get_block_by_number_async(block_number)

      Xooa::Api::BlockChainApi.new(app_url, api_token, debugging).get_block_by_number_async(block_number)
    end

    # Use this endpoint to Get transaction by transaction id
    #
    # @param transaction_id transactionId from a previous transaction
    # @param timeout Request timeout in millisecond
    # @return TransactionResponse
    def get_transaction_by_transaction_id(transaction_id, timeout = '4000')

      Xooa::Api::BlockChainApi.new(app_url, api_token, debugging).get_transaction_by_transaction_id(transaction_id, timeout)
    end

    # Use this endpoint to Get transaction by transaction id
    #
    # @param transaction_id transactionId from a previous transaction
    # @return PendingTransactionResponse
    def get_transaction_by_transaction_id_async(transaction_id)

      Xooa::Api::BlockChainApi.new(app_url, api_token, debugging).get_transaction_by_transaction_id_async(transaction_id)
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
    # @param timeout Request timeout in millisecond
    # @return InvokeResponse
    def invoke(function_name, args, timeout = '4000')

      Xooa::Api::InvokeApi.new(app_url, api_token, debugging).invoke(function_name, args, timeout)
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

      Xooa::Api::InvokeApi.new(app_url, api_token, debugging).invoke_async(function_name, args)
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
    # @param function_name Name of the smart contract function to be invoked
    # @param args the arguments to be passed to the smart contract
    # @param timeout Request timeout in millisecond
    # @return QueryResponse
    def query(function_name, args, timeout = '4000')

      Xooa::Api::QueryApi.new(app_url, api_token, debugging).query(function_name, args, timeout)
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
    # @param function_name Name of the smart contract function to be invoked
    # @param args the arguments to be passed to the smart contract
    # @return PendingTransactionResponse
    def query_async(function_name, args)

      Xooa::Api::QueryApi.new(app_url, api_token, debugging).query_async(function_name, args)
    end

    # This endpoint returns the result of previously submitted api request.
    #
    # @param result_id Returned in previous Query/Invoke/Participant Operation
    # @param timeout Request timeout in millisecond
    # @return QueryResponse
    def get_result_for_query(result_id, timeout = '4000')

      Xooa::Api::ResultApi.new(app_url, api_token, debugging).get_result_for_query(result_id, timeout)
    end

    # This endpoint returns the result of previously submitted api request.
    #
    # @param result_id Returned in previous Query/Invoke/Participant Operation
    # @param timeout Request timeout in millisecond
    # @return InvokeResponse
    def get_result_for_invoke(result_id, timeout = '4000')

      Xooa::Api::ResultApi.new(app_url, api_token, debugging).get_result_for_invoke(result_id, timeout)
    end

    # This endpoint returns the result of previously submitted api request.
    #
    # @param result_id Returned in previous Query/Invoke/Participant Operation
    # @param timeout Request timeout in millisecond
    # @return IdentityResponse
    def get_result_for_identities(result_id, timeout = '4000')

      Xooa::Api::ResultApi.new(app_url, api_token, debugging).get_result_for_identity(result_id, timeout)
    end

    # This endpoint returns the result of previously submitted api request.
    #
    # @param result_id Returned in previous Query/Invoke/Participant Operation
    # @param timeout Request timeout in millisecond
    # @return CurrentBlockResponse
    def get_result_for_current_block(result_id, timeout = '4000')

      Xooa::Api::ResultApi.new(app_url, api_token, debugging).get_result_for_current_block(result_id, timeout)
    end

    # This endpoint returns the result of previously submitted api request.
    #
    # @param result_id Returned in previous Query/Invoke/Participant Operation
    # @param timeout Request timeout in millisecond
    # @return BlockResponse
    def get_result_for_block_by_number(result_id, timeout = '4000')

      Xooa::Api::ResultApi.new(app_url, api_token, debugging).get_result_for_block_by_number(result_id, timeout)
    end

    # This endpoint returns the result of previously submitted api request.
    #
    # @param result_id Returned in previous Query/Invoke/Participant Operation
    # @param timeout Request timeout in millisecond
    # @return TransactionResponse
    def get_result_for_transaction(result_id, timeout = '4000')

      Xooa::Api::ResultApi.new(app_url, api_token, debugging).get_result_for_transaction(result_id, timeout)
    end

    # This endpoint returns authenticated identity information
    #
    # @param timeout Request timeout in millisecond
    # @return IdentityResponse
    def current_identity(timeout = '4000')

      Xooa::Api::IdentitiesApi.new(app_url, api_token, debugging).current_identity(timeout)
    end

    # Get all identities from the identity registry
    # Required permission: manage identities (canManageIdentities=true)
    #
    # @param timeout Request timeout in millisecond
    # @return Array[IdentityResponse]
    def get_identities(timeout = '4000')

      Xooa::Api::IdentitiesApi.new(app_url, api_token, debugging).get_identities(timeout)
    end

    # The Enroll identity endpoint is used to enroll new identities for the smart contract app.
    # A success response includes the API Token generated for the identity.
    # This API Token can be used to call API End points on behalf of the enrolled identity.
    # This endpoint provides equivalent functionality to adding new identity manually using Xooa console,
    # and identities added using this endpoint will appear, and can be managed, using Xooa console under the identities tab of the smart contract app
    # Required permission: manage identities (canManageIdentities=true)
    #
    # @param identity_request Identity Request data to create a new identity
    # @param timeout Request timeout in millisecond
    # @return IdentityResponse
    def enroll_identity(identity_request, timeout = '4000')

      Xooa::Api::IdentitiesApi.new(app_url, api_token, debugging).enroll_identity(identity_request, timeout)
    end

    # The Enroll identity endpoint is used to enroll new identities for the smart contract app.
    # A success response includes the API Token generated for the identity.
    # This API Token can be used to call API End points on behalf of the enrolled identity.
    # This endpoint provides equivalent functionality to adding new identity manually using Xooa console,
    # and identities added using this endpoint will appear, and can be managed, using Xooa console under the identities tab of the smart contract app
    # Required permission: manage identities (canManageIdentities=true)
    #
    # @param identity_request Identity Request data to create a new identity
    # @return PendingTransactionResponse
    def enroll_identity_async(identity_request)

      Xooa::Api::IdentitiesApi.new(app_url, api_token, debugging).enroll_identity_async(identity_request)
    end

    # Generates new identity API Token
    # Required permission: manage identities (canManageIdentities=true)
    #
    # @param identity_id Identity id for which to create a new API Token
    # @param timeout Request timeout in millisecond
    # @return IdentityResponse
    def regenerate_identity_api_token(identity_id, timeout = '4000')

      Xooa::Api::IdentitiesApi.new(app_url, api_token, debugging).regenerate_identity_api_token(identity_id, timeout)
    end

    # Get the specified identity from the identity registry.
    # Required permission: manage identities (canManageIdentities=true)
    #
    # @param identity_id Identity id for which to find the Identity details
    # @param timeout Request timeout in millisecond
    # @return IdentityResponse
    def get_identity(identity_id, timeout = '4000')

      Xooa::Api::IdentitiesApi.new(app_url, api_token, debugging).get_identity(identity_id, timeout)
    end

    # Deletes an identity.
    # Required permission: manage identities (canManageIdentities=true)
    #
    # @param identity_id Identity id for which to delete the Identity details
    # @param timeout Request timeout in millisecond
    # @return boolean
    def delete_identity(identity_id, timeout = '4000')

      Xooa::Api::IdentitiesApi.new(app_url, api_token, debugging).delete_identity(identity_id, timeout)
    end
  end
end
