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
    # Exception thrown when a synchronous call timesout
    class XooaRequestTimeoutException < StandardError

      attr_accessor :result_id

      attr_accessor :result_url

      # Initialize XooaRequestTimeoutException
      #
      # @param result_id result id for the transaction in pending state
      # @param result_url result url for the transaction in pending state
      # @return XooaRequestTimeoutException
      def initialize(result_id, result_url)

        @result_id = result_id
        @result_url = result_url
      end

      # display the details for the XooaResultTimeoutException
      def display

        puts("Result Id - #{@result_id}")
        puts("Result Url - #{@result_url}")
      end

    end

  end
end