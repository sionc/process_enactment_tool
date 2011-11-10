$(document).ready(function() {
	$("#new_deliverable").validate({
		onfocusout: false,
		onkeyup: false,
		rules: { 
			"deliverable[name]": "required",
			
			"deliverable[estimated_size]": "required",
			"deliverable[estimated_production_rate]": "required",
			"deliverable[estimated_effort]": "required"
		}
	});
});