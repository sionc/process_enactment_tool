/**
 * Created by JetBrains RubyMine.
 * User: cool_curly
 * Date: 10/8/11
 * Time: 8:05 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function() {
    $.ajaxSetup({ cache: false });

    $('#project_phase_details_container').hide();


    $('#project_phases tbody tr').click(function() {
        var projectPhaseId = $(this).find(".project_phase_id_cell").text();
        $('#project_phases tbody tr').removeClass("active");
        $(this).addClass("active");


        $.ajax({
            type:    'GET',
            url:     '/project_phases/' + projectPhaseId,
            dataType: 'json',
            success: function (data) {

                $('#project_phase_name').text(data.lifecycle_phase_container.lifecycle_phase.name);
                $('#project_phase_description').text(data.lifecycle_phase_container.lifecycle_phase.description);
                $('#project_phase_sequence_number').text(data.lifecycle_phase_container.lifecycle_phase.sequence_number);
                $('#project_phase_estimated_effort').text(data.project_phase_estimated_effort);

                // Loop through and display deliverables.
                var deliverableNames = "";
                for (var i = 0; i < data.stock_deliverables_container.length; i++) {
                  deliverableNames += "<a href='/deliverables/"+data.stock_deliverables_container[i].deliverable.id+"'> "+data.stock_deliverables_container[i].deliverable.name + "</a><br/>";
                }
                $('#project_phase_deliverables').html(deliverableNames);

                $('#new_deliverable_button').attr("href", '/deliverables/new?project_phase_id=' + projectPhaseId);

                $('#project_phase_details_container').show();
            },
            error: function() {
                alert("Ajax failed (phase details)");
            }
        })


    });

    $('#project_phases tbody tr').mouseover(function() {
        $(this).css({
            'background-color': '#D2D9FF',
            'cursor': 'pointer'
        });
    });

    $('#project_phases tbody tr').mouseout(function() {
        $(this).css('background-color', '');
    });
});