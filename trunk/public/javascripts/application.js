// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function quickRedReference() {
	window.open(
			"http://hobix.com/textile/quick.html",
			"redRef",
			"height=600,width=550,channelmode=0,dependent=0," +
			"directories=0,fullscreen=0,location=0,menubar=0," +
			"resizable=0,scrollbars=1,status=1,toolbar=0"
	);
}

function add_comment(url, parent_id) {
	var comment = window.prompt("댓글을 입력하세요:");
	if(comment) {
		if(!parent_id) parent_id = "";
		$.ajax({
			beforeSend: function() { $('#wait_'+parent_id).show() },
			complete: function() { $('#wait_'+parent_id).hide() },
			data: {'comment[text]': comment, 'parent_id': parent_id },
			dataType:'script', 
			type:'post', 
			url:url
		}); 
		return false;
	}
}

function show_event(day) {
	$('.events:not(#event_'+day+')').hide();
	$('#event_'+day).toggle();
}

jQuery.fn.linkToUnlessCurrent = function(){
	return this.each(function(){
		if($(this).attr("href") == parseUri(window.location).path) {
			$(this).replaceWith($(this).html());
		}	
	});
};

$(document).ready(function() {
	$.ajaxSetup({ data: { authenticity_token: encodeURIComponent(AUTH_TOKEN) }});
	$('#side_nav a').linkToUnlessCurrent();
  $("textarea.autogrow").autogrow();
});

