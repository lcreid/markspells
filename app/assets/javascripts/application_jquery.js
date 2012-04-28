function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content, new_id) {
  new_id = typeof new_id !== 'undefined' ? new_id : new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
  // Below added by LCR 2012-04-28
  // Set focus on the first field of the added row.
//  $("div.fields:last input:first").focus();
  $(link).parent().prev().find(":input:first").focus();
}
