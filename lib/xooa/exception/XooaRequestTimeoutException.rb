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

    class XooaRequestTimeoutException < StandardError

      attr_accessor :resultId

      attr_accessor :resultUrl

      # Initialize XooaRequestTimeoutException
      # @param resultId result id for the transaction in pending state
      # @param errorMessage result url for the transaction in pending state
      # @return XooaRequestTimeoutException
      def initialize(resultId, resultUrl)
        @resultId = resultId
        @resultUrl = resultUrl
      end

      # display the details for the XooaResultTimeoutException
      def display
        puts("Result Id - #{@resultId}")
        puts("Result Url - #{@resultUrl}")
      end

    end

  end
end