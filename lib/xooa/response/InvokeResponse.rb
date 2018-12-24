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
    # Response received for Invoke request
    class InvokeResponse
      attr_accessor :txn_id

      attr_accessor :payload

      # Initialize InvokeResponse
      #
      # @param txn_id transaction Id for the invoke request
      # @param payload payload inserted into the blockchain in the transaction
      # @return InvokeResponse
      def initialize(txn_id, payload)

        @txn_id = txn_id
        @payload = payload
      end

      # display the details for the InvokeResponse
      def display

        puts("Transaction Id - #{@txn_id}")
        puts("Payload - #{@payload}")
      end
    end

  end
end
