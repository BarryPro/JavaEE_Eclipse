function selected(cal, date) {
  cal.sel.value = date; 
  if (cal.dateClicked && (cal.sel.id == "sel1" || cal.sel.id == "sel3"))
    cal.callCloseHandler();
}

function closeHandler(cal) {
  cal.hide();            
  calendar = null;
}

function showCalendar(id, format, showsTime, showsOtherMonths) {
  var el = document.getElementById(id);
  if (calendar != null) {
    calendar.hide();                 
  } else {
    var cal = new Calendar(true, null, selected, closeHandler);
    if (typeof showsTime == "string") {
      cal.showsTime = true;
      cal.time24 = (showsTime == "24");
    }
    if (showsOtherMonths) {
      cal.showsOtherMonths = true;
    }
    calendar = cal;                  
    cal.setRange(1900, 2070);        
    cal.create();
  }
  calendar.setDateFormat(format);    
  calendar.parseDate(el.value);     
  calendar.sel = el;                

  //calendar.showAtElement(el.nextSibling, "Br");
  calendar.showAtElement(el, "Br");

  return false;
}

var MINUTE = 60 * 1000;
var HOUR = 60 * MINUTE;
var DAY = 24 * HOUR;
var WEEK = 7 * DAY;

function isDisabled(date) {
  var today = new Date();
  return (Math.abs(date.getTime() - today.getTime()) / DAY) > 10;
}
