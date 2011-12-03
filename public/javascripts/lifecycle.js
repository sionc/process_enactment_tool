$(document).ready(function() {
    $(function() {
        $("#sortable").sortable({
            placeholder: "ui-state-highlight",
            update: function(event, ui){
                var new_sequence_numbers = $("#sortable").sortable("serialize");
                var lifecycle_id = $("#lifecycle_id").text().trim();
                var query_values = "lifecycle_id="+lifecycle_id+ "&" +
                                   new_sequence_numbers;
                $.ajax({
                        type: 'PUT',
                        url: '/lifecycle_phases/'+lifecycle_id,
                        data: query_values,
                        dataType: 'json',
                        success: function(data) {
//                            $('#deliverable_assignable_id').append($("<option></option>")
//                                .attr("value", "custom_" + data.id)
//                                .attr("selected", "selected")
//                                .text(data.name)).trigger('change');
//                            $(this).dialog('close');

                        }
                    });
            }


        });
        $("#sortable").disableSelection();
    });
});

