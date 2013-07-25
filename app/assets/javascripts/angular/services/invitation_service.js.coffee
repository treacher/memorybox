angular.module("MemoryBoxApp").factory "SentInvitation", ($resource) ->
  $resource("/api/user/invitations/sent_invitations")

angular.module("MemoryBoxApp").factory "ReceivedInvitation", ($resource) ->
  $resource("/api/user/invitations/received_invitations")