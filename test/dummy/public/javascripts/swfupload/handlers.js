$(document).ready(function() {	
  attachmentMagick.startup();
});

var attachmentMagick = {
  startup: function(){
    this.klass            = $('#klass').val();
    this.klass_id         = $('#klass_id').val();
    this.elementSortable  = $("#attachmentSortable");
    
    if ( $('#attachmentProgressContainer:first') ) { attachmentMagick.prepareImageUpload( this.klass, this.klass_id ); }
    $('.remove_image').live('click', function(){ attachmentMagick.removeImage( $(this) ); });
    this.elementSortable.sortable({ update: function(event, ui){ attachmentMagick.updateImageList(); }});
  
  },
  removeImage: function(el){
    var $attach_image = el.parents('.attachment_magick_image')
    var $image        = $attach_image.find("img:first");
    var image_id      = $attach_image.find("input[type='hidden']:first").val();
    var url_path      = "/publisher/images/"+image_id+"/"+this.klass+"/"+this.klass_id
    
    $.ajax({
	    type: "DELETE",
	    url:  url_path, 
	    
	    success: function(data){  
	      $image.fadeOut(250, function(){ $(this).parents('.attachment_magick_image').remove(); })
	    }
		});
  },
  updateImageList: function(){
    var sort  = this.elementSortable.sortable('toArray');
    var array = new Array();
    
    for( var i = 0; i < sort.length; i++ ){ array.push( sort[i].split('_').pop() ); };

  	$.ajax({
  	   type: "POST",
  	   url: "/publisher/images/update_sortable",
  	   data: {images: array, klass: this.klass, klass_id: this.klass_id},
  	   
  	   error: function(XMLHttpRequest, message){
  	     console.log(XMLHttpRequest.responseText);
  	   }
  	 });
  },
  prepareImageUpload: function(type, id){
  	var swfu = new SWFUpload({
          upload_url : 					        '/publisher/images/',
          post_params : 					      { 'klass' : type, 'klass_id' : id },

          file_size_limit: 				      '20 MB',
          file_types: 					        '*.jpg; *.png; *.gif; *.jpeg',
          file_types_description: 		  'Images Files',
          file_upload_limit : 			    0,

          file_queue_error_handler: 		fileQueueError,
          file_dialog_complete_handler: fileDialogComplete,
          upload_progress_handler: 		  uploadProgress,
          upload_error_handler: 			  uploadError,
          upload_success_handler: 		  uploadSuccess,
          upload_complete_handler: 		  uploadComplete,

          button_placeholder_id: 			  'attachmentButton',
          button_width: 					      160,
          button_height: 					      16,
          button_text : 					      '<span class="button">BROWSE...</span>',
          button_text_style: 				    '.button { font-family: Helvetica, Arial, sans-serif; font-size: 11pt; border:1px solid #000;} .buttonSmall { font-size: 10pt; }',
          button_text_top_padding: 		  0,
          button_text_left_padding: 		0,
          button_window_mode: 			    SWFUpload.WINDOW_MODE.TRANSPARENT,
          button_cursor: 					      SWFUpload.CURSOR.HAND,

          flash_url: 						        '/javascripts/swfupload/swfupload.swf',
          custom_settings: 				      { upload_target : 'attachmentProgressContainer' },
          debug: false
        });

      return swfu;
  }
}

function fileQueueError(file, errorCode, message) {
	try {
		var imageName = "error.gif";
		var errorName = "";
		if (errorCode === SWFUpload.errorCode_QUEUE_LIMIT_EXCEEDED) {
			errorName = "Muitos arquivos na fila ao mesmo tempo.";
		}

		if (errorName !== "") {
			alert(errorName);
			return;
		}

		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			imageName = "zerobyte.gif";
			break;
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			imageName = "toobig.gif";
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
		default:
			alert(message);
			break;
		}

		addImage("/images/swfupload/" + imageName);

	} catch (ex) {
		this.debug(ex);
	}

}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (numFilesQueued > 0) {
			this.startUpload();
		}
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadProgress(file, bytesLoaded) {

	try {
		var percent = Math.ceil((bytesLoaded / file.size) * 100);

		var progress = new FileProgress(file,  this.customSettings.upload_target);
		progress.setProgress(percent);
		if (percent === 100) {
			progress.setStatus("Criando thumbnail...");
			progress.toggleCancel(false, this);
		} else {
			progress.setStatus("Fazendo upload...");
			progress.toggleCancel(true, this);
		}
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadSuccess(file, serverData) {
	try {
		var progress = new FileProgress(file,  this.customSettings.upload_target);
		
			addImagePublisher(serverData)
			progress.setStatus("Thumbnail criado.");
			progress.toggleCancel(false);

	} catch (ex) {
		this.debug(ex);
	}
}

function uploadComplete(file) {
	try {
		/*  I want the next upload to continue automatically so I'll call startUpload here */
		
		if (this.getStats().files_queued > 0) {
			this.startUpload();
		} else {
			var progress = new FileProgress(file,  this.customSettings.upload_target);
			progress.setComplete();
			progress.setStatus("Todas imagens recebidas.");
			progress.toggleCancel(false);
			update_img_index();
		}
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadError(file, errorCode, message) {
	var imageName =  "error.gif";
	var progress;
	try {
		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			try {
				progress = new FileProgress(file,  this.customSettings.upload_target);
				progress.setCancelled();
				progress.setStatus("Cancelado");
				progress.toggleCancel(false);
			}
			catch (ex1) {
				this.debug(ex1);
			}
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			try {
				progress = new FileProgress(file,  this.customSettings.upload_target);
				progress.setCancelled();
				progress.setStatus("Parado");
				progress.toggleCancel(true);
			}
			catch (ex2) {
				this.debug(ex2);
			}
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			imageName = "uploadlimit.gif";
			break;
		default:
			alert(message);
			break;
		}

		addImage("/images/swfupload/" + imageName);

	} catch (ex3) {
		this.debug(ex3);
	}

}

function addImagePublisher(serverData){
	$('.thumbnails:first .list_images:first').prepend(serverData).find("img:last");
	attachmentmagick.updateImageList();
}

function addImage(src) {
	var newImg = document.createElement("img");
	newImg.style.margin = "5px";

	document.getElementById("thumbnails").appendChild(newImg);
	
	if (newImg.filters) {
		try {
			newImg.filters.item("DXImageTransform.Microsoft.Alpha").opacity = 0;
		} catch (e) {
			// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
			newImg.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + 0 + ')';
		}
	} else {
		newImg.style.opacity = 0;
	}

	newImg.onload = function () {
		fadeIn(newImg, 0);
	};
	newImg.src = src;
}

function fadeIn(element, opacity) {
	var reduceOpacityBy = 5;
	var rate = 30;	// 15 fps

	if (opacity < 100) {
		opacity += reduceOpacityBy;
		if (opacity > 100) {
			opacity = 100;
		}

		if (element.filters) {
			try {
				element.filters.item("DXImageTransform.Microsoft.Alpha").opacity = opacity;
			} catch (e) {
				// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
				element.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + opacity + ')';
			}
		} else {
			element.style.opacity = opacity / 100;
		}
	}

	if (opacity < 100) {
		setTimeout(function () {
			fadeIn(element, opacity);
		}, rate);
	}
}


/* ******************************************
 *	FileProgress Object
 *	Control object for displaying file info
 * ****************************************** */
function FileProgress(file, targetID) {
	this.fileProgressID = "divFileProgress";

	this.fileProgressWrapper = document.getElementById(this.fileProgressID);
	if (!this.fileProgressWrapper) {
		this.fileProgressWrapper = document.createElement("div");
		this.fileProgressWrapper.className = "progressWrapper";
		this.fileProgressWrapper.id = this.fileProgressID;

		this.fileProgressElement = document.createElement("div");
		this.fileProgressElement.className = "progressContainer";

		var progressCancel = document.createElement("a");
		progressCancel.className = "progressCancel";
		progressCancel.href = "#";
		progressCancel.style.visibility = "hidden";
		progressCancel.appendChild(document.createTextNode(" "));

		var progressText = document.createElement("div");
		progressText.className = "progressName";
		progressText.appendChild(document.createTextNode(file.name));

		var progressBar = document.createElement("div");
		progressBar.className = "progressBarInProgress";

		var progressStatus = document.createElement("div");
		progressStatus.className = "progressBarStatus";
		progressStatus.innerHTML = "&nbsp;";

		this.fileProgressElement.appendChild(progressCancel);
		this.fileProgressElement.appendChild(progressText);
		this.fileProgressElement.appendChild(progressStatus);
		this.fileProgressElement.appendChild(progressBar);

		this.fileProgressWrapper.appendChild(this.fileProgressElement);

		document.getElementById(targetID).appendChild(this.fileProgressWrapper);
		fadeIn(this.fileProgressWrapper, 0);

	} else {
		this.fileProgressElement = this.fileProgressWrapper.firstChild;
		this.fileProgressElement.childNodes[1].firstChild.nodeValue = file.name;
	}

	this.height = this.fileProgressWrapper.offsetHeight;

}
FileProgress.prototype.setProgress = function (percentage) {
	this.fileProgressElement.className = "progressContainer green";
	this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
	this.fileProgressElement.childNodes[3].style.width = percentage + "%";
};
FileProgress.prototype.setComplete = function () {
	this.fileProgressElement.className = "progressContainer blue";
	this.fileProgressElement.childNodes[3].className = "progressBarComplete";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setError = function () {
	this.fileProgressElement.className = "progressContainer red";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setCancelled = function () {
	this.fileProgressElement.className = "progressContainer";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setStatus = function (status) {
	this.fileProgressElement.childNodes[2].innerHTML = status;
};

FileProgress.prototype.toggleCancel = function (show, swfuploadInstance) {
	this.fileProgressElement.childNodes[0].style.visibility = show ? "visible" : "hidden";
	if (swfuploadInstance) {
		var fileID = this.fileProgressID;
		this.fileProgressElement.childNodes[0].onclick = function () {
			swfuploadInstance.cancelUpload(fileID);
			return false;
		};
	}
};
