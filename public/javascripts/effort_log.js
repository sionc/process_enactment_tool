$(document).ready(function() {
    $('#start_datetime').datetime({ chainTo: '#stop_datetime', value: '-1hour', chainOptions: { value: '+1min' } });
    $('#stop_datetime').datetime({ value: '+0min' });
    $('#new_effort_log').validate({
      rules: {
          "effort_log[start_date_time]": {
            required: true,
            before_stop_time: true,
            before_midnight: true,
            does_not_overlap: true
            // date: true
          },
          "effort_log[stop_date_time]": {
            required: true,
            after_start_time: true,
            before_midnight: true,
            does_not_overlap: true
            // date: true
          },

          "effort_log[interrupt_time]": {
            less_than_logged_time: true
          }
        }
    });
    // custom validation for start date, 
    // making sure start date is not after stop date
    jQuery.validator.addMethod("before_stop_time", function(value, element, params) { 
      
      var start_time = Date.parse(value);
      var stop_time  = Date.parse($('#stop_datetime').val());
        
      return (start_time.isBefore(stop_time));
    }, jQuery.format("Must be before stop time"));


    // custom validation for stop date, 
    // making sure stop date is not before start date
    jQuery.validator.addMethod("after_start_time", function(value, element, params) { 
      
      var start_time = Date.parse($('#start_datetime').val());
      var stop_time  = Date.parse(value);
        
      return (start_time.isBefore(stop_time));
    }, jQuery.format("Must be after start time"));


    // custom validation for start and stop dates, 
    // making sure they are before midnight
    jQuery.validator.addMethod("before_midnight", function(value, element, params) {       
      return (Date.parse(value) < Date.today().set({hour:23, minute:59, second:59}));
    }, jQuery.format("Time must be before midnight "));


    // custom validation for start and stop dates, 
    // making sure they don't overlap prior date ranges
    jQuery.validator.addMethod("does_not_overlap", function(value, element, params) { 
      var doesNotOverlap = true;
    
      var queryValues = {
         "start_date_time": $("#start_datetime").val(),
         "stop_date_time": $("#stop_datetime").val(),
         "deliverable_id": $("#effort_log_deliverable_id").val()
      };

      $.ajax({ url: "/effort_logs/does_not_overlap", 
          data: queryValues, 
          async: false, 
          success: function(data) { 
            doesNotOverlap = data.doesNotOverlap
          }
      });    
            
      return doesNotOverlap;
    }, jQuery.format("Effort Log overlaps prior entries"));


    // custom validation for interrupt time,
    // making sure interrupt time is less than logged time
    jQuery.validator.addMethod("less_than_logged_time", function(value, element, params) {

      var start_time = Date.parse($('#start_datetime').val());
      var stop_time  = Date.parse($('#stop_datetime').val());
      return (value < (stop_time - start_time)/60000);
    }, jQuery.format("Must be less than logged time"));

});
