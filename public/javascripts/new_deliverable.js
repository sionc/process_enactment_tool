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

var toggleHistoricalDataLink = 
function() {
	var a_values = getAssignable();
	if(a_values[0] == "stock") {
		$("view_historical_data").attr("disabled", "disabled");
	} else if(a_values[0] == "custom") {
		$("view_historical_data").removeAttr("disabled");
	} else {
		return;
	}
}

var getAssignable =
    function() {
        var deliverableTypeId = $('#deliverable_assignable_id option:selected').val();
        var assignable_substr = new Array();

        assignable_substr = deliverableTypeId.split('_');

        // assignable_type => assignable_substr[0]
        // assignable_id => assignable_substr[1]
        return assignable_substr;
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
        close: function(event) {
            var a_type;
            var a_value;
            var sel_value;

            a_type = $('#deliverable_type_id input').attr("id");
            a_value = $('#deliverable_type_id input').attr("value");

            var a_type_substr = new Array();
            a_type_substr = a_type.split('_');
            sel_value = a_type_substr[1] + "_" + a_value;

            $('#deliverable_assignable_id').val(sel_value);
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
                        .text(data.name)).trigger('change');
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

		// Deliverable type event handlers
    $('#deliverable_assignable_id').change(loadUnitOfMeasure);
    $('#deliverable_assignable_id').change(showHiddenInputField);
	$('#deliverable_assignable_id').change(toggleHistoricalDataLink);

    buildDeliverableDialog();

	$("#view_historical_data").toggle(function(){
		$("#historical_data_table").slideDown();
		$(this).text("Hide historical data");
	}, function(){
		$("#historical_data_table").slideUp();
		$(this).text("Show historical data");
	});
});