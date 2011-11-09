var showHiddenInputField =
function() {
    var hiddenInputBox;

    var a_values = getAssignable();
    var a_type = a_values[0];
    var a_id = a_values[1];

    if (a_type == "stock") {
        hiddenInputBox = '<input id="deliverable_stock_deliverable_type_id"' +
            ' name="deliverable[stock_deliverable_type_id]" type="hidden" value="' +
            a_id + '" />';
    }
    else if (a_type == "custom") {
        hiddenInputBox = '<input id="deliverable_custom_deliverable_type_id"' +
            ' name="deliverable[custom_deliverable_type_id]" type="hidden" value="' +
            a_id + '" />';
    }
    else {
        return;
    }

    $('#deliverable_type_id input').remove();
    $('#deliverable_type_id').append(hiddenInputBox);
};

var loadUnitOfMeasure =
    function() {

        var a_values = getAssignable();
        var a_type = "";
        var del_type = a_values[0];
        var a_id = a_values[1];

        if (del_type == "stock") {
            a_type = "StockDeliverableType";
        }
        else if (del_type == "custom"){
            a_type = "CustomDeliverableType";
        }
        else{
            a_type= "";
            return;
        }


        var query_values = {
            "assignable_id": a_id,
            "assignable_type": a_type
        };

        $.ajax({
            type: 'GET',
            url: '/deliverables/get_unit_of_measure',
            data: query_values,
            dataType: 'json',
            success: function(data) {
                $('#unit_of_measure_name').html(data.name);
            }
        });

    };

var getAssignable =
    function() {
        var deliverableTypeId = $('#deliverable_assignable_id option:selected').val();
        var assignable_substr = new Array();

        assignable_substr = deliverableTypeId.split('_');

        // assignable_type => assignable_substr[0]
        // assignable_id => assignable_substr[1]
        return assignable_substr
    }

var addNewType =
function() {
    $('#deliverable_assignable_id').append($("<option></option>")
    .attr("value", "new")
    .text('New...'));
};

var buildDeliverableDialog =
function() {
    $('#dialog').dialog({
        autoOpen: false,
		open: function(event){
			$('.ui-dialog-buttonpane').find('button:contains("Create")').addClass("btn");	
		},
        height: 280,
        width: 400,
        modal: true,
        resizable: false,
        buttons: {
            Create: function() {
                var query_values = {
                    "name": $("#name").val(),
                    "project_phase_id": $("#deliverable_project_phase_id").val(),
                    "unit_of_measure_id": $("#unit_of_measure_id").val()
                };
                $.ajax({
                    type: 'POST',
                    url: '/deliverables/create_custom_deliverable_type',
                    data: query_values,
                    dataType: 'json',
                    context: $(this),
                    success: function(data) {
                        $('#deliverable_assignable_id').append($("<option></option>")
                        .attr("value", "custom_" + data.id)
                        .attr("selected", "selected")
                        .text(data.name));
                        showHiddenInputField();
                        loadUnitOfMeasure();
                        $(this).dialog('close');

                    }
                });
            }
        }
    });
	
	
    $('#deliverable_assignable_id').change(function() {
        if ($(this).val() == 'new')
        $('#dialog').dialog('open');
    })
};

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

var processCalculatedField =
function(calculatedField)  {
	
	// Extract the estimated size, estimated production rate, and estimated effort 
	var estimatedSize = parseFloat($('#deliverable_estimated_size').val());
	var estimatedProductionRate = parseFloat($('#deliverable_estimated_production_rate').val());
	var estimatedEffort = parseFloat($('#deliverable_estimated_effort').val());
	
	if (calculatedField == 'deliverable_estimated_effort') {

	    // Compute the estimated effort 	    
	    // Populate the field with the calculated value
	    $('#deliverable_estimated_effort').val(estimatedSize * estimatedProductionRate);
	}
	
	else if (calculatedField == 'deliverable_estimated_production_rate') {

	    // Compute the estimated production rate
	    // Populate the field with the calculated value
	    $('#deliverable_estimated_production_rate').val(estimatedEffort / estimatedSize);	
	}	
	
	else if (calculatedField == 'deliverable_estimated_size') {

	    // Compute the estimated size
	    // Populate the field with the calculated value
	    $('#deliverable_estimated_size').val(estimatedEffort / estimatedProductionRate);	
	}	

};

$(document).ready(function() {

		// Create a new field handler to manage the estimated size, estimated
		// production rate, and estimated effort input fields
    var fieldHandler = FieldHandler();

    addNewType();
    showHiddenInputField();
    loadUnitOfMeasure();

		// Deliverable type event handlers
    $('#deliverable_assignable_id').change(loadUnitOfMeasure);
    $('#deliverable_assignable_id').change(showHiddenInputField);
		
	// Estimated size, estimated production rate, and estimated effort  event handlers
	$('#deliverable_estimated_size').keyup(function() {processEstimatedSize(fieldHandler) });
	$('#deliverable_estimated_production_rate').keyup(function() {processEstimatedProductionRate(fieldHandler) });
	$('#deliverable_estimated_effort').keyup(function() {processEstimatedEffort(fieldHandler) });

		
    buildDeliverableDialog();
});