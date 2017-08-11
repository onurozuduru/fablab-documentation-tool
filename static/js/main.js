var HOST_URL = "http://10.20.220.45/";
var ImageApiUrl = HOST_URL + "api/images/";
var FileApiUrl = HOST_URL + "api/files/";

// Takes text in the element with the given ID and copies it to clipboard.
function copyToClipboard(elementId) {
    var aux = document.createElement("input");
    aux.setAttribute("value", document.getElementById(elementId).innerHTML);
    document.body.appendChild(aux);
    aux.select();
    document.execCommand("copy");

    document.body.removeChild(aux);
}

//Item IDs are in format of name-ID where ID is ID number of the element on database
//  and name is meaningful identification for the item.
//This function takes HTML id value and returns Database ID number of the item.
function getID(itemID) {
    return itemID.split('-')[1];
}

//Helper function to create one row on image list.
//imgid: ID of the image, will be used for generating ids for HTML elements.
//imgUrl: URL of the real image.
//thumbUrl: URL for the thumbnail.
//
//Returns a row of image as DIV element.
function createImageItem(imgid, imgUrl, thumbUrl) {
    //Row container.
    var row = $('<div id="'+imgid+'" class="row img-item ui-widget-content">');
    //Create thumbnail.
    var thumb = $('<div id="thumb-'+imgid+'" class="thumb col-3">');
    thumb.append('<img src="'+thumbUrl+'"></img>');
    //Create link for the image.
    var link = $('<div class="col-9">');
    link.append('<a class="imglink" href="'+imgUrl+'"> Image: '+imgid+'</a>');
    //Create remove button for the image.
    var delImgBtn = $('<button/>', {
        text: 'Delete',
        id: 'del_'+imgid,
        click: function () {
            var is_confirmed = confirm("This image will be removed!");//Confirm before deleting.
            if(is_confirmed) {
                $.ajax({
                    url: ImageApiUrl+imgid,
                    type: "DELETE",
                    processData:false,
                    contentType: "application/json"
                }).done(function (data, textStatus, jqXHR){
                    $('#image-list #'+imgid).remove();//If it is removed from DB, remove from image list too.

                }).fail(function (jqXHR, textStatus, errorThrown){
                    console.log ("RECEIVED ERROR: textStatus:",textStatus, ";error:",errorThrown);
                });
            }
        }
    });
    link.append(delImgBtn);
    row.append(thumb);
    row.append(link);
   return row;
}

//Helper function to create one row on file list.
//fileid: ID of the file, will be used for generating ids for HTML elements.
//fileUrl: URL of the real file.
//
//Returns a row of file as DIV element.
function createFileItem(fileid, fileUrl) {
    // Get the file name.
    var split_url = fileUrl.split("/");
    var filename = split_url[split_url.length-1];
    // Create row.
    var row = $('<div id="'+fileid+'" class="row file-item">');
    row.append('<a class="filelink" href="'+fileUrl+'" target="_blank"> File: '+filename+'</a>');
    var delfileBtn = $('<button/>', {
        text: 'Delete',
        id: 'del_'+fileid,
        click: function () {
            var is_confirmed = confirm("This file will be removed!");
            if(is_confirmed) {
                $.ajax({
                    url: FileApiUrl+fileid,
                    type: "DELETE",
                    processData:false,
                    contentType: "application/json"
                }).done(function (data, textStatus, jqXHR){
                    $('#file-list #'+fileid).remove();

                }).fail(function (jqXHR, textStatus, errorThrown){
                    console.log ("RECEIVED ERROR: textStatus:",textStatus, ";error:",errorThrown);
                });
            }
        }
    });
    row.append(delfileBtn);
    return row;
}

function populateImageList(imgList) {
    $.each( imgList, function( key, val ) {
        $('#image-list').append(createImageItem(val.id, val.imagepath, val.thumbpath));
        $('.imglink').click(function (event) {
            event.preventDefault();
            $('#textarea-img-notes').val('');
            $('#img-update-status').text('');
            $('#save-img-notes-button').off();
            var imgid = $(this).parent().parent().attr('id');
            $.getJSON( ImageApiUrl+imgid, function( data ) {
                if( data.notes ) {
                    $('#textarea-img-notes').val(data.notes);
                }
            });
            $('#save-img-notes-button').on('click', {id: imgid}, updateImageHandler);
            $('#imgCode').text('![]('+$(this).attr('href')+')');
            $( "#dialog" ).dialog({
                minWidth: 250
            });
        });
    });
}

function populateFileList(fileList) {
    $.each( fileList, function( key, val ) {
        $('#file-list').append(createFileItem(val.id, val.filepath));
    });
}

function populateCaptionDialog() {
    var images = $('.img-item');
    $.each(images, function (i, img) {
        var imgid = img.id;
        var element = $('<li class="ui-state-default" id="'+imgid+'">');
        element.append('<img src="'+img.children[0].children[0].src+'">');
        $('#selectable').append(element);
    });
}

// Save notes.
function updateImageHandler(event) {
    var data = {};
    data["notes"] = $('#textarea-img-notes').val();
    var id = event.data.id;
    $.ajax({
        url: ImageApiUrl+id,
        type: "PUT",
        data:JSON.stringify(data),
        processData:false,
        contentType: "application/json"
    }).done(function (data, textStatus, jqXHR){
        $('#img-update-status').text('Updated');
    }).fail(function (jqXHR, textStatus, errorThrown){
            console.log ("RECEIVED ERROR: textStatus:",textStatus, ";error:",errorThrown);
    });
}

// Create merged images.
function createCollageHandler(collageArray) {
    $.getJSON( HOST_URL + "concat/", {
        images: JSON.stringify(collageArray)
    })
    .done(function( data ) {
        $('#image-list').append(createImageItem(data.imageid, data.imagepath, data.thumbpath));
        $('.imglink').click(function (event) {
            event.preventDefault();
            $('#textarea-img-notes').val('');
            $('#img-update-status').text('');
            $('#save-img-notes-button').off();
            var imgid = $(this).parent().parent().attr('id');
            $.getJSON( ImageApiUrl+imgid, function( data ) {
                if( data.notes ) {
                    $('#textarea-img-notes').val(data.notes);
                }
            });
            $('#save-img-notes-button').on('click', {id: imgid}, updateImageHandler);
            $('#imgCode').text('![]('+$(this).attr('href')+')');
            $( "#dialog" ).dialog({
                minWidth: 250
            });
        });
        var element = $('<li class="ui-state-default" id="'+data.imageid+'">');
        element.append('<img src="'+data.thumbpath+'">');
        $('#selectable').append(element);
        console.log(data);
    });
}