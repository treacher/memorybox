angular.module("MemoryBoxApp").controller "MemoryBoxCreateCtrl", ($scope, MemoryBox, $routeParams, $location) ->
  $scope.createButtonDisabled = false

  $scope.createBox = (memory_box) ->
    $scope.createButtonDisabled = true
    new_memory_box = new MemoryBox(memory_box)
    new_memory_box.$save (u, putResponseHeaders) ->
      $location.path("/memory_boxes/" + u.id + "/entries")