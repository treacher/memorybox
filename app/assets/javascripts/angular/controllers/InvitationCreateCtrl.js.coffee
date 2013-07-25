angular.module("MemoryBoxApp").controller "InvitationCreateCtrl", ($scope, $http, $routeParams, $location, MemoryBox) ->
  $scope.createButtonDisabled = false
  $scope.memory_box_id = $routeParams.memory_box_id
  $scope.memory_box = MemoryBox.get(id: $routeParams.memory_box_id)


  $scope.sendInvitations = (emails, message) ->
    $scope.createButtonDisabled = true
    $http({method: 'POST', url: "/api/user/memory_boxes/"+$scope.memory_box_id+"/invitations/", data: { invitations: emails, message: message }})
    .success (data, status, headers, config) ->
      $location.path("/invitations/sent")
    .error (data, status, headers, config) ->
      $location.path("/invitations/sent")