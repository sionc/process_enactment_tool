/**
 * Created by JetBrains RubyMine.
 * User: cool_curly
 * Date: 11/30/11
 * Time: 9:11 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function() {
	$("#lifecycle_phase_form").validate({
		onfocusout: false,
		onkeyup: false,
		rules: {
			"lifecycle_phase[name]": "required"
        }
    })
});