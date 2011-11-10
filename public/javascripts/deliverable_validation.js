$(document).ready(function() {
	$("#new_deliverable").validate({
		rules: { 
			"deliverable[name]": "required"
		},
		// // the errorPlacement has to take the table layout into account 
		//         errorPlacement: function(error, element) { 
		//         	error.appendTo( element.next() ); 
		//         },
		submitHandler: function() { alert("submitted!"); } 			
	});
});