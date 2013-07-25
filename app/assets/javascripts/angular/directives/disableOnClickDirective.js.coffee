angular.module("MemoryBoxApp").directive "disableOnClick", ->
	(scope, element, attrs) ->
		element.click ->
			element.parent().parent().find('button').attr('disabled', 'disabled')