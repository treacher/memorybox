angular.module("MemoryBoxApp").config ($routeProvider) ->
	$routeProvider
		.when("/", {
			templateUrl: "/assets/angular/views/memory_boxes/index.html"
			controller: "MemoryBoxIndexCtrl"
		})
		.when("/shared_memories", {
			templateUrl: "/assets/angular/views/shared_memory_boxes/index.html"
			controller: "SharedMemoryBoxIndexCtrl"
		})
		.when("/memory_boxes/new", {
			templateUrl: "/assets/angular/views/memory_boxes/new.html"
			controller: "MemoryBoxCreateCtrl"
		})
		.when("/memory_boxes/:memory_box_id/entries",{
			templateUrl: "/assets/angular/views/entries/index.html",
			controller: "EntryGalleryCtrl"
		})
		.when("/memory_boxes/:memory_box_id/entries/:id",{
			templateUrl: "/assets/angular/views/entries/show.html",
			controller: "EntryShowCtrl"
		})
		.when("/invitations",{
			templateUrl: "/assets/angular/views/invitations/index.html",
			controller: "InvitationsIndexCtrl"
		})
		.when("/invitations/:section_tab",{
			templateUrl: "/assets/angular/views/invitations/index.html",
			controller: "InvitationsIndexCtrl"
		})
		.when("/memory_boxes/:memory_box_id/invitations/new",{
			templateUrl: "/assets/angular/views/invitations/new.html",
			controller: "InvitationCreateCtrl"
		})