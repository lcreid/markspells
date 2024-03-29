function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
	// Decades of ranting about global variables and here I am slinging them around...
	// I guess I always said certain use cases were permissible and this might be one.
	_isDirty = true;
}

function add_fields(link, association, content, new_id) {
  new_id = typeof new_id !== 'undefined' ? new_id : new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
  // Below added by LCR 2012-04-28
  // Set focus on the first field of the added row.
//  $("div.fields:last input:first").focus();
  $(link).parent().prev().find(":input:first").focus();
	protectInputs();
}

// Find where to put the new fields by finding the last ".fields" on the page
function add_fields_by_container(link, association, content, new_id) {
  new_id = typeof new_id !== 'undefined' ? new_id : new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(".fields-container:last").append(content.replace(regexp, new_id));
  $(".fields:last").find(":input:first").focus();
	protectInputs();
}
