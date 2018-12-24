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
    # Response received for a Block request
    class BlockResponse
      attr_accessor :previous_hash

      attr_accessor :data_hash

      attr_accessor :block_number

      attr_accessor :number_of_transactions

      # Initialize BlockResponse
      #
      # @param previous_hash Hash of the previous block
      # @param data_hash Hash of the data present in the block
      # @param block_number block number
      # @param number_of_transactions number of transactions in the block
      # @return BlockResponse
      def initialize(previous_hash, data_hash, block_number, number_of_transactions)

        @previous_hash = previous_hash
        @data_hash = data_hash
        @block_number = block_number
        @number_of_transactions = number_of_transactions
      end

      # display the details for the BlockResponse
      def display

        puts("Block Number - #{@block_mumber}")
        puts("Number of Transactions - #{@number_of_transactions}")
        puts("Data Hash - #{@data_hash}")
        puts("Previous Hash - #{@previous_hash}")
      end
    end

  end
end
