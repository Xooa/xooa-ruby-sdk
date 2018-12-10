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
require './lib/ruby/client/XooaClient'
require './lib/ruby/client/api/ResultApi'
require './lib/ruby/client/response/IdentityResponse'
require './lib/ruby/client/response/InvokeResponse'
require './lib/ruby/client/response/QueryResponse'
require './lib/ruby/client/response/CurrentBlockResponse'
require './lib/ruby/client/response/BlockResponse'
require './lib/ruby/client/response/PendingTransactionResponse'
require './lib/ruby/client/exception/XooaRequestTimeoutException'
require './lib/ruby/client/exception/XooaApiException'

RSpec.describe ResultApi do

  before do
    @instance = XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiJFMVpBQVNBLVBZU01WQkstS1BGM0JRUy1BMVQ1NVRFIiwiQXBpU2VjcmV0IjoibDVGS1pNanZUWHZlZkRWIiwiUGFzc3BocmFzZSI6IjMyNzNmNjg3MjE5MTM4ZjhlMmM1NzdiNzgwZmYzNjJhIiwiaWF0IjoxNTQ0NDMzNDQ4fQ.3s69b0wErmJe7LZC6zWISfbGQY4IR6gMODjPsgUYPyY")
  end

  describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(XooaClient)
    end
  end


  #describe 'Result for Query' do
    it 'Test for response of Result API for Query' do

      begin
        queryResponse = @instance.getResultForQuery("5cac705d-62a5-475d-adef-edca1d98740e", "4000")

        expect(queryResponse).to be_instance_of(QueryResponse)

        expect(queryResponse.payload).to_not be_nil

        expect(queryResponse.payload).to_not be("")

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

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
        invokeResponse = @instance.getResultForInvoke("74c34679-b1d8-4616-a0b6-4015db30b213", "4000")

        expect(invokeResponse).to be_instance_of(InvokeResponse)

        expect(invokeResponse.txnId).to_not be_nil
        expect(invokeResponse.payload).to_not be_nil

        expect(invokeResponse.txnId).to_not be("")
        expect(invokeResponse.payload).to_not be("")

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

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
        identityResponse = @instance.getResultForIdentities("57c36576-b083-485e-9721-1ef1743474d2", "4000")

        expect(identityResponse).to be_instance_of(IdentityResponse)

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

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

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
        currentBlock = @instance.getResultForCurrentBlock("1c41cde1-3810-48ae-8784-722fba151cbb", "4000")

        expect(currentBlock).to be_instance_of(CurrentBlockResponse)

        expect(currentBlock.blockNumber).to_not be_nil
        expect(currentBlock.currentBlockHash).to_not be_nil
        expect(currentBlock.previousBlockHash).to_not be_nil

        expect(currentBlock.blockNumber).to_not be("")
        expect(currentBlock.currentBlockHash).to_not be("")
        expect(currentBlock.previousBlockHash).to_not be("")

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

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
        blockResponse = @instance.getResultForBlockByNumber("d3cb73a5-3b20-407f-afc2-99bd3924b873", "4000")

        expect(blockResponse).to be_instance_of(BlockResponse)

        expect(blockResponse.previousHash).to_not be_nil
        expect(blockResponse.dataHash).to_not be_nil
        expect(blockResponse.blockNumber).to_not be_nil
        expect(blockResponse.numberOfTransactions).to_not be_nil

        expect(blockResponse.previousHash).to_not be("")
        expect(blockResponse.dataHash).to_not be("")
        expect(blockResponse.blockNumber).to_not be("")
        expect(blockResponse.numberOfTransactions).to_not be("")

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
  #end

end