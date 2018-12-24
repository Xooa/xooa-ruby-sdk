# Xooa Ruby SDK

This repository contains Xooa Ruby SDK to connect with the Xooa Blockchain PaaS.

This SDK refers to APIs available for Xooa platform. For more details, refer: <https://api.xooa.com/explorer>

The platform documentation is available at <https://docs.xooa.com>


## Installation

There are two ways to install the xooa-sdk gem in your project.

You can install the latest code for the xooa-sdk gem in a project by including this line in your Gemfile:
```ruby
    gem "xooa-sdk", :git => "git://https://github.com/Xooa/xooa-ruby-sdk.git"
```

Installing a gem directly from a git repository is a feature of Bundler, not a feature of RubyGems.
Gems installed this way will not show up when you run gem list.


The other way to install xooa-sdk is to add this line to your application's Gemfile:
```ruby
    gem 'xooa-sdk', '~> 1.0'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install xooa-sdk
    
    
## Usage
---
### [XooaClient](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa.rb)
```Ruby
    require 'xooa'

    Xooa::XooaClient
```
*This is the base class of Xooa Ruby SDK.*
This class contains all the methods made available by the SDK. 

## Summary
-------

### Properties

##### API Token
The API Token for the app provided on Xooa Platform when you deploy an app there. You can also regenerate a new API Token for an Identity by going to Identities tab in the app and clicking on Actions -> Regenerate API Token.
```Ruby
    attr_accessor :api_token
```

##### App URL
The App URL where the app is deployed. It is default to [Xooa](https://api.xooa.com/api/v1). You can change it if you want to test your app in a local environment.
```Ruby
    attr_accessor :app_url
```

##### Debugging
instance variable to set logging level to debugging.
```Ruby
    attr_accessor :debugging
```


### Constructors

##### initialize(api_token, app_url)

```Ruby
      def initialize(api_token = "", app_url = "https://api.xooa.com/api/v1")
```
Constructor to create a [XooaClient](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa.rb) object with the given API Token and App Url. It sets the default value for app url to [Xooa](https://api.xooa.com/api/v1).


### Methods

##### validate

```Ruby
     def validate
```
Method to Validate if the given API Token is valid or not.

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/IdentityResponse.rb) giving details about the identity.

Throws -
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb)
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) giving the error code and error message.


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


##### invoke(function_name, args, timeout = "4000")
```Ruby
   def invoke(function_name, args, timeout = "4000")
```
Method to Invoke blockchain to submit transactions. For more details refer [Xooa Invoke API](https://api.xooa.com/explorer/#!/Smart_Contract/Invoke).

Return - InvokeResponse
Instance of [Invoke Response](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/InvokeResponse.rb) giving Transaction Id and Payload returned by the smart contract.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### invoke_async(function_name, args)
```Ruby
    def invoke_async(function_name, args)
```
Method to Invoke blockchain in async mode to submit transactions. For more details refer [Xooa Invoke API](https://api.xooa.com/explorer/#!/Smart_Contract/Invoke).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.



##### query(function_name, args, timeout = "4000")
```Ruby
    def query(function_name, args, timeout = "4000")
```
Method to Query blockchain to fetch state for arguments. For more details refer [Xooa Query API](https://api.xooa.com/explorer/#!/Smart_Contract/Query).

Return - QueryResponse
Instance of [QueryResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/QueryResponse.rb) giving payload returned by the smart contract.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### query_async(function_name, args)
```Ruby
    def query_async(function_name, args)
```
Method to Query blockchain in async mode to fetch state for arguments. For more details refer [Xooa Query API](https://api.xooa.com/explorer/#!/Smart_Contract/Query).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.



##### current_identity(timeout = "4000")
```Ruby
    def current_identity(timeout = "4000")
```
Method to get the authenticating identity details. For more details refer [Authenticated Identity](https://api.xooa.com/explorer/#!/Identities/Authenticated_Identity).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/IdentityResponse.rb) giving details about the identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_identities(timeout = "4000")
```Ruby
    def get_identities(timeout = "4000")
```
Method to get a list of all the identities associated with the app. For more details refer [Get All Identitites](https://api.xooa.com/explorer/#!/Identities/Identities_getAllIdentities).

Return - List<IdentityResponse>
List containing all the instances of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/IdentityResponse.rb).

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### enroll_identity(identity_request, timeout = "4000")
```Ruby
    def enroll_identity(identity_request, timeout = "4000")
```
Method to enroll a new identity for the app. For more details refer [Enroll Identity](https://api.xooa.com/explorer/#!/Identities/Enrollment).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/IdentityResponse.rb) giving details about the new identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### enroll_identity_async(identity_request)
```Ruby
    def enroll_identity_async(identity_request)
```
Method to enroll a new identity for the app in async mode. For more details refer [Enroll Identity](https://api.xooa.com/explorer/#!/Identities/Enrollment).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.


##### regenerate_identity_api_token(identity_id, timeout = "4000")
```Ruby
    def regenerate_identity_api_token(identity_id, timeout = "4000")
```
Method to regenerate a new API Token for the given identity id. For more details refer [Regenerate Token](https://api.xooa.com/explorer/#!/Identities/Regenerate_Token).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/IdentityResponse.rb) giving details about the new identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_identity(identity_id, timeout = "4000")
```Ruby
    def get_identity(identity_id, timeout = "4000")
```
Method to get Identity details for the given identity id. For more details refer [Identity Information](https://api.xooa.com/explorer/#!/Identities/Get_identity).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/IdentityResponse.rb) giving details about the new identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### delete_identity(identity_id, timeout = "4000")
```Ruby
    def delete_identity(identity_id, timeout = "4000")
```
Method to delete the identity from the app for the given identity id. For more details refer [Delete Identity](https://api.xooa.com/explorer/#!/Identities/Delete_Identity).

Return - Boolean
True if identity was deleted false otherwise.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.



##### get_current_block(timeout = "4000")
```Ruby
    def get_current_block(timeout = "4000")
```
Method to get the block number and hashes of current (highest) block. For more details refer [Get Current Block](https://api.xooa.com/explorer/#!/Ledger/BlockHeight).

Return - CurrentBlockResponse
Instance of [CurrentBlockResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/CurrentBlockResponse.rb) giving the block number and hashes of current block.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_current_block_async
```Ruby
    def get_current_block_async
```
Method to get the block number and hashes of current (highest) block in async mode. For more details refer [Get Current Block](https://api.xooa.com/explorer/#!/Ledger/BlockHeight).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.


##### get_block_by_number(block_number, timeout = "4000")
```Ruby
    def get_block_by_number(block_number, timeout = "4000")
```
Method to get the block number and hashes of the block number. For more details refer [Get Block](https://api.xooa.com/explorer/#!/Ledger/BlockData).

Return - BlockResponse
Instance of [BlockResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/BlockResponse.rb) giving the block number and hashes of the block.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_block_by_number_async(block_number)
```Ruby
    def get_block_by_number_async(block_number)
```
Method to get the block number and hashes of the block number in async mode. For more details refer [Get Block](https://api.xooa.com/explorer/#!/Ledger/BlockData).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.


##### get_transaction_by_transaction_id(transaction_id, timeout = "4000")
```Ruby
    def get_transaction_by_transaction_id(transaction_id, timeout = "4000")
```
Method to get the transaction details for the transaction id. For more details refer [Get Transaction By TransactionId](https://api.xooa.com/explorer/#!/Ledger/BlockData_0).

Return - TransactionResponse
Instance of [TransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/TransactionResponse.rb) giving the details about the transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_transaction_by_transaction_id_async(transaction_id)
```Ruby
    def get_transaction_by_transaction_id_async(transaction_id)
```
Method to get the transaction details for the transaction id in async mode. For more details refer [Get Transaction By TransactionId](https://api.xooa.com/explorer/#!/Ledger/BlockData_0).

Return - PendingTransactionResponse
Instance of [PendingTransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/PendingTransactionResponse.rb) giving result id and result url for pending transaction.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.



##### get_result_for_invoke(result_id, timeout = "4000")
```Ruby
    def get_result_for_invoke(result_id, timeout = "4000")
```
Method to get Invoke Response for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - InvokeResponse
Instance of [InvokeResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/InvokeResponse.rb) giving the transaction id and payload.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_result_for_query(result_id, timeout = "4000")
```Ruby
    def get_result_for_query(result_id, timeout = "4000")
```
Method to get Query Response for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - QueryResponse
Instance of [QueryResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/QueryResponse.rb) giving the payload.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_result_for_identities(result_id, timeout = "4000")
```Ruby
    def get_result_for_identities(result_id, timeout = "4000")
```
Method to get Identity Response for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - IdentityResponse
Instance of [IdentityResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/IdentityResponse.rb) giving the details related to the identity.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_result_for_current_block(result_id, timeout = "4000")
```Ruby
    def get_result_for_current_block(result_id, timeout = "4000")
```
Method to get CurrentBlockResponse for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - CurrentBlockResponse
Instance of [CurrentBlockResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/CurrentBlockResponse.rb) giving the block number and hashes for the current block.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_result_for_block_by_number(result_id, timeout = "4000")
```Ruby
    def get_result_for_block_by_number(result_id, timeout = "4000")
```
Method to get BlockResponse for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - BlockResponse
Instance of [BlockResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/BlockResponse.rb) giving the block number and hashes for the block.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.


##### get_result_for_transaction(result_id, timeout = "4000")
```Ruby
    def get_result_for_transaction(result_id, timeout = "4000")
```
Method to get TransactionResponse for a request in pending state. For more detials refer [Result API](https://api.xooa.com/explorer/#!/Result/Result).

Return - TransactionResponse
Instance of [TransactionResponse](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/response/TransactionResponse.rb) giving the transaction details for the transaction id.

Throws - 
[XooaApiException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaApiException.rb) - Instance of XooaApiException giving the error code and error message.
[XooaRequestTimeoutException](https://github.com/Xooa/xooa-ruby-sdk/blob/master/lib/xooa/exception/XooaRequestTimeoutException.rb) - Instance of XooaRequestTimeoutException giving result id and result url for pending transaction.
