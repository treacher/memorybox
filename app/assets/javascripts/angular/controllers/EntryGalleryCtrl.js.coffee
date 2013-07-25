angular.module("MemoryBoxApp").controller "EntryGalleryCtrl", ($scope, Entry, MemoryBox, $http, $routeParams, $location) ->
  $scope.entries = Entry.query(memory_box_id: $routeParams.memory_box_id)
  $scope.memory_box = MemoryBox.get(id: $routeParams.memory_box_id)
  $scope.memory_box_id = $routeParams.memory_box_id

  $scope.inEditMode = false

  $scope.create = (media_url, media_identifier, media_format, media_type) ->
    new_entry = new Entry(media_url: media_url, media_identifier: media_identifier, media_format: media_format, media_type: media_type)
    new_entry.$save memory_box_id: $scope.memory_box_id, (u, putResponseHeaders) ->
      $scope.entries.push(u) if u.error == undefined

  $scope.updateObject = (scope, description) ->
    Entry.update(memory_box_id: $scope.memory_box_id, id: scope.entry.id, {description: $.trim(description)})

  $scope.updateTitle = (scope, title) ->
    MemoryBox.update(id: $scope.memory_box_id, {title: title})

  $scope.destroyMemoryBox = (memory_box_id) ->
    MemoryBox.delete(id: memory_box_id)

  $scope.leaveMemoryBox = (memory_box_id) ->
    $http({method: 'DELETE', url: "/api/user/memory_boxes/"+memory_box_id+"/leave_memory_box" })
    .success (data, status, headers, config) ->
      $location.path("/")

  $scope.destroyEntry = (entry_id) ->
    if confirm("Are you sure you want to delete the MemoryBox entry?")
      Entry.delete memory_box_id: $scope.memory_box_id, id: entry_id, ->
        $scope.entries = _.reject $scope.entries, (el) ->
          el.id == entry_id

  $scope.setWidth = (url, width) ->
    width = width * 2 if isRetinaDevice()
    matches = url.match(/(.*upload)(.*)/)
    return matches[1] + "/" + "w_" + width + matches[2] if matches != null
    return url

  $scope.setJpg = (url) ->
    matches = url.match(/(.*)(\.[^.]+)$/)
    return matches[1] + ".jpg"

  $scope.setWidthAndJpg = (url, width) ->
    return $scope.setJpg($scope.setWidth(url,width))

  isRetinaDevice = ->
    (window.devicePixelRatio == undefined ? 1 : window.devicePixelRatio) > 1

  $scope.setEditMode = (editMode) ->
    $scope.inEditMode = editMode

  $scope.goToEntry = (event, memory_box_id, entry_id) ->
    event.preventDefault() if event
    $location.path("/memory_boxes/" + memory_box_id + "/entries/" + entry_id ) if !$scope.inEditMode

  $scope.buttonPanel = ->
    return '/assets/angular/views/entries/partials/admin_button_panel.html' if $scope.memory_box.admin
  
  $scope.galleryEntry = ->
    return '/assets/angular/views/entries/partials/admin_gallery_entry.html' if $scope.memory_box.admin
    return '/assets/angular/views/entries/partials/gallery_entry.html'
