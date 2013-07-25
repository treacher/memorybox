angular.module("MemoryBoxApp").directive "confirmDestroyMemoryBox", ($location) ->
  (scope, element, attrs) ->
    element.click ->
      scope.destroyMemoryBox(scope.memory_box_id) if confirm("Are you sure you want to destroy the MemoryBox: " + scope.memory_box.title )
      $location.path("/")