var showHiddenInputField =
    function() {
        var deliverableTypeId = $('#deliverable_assignable_id').val();
        var hiddenInputBox = '<input id="deliverable_stock_deliverable_type_id"' +
            ' name="deliverable[stock_deliverable_type_id]" type="hidden" value="' +
            deliverableTypeId + '" />';

        $('#deliverable_type_id').append(hiddenInputBox);
    };

var addNewType =
    function() {
        $('#deliverable_assignable_id').append($("<option></option>")
                                       .attr("value", "new")
                                       .text('New...'));
    };

var showCreateDeliverableDialog =
  function() {
    $('#dialog').dialog({
        buttons: {
            Create: function() {
                $(this).dialog('close')
            }
        }
    });
};

$(document).ready(function() {
    addNewType();
    showHiddenInputField();
    $('#deliverable_assignable_id').change(showHiddenInputField);
});