angular.module("MemoryBoxApp").directive "update", ->
  (scope, element, attrs) ->
  	element.bind 'change', ->
  		scope.updateObject(scope, element[0].value)

angular.module("MemoryBoxApp").directive "updateTitle", ->
  (scope, element, attrs) ->
  	element.bind 'change', ->
  		scope.updateTitle(scope, element[0].value)