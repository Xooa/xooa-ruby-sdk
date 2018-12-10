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

require './spec/spec_helper'
require './lib/ruby/client/api/BlockchainApi'
require './lib/ruby/client/response/CurrentBlockResponse'
require './lib/ruby/client/response/BlockResponse'
require './lib/ruby/client/response/PendingTransactionResponse'
require './lib/ruby/client/exception/XooaRequestTimeoutException'
require './lib/ruby/client/exception/XooaApiException'
require './lib/ruby/client/XooaClient'

RSpec.describe BlockChainApi do

  before do
    @instance = XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiJFMVpBQVNBLVBZU01WQkstS1BGM0JRUy1BMVQ1NVRFIiwiQXBpU2VjcmV0IjoibDVGS1pNanZUWHZlZkRWIiwiUGFzc3BocmFzZSI6IjMyNzNmNjg3MjE5MTM4ZjhlMmM1NzdiNzgwZmYzNjJhIiwiaWF0IjoxNTQ0NDMzNDQ4fQ.3s69b0wErmJe7LZC6zWISfbGQY4IR6gMODjPsgUYPyY")
  end

 describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(XooaClient)
    end
  end



  #describe 'Current Block Test' do
    it 'Test the block data' do

      begin

        currentBlock = @instance.getCurrentBlock

        expect(currentBlock).to be_instance_of(CurrentBlockResponse)

        expect(currentBlock.blockNumber).to_not be_nil
        expect(currentBlock.currentBlockHash).to_not be_nil
        expect(currentBlock.previousBlockHash).to_not be_nil

=begin
        expect(currentBlock.blockNumber).to eq ("5")
        expect(currentBlock.currentBlockHash).to eq ("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9")
        expect(currentBlock.previousBlockHash).to eq ("9JCVXpkI6ICc5RnIsIiN1IzUeyJhbGciOiJI")
=end

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      #rescue XooaApiException => xae

        #expect(xae).to be_instance_of(XooaApiException)

        #expect(xae.errorMessage).to_not be_nil
        #expect(xae.errorCode).to_not be_nil
      end

    end
  #end


  #describe 'Current Block Async Test' do
    it 'Test the response data' do

      begin

        pendingResponse = @instance.getCurrentBlockAsync

        expect(pendingResponse).to be_instance_of(PendingTransactionResponse)

        expect(pendingResponse.resultId).to_not be_nil
        expect(pendingResponse.resultUrl).to_not be_nil

=begin
        expect(pendingResponse.resultId).to eq (response.resultId)
        expect(pendingResponse.resultUrl).to eq(response.resultUrl)
=end

      #rescue XooaApiException => xae

      #  expect(xae).to be_instance_of(XooaApiException)

      #  expect(xae.errorMessage).to_not be_nil
      #  expect(xae.errorCode).to_not be_nil
      end

    end
  #end


  #describe 'Block Data Test' do
    it 'Test the block data' do

      begin

        blockData = @instance.getBlockByNumber("10")

        expect(blockData).to be_instance_of(BlockResponse)

        expect(blockData.previousHash).to_not be_nil
        expect(blockData.dataHash).to_not be_nil
        expect(blockData.blockNumber).to_not be_nil
        expect(blockData.numberOfTransactions).to_not be_nil

=begin
        expect(blockData.previousHash).to eq(response.previousHash)
        expect(blockData.dataHash).to eq(response.dataHash)
        expect(blockData.blockNumber).to eq(response.blockNumber)
        expect(blockData.numberOfTransactions).to eq(response.numberOfTransactions)
=end

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      #rescue XooaApiException => xae

       # expect(xae).to be_instance_of(XooaApiException)

        #expect(xae.errorMessage).to_not be_nil
        #expect(xae.errorCode).to_not be_nil
      end

    end
  #end


  #describe 'Block Data Async Test' do
    it 'Test the response data' do

      begin

        pendingResponse = @instance.getBlockByNumberAsync("10")

        expect(pendingResponse).to be_instance_of(PendingTransactionResponse)

        expect(pendingResponse.resultId).to_not be_nil
        expect(pendingResponse.resultUrl).to_not be_nil

=begin
        expect(pendingResponse.resultId).to eq(response.resultId)
        expect(pendingResponse.resultUrl).to eq(response.resultUrl)
=end

      #rescue XooaApiException => xae

        #expect(xae).to be_instance_of(XooaApiException)

        #expect(xae.errorMessage).to_not be_nil
        #expect(xae.errorCode).to_not be_nil
      end

    end
  #end

end