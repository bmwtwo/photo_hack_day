$(document).ready( function() {
	$.each($("#sliders div div"), function(_, div) {
		var p = $(div).parent().children("p");
		$(div).slider({
			step: $(div).attr("name") == "shutter_speed" ? 0.001 : 0.1,
			slide: function(event, ui) { $(p).text( $(p).attr("value") + $(div).slider("value") ); },
			stop: function(event, ui) {
				$(p).text( $(p).attr("value") + $(div).slider("value") );
				$("#featureImage img").fadeOut();
				$("#stats").fadeOut();
				$.ajax({
					url: "/photos/ajax",
					cache: false,
					data: getAjaxData(),
					success: function(data) {
						displayImage(data);
					},
					error: function(e) {
						console.log(e);
					}
				});
			},
			max: parseFloat($(div).attr("data_max")),
			min: parseFloat($(div).attr("data_min"))
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
		//$("#featureImage").addClass("active");

		var featureImage = $("#featureImage img");

		if (data["image_url"] == $(featureImage).attr("src")) {
			$(featureImage).fadeIn();
			$("#stats").fadeIn();
		} else {
			$("#featureImage img")
				.attr("src", data["image_url"])
				.load(function() {
					$(this).css({width: "auto", height: "auto"});
					var width = $(this).width();
					var height = $(this).height();
					console.log(width, height);
					var ratio = 0.5*$(document).width() / width;
					var percent = ratio*height / $(document).height * 100;
					$(this).css({
						width: "50%",
						height: percent + "%",
						"margin-top": Math.max(-height*ratio / 2, -$(document).height() / 2) + "px"
					})
					.fadeIn();

					$("#stats h2").html(data["name"]);
					console.log(data["user"]);
					$("#stats p").html("by " + data["user"]["fullname"]);
					$("#stats ul").html(getStatString(data));
					$("#stats").fadeIn();
				});
		}
	}

	function getStatString(data) {
		// for(key in data) {
		// 	console.log(key + " => " + data[key]);
		// };
		result = "<li>Aperture: f/" + data["aperture"] + "</li>";
		result += "<li>Focal length: " + data["focal_length"] + "</li>";
		result += "<li>ISO: " + data["iso"] + "</li>";
		result += "<li>Shutter speed: " + data["shutter_speed"] + "</li>";
		return result
	}
});
