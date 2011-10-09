/**
 * Created by JetBrains RubyMine.
 * User: cool_curly
 * Date: 10/8/11
 * Time: 8:05 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function() {

    $("#project_phases").dataTable({
        "bPaginate": false,
        "bLengthChange": false,
        "bFilter": false,
        "bSort": false,
        "bInfo": false,
        "bAutoWidth": false
    });
});

$('#project_phases tbody tr').live('mouseover', function() {
    $(this).css({
        'background-color': '#D2D9FF',
        'cursor': 'pointer'
    });
});

$('#project_phases tbody tr').live('mouseout', function() {
    $(this).css('background-color', '');
});
