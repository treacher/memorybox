angular.module("MemoryBoxApp").controller "InvitationsIndexCtrl", ($scope, $rootScope, $http, $location, $routeParams) ->

  $scope.sectionTab = $routeParams.section_tab

  $(document).ready ->
    $("a[href='#sent']").trigger('click') if $scope.sectionTab != undefined

  $http({method: 'GET', url: "/api/user/invitations/received_invitations"})
  .success (data, status, headers, config) ->
    $scope.received_invitations = data

  $http({method: 'GET', url: "/api/user/invitations/sent_invitations"})
  .success (data, status, headers, config) ->
    $scope.sent_invitations = data
    $('.section-container').foundation('section', 'reflow')

  $rootScope.pusherChannel.bind 'updateReceivedInvitation', (data) ->
    $scope.updateReceivedInvitationStatus(data.message)
    $scope.$apply()

  $rootScope.pusherChannel.bind 'updateSentInvitation', (data) ->
    updateSentInvitationStatus(data.message)
    $scope.$apply()

  $rootScope.pusherChannel.bind 'deleteInvitation', (data) ->
    $scope.deleteInvitation(data.message.id)
    $scope.$apply()

  $rootScope.pusherChannel.bind 'addInvitation', (data) ->
    $scope.addInvitation(data.message)
    $scope.$apply()

  $scope.pendingCount = (collection) ->
    pendingInvitations = _.reject collection, (el) ->
      el.status != "pending"
    $('.section-container').foundation('section', 'reflow')
    return pendingInvitations.length

  $scope.setWidth = (url, width) ->
    matches = url.match(/(.*upload)(.*)/)
    if matches != null
      return matches[1] + "/" + "w_" + width + matches[2]
    return url

  $scope.retractInvitation = (invitation_id) ->
    $http({method: 'PUT', url: "/api/user/invitations/" + invitation_id + "/retract" })
    .success (data, status, headers, config) ->
      invitation = _.find $scope.sent_invitations, (el) ->
        el.id == invitation_id
      invitation.status = "retracted"
    .error (data, status, headers, config) ->
      #console.log(data)

  $scope.declineInvitation = (invitation_id) ->
    $http({method: 'PUT', url: "/api/user/invitations/" + invitation_id + "/decline" })
    .success (data, status, headers, config) ->
      invitation = _.find $scope.received_invitations, (el) ->
        el.id == invitation_id
      invitation.status = "declined"
      $('ul.button-group button').removeAttr('disabled')
    .error (data, status, headers, config) ->
      #console.log(data)

  $scope.acceptInvitation = (invitation_id) ->
    $http({method: 'PUT', url: "/api/user/invitations/" + invitation_id + "/accept" })
    .success (data, status, headers, config) ->
      invitation = _.find $scope.received_invitations, (el) ->
        el.id == invitation_id
      invitation.status = "accepted"
      $('ul.button-group button').removeAttr('disabled')
    .error (data, status, headers, config) ->
      #console.log(data)

  $scope.updateReceivedInvitationStatus = (invitation) ->
    invitation_element = _.find $scope.received_invitations, (el) ->
        el.id == invitation.id
    invitation_element.status = invitation.status

  updateSentInvitationStatus = (invitation) ->
    console.log($scope.sent_invitations.length)
    invitation_element = _.find $scope.sent_invitations, (el) ->
        el.id == invitation.id
    invitation_element.status = invitation.status if invitation_element != undefined

  $scope.deleteInvitation = (invitation_id) ->
    $scope.received_invitations = _.reject $scope.received_invitations, (el) ->
        el.id == invitation_id

  $scope.addInvitation = (invitation) ->
    $scope.received_invitations.push(invitation)