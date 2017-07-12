function populateMobileProjectList(apiurl, userid) {
    $.getJSON( apirul, {userid: userid}, function( data ) {
        var items = [];
        var docs = data.items;
        $.each( docs, function( key, val ) {
            var doc = "<a href='" + "{{ base_url }}" + val.id + "'>" + 'Title: ' + val.title + ' - ID: ' + val.id + "</a>";
            items.push( "<li id='" + key + "'>" + doc + "</li>" );
        });

        $( "<ul/>", {
            "class": "my-new-list",
            html: items.join( "" )
        }).appendTo( "body" );
    });
}

