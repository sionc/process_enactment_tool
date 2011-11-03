var showHiddenInputField =
function() {
    var deliverableTypeId = $('#deliverable_assignable_id').val();
    var hiddenInputBox;
    var assignable_substr = new Array();

    assignable_substr = deliverableTypeId.split('_');
    var a_type = assignable_substr[0];
    var a_id =  assignable_substr[1];


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
	var query_values = {
	    "assignable_id": $("#deliverable_assignable_id option:selected").val(),
	    "assignable_type": $("#deliverable_assignable_id option:selected").text()
	};
	
	$.ajax({
    type: 'GET',
    url: '/deliverables/get_unit_of_measure',
    data: query_values,
    dataType: 'json',
    success: function(data) {
			alert(data.toString());
    }
});

};

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

$(document).ready(function() {
    addNewType();
    showHiddenInputField();
    loadUnitOfMeasure();

    $('#deliverable_assignable_id').change(loadUnitOfMeasure);
    $('#deliverable_assignable_id').change(showHiddenInputField);
    buildDeliverableDialog();
});