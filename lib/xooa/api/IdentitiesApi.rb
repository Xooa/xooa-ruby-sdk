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
    # Class to provide methods for connecting to Identities Api
    class IdentitiesApi
      attr_accessor :request_util

      attr_accessor :logger

      attr_accessor :debugging

      # Initializes the IdentitiesApi
      #
      # @param app_url URL for the app to invoke
      # @param api_token API Token for the app and the identity
      # @param debugging debug tag
      # @return IdentitiesApi
      def initialize(app_url, api_token, debugging)

        @app_url = app_url
        @api_token = api_token
        @request_util = Xooa::Util::RequestUtil.new
        @logger = Logger.new(STDOUT)
        @debugging = debugging
      end


      # This endpoint returns authenticated identity information
      #
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def current_identity(timeout = '4000')

        path = '/identities/me/'

        url = request_util.get_url(@app_url, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        query_params = {}
        query_params[:'async'] = 'false'
        query_params[:'timeout'] = timeout

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = nil

        begin
          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

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

        if status_code == 200

          attributes = response['Attrs']

          attributes_list = Array.new(0)

          if attributes.respond_to?('each')
            attributes.each do |attr|

              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
              attributes_list.push(attribute)
            end
          else
            attribute = Xooa::Response::Attr.new(attributes['name'], attributes['value'], attributes['ecert'])
            attributes_list.push(attribute)
          end

          return Xooa::Response::IdentityResponse.new(response['IdentityName'],
                                                      response['AppName'],
                                                      response['ApiToken'],
                                                      response['Id'],
                                                      response['AppId'],
                                                      response['Access'],
                                                      response['canManageIdentities'],
                                                      response['createdAt'],
                                                      response['updatedAt'],
                                                      attributes_list)

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # Get all identities from the identity registry
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param timeout Request timeout in millisecond
      # @return Array[IdentityResponse]
      def get_identities(timeout = '4000')

        path = '/identities/'

        url = request_util.get_url(@app_url, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        query_params = {}
        query_params[:'async'] = 'false'
        query_params[:'timeout'] = timeout

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = nil

        begin

          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

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

        if status_code == 200

          responses = Array.new(0)

          if response.respond_to?('each')
            response.each do |resp|

              attributes = resp['Attrs']

              attributes_list = Array.new(0)

              if attributes.respond_to?('each')
                attributes.each do |attr|

                  attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
                  attributes_list.push(attribute)
                end
              elsif attribute = Xooa::Response::Attr.new(attributes['name'], attributes['value'], attributes['ecert'])
                attributes_list.push(attribute)
              end

              identity_response = Xooa::Response::IdentityResponse.new(resp['IdentityName'],
                                                                       resp['AppName'],
                                                                       resp['ApiToken'],
                                                                       resp['Id'],
                                                                       resp['AppId'],
                                                                       resp['Access'],
                                                                       resp['canManageIdentities'],
                                                                       resp['createdAt'],
                                                                       resp['updatedAt'],
                                                                       attributes_list)

              responses.push(identity_response)
            end
          end

          return responses

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)

        end
      end


      # The Enroll identity endpoint is used to enroll new identities for the smart contract app.
      # A success response includes the API Token generated for the identity.
      # This API Token can be used to call API End points on behalf of the enrolled identity.
      # This endpoint provides equivalent functionality to adding new identity manually using Xooa console,
      # and identities added using this endpoint will appear, and can be managed, using Xooa console under the identities tab of the smart contract app
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identity_request Identity Request data to create a new identity
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def enroll_identity(identity_request, timeout = '4000')

        path = '/identities/'

        url = request_util.get_url(@app_url, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        query_params = {}
        query_params[:'async'] = 'false'
        query_params[:'timeout'] = timeout

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = identity_request.to_json

        begin

          request = request_util.build_request(url, 'POST', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

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

        if status_code == 200

          attributes = response['Attrs']

          attributes_list = Array.new(0)

          if attributes.respond_to?('each')
            attributes.each do |attr|

              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])

              attributes_list.push(attribute)
            end
          end

          return Xooa::Response::IdentityResponse.new(response['IdentityName'],
                                                      response['AppName'],
                                                      response['ApiToken'],
                                                      response['Id'],
                                                      response['AppId'],
                                                      response['Access'],
                                                      response['canManageIdentities'],
                                                      response['createdAt'],
                                                      response['updatedAt'],
                                                      attributes_list)

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # The Enroll identity endpoint is used to enroll new identities for the smart contract app.
      # A success response includes the API Token generated for the identity.
      # This API Token can be used to call API End points on behalf of the enrolled identity.
      # This endpoint provides equivalent functionality to adding new identity manually using Xooa console,
      # and identities added using this endpoint will appear, and can be managed, using Xooa console under the identities tab of the smart contract app
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identity_request Identity Request data to create a new identity
      # @return PendingTransactionResponse
      def enroll_identity_async(identity_request)

        path = '/identities/'

        url = request_util.get_url(@app_url, path)

        logger.info "calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        query_params = {}
        query_params[:'async'] = 'true'

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = identity_request.to_json

        begin
          request = request_util.build_request(url, 'POST', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

          if debugging
            logger.debug "Status Code - #{status_code}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if status_code == 202
          return Xooa::Response::PendingTransactionResponse.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # Generates new identity API Token
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identity_id Identity id for which to create a new API Token
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def regenerate_identity_api_token(identity_id, timeout = '4000')

        path = '/identities/{IdentityId}/regeneratetoken'.sub('{' + 'IdentityId' + '}', identity_id.to_s)

        url = request_util.get_url(@app_url, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        query_params = {}
        query_params[:'async'] = 'false'
        query_params[:'timeout'] = timeout

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = nil

        begin
          request = request_util.build_request(url, 'POST', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

          if debugging
            logger.debug "Status Code - #{status_code}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if status_code == 200

          attributes = response['Attrs']

          attributes_list = Array.new(0)

          if attributes.respond_to?('each')
            attributes.each do |attr|
              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
              attributes_list.push(attribute)
            end
          end

          return Xooa::Response::IdentityResponse.new(response['IdentityName'],
                                                      response['AppName'],
                                                      response['ApiToken'],
                                                      response['Id'],
                                                      response['AppId'],
                                                      response['Access'],
                                                      response['canManageIdentities'],
                                                      response['createdAt'],
                                                      response['updatedAt'],
                                                      attributes_list)

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])
        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # Get the specified identity from the identity registry.
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identity_id Identity id for which to find the Identity details
      # @param timeout Request timeout in millisecond
      # @return IdentityResponse
      def get_identity(identity_id, timeout = "4000")

        path = '/identities/{IdentityId}'.sub('{' + 'IdentityId' + '}', identity_id.to_s)

        url = request_util.get_url(@app_url, path)

        logger.info "Calling API #{url}"
        if debugging
          logger.debug "Calling API #{url}"
        end

        query_params = {}
        query_params[:'async'] = 'false'
        query_params[:'timeout'] = timeout

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = nil

        begin
          request = request_util.build_request(url, 'GET', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

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

        if status_code == 200

          attributes = response['Attrs']

          attributes_list = Array.new(0)

          if attributes.respond_to?('each')
            attributes.each do |attr|
              attribute = Xooa::Response::Attr.new(attr['name'], attr['value'], attr['ecert'])
              attributes_list.push(attribute)
            end
          end

          return Xooa::Response::IdentityResponse.new(response['IdentityName'],
                                                      response['AppName'],
                                                      response['ApiToken'],
                                                      response['Id'],
                                                      response['AppId'],
                                                      response['Access'],
                                                      response['canManageIdentities'],
                                                      response['createdAt'],
                                                      response['updatedAt'],
                                                      attributes_list)

        elsif status_code == 202
          logger.error response
          raise Xooa::Exception::XooaRequestTimeoutException.new(response['resultId'], response['resultURL'])

        else
          logger.error response
          raise Xooa::Exception::XooaApiException.new(status_code, response)
        end
      end


      # Deletes an identity.
      # Required permission: manage identities (canManageIdentities=true)
      #
      # @param identity_id Identity id for which to delete the Identity details
      # @param timeout Request timeout in millisecond
      # @return boolean
      def delete_identity(identity_id, timeout = '4000')

        path = '/identities/{IdentityId}'.sub('{' + 'IdentityId' + '}', identity_id.to_s)

        url = request_util.get_url(@app_url, path)

        logger.info "Calling API #{url}"

        if debugging
          logger.debug "Calling API #{url}"
        end

        query_params = {}
        query_params[:'async'] = 'false'
        query_params[:'timeout'] = timeout

        header_params = {}
        header_params[:'Authorization'] = 'Bearer ' + @api_token
        header_params[:'Content-Type'] = 'application/json'

        post_body = nil

        begin
          request = request_util.build_request(url, 'DELETE', :header_params => header_params, :query_params => query_params, :body => post_body)

          response, status_code = request_util.get_response(request)

          if debugging
            logger.debug "Status Code - #{status_code}"
            logger.debug "Response - #{response}"
          end

        rescue Xooa::Exception::XooaApiException => xae
          logger.error xae
          raise xae

        rescue StandardError => se
          logger.error se
          raise Xooa::Exception::XooaApiException.new('0', se.to_s)
        end

        if status_code == 200
          return response['deleted']

        elsif status_code == 202
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
