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
    @instance = Xooa::XooaClient.new('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiI3MlQ3WjRBLUFNUE1ER0ctTkhKMlMxUi1CRDJZTkpKIiwiQXBpU2VjcmV0IjoiMEk3WjFRU1NHblZ3WVhnIiwiUGFzc3BocmFzZSI6IjM3ZGJmYmI3YmM0NTE0NTBjODIyODg0NTM5YTQ3ZTY5IiwiaWF0IjoxNTQ0NzgzMzIwfQ.pcOdvHM0KTzf_b0vZoReSwsSM3SYicAOMSgacfy-mVg')
  end

  it 'should create an instance of XooaClient' do
    expect(@instance).to be_instance_of(Xooa::XooaClient)
  end

  it 'Test the block data' do

    begin
      currentBlock = @instance.get_current_block('10000')

      currentBlock.display

      expect(currentBlock).to be_instance_of(Xooa::Response::CurrentBlockResponse)

      expect(currentBlock.block_number).to_not be_nil
      expect(currentBlock.current_block_hash).to_not be_nil
      expect(currentBlock.previous_block_hash).to_not be_nil

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

      expect(xrte.result_id).to_not be_nil
      expect(xrte.result_url).to_not be_nil

      expect(xrte.result_id).to_not be('')
      expect(xrte.result_url).to_not be('')
    end
  end

  it 'Test the response data' do

    begin
      pendingResponse = @instance.get_current_block_async

      pendingResponse.display

      expect(pendingResponse).to be_instance_of(Xooa::Response::PendingTransactionResponse)

      expect(pendingResponse.result_id).to_not be_nil
      expect(pendingResponse.result_url).to_not be_nil
    end
  end

  it 'Test the block data' do

    begin
      blockData = @instance.get_block_by_number('10','10000')

      blockData.display

      expect(blockData).to be_instance_of(Xooa::Response::BlockResponse)

      expect(blockData.previous_hash).to_not be_nil
      expect(blockData.data_hash).to_not be_nil
      expect(blockData.block_number).to_not be_nil
      expect(blockData.number_of_transactions).to_not be_nil

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

      expect(xrte.result_id).to_not be_nil
      expect(xrte.result_url).to_not be_nil

      expect(xrte.result_id).to_not be('')
      expect(xrte.result_url).to_not be('')
    end
  end

  it 'Test the response data' do

    begin
      pendingResponse = @instance.get_block_by_number_async('10')

      pendingResponse.display

      expect(pendingResponse).to be_instance_of(Xooa::Response::PendingTransactionResponse)

      expect(pendingResponse.result_id).to_not be_nil
      expect(pendingResponse.result_url).to_not be_nil
    end
  end

  it 'Test the Transaction by TransactionId' do

    begin
      invokeResponse =  @instance.invoke('set', ['args1', '1'], '10000')

      transactionData = @instance.get_transaction_by_transaction_id(invokeResponse.txn_id, '10000')

      transactionData.display

      expect(transactionData).to be_instance_of(Xooa::Response::TransactionResponse)

      expect(transactionData.transaction_id).to_not be_nil
      expect(transactionData.smart_contract).to_not be_nil
      expect(transactionData.creator_msp_id).to_not be_nil
      expect(transactionData.endorser_msp_id).to_not be_nil
      expect(transactionData.transaction_type).to_not be_nil
      expect(transactionData.read_set).to_not be_nil
      expect(transactionData.write_set).to_not be_nil

    rescue Xooa::Exception::XooaRequestTimeoutException => xrte

      expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

      expect(xrte.result_id).to_not be_nil
      expect(xrte.result_url).to_not be_nil

      expect(xrte.result_id).to_not be('')
      expect(xrte.result_url).to_not be('')
    end
  end

  it 'Test the Transaction by TransactionId' do

    begin
      invokeResponse =  @instance.invoke('set', ['args1', '1'], '10000')

      pendingResponse = @instance.get_transaction_by_transaction_id_async(invokeResponse.txn_id)

      pendingResponse.display

      expect(pendingResponse).to be_instance_of(Xooa::Response::PendingTransactionResponse)

      expect(pendingResponse.result_id).to_not be_nil
      expect(pendingResponse.result_url).to_not be_nil
    end
  end

  it 'Test Exception from API' do

    begin
      pendingResponse = @instance.get_block_by_number("latest")

    rescue Xooa::Exception::XooaApiException => xae

      expect(xae.error_code).to_not be_nil
      expect(xae.error_message).to_not be_nil
    end
  end

end
