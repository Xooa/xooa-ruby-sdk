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

    class CurrentBlockResponse

      attr_accessor :currentBlockHash

      attr_accessor :previousBlockHash

      attr_accessor :blockNumber

      # Initialize CurrentBlockResponse
      # @param blockNumber block number
      # @param currentBlockHash Hash of the current block
      # @param previousBlockHash Hash of the previous block
      # @return CurrentBlockResponse
      def initialize(blockNumber, currentBlockHash, previousBlockHash)
        @blockNumber = blockNumber
        @currentBlockHash = currentBlockHash
        @previousBlockHash = previousBlockHash
      end

      # display the details for the CurrentBlockResponse
      def display
        puts("Block Number - #{@blockNumber}")
        puts("Current Block Hash - #{@currentBlockHash}")
        puts("Previous Block Hash - #{@previousBlockHash}")
      end

    end

  end
end