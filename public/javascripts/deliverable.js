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
                    $(this).dialog('close')
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
    $('#deliverable_assignable_id').change(showHiddenInputField);
    buildDeliverableDialog();
});