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
