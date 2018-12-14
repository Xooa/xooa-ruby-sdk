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

    class IdentityResponse

      attr_accessor :identityName

      attr_accessor :access

      attr_accessor :canManageIdentities

      attr_accessor :createdAt

      attr_accessor :updatedAt

      attr_accessor :apiToken

      attr_accessor :id

      attr_accessor :appId

      attr_accessor :attributes

      # Initialize IdentityResponse
      #
      # @param identityName name for the identity
      # @param apiToken API Token for the identity
      # @param id id for the identity
      # @param appId app id to which the identity belongs
      # @param access access permissions for the identity
      # @param canManageIdentities permission to manage other identities
      # @param createdAt the timestamp when the identity was created
      # @param updatedAt the timestamp when the identity was last updated
      # @param attributes list of attributes for the identity
      # @return IdentityResponse
      def initialize(identityName, apiToken, id, appId, access, canManageIdentities, createdAt, updatedAt, attributes)
        @identityName = identityName
        @apiToken = apiToken
        @id = id
        @appId = appId
        @access = access
        @canManageIdentities = canManageIdentities
        @createdAt = createdAt
        @updatedAt = updatedAt
        @attributes = attributes
      end

      # display the details for the IdentityResponse
      def display
        puts("Identity Name - #{@identityName}")
        puts("API Token - #{@apiToken}")
        puts("Id - #{@id}")
        puts("App Id - #{@appId}")
        puts("Access - #{@access}")
        puts("Can Manage Identities - #{@canManageIdentities}")
        puts("createdAt - #{@createdAt}")
        puts("UpdatedAt - #{@updatedAt}")
        puts("Attributes - ")

        if @attributes.respond_to?("each")
          @attributes.each do |attribute|
            attribute.display
          end
        else
          attributes.display
        end
      end

    end


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
      def toJson
        json = "{\"name\" : \"" + name + "\", \"ecert\" : " + ecert.to_s + ", \"value\" : \"" + value + "\"}"
      end

    end

  end
end