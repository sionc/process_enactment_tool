$(document).ready(function() {
    var pathname = window.location.pathname;
	if(pathname.search(/lifecycles/) >= 0) {
		$("#pm").removeClass("active_tab");
		$("#lm").addClass("active_tab");
	} else {
		$("#pm").addClass("active_tab");
		$("#lm").removeClass("active_tab");	
	}
});
