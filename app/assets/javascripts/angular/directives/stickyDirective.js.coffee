angular.module("MemoryBoxApp").directive "sticky", ->
  (scope, element, attrs) ->
    element.sticky({topSpacing:0, wrapperClassName: "sticky-wrapper"})

angular.module("MemoryBoxApp").directive 'backImg', -> 
  (scope, element, attrs) ->
    attrs.$observe 'backImg', (value) ->
      element.css('background-image', 'url('+value+')')
      element.css('background-size', 'cover')