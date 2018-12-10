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

class TransactionResponse

  attr_accessor :transactionId

  attr_accessor :createdAt

  attr_accessor :smartContract

  attr_accessor :creatorMspId

  attr_accessor :endorserMspId

  attr_accessor :transactionType

  attr_accessor :readSet

  attr_accessor :writeSet

  # Initialize TransactionResponse
  def initialize(transactionId, smartContract, creatorMspId, endorserMspId, transactionType, createdAt, readSet, writeSet)
    @transactionId = transactionId
    @smartContract = smartContract
    @creatorMspId = creatorMspId
    @endorserMspId = endorserMspId
    @transactionType = transactionType
    @createdAt = createdAt
    @readSet = readSet
    @writeSet = writeSet
  end

  #display TransactionResponse
  def display
    puts("Transaction Id - #{@transactionId}")
    puts("Smart Contract - #{@smartContract}")
    puts("Creator MSP Id - #{@creatorMspId}")
    puts("Type - #{@transactionType}")
    puts("Created At - #{@createdAt}")

    puts("Endorser MSP ID -")
    if @endorserMspId.respond_to?("each")
      @endorserMspId.each do |id|
        puts("\t  #{id}")
      end
    end

    puts("ReadSet -")
    if @readSet.respond_to?("each")
      @readSet.each do |set|
        set.display
      end
    else
      @readSet.display
    end

    puts("WriteSet -")
    if @writeSet.respond_to?("each")
      @writeSet.each do |set|
        set.display
      end
    else
      @writeSet.display
    end
  end
end


class ReadSet

  attr_accessor :chaincode

  attr_accessor :sets

  # Initialize ReadSet
  def initialize(chaincode, sets)
    @chaincode = chaincode
    @sets = sets
  end

  # display read set details
  def display
    puts("\t Chaincode - #{@chaincode}")
    puts("\t Sets -")

    if @sets.respond_to?("each")
      @sets.each do |set|
        set.display
      end
    else
      @sets.display
    end
  end
end


class ReadSubSet

  attr_accessor :key

  attr_accessor :version

  # Initialize ReadSubSet
  def initialize(key, version)
    @key = key
    @version = version
  end

  # display the read sub set
  def display
    puts("\t\t Key - #{@key}")
    puts("\t\t Version -")
    version.display
  end
end


class Version

  attr_accessor :blockNumber

  attr_accessor :transactionNumber

  # Initialize Version
  def initialize(blockNumber, transactionNumber)
    @blockNumber = blockNumber
    @transactionNumber = transactionNumber
  end

  # display version details
  def display
    puts("\t\t\t Block Number - #{@blockNumber}")
    puts("\t\t\t Transaction Number - #{@transactionNumber}")
  end
end


class WriteSet

  attr_accessor :chaincode

  attr_accessor :sets

  # Initialize WriteSet
  def initialize(chaincode, sets)
    @chaincode = chaincode
    @sets = sets
  end

  # display the WriteSet
  def display
    puts("\t Chaincode - #{@chaincode}")
    puts("\t Sets -")

    if @sets.respond_to?("each")
      @sets.each do |set|
        set.display
      end
    else
      @sets.display
    end

  end
end

class WriteSubSet

  attr_accessor :key

  attr_accessor :value

  attr_accessor :isDelete

  # Initialize WriteSubSet
  def initialize(key, value, isDelete)
    @key = key
    @value = value
    @isDelete = isDelete
  end

  # display the WriteSubSet
  def display
    puts("\t\t Key - #{@key}")
    puts("\t\t Value - #{@value}")
    puts("\t\t Is Deleted - #{@isDelete}")
  end
end