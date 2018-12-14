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

require 'spec_helper'
require 'xooa/api/BlockchainApi'
require 'xooa/response/CurrentBlockResponse'
require 'xooa/response/BlockResponse'
require 'xooa/response/PendingTransactionResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'
require 'xooa'

RSpec.describe Xooa::Api::BlockChainApi do

  before do
    @instance = Xooa::XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiI3MlQ3WjRBLUFNUE1ER0ctTkhKMlMxUi1CRDJZTkpKIiwiQXBpU2VjcmV0IjoiMEk3WjFRU1NHblZ3WVhnIiwiUGFzc3BocmFzZSI6IjM3ZGJmYmI3YmM0NTE0NTBjODIyODg0NTM5YTQ3ZTY5IiwiaWF0IjoxNTQ0NzgzMzIwfQ.pcOdvHM0KTzf_b0vZoReSwsSM3SYicAOMSgacfy-mVg")
  end

  #describe 'test an instance of XooaClient' do
  it 'should create an instance of XooaClient' do
    expect(@instance).to be_instance_of(Xooa::XooaClient)
  end
  #end


  #describe 'Current Block Test' do
  it 'Test the block data' do

    begin

      currentBlock = @instance.getCurrentBlock

      expect(currentBlock).to be_instance_of(Xooa::Response::CurrentBlockResponse)

      expect(currentBlock.blockNumber).to_not be_nil
      expect(currentBlock.currentBlockHash).to_not be_nil
      expect(currentBlock.previousBlockHash).to_not be_nil

=begin
        expect(currentBlock.blockNumber).to eq ("5")
        expect(currentBlock.currentBlockHash).to eq ("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9")
        expect(currentBlock.previousBlockHash).to eq ("9JCVXpkI6ICc5RnIsIiN1IzUeyJhbGciOiJI")
=end

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

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

      expect(pendingResponse).to be_instance_of(Xooa::Response::PendingTransactionResponse)

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

      expect(blockData).to be_instance_of(Xooa::Response::BlockResponse)

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

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

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

      expect(pendingResponse).to be_instance_of(Xooa::Response::PendingTransactionResponse)

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
