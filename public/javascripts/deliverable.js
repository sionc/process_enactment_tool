var showHiddenInputField =
    function() {
       var deliverableTypeId =  $('#deliverable_assignable_id').val();
       var hiddenInputBox = '<input id="deliverable_stock_deliverable_type_id"' +
        ' name="deliverable[stock_deliverable_type_id]" type="hidden" value="' +
        deliverableTypeId +'" />';

       $('#deliverable_type_id').append(hiddenInputBox);
   };

$(document).ready(function() {
   showHiddenInputField();
   $('#deliverable_assignable_id').change(showHiddenInputField);
});