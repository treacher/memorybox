angular.module("MemoryBoxApp").controller "SharedMemoryBoxIndexCtrl", ($scope, $http, MemoryBox, $routeParams, $location) ->

  $http({method: 'GET', url: "/api/user/memory_boxes?relationship=shared"})
  .success (data, status, headers, config) ->
    $scope.shared_memory_boxes = data

  $scope.setWidth = (url, width) ->
    matches = url.match(/(.*upload)(.*)/)
    if matches != null
      return matches[1] + "/" + "w_" + width + matches[2]
    return url

  $scope.goToMemoryBox = (event, memory_box_id) ->
    event.preventDefault() if event
    $location.path("/memory_boxes/" + memory_box_id + "/entries/")