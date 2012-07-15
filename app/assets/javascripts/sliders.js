$(document).ready( function() {
	$.each($("#sliders div div"), function(_, div) {
		var p = $(div).parent().children("p");
		$(div).slider({
			slide: function(event, ui) { $(p).text( $(p).attr("value") + $(div).slider("value") ); },
			stop: function(event, ui) { $(p).text( $(p).attr("value") + $(div).slider("value") ); },
			max: 100,
			min: 0
		});
	});
});