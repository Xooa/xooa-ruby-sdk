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

require 'spec_helper'
require 'xooa'
require 'xooa/api/InvokeApi'
require 'xooa/response/InvokeResponse'
require 'xooa/response/PendingTransactionResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'

RSpec.describe Xooa::Api::InvokeApi do

  before do
    @instance = Xooa::XooaClient.new('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiI3MlQ3WjRBLUFNUE1ER0ctTkhKMlMxUi1CRDJZTkpKIiwiQXBpU2VjcmV0IjoiMEk3WjFRU1NHblZ3WVhnIiwiUGFzc3BocmFzZSI6IjM3ZGJmYmI3YmM0NTE0NTBjODIyODg0NTM5YTQ3ZTY5IiwiaWF0IjoxNTQ0NzgzMzIwfQ.pcOdvHM0KTzf_b0vZoReSwsSM3SYicAOMSgacfy-mVg')
  end

  describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(Xooa::XooaClient)
    end
  end

  it 'Test for response on Invoking blockchain' do

    begin
      invokeResponse = @instance.invoke('set', ['args1', '4000'])

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

  it 'Test for response on Invoking blockchain' do

    begin
      pendingResponse = @instance.invoke_async('set', ['args1', '67yg'])

      expect(pendingResponse).to be_instance_of(Xooa::Response::PendingTransactionResponse)

      expect(pendingResponse.result_id).to_not be_nil
      expect(pendingResponse.result_url).to_not be_nil

      expect(pendingResponse.result_id).to_not be('')
      expect(pendingResponse.result_url).to_not be('')
    end
  end
end
