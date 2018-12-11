# Xooa Ruby SDK

The official Xooa SDK for Ruby to connect with the Xooa Paas.

Xooa (pronounced ZUU-ah) is dedicated to making blockchain easy. Focus on business problems, not blockchain problems.

This SDK refers to APIs available for Xooa platform. For more details, refer: <https://api.xooa.com/explorer>

The platform documentation is available at <https://docs.xooa.com>


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xooa-ruby-sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xooa-ruby-sdk
    
    
## Usage
---
### [XooaClient](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/XooaClient.rb)
```Ruby
    require './lib/ruby/client/XooaClient'
```
*This is the base class of Xooa Ruby SDK.*
This class contains all the methods made available by the SDK. 

## Summary
-------

### Properties

##### API Token
The API Token for the app provided on Xooa Platform when you deploy an app there. You can also regenerate a new API Token for an Identity by going to Identities tab in the app and clicking on Actions -> Regenerate API Token.
```Ruby
    attr_accessor :apiToken
```

##### App URL
The App URL where the app is deployed. It is default to [Xooa](https://api.xooa.com/api/v1). You can change it if you want to test your app in a local environment.
```Ruby
    attr_accessor :appUrl
```

##### Debugging
instance variable to set logging level to debugging.
```Ruby
    attr_accessor :debugging
```


### Constructors

##### initialize

```Ruby
    def initialize
```
Default Constructor of [XooaClient](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/XooaClient.rb).


##### initialize(apiToken, appUrl)

```Ruby
      def initialize(apiToken, appUrl = "https://api.xooa.com/api/v1")
```
Constructor to create a [XooaClient](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/XooaClient.rb) object with the given API Token and App Url. It sets the default value for app url to [Xooa](https://api.xooa.com/api/v1).


### Methods

##### validate

```Ruby
     def validate
```
Method to Validate if the given API Token is valid or not.

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/IdentityResponse.rb) giving details about the identity.

Throws -
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb)
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) giving the error code and error message.


##### subscribe(callback)
```Ruby
    def subscribe(callback)
```
Method to subscribe to events generated in the smart contract. This method requires a callback method which decides what to do when an event is received.



##### unsubscribe

```Ruby
    def unsubscribe
```
Method to unsubscribe the events from the smart contract.


##### invoke(functionName, args, timeout = "4000")
```Ruby
   def invoke(functionName, args, timeout = "4000")
```
Method to Invoke blockchain to submit transactions. For more details refer [Xooa Invoke API](https://api.xooa.com/explorer/#!/Smart_Contract/Invoke).

Return - InvokeResponse
Instance of [Invoke Response](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/InvokeResponse.rb) giving Transaction Id and Payload returned by the smart contract.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### invokeAsync(functionName, args)
```Ruby
    def invokeAsync(functionName, args)
```
Method to Invoke blockchain in async mode to submit transactions. For more details refer [Xooa Invoke API](https://api.xooa.com/explorer/#!/Smart_Contract/Invoke).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.



##### query(functionName, args, timeout = "4000")
```Ruby
    def query(functionName, args, timeout = "4000")
```
Method to Query blockchain to fetch state for arguments. For more details refer [Xooa Query API](https://api.xooa.com/explorer/#!/Smart_Contract/Query).

Return - QueryResponse
Instance of [QueryResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/QueryResponse.rb) giving payload returned by the smart contract.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### queryAsync(functionName, args)
```Ruby
    def queryAsync(functionName, args)
```
Method to Query blockchain in async mode to fetch state for arguments. For more details refer [Xooa Query API](https://api.xooa.com/explorer/#!/Smart_Contract/Query).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.



##### currentIdentity(timeout = "4000")
```Ruby
    def currentIdentity(timeout = "4000")
```
Method to get the authenticating identity details. For more details refer [Authenticated Identity](https://api.xooa.com/explorer/#!/Identities/Authenticated_Identity).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/IdentityResponse.rb) giving details about the identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getIdentities(timeout = "4000")
```Ruby
    def getIdentities(timeout = "4000")
```
Method to get a list of all the identities associated with the app. For more details refer [Get All Identitites](https://api.xooa.com/explorer/#!/Identities/Identities_getAllIdentities).

Return - List<IdentityResponse>
List containing all the instances of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/IdentityResponse.rb).

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### enrollIdentity(identityRequest, timeout = "4000")
```Ruby
    def enrollIdentity(identityRequest, timeout = "4000")
```
Method to enroll a new identity for the app. For more details refer [Enroll Identity](https://api.xooa.com/explorer/#!/Identities/Enrollment).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/IdentityResponse.rb) giving details about the new identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### enrollIdentityAsync(identityRequest)
```Ruby
    def enrollIdentityAsync(identityRequest)
```
Method to enroll a new identity for the app in async mode. For more details refer [Enroll Identity](https://api.xooa.com/explorer/#!/Identities/Enrollment).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.


##### regenerateIdentityApiToken(identityId, timeout = "4000")
```Ruby
    def regenerateIdentityApiToken(identityId, timeout = "4000")
```
Method to regenerate a new API Token for the given identity id. For more details refer [Regenerate Token](https://api.xooa.com/explorer/#!/Identities/Regenerate_Token).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/IdentityResponse.rb) giving details about the new identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getIdentity(identityId, timeout = "4000")
```Ruby
    def getIdentity(identityId, timeout = "4000")
```
Method to get Identity details for the given identity id. For more details refer [Identity Information](https://api.xooa.com/explorer/#!/Identities/Get_identity).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/IdentityResponse.rb) giving details about the new identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### deleteIdentity(identityId, timeout = "4000")
```Ruby
    def deleteIdentity(identityId, timeout = "4000")
```
Method to delete the identity from the app for the given identity id. For more details refer [Delete Identity](https://api.xooa.com/explorer/#!/Identities/Delete_Identity).

Return - Boolean
True if identity was deleted false otherwise.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.



##### getCurrentBlock(timeout = "4000")
```Ruby
    def getCurrentBlock(timeout = "4000")
```
Method to get the block number and hashes of current (highest) block. For more details refer [Get Current Block](https://api.xooa.com/explorer/#!/Ledger/BlockHeight).

Return - CurrentBlockResponse
Instance of [CurrentBlockResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/CurrentBlockResponse.rb) giving the block number and hashes of current block.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getCurrentBlockAsync
```Ruby
    def getCurrentBlockAsync
```
Method to get the block number and hashes of current (highest) block in async mode. For more details refer [Get Current Block](https://api.xooa.com/explorer/#!/Ledger/BlockHeight).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.


##### getBlockByNumber(blockNumber, timeout = "4000")
```Ruby
    def getBlockByNumber(blockNumber, timeout = "4000")
```
Method to get the block number and hashes of the block number. For more details refer [Get Block](https://api.xooa.com/explorer/#!/Ledger/BlockData).

Return - BlockResponse
Instance of [BlockResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/BlockResponse.rb) giving the block number and hashes of the block.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getBlockByNumberAsync(blockNumber)
```Ruby
    def getBlockByNumberAsync(blockNumber)
```
Method to get the block number and hashes of the block number in async mode. For more details refer [Get Block](https://api.xooa.com/explorer/#!/Ledger/BlockData).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.


##### getTransactionByTransactionId(transactionId, timeout = "4000")
```Ruby
    def getTransactionByTransactionId(transactionId, timeout = "4000")
```
Method to get the transaction details for the transaction id. For more details refer [Get Transaction By TransactionId](https://api.xooa.com/explorer/#!/Ledger/BlockData_0).

Return - TransactionResponse
Instance of [TransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/TransactionResponse.rb) giving the details about the transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getTransactionByTransactionIdAsync(transactionId)
```Ruby
    def getTransactionByTransactionIdAsync(transactionId)
```
Method to get the transaction details for the transaction id in async mode. For more details refer [Get Transaction By TransactionId](https://api.xooa.com/explorer/#!/Ledger/BlockData_0).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.



##### getResultForInvoke(resultId, timeout = "4000")
```Ruby
    def getResultForInvoke(resultId, timeout = "4000")
```
Method to get Invoke Response for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - InvokeResponse
Instance of [InvokeResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/InvokeResponse.rb) giving the transaction id and payload.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getResultForQuery(resultId, timeout = "4000")
```Ruby
    def getResultForQuery(resultId, timeout = "4000")
```
Method to get Query Response for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - QueryResponse
Instance of [QueryResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/QueryResponse.rb) giving the payload.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getResultForIdentities(resultId, timeout = "4000")
```Ruby
    def getResultForIdentities(resultId, timeout = "4000")
```
Method to get Identity Response for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/IdentityResponse.rb) giving the details related to the identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getResultForCurrentBlock(resultId, timeout = "4000")
```Ruby
    def getResultForCurrentBlock(resultId, timeout = "4000")
```
Method to get CurrentBlockResponse for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - CurrentBlockResponse
Instance of [CurrentBlockResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/CurrentBlockResponse.rb) giving the block number and hashes for the current block.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getResultForBlockByNumber(resultId, timeout = "4000")
```Ruby
    def getResultForBlockByNumber(resultId, timeout = "4000")
```
Method to get BlockResponse for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - BlockResponse
Instance of [BlockResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/BlockResponse.rb) giving the block number and hashes for the block.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### getResultForTransaction(resultId, timeout = "4000")
```Ruby
    def getResultForTransaction(resultId, timeout = "4000")
```
Method to get TransactionResponse for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - TransactionResponse
Instance of [TransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/response/TransactionResponse.rb) giving the transaction details for the transaction id.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/ruby/client/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.
