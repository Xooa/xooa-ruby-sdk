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

class PendingTransactionResponse

  attr_accessor :resultId

  attr_accessor :resultUrl

  # Initialize PendingTransactionResponse
  #
  # @param resultId result Id for the request in pending state
  # @param resultUrl result Url for the request in pending state
  # @return PendingTransactionResponse
  def initialize(resultId, resultUrl)
    @resultId = resultId
    @resultUrl = resultUrl
  end

  # display the details for the PendingTransactionResponse
  def display
    puts("Result Id - #{@resultId}")
    puts("Result Url - #{@resultUrl}")
  end

end