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
    @instance = Xooa::XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiI3MlQ3WjRBLUFNUE1ER0ctTkhKMlMxUi1CRDJZTkpKIiwiQXBpU2VjcmV0IjoiMEk3WjFRU1NHblZ3WVhnIiwiUGFzc3BocmFzZSI6IjM3ZGJmYmI3YmM0NTE0NTBjODIyODg0NTM5YTQ3ZTY5IiwiaWF0IjoxNTQ0NzgzMzIwfQ.pcOdvHM0KTzf_b0vZoReSwsSM3SYicAOMSgacfy-mVg")
  end

  describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(Xooa::XooaClient)
    end
  end


  #describe 'Result for Query' do
    it 'Test for response of Result API for Query' do

      begin
        queryResponse = @instance.getResultForQuery("1f4df422-f783-4039-a804-04991d3a38bd", "4000")

        expect(queryResponse).to be_instance_of(Xooa::Response::QueryResponse)

        expect(queryResponse.payload).to_not be_nil

        expect(queryResponse.payload).to_not be("")

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")
      end

    end
  #end


  #describe 'Result for Invoke' do
    it 'Test for response of Result API for Invoke' do

      begin
        invokeResponse = @instance.getResultForInvoke("61b280e5-8467-4a1d-a292-19425d81ff92", "4000")

        expect(invokeResponse).to be_instance_of(Xooa::Response::InvokeResponse)

        expect(invokeResponse.txnId).to_not be_nil
        expect(invokeResponse.payload).to_not be_nil

        expect(invokeResponse.txnId).to_not be("")
        expect(invokeResponse.payload).to_not be("")

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
  #end


  #describe 'Result for Identity' do
    it 'Test for response of Result API for Identity' do

      begin
        identityResponse = @instance.getResultForIdentities("1b03e21b-01da-46fd-aa93-fc449cce519f", "4000")

        expect(identityResponse).to be_instance_of(Xooa::Response::IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.apiToken).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil
        expect(identityResponse.attributes).to_not be_nil

        expect(identityResponse.identityName).to_not be("")
        expect(identityResponse.apiToken).to_not be("")
        expect(identityResponse.id).to_not be("")
        expect(identityResponse.access).to_not be("")
        expect(identityResponse.canManageIdentities).to_not be("")
        expect(identityResponse.attributes).to_not be("")

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
  #end


  #describe 'Result for Current Block' do
    it 'Test for response of Result API for Current Block' do

      begin
        currentBlock = @instance.getResultForCurrentBlock("bd7481c6-3914-4095-8c0f-f6e0e89f3598", "4000")

        expect(currentBlock).to be_instance_of(Xooa::Response::CurrentBlockResponse)

        expect(currentBlock.blockNumber).to_not be_nil
        expect(currentBlock.currentBlockHash).to_not be_nil
        expect(currentBlock.previousBlockHash).to_not be_nil

        expect(currentBlock.blockNumber).to_not be("")
        expect(currentBlock.currentBlockHash).to_not be("")
        expect(currentBlock.previousBlockHash).to_not be("")

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
  #end


  #describe 'Result for Block Number' do
    it 'Test for response of Result API for Block Number' do

      begin
        blockResponse = @instance.getResultForBlockByNumber("cc95a5cb-3eeb-49f8-939d-d92622ecb81a", "4000")

        expect(blockResponse).to be_instance_of(Xooa::Response::BlockResponse)

        expect(blockResponse.previousHash).to_not be_nil
        expect(blockResponse.dataHash).to_not be_nil
        expect(blockResponse.blockNumber).to_not be_nil
        expect(blockResponse.numberOfTransactions).to_not be_nil

        expect(blockResponse.previousHash).to_not be("")
        expect(blockResponse.dataHash).to_not be("")
        expect(blockResponse.blockNumber).to_not be("")
        expect(blockResponse.numberOfTransactions).to_not be("")

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
  #end

end
