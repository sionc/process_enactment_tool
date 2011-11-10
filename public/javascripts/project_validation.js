$(document).ready(function() {
	$("#project_form").validate({
		onfocusout: false,
		onkeyup: false,
		rules: {
			"project[name]": "required"
        }
    })
});