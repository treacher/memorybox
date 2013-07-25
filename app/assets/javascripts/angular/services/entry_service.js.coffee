angular.module("MemoryBoxApp").factory "Entry", ($resource) ->
	$resource("/api/user/memory_boxes/:memory_box_id/entries/:id",
		{ id:"@id", memory_box_id: "@memory_box_id"}, 
		{ update: { method: "PUT" } }
	)