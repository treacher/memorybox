angular.module("MemoryBoxApp").controller "NavigationCtrl", ($scope, $rootScope, $location, $http, ReceivedInvitation) ->

	$scope.invitationCount = 0

	$http({method: "GET", url: "/api/user/invitations/received_invitations"})
	.success (data, status, headers, config) ->
		invitations = _.reject data, (invitation) ->
	  	return invitation.status != "pending"
	  $scope.invitationCount = invitations.length 
  	$('.top-bar a.compact-on-click').click ->
  		$('.toggle-topbar a').trigger('click')

	$rootScope.pusherChannel.bind 'updateInvitations', (data) ->
	  $scope.invitationCount = data.message
	  $scope.$apply()

	$scope.isActive = (route) ->
    return route == $location.path()