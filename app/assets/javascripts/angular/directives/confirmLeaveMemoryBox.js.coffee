angular.module("MemoryBoxApp").directive "confirmLeaveMemoryBox", ->
  (scope, element, attrs) ->
    element.click ->
      scope.leaveMemoryBox(scope.memory_box_id) if confirm("Are you sure you want to leave the MemoryBox: " + scope.memory_box.title )