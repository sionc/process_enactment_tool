var hideHistoricalData =
function() {
    $("#historical_data_table").slideUp();
    $("#view_historical_data_container").removeClass("disabled");
    $("#view_historical_data").text("Show historical data");
};

var showHistoricalData =
function() {
    $("#historical_data_table").slideDown();
    $("#view_historical_data_container").removeClass("disabled");
    $("#view_historical_data").text("Hide historical data");
};

var disableHistoricalData =
function() {
    $("#historical_data_table").slideUp();
    $("#view_historical_data_container").addClass("disabled");
    $("#view_historical_data").text("No historical data");
};

var enableHistoricalData =
function() {
    $("#view_historical_data_container").removeClass("disabled");
    if($("#historical_data_table").is(":visible")){
        $("#view_historical_data").text("Hide historical data");
    }
    else{
        $("#view_historical_data").text("Show historical data");
    }
};

var populateHistoricalData =
function(data) {
    var table_data = "<table class='condensed-table show_all'> \
                        <thead> \
                          <tr> \
                            <th></th> \
                            <th>Size</th> \
                            <th>Rate</th> \
                            <th>Effort</th> \
                          </tr> \
                        </thead> \
                        <tbody> \
                          <tr> \
                            <td>Minimum</td> \
                            <td>" + data.hist[0][0] + "</td> \
                            <td>" + data.hist[0][1] + "</td> \
                            <td>" + data.hist[0][2] + "</td> \
                          </tr> \
                          <tr> \
                            <td>Average</td> \
                            <td>" + data.hist[1][0] + "</td> \
                            <td>" + data.hist[1][1] + "</td> \
                            <td>" + data.hist[1][2] + "</td> \
                          </tr> \
                          <tr> \
                            <td>Maximum</td> \
                            <td>" + data.hist[2][0] + "</td> \
                            <td>" + data.hist[2][1] + "</td> \
                            <td>" + data.hist[2][2] + "</td> \
                          </tr> \
                        </tbody> \
                      </table> \
                      ";

    $("#historical_data_table").html(table_data);

};

var retrieveHistoricalData =
function() {
    var a_values = getAssignable();
    var a_type = a_values[0];
    var a_id = a_values[1];

    if (a_type == "stock") {
        var query_values = {
            "stock_deliverable_type_id": a_id,
            "complexity_id": $("#deliverable_complexity_id option:selected").val()
        };
        $.ajax({
            type: 'POST',
            url: '/deliverables/get_historical_data',
            data: query_values,
            dataType: 'json',
            success: historicalDataSuccess
        });
    }
};

var historicalDataSuccess =
function(data){
    // If historical data is available...
    if (data.hist.length === 0) {
       disableHistoricalData();
    } else {
       populateHistoricalData(data);
       enableHistoricalData();
    }
};

var assignableTypeChangeHandler =
function() {
    var a_values = getAssignable();
    var a_type = a_values[0];

    if (a_type == "stock") {
        retrieveHistoricalData();
    } else {
        disableHistoricalData();
    }
};

var complexityChangeHandler =
function() {
   retrieveHistoricalData();
};

// When you click the view historical data link,
// show or hide the table appropriately
var addViewHistoricalDataEventHandler = function() {
    $("#view_historical_data").click(function() {

        if (!$("#view_historical_data_container").hasClass("disabled")) {
            // If the historical data is shown
            if ($("#historical_data_table").is(":visible")) {
                hideHistoricalData();
            }
            // Otherwise, if the historical data is shown
            else {
                showHistoricalData();
            }
        }
    });
};

$(document).ready(
function() {

    retrieveHistoricalData();
    addViewHistoricalDataEventHandler();

    // Deliverable type event handler
    $('#deliverable_assignable_id').change(assignableTypeChangeHandler);

    // Complexity event handler
    $('#deliverable_complexity_id').change(complexityChangeHandler);

});