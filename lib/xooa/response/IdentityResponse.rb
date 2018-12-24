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

module Xooa
  module Response
    # Response received for Identity Request
    class IdentityResponse
      attr_accessor :identity_name

      attr_accessor :access

      attr_accessor :can_manage_identities

      attr_accessor :created_at

      attr_accessor :updated_at

      attr_accessor :api_token

      attr_accessor :id

      attr_accessor :app_id

      attr_accessor :attributes

      attr_accessor :app_name

      # Initialize IdentityResponse
      #
      # @param identity_name name for the identity
      # @param app_name app name to which the identity belongs
      # @param api_token API Token for the identity
      # @param id id for the identity
      # @param app_id app id to which the identity belongs
      # @param access access permissions for the identity
      # @param can_manage_identities permission to manage other identities
      # @param created_at the timestamp when the identity was created
      # @param updated_at the timestamp when the identity was last updated
      # @param attributes list of attributes for the identity
      # @return IdentityResponse
      def initialize(identity_name, app_name, api_token, id, app_id, access, can_manage_identities, created_at, updated_at, attributes)

        @identity_name = identity_name
        @app_name = app_name
        @api_token = api_token
        @id = id
        @app_id = app_id
        @access = access
        @can_manage_identities = can_manage_identities
        @created_at = created_at
        @updated_at = updated_at
        @attributes = attributes
      end

      # display the details for the IdentityResponse
      def display

        puts("Identity Name - #{@identity_name}")
        puts("App Name - #{@app_name}")
        puts("API Token - #{@api_token}")
        puts("Id - #{@id}")
        puts("App Id - #{@app_id}")
        puts("Access - #{@access}")
        puts("Can Manage Identities - #{@can_manage_identities}")
        puts("createdAt - #{@created_at}")
        puts("UpdatedAt - #{@updated_at}")
        puts('Attributes - ')

        if @attributes.respond_to?('each')
          @attributes.each do |attribute|
            attribute.display
          end
        else
          attributes.display
        end
      end
    end

    # Attributes for the identity
    class Attr
      attr_accessor :name

      attr_accessor :value

      attr_accessor :ecert

      # Initialize Attr
      #
      # @param name name of the attribute
      # @param value value for the identity attribute
      # @param ecert if the attribute requires ecert
      # @return Attr
      def initialize(name, value, ecert)

        @name = name
        @value = value
        @ecert = ecert
      end

      # display the details for the Attr
      def display

        puts("\t Name - #{@name}")
        puts("\t Value - #{@value}")
        puts("\t Ecert - #{@ecert}")
      end

      # convert the request into json form
      # @return attrJson
      def to_json
        json = "{\"name\" : \"" + name + "\", \"ecert\" : " + ecert.to_s + ", \"value\" : \"" + value + "\"}"
      end
    end

  end
end
