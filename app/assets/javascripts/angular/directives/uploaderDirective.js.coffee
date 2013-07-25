angular.module("MemoryBoxApp").directive "uploader", ($http)->
  (scope, element, attrs) ->
    $http.get("/api/user/cloudinary").success (result, status, headers, config) ->
      scope.uploader = new plupload.Uploader
        runtimes : 'html5, flash, html4'
        browse_button : element[0].id
        max_file_size : '10mb'
        url : result.url
        autostart : true
        resize : { height: 800, quality: 60 }
        flash_swf_url : '/assets/uploader/flash/plupload.flash.swf'

      scope.uploader.bind "BeforeUpload", (upload, file) ->
        $('.progress').show();

      scope.uploader.bind "Error", (upload, error) ->
        console.log(JSON.stringify(error))

      scope.uploader.bind 'FileUploaded', (up, file, result) ->
        result = JSON.parse(result.response)
        scope.create(result.secure_url, result.public_id, result.format, result.resource_type)

      scope.uploader.bind 'UploadProgress', (up, file) ->
        $('.progress .meter').css('width', up.total.percent + '%')

      scope.uploader.bind 'UploadComplete', (up, files) ->
        $('.progress').hide();

      scope.uploader.init()

      scope.uploader.bind "FilesAdded", (upload, file) ->
        $('.progress .meter').css('width', '0%')
        scope.uploader.start()