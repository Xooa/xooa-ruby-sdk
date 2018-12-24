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
  module Exception
    # Exception thrown for any Exception generated within the sdk
    class XooaApiException < StandardError
      attr_accessor :error_code

      attr_accessor :error_message

      # Initialize XooaApiException
      #
      # @param error_code error code for the exception
      # @param error_message error message for the exception
      # @return XooaApiException
      def initialize(error_code, error_message)

        @error_code = error_code
        @error_message = error_message
      end

      # display the details for the XooaApiException
      def display

        puts('Error Code - #{@error_code}')
        puts('Error Message - #{@error_message}')
      end
    end

  end
end
