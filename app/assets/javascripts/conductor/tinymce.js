window.initTinyMCE = function() {
tinyMCE.init({
    // General options
    mode : "textareas",
    editor_selector: "tinymce",
    theme : "advanced",
    convert_urls : false,
    plugins : "autolink,lists,pagebreak,style,table,save,advhr,advimage,advlink,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

    // Theme options
    theme_advanced_buttons1 : "styleselect,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|,undo,redo,|,sub,sup",
    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,outdent,indent,blockquote,|,hr,removeformat,visualaid,|,insertdate,inserttime,preview",
    theme_advanced_buttons3 : "tablecontrols,|,link,unlink,anchor,cleanup,code,|,charmap,iespell,image,media,advhr,|,fullscreen,|,spellchecker,|,attribs",
    theme_advanced_buttons4 : "",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    theme_advanced_statusbar_location : "",
    theme_advanced_resizing : true,
    width: "600",

    file_browser_callback : 'myFileBrowser',

    // Style formats
    style_formats : [
    	{title : 'Paragraph', block : 'p'},
    	{title : 'Heading 1', block : 'h1'},
    	{title : 'Heading 2', block : 'h2'},
    	{title : 'Heading 3', block : 'h3'},
    	{title : 'Heading 4', block : 'h4'},
    ],
    // Replace values for the template plugin
    template_replace_values : {
            username : "Some User",
            staffid : "991234"
    }
});
}
initTinyMCE();

function myFileBrowser(field_name, url, type, win) {

    var cmsURL = "/images/select"
    if (cmsURL.indexOf("?") < 0) {
        cmsURL = cmsURL + "?type=" + type;
    }
    else {
        cmsURL = cmsURL + "&type=" + type;
    }

    tinyMCE.activeEditor.windowManager.open({
        file : cmsURL,
        title : 'My File Browser',
        width : 600,
        height : 500,
        resizable : "yes",
        inline : "no",
        close_previous : "no"
    }, {
        window : win,
        input : field_name
    });
    return false;
}
