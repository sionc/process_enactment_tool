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
        $.ajax({
            type:    'GET',
            url:     '/projects/1',
            dataType: 'json',
            success: function (data) {
                $('#project_phase_description').text(data.project.name);
                $('#project_phase_details_container').show();
            },
            error: function() {
                alert("Ajax failed");
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