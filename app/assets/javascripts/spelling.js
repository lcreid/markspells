function httpGetURL(url)
{
  window.location.replace(url)
}

function pad2(x)
{
  return x < 10? "0" + x: "" + x;
}

function pad3(x)
{
  return x < 10? "00" + x: x < 100? "0" + x: "" + x;
}

function BrowserNowToRubyTime(elem)
{
  var d=new Date();
  elem.value = d.getUTCFullYear().toString().concat("-", 
    pad2(d.getUTCMonth()+1), "-", pad2(d.getUTCDate()), " ",
    pad2(d.getUTCHours()), ":", pad2(d.getUTCMinutes()), ":", pad2(d.getUTCSeconds()), ".", 
    pad3(d.getUTCMilliseconds())
  );
}

// PROTECT INPUT
// Warn user before navigating off pages with unsaved changes.
var _isDirty = false;
window.onbeforeunload = function () { 
	if(_isDirty == true) return "You have unsaved changes. If you leave or reload this page you'll lose the changes."; 
}

function protectInputs() {
	$(":input", "form.protected").change(function() {
		_isDirty = true;
	});
}

// jQuery execute when page is loaded
$(function() {
	$("input:submit, a.button").button();
	
	$('form#practice-form').submit(function() {
		BrowserNowToRubyTime(document.getElementById('end_time'));
	});

	protectInputs();
	$("form.protected").submit(function() {
		_isDirty = false;
	});
	
	//~ This doesn't work in Chrome at least.
	//~ $(window).unload(function () {
		//~ return "You have unsaved changes.";
	//~ });
});
