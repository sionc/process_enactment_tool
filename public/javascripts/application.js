$(document).ready(function() {
    var pathname = window.location.pathname;
	if(pathname.search(/lifecycles/) >= 0) {
		$("#pm").removeClass("active_tab");
		$("#lm").addClass("active_tab");
    $("#home").removeClass("active_tab");
    $("#users").removeClass("active_tab");
	} else if ((pathname.search(/projects/) >=0 ) || (pathname.search(/deliverables/) >= 0)) {
		$("#pm").addClass("active_tab");
		$("#lm").removeClass("active_tab");
    $("#home").removeClass("active_tab");
    $("#users").removeClass("active_tab");
	} else if (pathname.search(/users/) >=0 ) {
		$("#users").addClass("active_tab");
		$("#lm").removeClass("active_tab");
		$("#pm").removeClass("active_tab");
    $("#home").removeClass("active_tab");
	}else {
    $("#pm").removeClass("active_tab");
		$("#lm").removeClass("active_tab");
    $("#home").addClass("active_tab");
    $("#users").removeClass("active_tab");
    }
});
