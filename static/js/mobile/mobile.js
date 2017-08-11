var contentApiUrl = "http://10.20.220.45/api/contents/";
var imageApiUrl = "http://10.20.220.45/api/images/";
var fileApiUrl = "http://10.20.220.45/api/files/";

var projectEditUrl;
var imgEditUrl;
var imgUploadUrl;
var authorid;

function getID(itemID) {
    return itemID.split('-')[1];
}

function createProjectHandler(event, contentid) {
    event.preventDefault();
    var data = {};
    data["content"] = "";
    data["title"] = "New Project";
    data["authorid"] = authorid;
    console.log(JSON.stringify(data));
    $.ajax({
        url: contentApiUrl,
        type: "POST",
        data:JSON.stringify(data),
        processData:false,
        contentType: "application/json"
    }).done(function (data, textStatus, jqXHR){
        location.reload();
    }).fail(function (jqXHR, textStatus, errorThrown){
        console.log ("RECEIVED ERROR: textStatus:",textStatus, ";error:",errorThrown);
    });
}

function updateImageHandler(event) {
    var data = {};
    data["notes"] = $('#textarea-img-notes').val();
    var id = event.data.id;
    $.ajax({
        url: imageApiUrl+id,
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

function uploadImage(event) {
    // var data = {};
    // data["content"] = "";
    // data["title"] = "New Project";
    // data["authorid"] = authorid;
    // console.log(JSON.stringify(data));
    // $.ajax({
    //     url: contentApiUrl,
    //     type: "POST",
    //     data:JSON.stringify(data),
    //     processData:false,
    //     contentType: "application/json"
    // }).done(function (data, textStatus, jqXHR){
    //     location.reload();
    // }).fail(function (jqXHR, textStatus, errorThrown){
    //     console.log ("RECEIVED ERROR: textStatus:",textStatus, ";error:",errorThrown);
    // });
    var formData = new FormData($('#form-image-upload'));
    console.log(formData.keys());
}

function removeProject(contentid) {
    $.ajax({
        url: contentApiUrl+contentid,
        type: "DELETE",
        processData:false,
        contentType: "application/json"
    }).done(function (data, textStatus, jqXHR){

    }).fail(function (jqXHR, textStatus, errorThrown){
        console.log ("RECEIVED ERROR: textStatus:",textStatus, ";error:",errorThrown);
    });
}

function removeImage(imageid) {
    $.ajax({
        url: imageApiUrl+imageid,
        type: "DELETE",
        processData:false,
        contentType: "application/json"
    }).done(function (data, textStatus, jqXHR){

    }).fail(function (jqXHR, textStatus, errorThrown){
        console.log ("RECEIVED ERROR: textStatus:",textStatus, ";error:",errorThrown);
    });
}

function setPages(userid, projectEditUrl_, imgEditUrl_, imgUploadUrl_) {
    projectEditUrl = projectEditUrl_;
    imgEditUrl = imgEditUrl_;
    imgUploadUrl = imgUploadUrl_;
    authorid = userid;
    var totalPages = 1;
    for (i = 1; i <= totalPages; i++) {
        $.getJSON(contentApiUrl, {userid: authorid, page: i}, function ( data ) {
            totalPages = data.pages;
            var projects = data.items;

            populateMobileProjectList(projects, authorid, projectEditUrl);
            $('#button-create-project').click(createProjectHandler);

        });
    }
}

function getUrlVars() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

function populateMobileProjectList( projectList, userid, editurl ) {
    $.each( projectList, function( key, val ) {
        var project = "<a href='" + editurl + val.id + "&userid="+ userid +"'>" + 'Title: ' + val.title + ' - ID: ' + val.id + "</a>";
        var del = "<a href='#' class='delete' data-icon='delete'>Delete</a>";
        $('#listview-project-list').append("<li id=doc-" + val.id + ">" + project + del + "</li>");
    });
    $( ".delete" ).on( "click", function(e) {
        e.preventDefault();
        var listitem = $( this ).parent( "li" );
        confirmAndDeleteProject( listitem );
    });
    $('#listview-project-list').listview("refresh");
}

function confirmAndDeleteProject(listitem) {
    // Highlight the list item that will be removed
    listitem.children( ".ui-btn" ).addClass( "ui-btn-active" );
    // Show the confirmation popup
    $( "#confirm-delete-project" ).popup( "open" );
    // Proceed when the user confirms
    $( "#confirm-delete-project #yes" ).on( "click", function() {
        removeProject(getID(listitem[0].id));
        listitem.remove();
        $( "#list" ).listview( "refresh" );
    });
    // Remove active state and unbind when the cancel button is clicked
    $( "#confirm-delete-project #cancel" ).on( "click", function() {
        listitem.children( ".ui-btn" ).removeClass( "ui-btn-active" );
        $( "#confirm-delete-project #yes" ).off();
    });
}

function confirmAndDeleteImage(listitem) {
    // Highlight the list item that will be removed
    listitem.children( ".ui-btn" ).addClass( "ui-btn-active" );
    // Show the confirmation popup
    $( "#confirm-delete-image" ).popup( "open" );
    // Proceed when the user confirms
    $( "#confirm-delete-image #yes" ).on( "click", function() {
        removeImage(getID(listitem[0].id));
        listitem.remove();
        $( "#list" ).listview( "refresh" );
    });
    // Remove active state and unbind when the cancel button is clicked
    $( "#confirm-delete-image #cancel" ).on( "click", function() {
        listitem.children( ".ui-btn" ).removeClass( "ui-btn-active" );
        $( "#confirm-delete-image #yes" ).off();
    });
}

function populateMobileProjectListAjax(apiurl, userid, editurl) {
    $.getJSON( apiurl, {userid: userid}, function( data ) {
        var docs = data.items;
        populateMobileProjectList(docs, userid, editurl);
    });
}

function populateMobileImageList(imgList, imgediturl) {
    $.each( imgList, function( key, val ) {
        var imgitem = $('<li id="img-'+val.id+'"/>');
        var link = $('<a/>');
        var linkthumb = $('<img src="' + val.thumbpath + '"/>');

        linkthumb.attr('src', val.thumblink);
        link.text('Image: ' + val.id);
        link.attr('href', imgediturl + '?id=' + val.id);
        link.append(linkthumb);

        imgitem.append(link);
        imgitem.append("<a href='#' class='delete-img' data-icon='delete'>Delete</a>");
        $('#listview-image-list').append(imgitem);
    });
    $( ".delete-img" ).on( "click", function(e) {
        e.preventDefault();
        var listitem = $( this ).parent( "li" );
        confirmAndDeleteImage( listitem );
    });
    $('#listview-image-list').listview("refresh");
}

function populateMobileImageListAjax(apiurl, userid, imgediturl) {
    $.getJSON( apiurl, {userid: userid}, function( data ) {
        populateMobileImageList(data.images, imgediturl);
        $('#listview-image-list').listview("refresh");
    });
}


$(document).on( "pagebeforeshow", '#page-image-list',function( event ) {
    var id = getUrlVars()["id"];
    $.getJSON( contentApiUrl+id, function( data ) {
        var imageList = data.images;
        populateMobileImageList(imageList, imgEditUrl);
    });

    $('#button-add-image').attr('href', imgUploadUrl+'?id='+id);
    $('[data-role="page"]').trigger('pagecreate');
} );

$(document).on( "pagebeforeshow", '#page-image-edit',function( event ) {
    var id = getUrlVars()["id"];
    $('#textarea-img-notes').val('');
    $('#img-update-status').text('');
    $('#button-save-img').off();
    $.getJSON( imageApiUrl+id, function( data ) {
        $('#img-detail').attr('src', data.imagepath);
        if( data.notes ) {
            $('#textarea-img-notes').val(data.notes);
        }
    });
    $('#button-save-img').on('click', {id: id}, updateImageHandler);
    $('[data-role="page"]').trigger('pagecreate');
} );

$(document).on("pagebeforeshow", '#page-image-upload', function ( event ) {
   var id = getUrlVars()["id"];
    $('#imageupload').fileupload({
    dataType: 'json',
    add: function (e, data) {
        var fileName = "";
        $.each(data.files, function (index, file) {
            fileName = file.name + " ";
        });

        data.context = $('#button-upload-img')
                .click(function () {
                    //data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.formData = [{name: 'id', value: id}, {name: 'size', value: $("fieldset :radio:checked").attr('id')}];
                    data.submit();
                });
    },
    done: function (e, data) {
        console.log(data.result);
    }
    });
   $('[data-role="page"]').trigger('pagecreate');
});


