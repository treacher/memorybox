angular.module("MemoryBoxApp").controller "MemoryBoxIndexCtrl", ($scope, MemoryBox, $routeParams, $location) ->
  $scope.memory_boxes = MemoryBox.query()

  $scope.inEditMode = false

  $scope.setWidth = (url, width) ->
    matches = url.match(/(.*upload)(.*)/)
    if matches != null
      return matches[1] + "/" + "w_" + width + matches[2]
    return url

  $scope.updateObject = (scope, title) ->
    MemoryBox.update(id: scope.memory_box.id, {title: title})

  $scope.setEditMode = (editMode) ->
    $scope.inEditMode = editMode

  $scope.goToMemoryBox = (event, memory_box_id) ->
    event.preventDefault() if event
    $location.path("/memory_boxes/" + memory_box_id + "/entries/") if !$scope.inEditMode