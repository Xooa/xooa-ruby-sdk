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
require 'xooa/api/IdentitiesApi'
require 'xooa/response/IdentityResponse'
require 'xooa/request/IdentityRequest'
require 'xooa/response/PendingTransactionResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'

RSpec.describe Xooa::Api::IdentitiesApi do

  before do
    @instance = Xooa::XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiI3MlQ3WjRBLUFNUE1ER0ctTkhKMlMxUi1CRDJZTkpKIiwiQXBpU2VjcmV0IjoiMEk3WjFRU1NHblZ3WVhnIiwiUGFzc3BocmFzZSI6IjM3ZGJmYmI3YmM0NTE0NTBjODIyODg0NTM5YTQ3ZTY5IiwiaWF0IjoxNTQ0NzgzMzIwfQ.pcOdvHM0KTzf_b0vZoReSwsSM3SYicAOMSgacfy-mVg")
  end

  describe 'test an instance of XooaClient' do
    it 'should create an instance of XooaClient' do
      expect(@instance).to be_instance_of(Xooa::XooaClient)
    end
  end


  #describe 'Current Identity' do
    it 'Test for response of Current Identity' do

      begin
        identityResponse = @instance.currentIdentity("4000")

        expect(identityResponse).to be_instance_of(Xooa::Response::IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil

        expect(identityResponse.identityName).to_not be("")
        expect(identityResponse.id).to_not be("")
        expect(identityResponse.access).to_not be("")
        expect(identityResponse.canManageIdentities).to_not be("")

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

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
        expect(identityResponse).to be_instance_of(Xooa::Response::IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil

        expect(identityResponse.identityName).to_not be("")
        expect(identityResponse.id).to_not be("")
        expect(identityResponse.access).to_not be("")
        expect(identityResponse.canManageIdentities).to_not be("")

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

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

        attr = Xooa::Response::Attr.new("Test", "Test", false)
        attributes = Array.new.push(attr)
        identityRequest = Xooa::Request::IdentityRequest.new("Kavi", "r", false, attributes)

        identityResponse = @instance.enrollIdentity(identityRequest,"4000")

        expect(identityResponse).to be_instance_of(Xooa::Response::IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.apiToken).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil
        expect(identityResponse.attributes).to_not be_nil

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

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

        attr = Xooa::Response::Attr.new("Test", "Test", false)
        attributes = Array.new.push(attr)
        identityRequest = Xooa::Request::IdentityRequest.new("Kavi", "r", false, attributes)

        pendingResponse = @instance.enrollIdentityAsync(identityRequest)

        expect(pendingResponse).to be_instance_of(Xooa::Response::PendingTransactionResponse)

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
        identityResponse = @instance.regenerateIdentityApiToken("d0957501-f96b-4068-b54d-31bd474c7dc9", "4000")

        expect(identityResponse).to be_instance_of(Xooa::Response::IdentityResponse)

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

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

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
        identityResponse = @instance.getIdentity("d0957501-f96b-4068-b54d-31bd474c7dc9", "4000")

        expect(identityResponse).to be_instance_of(Xooa::Response::IdentityResponse)

        expect(identityResponse.identityName).to_not be_nil
        expect(identityResponse.id).to_not be_nil
        expect(identityResponse.access).to_not be_nil
        expect(identityResponse.canManageIdentities).to_not be_nil


        expect(identityResponse.identityName).to_not be("")
        expect(identityResponse.id).to_not be("")
        expect(identityResponse.access).to_not be("")
        expect(identityResponse.canManageIdentities).to_not be("")

      rescue Xooa::Exception::XooaRequestTimeoutException => xrte

        expect(xrte).to be_instance_of(Xooa::Exception::XooaRequestTimeoutException)

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
        response = @instance.deleteIdentity("90a03607-f5c7-4b52-adc7-9aad04cdda1c", "4000")

        expect(response).to be(true)

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
