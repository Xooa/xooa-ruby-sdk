require 'xooa'
require 'xooa/request/IdentityRequest'

if __FILE__ == $0
  client = Xooa::XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiI3MlQ3WjRBLUFNUE1ER0ctTkhKMlMxUi1CRDJZTkpKIiwiQXBpU2VjcmV0IjoiMEk3WjFRU1NHblZ3WVhnIiwiUGFzc3BocmFzZSI6IjM3ZGJmYmI3YmM0NTE0NTBjODIyODg0NTM5YTQ3ZTY5IiwiaWF0IjoxNTQ0NzgzMzIwfQ.pcOdvHM0KTzf_b0vZoReSwsSM3SYicAOMSgacfy-mVg")

  begin

    puts("----- Start -----")

    puts("----- Validate -----")

    client.validate.display

    puts()

    puts("----- Current Blcok Async -----")

    pendingCurrentBlock = client.getCurrentBlockAsync
    pendingCurrentBlock.display

    puts()

    puts("----- Current Block -----")

    client.getCurrentBlock.display

    puts()

    puts("----- Pending current block details -----")

    client.getResultForCurrentBlock(pendingCurrentBlock.resultId).display

    puts()

    puts("----- Block by Number Async -----")

    pendingBlockResponse = client.getBlockByNumberAsync(4)
    pendingBlockResponse.display

    puts()

    puts("----- Block By Number -----")

    client.getBlockByNumber(4).display

    puts()

    puts("----- Pending Block Response -----")

    client.getResultForBlockByNumber(pendingBlockResponse.resultId).display

    puts("----- Current Identity -----")

    client.currentIdentity.display

    puts()

    puts("----- New Identity Async -----")

    attr1 = Xooa::Response::Attr.new('Kavi', 'cscs', false)
    attributes = Array.new(0)
    attributes.push(attr1)

    identityRequest = Xooa::Request::IdentityRequest.new("s", 'r', false, attributes)

    pendingIdentityResponse = client.enrollIdentityAsync(identityRequest)
    pendingIdentityResponse.display

    puts()

    puts("----- New Identity -----")

    newIdentity = client.enrollIdentity(identityRequest)
    newIdentity.display

    puts()

    puts("----- New Identity Async Details -----")

    newIdentity2 = client.getResultForIdentities(pendingIdentityResponse.resultId)
    newIdentity2.display

    puts()

    puts("----- Regenerate API Token -----")

    client.regenerateIdentityApiToken(newIdentity.id).display

    puts()

    puts("----- Get Identity -----")

    client.getIdentity(newIdentity.id).display

    puts()

    puts("----- Get All Identities -----")

    identities = client.getIdentities
    if identities.respond_to?("each")
      identities.each do |identity|
        identity.display
        puts()
      end
    end

    puts()

    puts("----- Delete Identity -----")

    puts(client.deleteIdentity(newIdentity.id))


    puts("----- Invoke Async -----")

    args = ["a", "g"]
    pendingInvokeResponse  = client.invokeAsync("set", args)
    pendingInvokeResponse.display

    puts()

    puts("----- Invoke -----")

    args = ["a", "d"]

    invokeResponse  = client.invoke("set", args)
    invokeResponse.display

    puts()

    puts("----- Invoke Async details -----")

    client.getResultForInvoke(pendingInvokeResponse.resultId).display

    puts()


    puts("----- Transaction Response Async -----")

    pendingTransaction = client.getTransactionByTransactionIdAsync(invokeResponse.txnId)
    pendingTransaction.display

    puts()

    puts("----- Transaction Response -----")

    client.getTransactionByTransactionId(invokeResponse.txnId).display

    puts()

    puts("----- Transaction Async Details -----")

    client.getResultForTransaction(pendingTransaction.resultId).display

    puts()


    puts("----- Query Async -----")

    args = ["a"]

    pendingQuery = client.queryAsync("get", args)
    pendingQuery.display

    puts()

    puts("----- Query -----")

    client.query("get", args).display

    puts()

    puts("----- Query Async details -----")

    client.getResultForQuery(pendingQuery.resultId).display

    puts('----- END -----')

  rescue Xooa::Exception::XooaApiException => e
    puts()
    puts('----- Exception -----')
    e.display
  rescue Xooa::Exception::XooaRequestTimeoutException => xe
    puts()
    puts('----- Exception -----')
    xe.display
  end

end