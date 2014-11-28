$(document).ready(function() {
	$("section").first().addClass("active");
	$("#previous").addClass("hide");

	var current = 1;
	var number = $("section").length;

	$("#previous").click(function() {previous();});

	function previous() {
		$("#next").removeClass("hide");
		if(current > 1) {
			current--;
		}
		if(current <= 1) {
			$("#previous").addClass("hide");
		}
		$("section").removeClass("active");
		$("#n" + current).addClass("active");
	}

	$("#next").click(function() {next();});

	function next() {
		$("#previous").removeClass("hide");
		if(current < number) {
			current++;
		}
		if(current >= number) {
			$("#next").addClass("hide");
		}
		$("section").removeClass("active");
		$("#n" + current).addClass("active");
	}
});