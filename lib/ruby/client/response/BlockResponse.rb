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

class BlockResponse

  attr_accessor :previousHash

  attr_accessor :dataHash

  attr_accessor :blockNumber

  attr_accessor :numberOfTransactions

  # Initialize BlockResponse
  # @param previousHash Hash of the previous block
  # @param dataHash Hash of the data present in the block
  # @param blockNumber block number
  # @param numberOfTransactions number of transactions in the block
  # @return BlockResponse
  def initialize(previousHash, dataHash, blockNumber, numberOfTransactions)
    @previousHash = previousHash
    @dataHash = dataHash
    @blockNumber = blockNumber
    @numberOfTransactions = numberOfTransactions
  end

  # display the details for the BlockResponse
  def display
    puts("Block Number - #{@blockNumber}")
    puts("Number of Transactions - #{@numberOfTransactions}")
    puts("Data Hash - #{@dataHash}")
    puts("Previous Hash - #{@previousHash}")
  end

end