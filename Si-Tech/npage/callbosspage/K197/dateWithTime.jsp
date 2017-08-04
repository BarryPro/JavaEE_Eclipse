<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<meta http-equiv="Cache-Control" content="no-store"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Expires" content="0" />
<script language="javascript" type="text/javascript">
var selectDay = "";/*设定选择日期.*/
var months = new Array("一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一",
		"十二");
var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var days = new Array("日", "一", "二", "三", "四", "五", "六");
var classTemp;
var today = new getToday();
var year = today.year;
var month = today.month;
var newCal;
function getDays(month, year) {
	if (1 == month)
		return ((0 == year % 4) && (0 != (year % 100))) || (0 == year % 400) ? 29
				: 28;
	else
		return daysInMonth[month];
}
function getToday() {/*在这里判断是否是输入框的时间.如果是将时间放到日历里面.*/
	//alert(window.dialogArguments);
	if(window.dialogArguments == "" || window.dialogArguments == "null" || window.dialogArguments == "undifine" )
	{
		this.now = new Date();
		
	}else{
		try{
			var dateArrays = window.dialogArguments.split(' ')[0].split('-');
			this.now = new Date(dateArrays[0],new Number(dateArrays[1]) - 1,dateArrays[2]);
		}catch(err){
			this.now = new Date();
		}
	}
	this.year = this.now.getFullYear();
	this.month = this.now.getMonth();
	this.day = this.now.getDate();
	selectDay = this.day;/*设定选择日期.*/
}
function Calendar() {
	newCal = new Date(year, month, 1);
	today = new getToday();
	var day = -1;
	var startDay = newCal.getDay();
	var endDay = getDays(newCal.getMonth(), newCal.getFullYear());
	var daily = 0;
	if ((today.year == newCal.getFullYear())
			&& (today.month == newCal.getMonth())) {
		day = today.day;
	}
	var caltable = document.all.caltable.tBodies.calendar;
	var intDaysInMonth = getDays(newCal.getMonth(), newCal.getFullYear());
	for ( var intWeek = 0; intWeek < caltable.rows.length; intWeek++)
		for ( var intDay = 0; intDay < caltable.rows[intWeek].cells.length; intDay++) {
			var cell = caltable.rows[intWeek].cells[intDay];
			var montemp = (newCal.getMonth() + 1) < 10 ? ("0" + (newCal
					.getMonth() + 1)) : (newCal.getMonth() + 1);
			if ((intDay == startDay) && (0 == daily)) {
				daily = 1;
			}
			var daytemp = daily < 10 ? ("0" + daily) : (daily);
			var d = "<" + newCal.getFullYear() + "-" + montemp + "-" + daytemp
					+ ">";
			if (day == daily)
				cell.className = "DayNow";
			else if (intDay == 6)
				cell.className = "DaySat";
			else if (intDay == 0)
				cell.className = "DaySun";
			else
				cell.className = "Day";
			if ((daily > 0) && (daily <= intDaysInMonth)) {
				cell.innerText = daily;
				daily++;
			} else {
				cell.className = "CalendarTD";
				cell.innerText = "";
			}
		}
	document.all.year.value = year;
	document.all.month.value = month + 1;
}
function subMonth() {
	if ((month - 1) < 0) {
		month = 11;
		year = year - 1;
	} else {
		month = month - 1;
	}
	Calendar();
}
function addMonth() {
	if ((month + 1) > 11) {
		month = 0;
		year = year + 1;
	} else {
		month = month + 1;
	}
	Calendar();
}
function setDate() {
	if (document.all.month.value < 1 || document.all.month.value > 12) {
		alert("月的有效范围在1-12之间!");
		return;
	}
	year = Math.ceil(document.all.year.value);
	month = Math.ceil(document.all.month.value - 1);
	Calendar();
}
function buttonOver() {
	var obj = window.event.srcElement;
	obj.runtimeStyle.cssText = "background-color:#FFFFFF";
	// obj.className="Hover";
}
function buttonOut() {
	var obj = window.event.srcElement;
	window.setTimeout(function() {
		obj.runtimeStyle.cssText = "";
	}, 300);
}	
</script>
<style>
Input {font-family: verdana;font-size: 9pt;text-decoration: none;background-color: #FFFFFF;height: 20px;border: 1px solid #666666;color:#000000;}
.Calendar {font-family: verdana;text-decoration: none;width: 170;background-color: #C0D0E8;font-size: 9pt;border:0px dotted #1C6FA5;}
body {
	margin: 0px;
	padding: 0px;
}
.CalendarTD {font-family: verdana;font-size: 7pt;color: #000000;background-color:#f6f6f6;height: 20px;width:11%;text-align: center;}
.Title {font-family: verdana;font-size: 11pt;font-weight: normal;height: 24px;text-align: center;color: #333333;text-decoration: none;background-color: #A4B9D7;border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-bottom-style:1px;border-top-color: #999999;border-right-color: #999999;border-bottom-color: #999999;border-left-color: #999999;}
.Day {font-family: verdana;font-size: 7pt;color:#243F65;background-color: #E5E9F2;height: 20px;width:11%;text-align: center;}
.DaySat {font-family: verdana;font-size: 7pt;color:#FF0000;text-decoration: none;background-color:#E5E9F2;text-align: center;height: 18px;width: 12%;}
.DaySun {font-family: verdana;font-size: 7pt;color: #FF0000;text-decoration: none;background-color:#E5E9F2;text-align: center;height: 18px;width: 12%;}
.DayNow {font-family: verdana;font-size: 7pt;font-weight: bold;color: #000000;background-color: #FFFFFF;height: 20px;text-align: center;}
.DayTitle {font-family: verdana;font-size: 9pt;color: #000000;background-color: #C0D0E8;height: 20px;width:11%;text-align: center;}
.DaySatTitle {font-family: verdana;font-size: 9pt;color:#FF0000;text-decoration: none;background-color:#C0D0E8;text-align: center;height: 20px;width: 12%;}
.DaySunTitle {font-family: verdana;font-size: 9pt;color: #FF0000;text-decoration: none;background-color: #C0D0E8;text-align: center;height: 20px;width: 12%;}
.DayButton {font-family: Webdings;font-size: 9pt;font-weight: bold;color: #243F65;cursor:hand;text-decoration: none;}
</Style>
</head>
<body>
<div id="div1"></div>
<table border="0" cellpadding="0" cellspacing="0" class="Calendar" id="caltable" align="center">
<thead>
     <tr align="center" valign="middle"> 
  <td colspan="7" class="Title">
   <a href="#" onClick="javaScript:subMonth();" title="上一月" Class="DayButton">3</a> 
   <input name="year" type="text" size="4" maxlength="4" onkeydown="if (event.keyCode==13){setDate()}" 
   onkeyup="this.value=this.value.replace(/[^0-9]/g,'')"  
   onpaste="this.value=this.value.replace(/[^0-9]/g,'')"/> 年 
   <input name="month" type="text" size="1" maxlength="2" onkeydown="if (event.keyCode==13){setDate()}" 
   onkeyup="this.value=this.value.replace(/[^0-9]/g,'')"  onpaste="this.value=this.value.replace(/[^0-9]/g,'')"/> 
   月 <a href="#" onClick="JavaScript:addMonth();" title="下一月" Class="DayButton">4</a>
  </td>
 </tr>
 <tr align="center" valign="middle"> 
  <Script language="javascript" type="text/javascript">  
   document.write("<TD class=DaySunTitle id=diary >" + days[0] + "</TD>"); 
   for (var intLoop = 1; intLoop <= days.length-1 ;intLoop++)
    document.write("<TD class=DaySatTitle id=diary>" + days[intLoop] + "</TD>"); 
  </Script>
 </tr>
</thead>
<tbody border=1 cellspacing="0" cellpadding="0" ID="calendar" ALIGN=CENTER>
<script language="javascript" type="text/javascript">
for ( var intWeeks = 0; intWeeks < 6; intWeeks++) {
	document.write("<TR style='cursor:hand'>");
	for ( var intDays = 0; intDays < days.length; intDays++)
		document
				.write("<TD class=CalendarTD onMouseover='buttonOver();' onMouseOut='buttonOut();' onclick='setdateinfo(this)'></TD>");
	document.write("</TR>");
}
Calendar();
function fillZero(s) {
	var a = parseInt(s);
	if (isNaN(a))
		return s;
	if (a < 10)
		return "0" + a;
	return s;
}

function setdateinfo(day) {
	selectDay = day.innerText;
	var caltable = document.all.caltable.tBodies.calendar;
	/*alert(caltable.rows.length);*/
	for ( var intWeek = 0; intWeek < caltable.rows.length; intWeek++){
		for ( var intDay = 2; intDay < caltable.rows[intWeek].cells.length; intDay++) {
			/*intDay是指的前两行的月和日:这两个的样式不用改变.*/
			var cell = caltable.rows[intWeek].cells[intDay];
			cell.className = "Day";
		}
	}
	day.className = "DayNow";
}
</script>
</tbody>
</table>

<!-- 下面是添加时间内容的代码####BEGIN############################ -->
<style>
.DynarchCalendar-time td { font-weight: bold; font-size: 120%; }
.DynarchCalendar-time-hour, .DynarchCalendar-time-minute ,.DynarchCalendar-time-second { padding: 1px 3px; }
.DynarchCalendar-time-down { background: url("date_time_img/time-down.png") no-repeat 50% 50%; width: 11px; height: 6px; opacity: 0.5; }
.DynarchCalendar-time-up { background: url("date_time_img/time-up.png") no-repeat 50% 50%; width: 11px; height: 6px; opacity: 0.5; }
.dateWithTime_button_css {border:0px;
	background-image: url("date_time_img/button_s.gif");height:21px;width: 60px;text-align: center;cursor: hand;color: black;font: bold;
}
</style>

<table border="0" cellSpacing=0 width="100%" style="" bgcolor="#F6F6F6"
	cellPadding=0  >
	<tr>
		<td align="center">
		<table border="0" cellSpacing=0  style="font-weight: bold; font-size: 90%;color: #333333;"
	cellPadding=0 align="center">
		<tr><td rowSpan=2>
		时间:
		<input type="text" style="width: 20px;height: 20px;border: 1;" onchange="FOnKeyDown();"
		onkeyup="value=value.replace(/[^\d]/g,'')" id="did_time_hour">
		</td>
		<td class=DynarchCalendar-time-up onclick="FTimeHour('+');" style="cursor: pointer;"></td>

		<td rowSpan=2>
		<input type="text" style="width: 20px;height: 20px;border: 1;" onchange="FOnKeyDown();"
		onkeyup="value=value.replace(/[^\d]/g,'')" 
		id="did_time_minute">
		</TD>
		<TD class=DynarchCalendar-time-up onclick="FTimeMinute('+');" style="cursor: pointer;"></TD>
		
		<TD rowSpan=2>
		<input type="text" style="width: 20px;height: 20px;border: 1;" onchange="FOnKeyDown();" 
		onkeyup="value=value.replace(/[^\d]/g,'')" 
		id="did_time_second">
		</TD>
		<TD class=DynarchCalendar-time-up onclick="FTimeSecond('+');" style="cursor: pointer;"></td>
	</tr>
	<tr>
		<td class=DynarchCalendar-time-down onclick="FTimeHour('-');" style="cursor: pointer;"></td>
		<td class=DynarchCalendar-time-down onclick="FTimeMinute('-');" style="cursor: pointer;"></td>
		<td class=DynarchCalendar-time-down onclick="FTimeSecond('-');" style="cursor: pointer;"></td>
	</tr>
</table>
		</td>
		</tr>
		<tr>
		<td colspan="9" align="center">
		<input class="dateWithTime_button_css" type="button" value="确定" onclick="time_button_ok();" id="callOut"/>
		<input class="dateWithTime_button_css" type="button" value="关闭" onclick="window.close();" id="callOut"/>
		</td>
	</tr>
</table>
<script type="text/javascript">
var DUserLocalDate =new Date();	   
var Dtime_hour = document.getElementById("did_time_hour");
var Dtime_minute = document.getElementById("did_time_minute");
var Dtime_second = document.getElementById("did_time_second");
if(window.dialogArguments == "" || window.dialogArguments == "null" || window.dialogArguments == "undifine" )
{/*进行时间判断如果时间已经在输入框里面有了.就不新定义一个时间.*/
	Dtime_hour.value = DUserLocalDate.getHours();/*定义小时变量的初始值*/
	Dtime_minute.value = DUserLocalDate.getMinutes();/*定义分钟变量的初始值*/
	Dtime_second.value = DUserLocalDate.getSeconds();/*定义秒钟变量的初始值*/
}else{
	try{
		var dateArrays = window.dialogArguments.split(' ')[1].split(':');
		Dtime_hour.value = dateArrays[0];/*定义小时变量的初始值*/
		Dtime_minute.value = dateArrays[1];/*定义分钟变量的初始值*/
		Dtime_second.value = dateArrays[2];/*定义秒钟变量的初始值*/
	}catch(err){
		Dtime_hour.value = DUserLocalDate.getHours();/*定义小时变量的初始值*/
		Dtime_minute.value = DUserLocalDate.getMinutes();/*定义分钟变量的初始值*/
		Dtime_second.value = DUserLocalDate.getSeconds();/*定义秒钟变量的初始值*/
	}
}

FOnKeyDown();/*进行元素检测.*/
function FTimeHour(flag){/*对小时进行处理.增加减少..*/
	if(flag == '+'){
		Dtime_hour.value = (new Number(Dtime_hour.value) + 1) % 24;
		if( (Dtime_hour.value+"").length == 1)
			Dtime_hour.value = "0" + Dtime_hour.value;
	}else if(flag == '-'){
		Dtime_hour.value = (new Number(Dtime_hour.value) - 1 + 24) % 24;
		if( (Dtime_hour.value+"").length == 1)
			Dtime_hour.value = "0" + Dtime_hour.value;
	}
}
function FTimeMinute(flag){/*对分钟进行处理.增加减少..*/
	if(flag == '+'){
		Dtime_minute.value = (new Number(Dtime_minute.value) + 1) % 60;
		if( (Dtime_minute.value+"").length == 1)
			Dtime_minute.value = "0" + Dtime_minute.value;
	}else if(flag == '-'){
		Dtime_minute.value = (new Number(Dtime_minute.value) - 1 + 60) % 60;
		if( (Dtime_minute.value+"").length == 1)
			Dtime_minute.value = "0" + Dtime_minute.value;
	}
}
function FTimeSecond(flag){/*对秒进行处理.增加减少..*/
	if(flag == '+'){
		Dtime_second.value = (new Number(Dtime_second.value) + 1) % 60;
		if( (Dtime_second.value+"").length == 1)
			Dtime_second.value = "0" + Dtime_second.value;
	}else if(flag == '-'){
		Dtime_second.value = (new Number(Dtime_second.value) - 1 + 60) % 60;
		if( (Dtime_second.value+"").length == 1)
			Dtime_second.value = "0" + Dtime_second.value;
	}
}
function FOnKeyDown(){/*当按钮按下的时候做出的相应.将0不齐.同时判断数字是否超出最大限制.*/
	Dtime_hour.value = new Number(Dtime_hour.value) % 24;
	Dtime_minute.value = new Number(Dtime_minute.value) % 60;
	Dtime_second.value = new Number(Dtime_second.value) % 60;
	if( (Dtime_hour.value+"").length == 1)
		Dtime_hour.value = "0" + Dtime_hour.value;
	if( (Dtime_minute.value+"").length == 1)
		Dtime_minute.value = "0" + Dtime_minute.value;
	if( (Dtime_second.value+"").length == 1)
		Dtime_second.value = "0" + Dtime_second.value;
	
}
/*取得日期时间.将参数返回.*/
function time_button_ok() {
	FOnKeyDown();
	var str1 = document.all.year.value + "-"
			+ fillZero(document.all.month.value) + "-" + fillZero(selectDay)
	window.returnValue = str1 + " "+Dtime_hour.value+":"+Dtime_minute.value+":"+Dtime_second.value;
	window.close();
}
</script>

<!-- 下面是添加时间内容的代码####END############################ -->


</body>
</html>