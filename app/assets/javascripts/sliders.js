$(document).ready( function() {
	$.each($("#sliders div div"), function(_, div) {
		var p = $(div).parent().children("p");
		$(div).slider({
			slide: function(event, ui) { $(p).text( $(p).attr("value") + $(div).slider("value") ); },
			stop: function(event, ui) {
				$(p).text( $(p).attr("value") + $(div).slider("value") );
				$("#featureImage img").css("opacity", 0.5);
				$.ajax({
					url: "/photos/ajax",
					cache: false,
					data: getAjaxData(),
					success: function(data) {
						console.log(data["image_url"]);
						displayImage(data);
					},
					error: function(e) {
						console.log(e);
					}
				});
			},
			max: parseInt($(div).attr("data_max")),
			min: parseInt($(div).attr("data_min"))
		});
	});

	function getAjaxData() {
		var data = "";
		$.each($("#sliders div div"), function(_, div) {
			data += $(div).attr("name") + "=" + $(div).slider("value") + "&";
		});
		return data
	}

	function displayImage(data) {
		$("#featureImage").removeClass("hidden");
		$("#featureImage img").attr("src", data["image_url"]).css("opacity", 1);
	}
});