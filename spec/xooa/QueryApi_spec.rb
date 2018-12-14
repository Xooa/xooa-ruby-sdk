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
require 'xooa/api/QueryApi'
require 'xooa/response/QueryResponse'
require 'xooa/response/PendingTransactionResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'

RSpec.describe Xooa::Api::QueryApi do

  before do
    @instance = Xooa::XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiJQTVQ4NlpBLTcxRk1ZRjAtTjI1UjFBVC1BTlhIOUJZIiwiQXBpU2VjcmV0IjoiaEs0aDd2MWxURjI0OWNmIiwiUGFzc3BocmFzZSI6ImM0Njc5ZjA3ZWQ3N2QxMjY0OWE5ZWQ4NmU0MTRmMDlhIiwiaWF0IjoxNTQ0NzA1NzMwfQ.0PArUpK_33jfsCHDxZwUCPe3sdB8qTAvLyeqryzgD84")
  end

  describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(Xooa::XooaClient)
    end
  end

  #describe 'Query blockchain' do
  it 'Test for response on Querying blockchain' do

    begin
      queryResponse = @instance.query("get", ["args1"], "4000")

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


  #describe 'Query blockchain Async' do
  it 'Test for response on Querying blockchain' do

    begin
      pendingResponse = @instance.invokeAsync("get", ["args1"])

      expect(pendingResponse).to be_instance_of(Xooa::Response::PendingTransactionResponse)

      expect(pendingResponse.resultId).to_not be_nil
      expect(pendingResponse.resultUrl).to_not be_nil

      expect(pendingResponse.resultId).to_not be("")
      expect(pendingResponse.resultUrl).to_not be("")
    end

  end
  #end

end
