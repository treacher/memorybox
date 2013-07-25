angular.module("MemoryBoxApp", ["ngResource"]).run ($rootScope) ->
	$rootScope.pusher = new Pusher('7bc50c67070fc818bce3')
	$rootScope.pusherChannel = $rootScope.pusher.subscribe($('.pusher')[0].id)

	#Pusher.log = (message) ->
  #	window.console.log(message) if (window.console && window.console.log)