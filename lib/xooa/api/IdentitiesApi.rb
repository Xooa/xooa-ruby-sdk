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
require 'uri'

require 'xooa/util/Request'
require 'xooa/response/IdentityResponse'
require 'xooa/response/PendingTransactionResponse'
require 'xooa/exception/XooaRequestTimeoutException'
require 'xooa/exception/XooaApiException'

module Xooa
  module Api

    class IdentitiesApi

      attr_accessor :requestUtil

      attr_accessor :logger

      attr_accessor :debugging

      def initialize(appUrl, apiToken, debugging)

        @appUrl = appUrl
        @apiToken = apiToken
        @requestUtil = Xooa::Util::RequestUtil.new
        @logger = Logger.new(STDOUT)
        @debugging = debugging
      end


      # This endpoint returns authenticated identity information
      #
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def currentIdentity(timeout = "4000")

        path = "/identities/me/"

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'false'
        queryParams[:'timeout'] = timeout

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae
        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 200

          attributes = response['Attrs']

          attributesList = Array.new(0)

          if attributes.respond_to?("each")
            attributes.each do |attr|

              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
              attributesList.push(attribute)
            end
          else
            attribute = Xooa::Response::Attr.new(attributes['name'], attributes['value'], attributes['ecert'])
            attributesList.push(attribute)
          end

          return Xooa::Response::IdentityResponse.new(response['IdentityName'],
                                                      response['ApiToken'],
                                                      response['Id'],
                                                      response['AppId'],
                                                      response['Access'],
                                                      response['canManageIdentities'],
                                                      response['createdAt'],
                                                      response['updatedAt'],
                                                      attributesList)

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # Get all identities from the identity registry
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param timeout Request timeout in millisecond
      # @return Array[IdentityResponse]
      def getIdentities(timeout = "4000")

        path = "/identities/"

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'false'
        queryParams[:'timeout'] = timeout

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = nil

        begin

          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 200

          responses = Array.new(0)

          if response.respond_to?("each")
            response.each do |resp|

              attributes = resp['Attrs']

              attributesList = Array.new(0)

              if attributes.respond_to?("each")
                attributes.each do |attr|

                  attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
                  attributesList.push(attribute)
                end
              elsif attribute = Xooa::Response::Attr.new(attributes['name'], attributes['value'], attributes['ecert'])
                attributesList.push(attribute)
              end

              identityResponse = Xooa::Response::IdentityResponse.new(resp['IdentityName'],
                                                                      resp['ApiToken'],
                                                                      resp['Id'],
                                                                      resp['AppId'],
                                                                      resp['Access'],
                                                                      resp['canManageIdentities'],
                                                                      resp['createdAt'],
                                                                      resp['updatedAt'],
                                                                      attributesList)

              responses.push(identityResponse)
            end
          end

          return responses

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)

        end
      end


      # The Enroll identity endpoint is used to enroll new identities for the smart contract app.
      # A success response includes the API Token generated for the identity.
      # This API Token can be used to call API End points on behalf of the enrolled identity.
      # This endpoint provides equivalent functionality to adding new identity manually using Xooa console,
      # and identities added using this endpoint will appear, and can be managed, using Xooa console under the identities tab of the smart contract app
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identityRequest Identity Request data to create a new identity
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def enrollIdentity(identityRequest, timeout = "4000")

        path = "/identities/"

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'false'
        queryParams[:'timeout'] = timeout

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = identityRequest.toJson

        begin

          request = requestUtil.buildRequest(url, 'POST', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 200

          attributes = response['Attrs']

          attributesList = Array.new(0)

          if attributes.respond_to?("each")
            attributes.each do |attr|

              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])

              attributesList.push(attribute)
            end
          end

          return Xooa::Response::IdentityResponse.new(response['IdentityName'],
                                                      response['ApiToken'],
                                                      response['Id'],
                                                      response['AppId'],
                                                      response['Access'],
                                                      response['canManageIdentities'],
                                                      response['createdAt'],
                                                      response['updatedAt'],
                                                      attributesList)

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # The Enroll identity endpoint is used to enroll new identities for the smart contract app.
      # A success response includes the API Token generated for the identity.
      # This API Token can be used to call API End points on behalf of the enrolled identity.
      # This endpoint provides equivalent functionality to adding new identity manually using Xooa console,
      # and identities added using this endpoint will appear, and can be managed, using Xooa console under the identities tab of the smart contract app
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identityRequest Identity Request data to create a new identity
      # @return PendingTransactionResponse
      def enrollIdentityAsync(identityRequest)

        path = "/identities/"

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'true'

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = identityRequest.toJson

        begin
          request = requestUtil.buildRequest(url, 'POST', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 202
          return Xooa::Response::PendingTransactionResponse.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # Generates new identity API Token
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identityId Identity id for which to create a new API Token
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def regenerateIdentityApiToken(identityId, timeout = "4000")

        path = "/identities/{IdentityId}/regeneratetoken".sub('{' + 'IdentityId' + '}', identityId.to_s)

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'false'
        queryParams[:'timeout'] = timeout

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'POST', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 200

          attributes = response['Attrs']

          attributesList = Array.new(0)

          if attributes.respond_to?("each")
            attributes.each do |attr|
              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
              attributesList.push(attribute)
            end
          end

          return Xooa::Response::IdentityResponse.new(response['IdentityName'],
                                                      response['ApiToken'],
                                                      response['Id'],
                                                      response['AppId'],
                                                      response['Access'],
                                                      response['canManageIdentities'],
                                                      response['createdAt'],
                                                      response['updatedAt'],
                                                      attributesList)

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # Get the specified identity from the identity registry.
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identityId Identity id for which to find the Identity details
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def getIdentity(identityId, timeout = "4000")

        path = "/identities/{IdentityId}".sub('{' + 'IdentityId' + '}', identityId.to_s)

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'false'
        queryParams[:'timeout'] = timeout

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'GET', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 200

          attributes = response['Attrs']

          attributesList = Array.new(0)

          if attributes.respond_to?("each")
            attributes.each do |attr|
              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
              attributesList.push(attribute)
            end
          end

          return Xooa::Response::IdentityResponse.new(response['IdentityName'],
                                                      response['ApiToken'],
                                                      response['Id'],
                                                      response['AppId'],
                                                      response['Access'],
                                                      response['canManageIdentities'],
                                                      response['createdAt'],
                                                      response['updatedAt'],
                                                      attributesList)

        elsif statusCode == 202.ds
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end


      # Deletes an identity.
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identityId Identity id for which to delete the Identity details
      # @param timeout Request timeout in millisecond
      # @return boolean
      def deleteIdentity(identityId, timeout = "4000")

        path = "/identities/{IdentityId}".sub('{' + 'IdentityId' + '}', identityId.to_s)

        url = requestUtil.getUrl(@appUrl, path)

        logger.info "Calling API #{url}"

        if debugging
          logger.debug "Calling API #{url}"
        end

        queryParams = {}
        queryParams[:'async'] = 'false'
        queryParams[:'timeout'] = timeout

        headerParams = {}
        headerParams[:'Authorization'] = 'Bearer ' + @apiToken
        headerParams[:'Content-Type'] = 'application/json'

        postBody = nil

        begin
          request = requestUtil.buildRequest(url, 'DELETE', :headerParams => headerParams, :queryParams => queryParams, :body => postBody)

          response, statusCode = requestUtil.getResponse(request)

          if debugging
            logger.debug "Status Code - #{statusCode}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if statusCode == 200
          return response['deleted']

        elsif statusCode == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(statusCode, response)
        end
      end

    end

  end
end