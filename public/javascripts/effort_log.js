$(document).ready(function() {
    $('#start_datetime').datetime({ chainTo: '#stop_datetime', value: '-7 days', chainOptions: { value: '+7 days' } });
    $('#stop_datetime').datetime({ value: '+1min' });
});
