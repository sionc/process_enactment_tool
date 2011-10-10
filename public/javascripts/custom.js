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

        $.ajax({
            type:    'GET',
            url:     '/project_phases/' + projectPhaseId,
            dataType: 'json',
            success: function (data) {
                $('#project_phase_name').text(data.lifecycle_phase.name);
                $('#project_phase_description').text(data.lifecycle_phase.description);
                $('#project_phase_sequence_number').text(data.lifecycle_phase.sequence_number);
                $('#project_phase_estimated_effort').text(data.lifecycle_phase.estimated_effort);

                $('#new_deliverable_button').attr("href", '/deliverables/new?project_phase_id=' + projectPhaseId);

                $('#project_phase_details_container').show();
            },
            error: function() {
                alert("Ajax failed (phase details)");
            }
        })

        $.ajax({
            type:    'GET',
            url:     '/phase_deliverables',
            dataType: 'json',
            success: function (data) {
                var deliverableNames = "";
                for (var i = 0; i < data.length; i++) {
                  deliverableNames += data[i].deliverable.name + "<br/>";
                }

                $('#project_phase_deliverables').html(deliverableNames);
                $('#project_phase_details_container').show();
            },
            error: function() {
                alert("Ajax failed (deliverables)");
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