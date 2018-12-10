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
require './lib/ruby/client/XooaClient'
require './lib/ruby/client/api/IdentitiesApi'
require './lib/ruby/client/response/IdentityResponse'
require './lib/ruby/client/request/IdentityRequest'
require './lib/ruby/client/response/PendingTransactionResponse'
require './lib/ruby/client/exception/XooaRequestTimeoutException'
require './lib/ruby/client/exception/XooaApiException'

RSpec.describe IdentitiesApi do

  before do
    @instance = XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiJFMVpBQVNBLVBZU01WQkstS1BGM0JRUy1BMVQ1NVRFIiwiQXBpU2VjcmV0IjoibDVGS1pNanZUWHZlZkRWIiwiUGFzc3BocmFzZSI6IjMyNzNmNjg3MjE5MTM4ZjhlMmM1NzdiNzgwZmYzNjJhIiwiaWF0IjoxNTQ0NDMzNDQ4fQ.3s69b0wErmJe7LZC6zWISfbGQY4IR6gMODjPsgUYPyY")
  end

  describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(XooaClient)
    end
  end


  #describe 'Current Identity' do
    it 'Test for response of Current Identity' do

      begin
        identityResponse = @instance.currentIdentity("4000")

        expect(identityResponse).to be_instance_of(IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil

        expect(identityResponse.identityName).to_not be("")
        expect(identityResponse.id).to_not be("")
        expect(identityResponse.access).to_not be("")
        expect(identityResponse.canManageIdentities).to_not be("")

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
  #end

  #describe 'Get All Identities' do
    it 'Test for response of Get All Identities' do

      begin
        identityResponses = @instance.getIdentities("4000")

        identityResponse = identityResponses[0]
        expect(identityResponse).to be_instance_of(IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil

        expect(identityResponse.identityName).to_not be("")
        expect(identityResponse.id).to_not be("")
        expect(identityResponse.access).to_not be("")
        expect(identityResponse.canManageIdentities).to_not be("")

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
  #end


  #describe 'Enroll Identity' do
    it 'Test for response of Enroll Identity' do

      begin

        attr = Attr.new("Test", "Test", false)
        attributes = Array.new.push(attr)
        identityRequest = IdentityRequest.new("Kavi", "r", false, attributes)

        identityResponse = @instance.enrollIdentity(identityRequest,"4000")

        expect(identityResponse).to be_instance_of(IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.apiToken).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil
        expect(identityResponse.attributes).to_not be_nil

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
 # end


  #describe 'Enroll Identity Async' do
    it 'Test for response of Enroll Identity Async' do

      begin

        attr = Attr.new("Test", "Test", false)
        attributes = Array.new.push(attr)
        identityRequest = IdentityRequest.new("Kavi", "r", false, attributes)

        pendingResponse = @instance.enrollIdentityAsync(identityRequest)

        expect(pendingResponse).to be_instance_of(PendingTransactionResponse)

        expect(pendingResponse.resultId).to_not be_nil
        expect(pendingResponse.resultUrl).to_not be_nil

        expect(pendingResponse.resultId).to_not be("")
        expect(pendingResponse.resultUrl).to_not be("")

      end

    end
  #end


  #describe 'Regenerate Identity Api Token' do
    it 'Test for response of Regenerate Identity Api Token' do

      begin
        identityResponse = @instance.regenerateIdentityApiToken("b0e9e3c6-97bf-498a-9301-bd1e499ca58c", "4000")

        expect(identityResponse).to be_instance_of(IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.apiToken).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil

        expect(identityResponse.identityName).to_not be("")
        expect(identityResponse.apiToken).to_not be("")
        expect(identityResponse.id).to_not be("")
        expect(identityResponse.access).to_not be("")
        expect(identityResponse.canManageIdentities).to_not be("")

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")

      end

    end
  #end


  #describe 'Get Identity' do
    it 'Test for response of Get Identity' do

      begin
        identityResponse = @instance.getIdentity("b0e9e3c6-97bf-498a-9301-bd1e499ca58c", "4000")

        expect(identityResponse).to be_instance_of(IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil


        expect(identityResponse.identityName).to_not be("")
        expect(identityResponse.id).to_not be("")
        expect(identityResponse.access).to_not be("")
        expect(identityResponse.canManageIdentities).to_not be("")

      rescue XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(XooaRequestTimeoutException)

        expect(xrte.resultId).to_not be_nil
        expect(xrte.resultUrl).to_not be_nil

        expect(xrte.resultId).to_not be("")
        expect(xrte.resultUrl).to_not be("")


      end

    end
  #end


 # describe 'Delete Identity' do
    it 'Test for response of Delete Identity' do

      begin
        response = @instance.deleteIdentity("814fe5c0-bcd2-4b35-bf8e-6d4571f68489", "4000")

        expect(response).to be(true)

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