$(document).ready(function() {
	$("#deliverable_form").validate({
		onfocusout: false,
		onkeyup: false,
		rules: { 
			"deliverable[name]": "required",
			
			"deliverable[estimated_size]": "required",
			"deliverable[estimated_production_rate]": "required",
			"deliverable[estimated_effort]": "required"
		},
        errorPlacement: function(error, element) {

            switch(element.attr("name"))
            {
                case "deliverable[estimated_size]":
                    error.appendTo('#estimated_size_input_id');
                break;
                case "deliverable[estimated_production_rate]":
                    error.appendTo('#estimated_production_rate_input_id');
                break;
                case "deliverable[estimated_effort]":
                    error.appendTo('#estimated_effort_input_id');
                break;
                default:
                     error.insertAfter(element);
                break;
            }
        }
    })
});