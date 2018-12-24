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

require 'xooa/response/IdentityResponse'

module Xooa
  module Request
    # Class to create an Identity request for enrolling a new Identity
    class IdentityRequest
      attr_accessor :identity_name

      attr_accessor :access

      attr_accessor :can_manage_identities

      attr_accessor :attributes

      # Initialize IdentityRequest
      #
      # @param identity_name name of the identity to be created
      # @param access access privilige to be given to the new identity
      # @param can_manage_identities permission to manage other identities
      # @param attributes attributes related to the entity
      # @return IdentityRequest
      def initialize(identity_name, access, can_manage_identities, attributes)

        @identity_name = identity_name
        @access = access
        @can_manage_identities = can_manage_identities
        @attributes = attributes
      end

      # convert the request into json form
      # @return identityRequestJson
      def to_json

        json = "{\"IdentityName\" : \"" + identity_name + "\", \"Access\" : \"" + access.to_s + "\", \"canManageIdentities\" : " + can_manage_identities.to_s + ", \"Attrs\" : [";

        if attributes.respond_to?('each')
          attributes.each do |attribute|
            json += attribute.to_json + ','
          end
        elsif
          json += attributes.to_json
        end

        if json.to_s.end_with?(',')
          json = json.to_s[0..-2]
        end

        json += ']}'
        json
      end
    end

  end
end
