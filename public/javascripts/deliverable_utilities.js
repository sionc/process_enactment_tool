var getAssignable =
function() {

    if ($('#deliverable_assignable_id option:selected').length) {
        var assignable_substr = new Array();
        var deliverableTypeId = $('#deliverable_assignable_id option:selected').val();
        assignable_substr = deliverableTypeId.split('_');
        return assignable_substr;
    }
    else {
        return ''
    }
};