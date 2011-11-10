var processEstimatedSize =
function(fieldHandler) {
	  // Extract the estimated size
    var estimatedSize = parseFloat($('#deliverable_estimated_size').val());
    
    // Notify the field handler that the size has been updated
    fieldHandler.modifyEstimatedSize(estimatedSize);

    // Determine which field should be calculated and disabled
    var calculatedField = fieldHandler.getCalculatedField();
    
    // Calculate and populate the calculated field
    processCalculatedField(calculatedField);
}

var processEstimatedProductionRate = 
function(fieldHandler) {
	  // Extract the estimated production rate
    var estimatedProductionRate = parseFloat($('#deliverable_estimated_production_rate').val());
    
    // Notify the field handler that the production rate has been updated
    fieldHandler.modifyEstimatedProductionRate(estimatedProductionRate);

    // Determine which field should be calculated and disabled
    var calculatedField = fieldHandler.getCalculatedField();
    
    // Calculate and populate the calculated field
    processCalculatedField(calculatedField);
}

var processEstimatedEffort = 
function(fieldHandler) {
	  // Extract the estimated effort
    var estimatedEffort = parseFloat($('#deliverable_estimated_effort').val());
    
    // Notify the field handler that the estimated effort has been updated
    fieldHandler.modifyEstimatedEffort(estimatedEffort);

    // Determine which field should be calculated and disabled
    var calculatedField = fieldHandler.getCalculatedField();
    
    // Calculate and populate the calculated field
    processCalculatedField(calculatedField);
}

var removeNaN = 
function(value) {
	if(isNaN(value)){
		return "";
	} else {
		return value.toFixed(2);
	}
}

var processCalculatedField =
function(calculatedField)  {
	
	// Extract the estimated size, estimated production rate, and estimated effort 
	var estimatedSize = parseFloat($('#deliverable_estimated_size').val());
	var estimatedProductionRate = parseFloat($('#deliverable_estimated_production_rate').val());
	var estimatedEffort = parseFloat($('#deliverable_estimated_effort').val());
	
	if (calculatedField == 'deliverable_estimated_effort') {

	    // Compute the estimated effort 	    
	    // Populate the field with the calculated value
	    $('#deliverable_estimated_effort').val(removeNaN(estimatedSize * estimatedProductionRate))
										  .stop(true, true).effect("highlight", {}, 2000);
	}
	
	else if (calculatedField == 'deliverable_estimated_production_rate') {

	    // Compute the estimated production rate
	    // Populate the field with the calculated value
	    $('#deliverable_estimated_production_rate').val(removeNaN(estimatedEffort / estimatedSize))
												   .stop(true, true).effect("highlight", {}, 2000);
	}	
	
	else if (calculatedField == 'deliverable_estimated_size') {

	    // Compute the estimated size
	    // Populate the field with the calculated value
	    $('#deliverable_estimated_size').val(removeNaN(estimatedEffort / estimatedProductionRate))
										.stop(true, true).effect("highlight", {}, 2000);	
	}	

};

// If the page already has estimated size, production rate, or estimated effort populated
// when it is loaded, update the field handler accordingly
var checkForExistingValues =
function(fieldHandler) {
	var estimatedSize = $('#deliverable_estimated_size').val();
	var estimatedProductionRate = $('#deliverable_estimated_production_rate').val();
	var estimatedEffort = $('#deliverable_estimated_effort').val();
	
	if (estimatedEffort != '') {
    // Notify the field handler that the estimated effort has been updated
  	fieldHandler.modifyEstimatedEffort(estimatedEffort);
	}
	
	if (estimatedSize != '') {
    // Notify the field handler that the estimated size has been updated
    fieldHandler.modifyEstimatedSize(estimatedSize);
	}

	if (estimatedProductionRate != '') {
    // Notify the field handler that the estimated production rate has been updated
    fieldHandler.modifyEstimatedProductionRate(estimatedProductionRate);
	}
}

$(document).ready(function() {

	// Create a new field handler to manage the estimated size, estimated
	// production rate, and estimated effort input fields
    var fieldHandler = FieldHandler();

	// Estimated size, estimated production rate, and estimated effort  event handlers
	$('#deliverable_estimated_size').keyup(function() { processEstimatedSize(fieldHandler) });
	$('#deliverable_estimated_production_rate').keyup(function() { processEstimatedProductionRate(fieldHandler) });
	$('#deliverable_estimated_effort').keyup(function() { processEstimatedEffort(fieldHandler) });
	
	checkForExistingValues(fieldHandler);
});