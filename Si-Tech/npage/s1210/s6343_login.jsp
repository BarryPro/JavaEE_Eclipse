<%
  /* *********************
   * ����:�����������ʱ���޸�
   * �汾: 1.0
   * ����: 2010/01/25
   * ����: cangjin
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<title>�����������ʱ���޸�</title>

<%
	String opCode = "6343";
	String opName = "�����������ʱ���޸�";
	activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
%>

<script language=javascript>

function fPopUpCalendarDlg()
{
	if(false)
	{
		showx = 220 ; // + deltaX;
		showy = 220; // + deltaY;
	}
	else
	{
		showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
		showy = event.screenY - event.offsetY + 18; // + deltaY;
	}
	newWINwidth = 210 + 4 + 18;
	if(false)
	{
		window.top.captureEvents (Event.CLICK|Event.FOCUS);
		window.top.onclick=IgnoreEvents;
		window.top.onfocus=HandleFocus;
		winPopupWindow.args = beginTime;
		winPopupWindow.returnedValue = new Array();
		winPopupWindow.args = beginTime;
		newWINwidth = 202;
		winPopupWindow.win = window.open("/js/common/date/CalendarDlg.htm","CalendarDialog","dependent=yes,left="+showx + ",top=" + showy + ",width="+newWINwidth + ",height=182px" )
		winPopupWindow.win.focus()
		return winPopupWindow;
	}
	else
	{
		retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	}
	if(retval != null && retval != "")
	{
		retval = retval.replace(/\//g,"");
		var myDate = new Date();
		var year = myDate.getFullYear();
		var mon = myDate.getMonth();
		mon = mon + 1 + "";
		if(mon < 10){
			mon = "0" + mon;
		}
		var day = myDate.getDate();
		if(day < 10){
			day = "0" + day;
		}
		var today = year + mon + day;
		//alert("today : " + today + "|" + retval + "|")
		if(today > retval){
			rdShowMessageDialog("����ѡ�����֮ǰ������");
			return false;
		}else{
			document.frm.beginTime.value = retval;
		}
	}
	else if(retval == "")
	{
		document.frm.beginTime.value = "";
	}else{
	}
}

/***  ***/

<!-- 20091218 fengry begin for �����ؼ� -->

function atCalendarControl(){
  var calendar=this;
  this.calendarPad=null;
  this.prevMonth=null;
  this.nextMonth=null;
  this.prevYear=null;
  this.nextYear=null;
  this.goToday=null;
  this.calendarClose=null;
  this.calendarAbout=null;
  this.head=null;
  this.body=null;
  this.today=[];
  this.currentDate=[];
  this.sltDate;
  this.target;
  this.source;
  /************** ���������װ弰��Ӱ *********************/
  this.addCalendarPad=function(){
   document.write("<div id='divCalendarpad' style='position:absolute;top:100px;left:0;width:255px;height:167px;display:none;'>");
   document.write("<iframe frameborder=0 height=168px width=255px></iframe>");
   document.write("<div style='position:absolute;top:4px;left:4px;width:248px;height:164px;background-color:#336699;'></div>");
   document.write("</div>");
   calendar.calendarPad=document.all.divCalendarpad;
  }
  /************** ����������� *********************/
  this.addCalendarBoard=function(){
   var BOARD=this;
   var divBoard=document.createElement("div");
   calendar.calendarPad.insertAdjacentElement("beforeEnd",divBoard);
   divBoard.style.cssText="position:absolute;top:0;left:0;width:250px;height:166px;border:1px outset;background-color:buttonface;";
   var tbBoard=document.createElement("table");
   divBoard.insertAdjacentElement("beforeEnd",tbBoard);
   tbBoard.style.cssText="position:absolute;top:0;left:0;width:100%;height:10px;font-size:12px;";
   tbBoard.cellPadding=0;
   tbBoard.cellSpacing=1;
   tbBoard.bgColor="#333333";
   /************** ���ø����ܰ�ť�Ĺ��� *********************/
   /*********** Calendar About Button ***************/
   trRow = tbBoard.insertRow(0);
   calendar.calendarAbout=calendar.insertTbCell(trRow,0,"-","center");
   calendar.calendarAbout.onclick=function(){calendar.about();}
   /*********** Calendar Head ***************/
   tbCell=trRow.insertCell(1);
   tbCell.colSpan=5;
   tbCell.bgColor="#99CCFF";
   tbCell.align="center";
   tbCell.style.cssText = "cursor:default";
   calendar.head=tbCell;
   /*********** Calendar Close Button ***************/
   tbCell=trRow.insertCell(2);
   calendar.calendarClose = calendar.insertTbCell(trRow,2,"x","center");
   calendar.calendarClose.title="�ر�";
   calendar.calendarClose.onclick=function(){calendar.hide();}
   /*********** Calendar PrevYear Button ***************/
   trRow = tbBoard.insertRow(1);
   calendar.prevYear = calendar.insertTbCell(trRow,0,"&lt;&lt;","center");
   calendar.prevYear.title="��һ��";
   calendar.prevYear.onmousedown=function(){
    calendar.currentDate[0]--;
    calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
   }
   /*********** Calendar PrevMonth Button ***************/
   calendar.prevMonth = calendar.insertTbCell(trRow,1,"&lt;","center");
   calendar.prevMonth.title="��һ��";
   calendar.prevMonth.onmousedown=function(){
    calendar.currentDate[1]--;
    if(calendar.currentDate[1]==0){
     calendar.currentDate[1]=12;
     calendar.currentDate[0]--;
    }
    calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
   }
   /*********** Calendar Today Button ***************/
   calendar.goToday = calendar.insertTbCell(trRow,2,"����","center",3);
   calendar.goToday.title="ѡ�����";
   calendar.goToday.onclick=function(){
    calendar.sltDate=calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2];
    calendar.target.value=calendar.sltDate;
    calendar.hide();
    //calendar.show(calendar.target,calendar.today[0]+"-"+calendar.today[1]+"-"+calendar.today[2],calendar.source);
   }
   /*********** Calendar NextMonth Button ***************/
   calendar.nextMonth = calendar.insertTbCell(trRow,3,"&gt;","center");
   calendar.nextMonth.title="��һ��";
   calendar.nextMonth.onmousedown=function(){
    calendar.currentDate[1]++;
    if(calendar.currentDate[1]==13){
     calendar.currentDate[1]=1;
     calendar.currentDate[0]++;
    }
    calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
   }
   /*********** Calendar NextYear Button ***************/
   calendar.nextYear = calendar.insertTbCell(trRow,4,"&gt;&gt;","center");
   calendar.nextYear.title="��һ��";
   calendar.nextYear.onmousedown=function(){
    calendar.currentDate[0]++;
    calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
   }
   trRow = tbBoard.insertRow(2);
   var cnDateName = new Array("����","��һ","�ܶ�","����","����","����","����");
   for (var i = 0; i < 7; i++) {
    tbCell=trRow.insertCell(i)
    tbCell.innerText=cnDateName[i];
    tbCell.align="center";
    tbCell.width=35;
    tbCell.style.cssText="cursor:default;border:1px solid #99CCCC;background-color:#99CCCC;";
   }
   /*********** Calendar Body ***************/
   trRow = tbBoard.insertRow(3);
   tbCell=trRow.insertCell(0);
   tbCell.colSpan=7;
   tbCell.height=97;
   tbCell.vAlign="top";
   tbCell.bgColor="#F0F0F0";
   var tbBody=document.createElement("table");
   tbCell.insertAdjacentElement("beforeEnd",tbBody);
   tbBody.style.cssText="position:relative;top:0;left:0;width:245px;height:103px;font-size:12px;"
   tbBody.cellPadding=0;
   tbBody.cellSpacing=1;
   calendar.body=tbBody;
  }
  /************** ���빦�ܰ�ť������ʽ *********************/
  this.insertTbCell=function(trRow,cellIndex,TXT,trAlign,tbColSpan){
   var tbCell=trRow.insertCell(cellIndex);
   if(tbColSpan!=undefined) tbCell.colSpan=tbColSpan;
   var btnCell=document.createElement("button");
   tbCell.insertAdjacentElement("beforeEnd",btnCell);
   btnCell.value=TXT;
   btnCell.style.cssText="width:100%;border:1px outset;background-color:buttonface;";
   btnCell.onmouseover=function(){
    btnCell.style.cssText="width:100%;border:1px outset;background-color:#F0F0F0;";
   }
   btnCell.onmouseout=function(){
    btnCell.style.cssText="width:100%;border:1px outset;background-color:buttonface;";
   }
  // btnCell.onmousedown=function(){
  //  btnCell.style.cssText="width:100%;border:1 inset;background-color:#F0F0F0;";
  // }
   btnCell.onmouseup=function(){
    btnCell.style.cssText="width:100%;border:1px outset;background-color:#F0F0F0;";
   }
   btnCell.onclick=function(){
    btnCell.blur();
   }
   return btnCell;
  }
  this.setDefaultDate=function(){
   var dftDate=new Date();
   calendar.today[0]=dftDate.getYear();
   calendar.today[1]=dftDate.getMonth()+1;
   calendar.today[2]=dftDate.getDate();
  }
  /****************** Show Calendar *********************/
  this.show=function(targetObject,defaultDate,sourceObject){
   if(targetObject==undefined) {
    alert("δ����Ŀ�����. \n����: ATCALENDAR.show(obj Ŀ�����,string Ĭ������,obj �������);\n\nĿ�����:�������ڷ���ֵ�Ķ���.\nĬ������:��ʽΪ\"yyyy-mm-dd\",ȱʡΪ��������.\n�������:���������񵯳�calendar,Ĭ��ΪĿ�����.\n");
    return false;
   }
   else    calendar.target=targetObject;
   if(sourceObject==undefined) calendar.source=calendar.target;
   else calendar.source=sourceObject;
   var firstDay;
   var Cells=new Array();
   if(defaultDate==undefined || defaultDate==""){
    var theDate=new Array();
    calendar.head.innerText = calendar.today[0]+"-"+calendar.today[1]+"-"+calendar.today[2];
    theDate[0]=calendar.today[0]; theDate[1]=calendar.today[1]; theDate[2]=calendar.today[2];
   }
   else{
    var reg=/^\d{4}-\d{1,2}-\d{1,2}$/
    if(!defaultDate.match(reg)){
     alert("Ĭ�����ڵĸ�ʽ����ȷ\n\nĬ�����ڿɽ��ܸ�ʽΪ:'yyyy-mm-dd'");
     return;
    }
    var theDate=defaultDate.split("-");
    calendar.head.innerText = defaultDate;
   }
   calendar.currentDate[0]=theDate[0];
   calendar.currentDate[1]=theDate[1];
   calendar.currentDate[2]=theDate[2];
   theFirstDay=calendar.getFirstDay(theDate[0],theDate[1]);
   theMonthLen=theFirstDay+calendar.getMonthLen(theDate[0],theDate[1]);
   //calendar.setEventKey();
   calendar.calendarPad.style.display="";
   var theRows = Math.ceil((theMonthLen)/7);
   //����ɵ�����;
   while (calendar.body.rows.length > 0) {
    calendar.body.deleteRow(0)
   }
   //�����µ�����;
   var n=0;day=0;
   for(i=0;i<theRows;i++){
    theRow=calendar.body.insertRow(i);
    for(j=0;j<7;j++){
     n++;
     if(n>theFirstDay && n<=theMonthLen){
      day=n-theFirstDay;
      calendar.insertBodyCell(theRow,j,day);
     }
     else{
      var theCell=theRow.insertCell(j);
      theCell.style.cssText="background-color:#F0F0F0;cursor:default;";
     }
    }
   }
   //****************��������λ��**************//
   var offsetPos=calendar.getAbsolutePos(calendar.source);//��������λ��;
   if((document.body.offsetHeight-(offsetPos.y+calendar.source.offsetHeight-document.body.scrollTop))<calendar.calendarPad.style.pixelHeight){
    var calTop=offsetPos.y-calendar.calendarPad.style.pixelHeight;
   }
   else{
    var calTop=offsetPos.y+calendar.source.offsetHeight;
   }
   if((document.body.offsetWidth-(offsetPos.x+calendar.source.offsetWidth-document.body.scrollLeft))>calendar.calendarPad.style.pixelWidth){
    var calLeft=offsetPos.x;
   }
   else{
    var calLeft=calendar.source.offsetLeft+calendar.source.offsetWidth;
   }
   //alert(offsetPos.x);
   calendar.calendarPad.style.pixelLeft=calLeft;
   calendar.calendarPad.style.pixelTop=calTop;
  }
  /****************** ��������λ�� *************************/
  this.getAbsolutePos = function(el) {
   var r = { x: el.offsetLeft, y: el.offsetTop };
   if (el.offsetParent) {
    var tmp = calendar.getAbsolutePos(el.offsetParent);
    r.x += tmp.x;
    r.y += tmp.y;
   }
   return r;
  };
  //************* �������ڵ�Ԫ�� **************/
  this.insertBodyCell=function(theRow,j,day,targetObject){
   var theCell=theRow.insertCell(j);
   if(j==0) var theBgColor="#FF9999";
   else var theBgColor="#FFFFFF";
   if(day==calendar.currentDate[2]) var theBgColor="#CCCCCC";
   if(day==calendar.today[2]) var theBgColor="#99FFCC";
   theCell.bgColor=theBgColor;
   theCell.innerText=day;
   theCell.align="center";
   theCell.width=35;
   theCell.style.cssText="border:1px solid #CCCCCC;cursor:hand;";
   theCell.onmouseover=function(){
    theCell.bgColor="#FFFFCC";
    theCell.style.cssText="border:1px outset;cursor:hand;";
   }
   theCell.onmouseout=function(){
    theCell.bgColor=theBgColor;
    theCell.style.cssText="border:1px solid #CCCCCC;cursor:hand;";
   }
   theCell.onmousedown=function(){
    theCell.bgColor="#FFFFCC";
    theCell.style.cssText="border:1px inset;cursor:hand;";
   }
   theCell.onclick=function(){
    if(calendar.currentDate[1].length<2) calendar.currentDate[1]="0"+calendar.currentDate[1];
    if(day.toString().length<2) day="0"+day;
    calendar.sltDate=calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+day;
    calendar.target.value=calendar.sltDate;
    calendar.hide();
   }
  }
  /************** ȡ���·ݵĵ�һ��Ϊ���ڼ� *********************/
  this.getFirstDay=function(theYear, theMonth){
   var firstDate = new Date(theYear,theMonth-1,1);
   return firstDate.getDay();
  }
  /************** ȡ���·ݹ��м��� *********************/
  this.getMonthLen=function(theYear, theMonth) {
   theMonth--;
   var oneDay = 1000 * 60 * 60 * 24;
   var thisMonth = new Date(theYear, theMonth, 1);
   var nextMonth = new Date(theYear, theMonth + 1, 1);
   var len = Math.ceil((nextMonth.getTime() - thisMonth.getTime())/oneDay);
   return len;
  }
  /************** �������� *********************/
  this.hide=function(){
   //calendar.clearEventKey();
   calendar.calendarPad.style.display="none";
  }
  /************** �����￪ʼ *********************/
  this.setup=function(defaultDate){
   calendar.addCalendarPad();
   calendar.addCalendarBoard();
   calendar.setDefaultDate();
  }
  /************** ����AgetimeCalendar *********************/
  this.about=function(){
   /*//alert("Agetime Calendar V1.0\n\nwww.agetime.com\n");
   popLeft = calendar.calendarPad.style.pixelLeft+4;
   popTop = calendar.calendarPad.style.pixelTop+25;
   var popup = window.createPopup();
   var popupBody = popup.document.body;
   popupBody.style.cssText="border:solid 2 outset;font-size:9pt;background-color:#F0F0F0;";
   var popHtml = "<span style='color:#336699;font-size:12pt;'><U>���� AgetimeCalendar</U></span><BR><BR>";
   popHtml+="�汾: v1.0<BR>����: 2004-03-13";
   popupBody.innerHTML=popHtml;
   popup.show(popLeft,popTop,240,136,document.body); */
   var strAbout = "����JS�����ؼ�\n\n";
   strAbout+="-\t: ����\n";
   strAbout+="x\t: ����\n";
   strAbout+="<<\t: ��һ��\n";
   strAbout+="<\t: ��һ��\n";
   strAbout+="����\t: ���ص�������\n";
   strAbout+=">\t: ��һ��\n";
   strAbout+="<<\t: ��һ��\n";
   strAbout+="\nJS�����ؼ�\n";
   alert(strAbout);
  }
  calendar.setup();
 }
var CalendarWebControl = new atCalendarControl();
<!-- 20091218 end -->

//----------------��֤���ύ����-----------------
function doCfm()
{
	if (document.frm.beginTime.value.length == 0) {
     rdShowMessageDialog("��������ʱ�䲻��Ϊ�գ�");
     return false;
  }
	if(!check(document.frm)){
		return false;
	}
	frm.submit();
}

</script>
</head>

<body>
<form name="frm" method="POST" action="s6343_1.jsp">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">�����������ʱ���޸�</div>
		</div>
		<input type="hidden" name="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" value="<%=opName%>">
		<input type="hidden" name="activePhone" value="<%=activePhone%>">
		<table cellspacing="0">
			<tr>
				<td class="blue">�ֻ�����</td>
				<td><input type="text" size="12" name="PhoneNo" value="<%=activePhone%>" id="PhoneNo" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readonly /></td>
			</tr>
			<tr>
				<td class="blue">��������ʱ���޸�Ϊ</td>
				<td><input type="text" name="beginTime" v_must="1" v_type="date" class="button" maxlength="8" readonly/>&nbsp;
						<font class="orange">*</font>
						<input type="button" name="dateButton" alt="�������������˵�" onclick='fPopUpCalendarDlg();return false' value="�� ��" />
				</td>
			</tr>
			<tr>
				<td id="footer" colspan="2">
					<input class="b_foot" type="button" name="confirm" value="ȷ��" onClick="doCfm()" index="2">&nbsp;
					<input class="b_foot" type="button" name="close" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
				</td>
			</tr>
		</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
