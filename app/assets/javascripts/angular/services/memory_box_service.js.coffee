angular.module("MemoryBoxApp").factory "MemoryBox", ($resource) ->
	$resource("/api/user/memory_boxes/:id", { id:"@id" }, { 
		update: {method: "PUT"}
	})