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

require './spec/spec_helper'
require 'xooa'
require 'xooa/api/ResultApi'
require 'xooa/request/IdentityRequest'
require 'xooa/response/IdentityResponse'
require 'xooa/response/InvokeResponse'
require 'xooa/response/QueryResponse'
require 'xooa/response/CurrentBlockResponse'
require 'xooa/response/BlockResponse'
require 'xooa/response/PendingTransactionResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'

RSpec.describe Xooa::Api::ResultApi do

  before do
    @instance = Xooa::XooaClient.new('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiI3MlQ3WjRBLUFNUE1ER0ctTkhKMlMxUi1CRDJZTkpKIiwiQXBpU2VjcmV0IjoiMEk3WjFRU1NHblZ3WVhnIiwiUGFzc3BocmFzZSI6IjM3ZGJmYmI3YmM0NTE0NTBjODIyODg0NTM5YTQ3ZTY5IiwiaWF0IjoxNTQ0NzgzMzIwfQ.pcOdvHM0KTzf_b0vZoReSwsSM3SYicAOMSgacfy-mVg')
  end

  describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(Xooa::XooaClient)
    end
  end

  it 'Test for response of Result API for Query' do

    begin
      pendingResponse = @instance.query_async('get', ['args1'])

      sleep(4)

      queryResponse = @instance.get_result_for_query(pendingResponse.result_id, '4000')

      expect(queryResponse).to be_instance_of(Xooa::Response::QueryResponse)

      expect(queryResponse.payload).to_not be_nil

      expect(queryResponse.payload).to_not be('')

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

      expect(xrte.result_id).to_not be_nil
      expect(xrte.result_url).to_not be_nil

      expect(xrte.result_id).to_not be('')
      expect(xrte.result_url).to_not be('')
    end
  end

  it 'Test for response of Result API for Invoke' do

    begin
      pendingResponse = @instance.invoke_async('set', ['args1', '234'])

      sleep(4)

      invokeResponse = @instance.get_result_for_invoke(pendingResponse.result_id, '4000')

      expect(invokeResponse).to be_instance_of(Xooa::Response::InvokeResponse)

      expect(invokeResponse.txn_id).to_not be_nil
      expect(invokeResponse.payload).to_not be_nil

      expect(invokeResponse.txn_id).to_not be('')
      expect(invokeResponse.payload).to_not be('')

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

      expect(xrte.result_id).to_not be_nil
      expect(xrte.result_url).to_not be_nil

      expect(xrte.result_id).to_not be('')
      expect(xrte.result_url).to_not be('')
    end
  end

  it 'Test for response of Result API for Identity' do

    begin
      attr = Xooa::Response::Attr.new('Test', 'Test', false)
      attributes = Array.new.push(attr)
      identityRequest = Xooa::Request::IdentityRequest.new('Kavi', 'r', false, attributes)

      pendingResponse = @instance.enroll_identity_async(identityRequest)

      sleep(4)

      identityResponse = @instance.get_result_for_identities(pendingResponse.result_id, '4000')

      expect(identityResponse).to be_instance_of(Xooa::Response::IdentityResponse)

      expect(identityResponse.identity_name).to_not be_nil
      expect(identityResponse.api_token).to_not be_nil
      expect(identityResponse.id).to_not be_nil
      expect(identityResponse.access).to_not be_nil
      expect(identityResponse.can_manage_identities).to_not be_nil
      expect(identityResponse.attributes).to_not be_nil

      expect(identityResponse.identity_name).to_not be('')
      expect(identityResponse.api_token).to_not be('')
      expect(identityResponse.id).to_not be('')
      expect(identityResponse.access).to_not be('')
      expect(identityResponse.can_manage_identities).to_not be('')
      expect(identityResponse.attributes).to_not be('')

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

      expect(xrte.result_id).to_not be_nil
      expect(xrte.result_url).to_not be_nil

      expect(xrte.result_id).to_not be("")
      expect(xrte.result_url).to_not be("")
    end
  end

  it 'Test for response of Result API for Current Block' do

    begin
      pendingResponse = @instance.get_current_block_async

      sleep(4)

      currentBlock = @instance.get_result_for_current_block(pendingResponse.result_id, '4000')

      expect(currentBlock).to be_instance_of(Xooa::Response::CurrentBlockResponse)

      expect(currentBlock.block_number).to_not be_nil
      expect(currentBlock.current_block_hash).to_not be_nil
      expect(currentBlock.previous_block_hash).to_not be_nil

      expect(currentBlock.block_number).to_not be('')
      expect(currentBlock.current_block_hash).to_not be('')
      expect(currentBlock.previous_block_hash).to_not be('')

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

      expect(xrte.result_id).to_not be_nil
      expect(xrte.result_url).to_not be_nil

      expect(xrte.result_id).to_not be('')
      expect(xrte.result_url).to_not be('')
    end
  end

  it 'Test for response of Result API for Block Number' do

    begin
      blockData = @instance.get_block_by_number_async('10')

      sleep(4)

      blockResponse = @instance.get_result_for_block_by_number(blockData.result_id, '4000')

      expect(blockResponse).to be_instance_of(Xooa::Response::BlockResponse)

      expect(blockResponse.previous_hash).to_not be_nil
      expect(blockResponse.data_hash).to_not be_nil
      expect(blockResponse.block_number).to_not be_nil
      expect(blockResponse.number_of_transactions).to_not be_nil

      expect(blockResponse.previous_hash).to_not be('')
      expect(blockResponse.data_hash).to_not be('')
      expect(blockResponse.block_number).to_not be('')
      expect(blockResponse.number_of_transactions).to_not be('')

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

      expect(xrte.result_id).to_not be_nil
      expect(xrte.result_url).to_not be_nil

      expect(xrte.result_id).to_not be('')
      expect(xrte.result_url).to_not be('')
    end
  end
end
