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
    # Response received for Current Block Request
    class CurrentBlockResponse
      attr_accessor :current_block_hash

      attr_accessor :previous_block_hash

      attr_accessor :block_number

      # Initialize CurrentBlockResponse
      #
      # @param block_number block number
      # @param current_block_hash Hash of the current block
      # @param previous_block_hash Hash of the previous block
      # @return CurrentBlockResponse
      def initialize(block_number, current_block_hash, previous_block_hash)

        @block_number = block_number
        @current_block_hash = current_block_hash
        @previous_block_hash = previous_block_hash
      end

      # display the details for the CurrentBlockResponse
      def display

        puts("Block Number - #{@block_number}")
        puts("Current Block Hash - #{@current_block_hash}")
        puts("Previous Block Hash - #{@previous_block_hash}")
      end
    end

  end
end
