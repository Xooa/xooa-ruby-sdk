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
    # Response received for transaction request
    class TransactionResponse
      attr_accessor :transaction_id

      attr_accessor :created_at

      attr_accessor :smart_contract

      attr_accessor :creator_msp_id

      attr_accessor :endorser_msp_id

      attr_accessor :transaction_type

      attr_accessor :read_set

      attr_accessor :write_set

      # Initialize TransactionResponse
      def initialize(transaction_id, smart_contract, creator_msp_id, endorser_msp_id, transaction_type, created_at, read_set, write_set)

        @transaction_id = transaction_id
        @smart_contract = smart_contract
        @creator_msp_id = creator_msp_id
        @endorser_msp_id = endorser_msp_id
        @transaction_type = transaction_type
        @created_at = created_at
        @read_set = read_set
        @write_set = write_set
      end

      #display TransactionResponse
      def display

        puts("Transaction Id - #{@transaction_id}")
        puts("Smart Contract - #{@smart_contract}")
        puts("Creator MSP Id - #{@creator_msp_id}")
        puts("Type - #{@transaction_type}")
        puts("Created At - #{@created_at}")

        puts('Endorser MSP ID -')
        if @endorser_msp_id.respond_to?('each')
          @endorser_msp_id.each do |id|
            puts("\t  #{id}")
          end
        end

        puts('ReadSet -')
        if @read_set.respond_to?('each')
          @read_set.each do |set|
            set.display
          end
        else
          @read_set.display
        end

        puts('WriteSet -')
        if @write_set.respond_to?('each')
          @write_set.each do |set|
            set.display
          end
        else
          @write_set.display
        end
      end
    end

    # Read set for transaction
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

        if @sets.respond_to?('each')
          @sets.each do |set|
            set.display
          end
        else
          @sets.display
        end
      end
    end

    #Read sub sets for Read set
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

    # Version details for Read Sub set
    class Version
      attr_accessor :block_number

      attr_accessor :transaction_number

      # Initialize Version
      def initialize(block_number, transaction_number)

        @block_number = block_number
        @transaction_number = transaction_number
      end

      # display version details
      def display

        puts("\t\t\t Block Number - #{@block_number}")
        puts("\t\t\t Transaction Number - #{@transaction_number}")
      end
    end

    # Write set for transaction response
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

        if @sets.respond_to?('each')
          @sets.each do |set|
            set.display
          end
        else
          @sets.display
        end
      end
    end

    # Write Sub Set for Write Set
    class WriteSubSet
      attr_accessor :key

      attr_accessor :value

      attr_accessor :is_delete

      # Initialize WriteSubSet
      def initialize(key, value, is_delete)

        @key = key
        @value = value
        @is_delete = is_delete
      end

      # display the WriteSubSet
      def display
        puts("\t\t Key - #{@key}")
        puts("\t\t Value - #{@value}")
        puts("\t\t Is Deleted - #{@is_delete}")
      end
    end

  end
end
