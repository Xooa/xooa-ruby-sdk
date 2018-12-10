require './lib/ruby/client/XooaClient'
require './lib/ruby/client/request/IdentityRequest'
require './lib/ruby/client/exception/XooaApiException'

if __FILE__ == $0
  client = XooaClient.new("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcGlLZXkiOiJFMVpBQVNBLVBZU01WQkstS1BGM0JRUy1BMVQ1NVRFIiwiQXBpU2VjcmV0IjoibDVGS1pNanZUWHZlZkRWIiwiUGFzc3BocmFzZSI6IjMyNzNmNjg3MjE5MTM4ZjhlMmM1NzdiNzgwZmYzNjJhIiwiaWF0IjoxNTQ0NDMzNDQ4fQ.3s69b0wErmJe7LZC6zWISfbGQY4IR6gMODjPsgUYPyY")

  begin

    puts("----- Start -----")

    puts("----- Validate -----")

    client.validate.display

    puts()

    puts("----- Current Block -----")

    client.getCurrentBlock.display

    puts()

    puts("----- Current Blcok Async -----")

    pendingCurrentBlock = client.getCurrentBlockAsync
    pendingCurrentBlock.display

    puts()

    puts("----- Pending current block details -----")

    client.getResultForCurrentBlock(pendingCurrentBlock.resultId).display

    puts()


    puts("----- Block By Number -----")

    client.getBlockByNumber(4).display

    puts()

    puts("----- Block by Number Async -----")

    pendingBlockResponse = client.getBlockByNumberAsync(4)
    pendingBlockResponse.display

    puts()

    puts("----- Pending Block Response -----")

    client.getResultForBlockByNumber(pendingBlockResponse.resultId).display


    puts("----- Current Identity -----")

    client.currentIdentity.display

    puts()


    puts("----- New Identity Async -----")

    attr1 = Attr.new('Kavi', 'cscs', false)
    attributes = Array.new(0)
    attributes.push(attr1)

    identityRequest = IdentityRequest.new("s", 'r', false, attributes)

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

  rescue XooaApiException => e
    e.display
  rescue XooaRequestTimeoutException => xe
    xe.display
  end

end
