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
require './lib/ruby/client/api/QueryApi'
require './lib/ruby/client/response/QueryResponse'
require './lib/ruby/client/response/PendingTransactionResponse'
require './lib/ruby/client/exception/XooaRequestTimeoutException'
require './lib/ruby/client/exception/XooaApiException'

RSpec.describe QueryApi do

  before do
    @instance = XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiJFMVpBQVNBLVBZU01WQkstS1BGM0JRUy1BMVQ1NVRFIiwiQXBpU2VjcmV0IjoibDVGS1pNanZUWHZlZkRWIiwiUGFzc3BocmFzZSI6IjMyNzNmNjg3MjE5MTM4ZjhlMmM1NzdiNzgwZmYzNjJhIiwiaWF0IjoxNTQ0NDMzNDQ4fQ.3s69b0wErmJe7LZC6zWISfbGQY4IR6gMODjPsgUYPyY")
  end

  describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(XooaClient)
    end
  end

  #describe 'Query blockchain' do
    it 'Test for response on Querying blockchain' do

      begin
        queryResponse = @instance.query("get", ["args1"], "4000")

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


  #describe 'Query blockchain Async' do
    it 'Test for response on Querying blockchain' do

      begin
        pendingResponse = @instance.invokeAsync("get", ["args1"])

        expect(pendingResponse).to be_instance_of(PendingTransactionResponse)

        expect(pendingResponse.resultId).to_not be_nil
        expect(pendingResponse.resultUrl).to_not be_nil

        expect(pendingResponse.resultId).to_not be("")
        expect(pendingResponse.resultUrl).to_not be("")
      end

    end
  #end

end