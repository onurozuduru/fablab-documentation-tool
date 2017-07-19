var HOST_URL = "http://10.20.203.95/";
var ImageApiUrl = HOST_URL + "api/images/";
var FileApiUrl = HOST_URL + "api/files/";
function copyToClipboard(elementId) {
    var aux = document.createElement("input");
    aux.setAttribute("value", document.getElementById(elementId).innerHTML);
    document.body.appendChild(aux);
    aux.select();
    document.execCommand("copy");

    document.body.removeChild(aux);
}
function createImageItem(imgid, imgUrl, thumbUrl) {
    var row = $('<div id="'+imgid+'" class="row img-item">');
    var thumb = $('<div class="col-3">');
    thumb.append('<img src="'+thumbUrl+'"></img>');
    var link = $('<div class="col-9">');
    link.append('<a class="imglink" href="'+imgUrl+'"> Image: '+imgid+'</a>');

    var delImgBtn = $('<button/>', {
        text: 'Delete',
        id: 'del_'+imgid,
        click: function () {
            var is_confirmed = confirm("This image will be removed!");
            if(is_confirmed) {
                $.ajax({
                    url: ImageApiUrl+imgid,
                    type: "DELETE",
                    processData:false,
                    contentType: "application/json"
                }).done(function (data, textStatus, jqXHR){
                    $('#image-list #'+imgid).remove();

                }).fail(function (jqXHR, textStatus, errorThrown){
                    console.log ("RECEIVED ERROR: textStatus:",textStatus, ";error:",errorThrown);
                });
            }
        }
    });
    link.append(delImgBtn);
    row.append(thumb);
    row.append(link);
   return row;//'<div id="'+imgid+'" class="row img-item"><div class="col-3"><i class="fa fa-picture-o" aria-hidden="true"></i></div><div class="col-9"><a class="imglink" href="'+imgUrl+'"> Image: '+imgid+'</a></div></div>';
}
function createFileItem(fileid, fileUrl) {
    var split_url = fileUrl.split("/");
    var filename = split_url[split_url.length-1];
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