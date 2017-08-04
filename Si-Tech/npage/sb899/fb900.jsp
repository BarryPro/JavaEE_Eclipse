<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 营业厅统计报表 fb900
   * 版本: 1.0
   * 日期: 2010/11/29
   * 作者: ningtn
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%
	String opCode="b900";
	String opName="营业厅统计报表";
	String work_no = (String)session.getAttribute("workNo");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>营业厅统计报表</TITLE>
</HEAD>
<script language="javascript">
	function doSubmit(){
		hiddenTip($("#groupName")[0]);
		var groupNameStr = $("#groupName").val()
		if(groupNameStr == '' && groupNameStr.length == 0){
			showTip($("#groupName")[0],"请选择组织机构节点");
			return false;
		}
		if(!check(document.form1)){
			return false;
		}	
		
		var selectDateObj = $("#beginTime");
		var hourseObj = $("#hourse");
		var nowFlagObj = $("#nowFlag");
		var sendTime ;
		if(nowFlagObj.val() == "1"){
			//是今天
			if(hourseObj.val() < 0){
				showTip(hourseObj[0],"请选择想统计的时间");
				return false;
			}
			sendTime = selectDateObj.val() + " " + hourseObj.val() + ":00:00";
		}else{
			sendTime = selectDateObj.val() + " 23:59:59";
		}
		with(document.forms[0]){
			var rptTypeVal = $("#rptType").val();
			if(rptTypeVal == 1){
				hTableName.value="rjo005";
				hParams1.value= "prc_b900_001('"+$("#workNo").val()+"','"+sendTime+"','"+$("#groupId").val()+"'";
			}else if(rptTypeVal == 2){
				hTableName.value="rjo005";
				hParams1.value= "prc_b900_002('"+$("#workNo").val()+"','"+sendTime+"','"+$("#groupId").val()+"'";
			}else if(rptTypeVal == 3){
				hTableName.value="rjo005";
				hParams1.value= "prc_b900_003('"+$("#workNo").val()+"','"+sendTime+"','"+$("#groupId").val()+"'";
			}else if(rptTypeVal == 4){
				hTableName.value="rjo005";
				hParams1.value= "prc_b900_004('"+$("#workNo").val()+"','"+sendTime+"','"+$("#groupId").val()+"'";
			}else{
				return false;
			}
			submit();
		}
	}
	function selectGroup(){
		var path = "grouptree.jsp";
    	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
var today;
$(document).ready(function(){
	today = "<%=dateStr%>";
	today = today.substr(0,8);
	$("#beginTime").val(today);
});
	
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
		//alert("today : " + today + "|" + retval + "|")
		if(today < retval){
			rdShowMessageDialog("不能选择今天之后的日期");
			return false;
		}else{
			document.form1.beginTime.value = retval;
		}
		var hourseObj = $("#hourse");
		if(today == retval){
			hourseObj.removeAttr("disabled");
			$("#nowFlag").val("1");
		}else{
			hourseObj.attr("disabled","disabled");
			$("#nowFlag").val("0");
		}
	}
	else if(retval == "")
	{
		document.form1.beginTime.value = "";
	}else{
	}
}
	
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
  /************** 加入日历底板及阴影 *********************/
  this.addCalendarPad=function(){
   document.write("<div id='divCalendarpad' style='position:absolute;top:100px;left:0;width:255px;height:167px;display:none;'>");
   document.write("<iframe frameborder=0 height=168px width=255px></iframe>");
   document.write("<div style='position:absolute;top:4px;left:4px;width:248px;height:164px;background-color:#336699;'></div>");
   document.write("</div>");
   calendar.calendarPad=document.all.divCalendarpad;
  }
  /************** 加入日历面板 *********************/
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
   /************** 设置各功能按钮的功能 *********************/
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
   calendar.calendarClose.title="关闭";
   calendar.calendarClose.onclick=function(){calendar.hide();}
   /*********** Calendar PrevYear Button ***************/
   trRow = tbBoard.insertRow(1);
   calendar.prevYear = calendar.insertTbCell(trRow,0,"&lt;&lt;","center");
   calendar.prevYear.title="上一年";
   calendar.prevYear.onmousedown=function(){
    calendar.currentDate[0]--;
    calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
   }
   /*********** Calendar PrevMonth Button ***************/
   calendar.prevMonth = calendar.insertTbCell(trRow,1,"&lt;","center");
   calendar.prevMonth.title="上一月";
   calendar.prevMonth.onmousedown=function(){
    calendar.currentDate[1]--;
    if(calendar.currentDate[1]==0){
     calendar.currentDate[1]=12;
     calendar.currentDate[0]--;
    }
    calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
   }
   /*********** Calendar Today Button ***************/
   calendar.goToday = calendar.insertTbCell(trRow,2,"今天","center",3);
   calendar.goToday.title="选择今天";
   calendar.goToday.onclick=function(){
    calendar.sltDate=calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2];
    calendar.target.value=calendar.sltDate;
    calendar.hide();
    //calendar.show(calendar.target,calendar.today[0]+"-"+calendar.today[1]+"-"+calendar.today[2],calendar.source);
   }
   /*********** Calendar NextMonth Button ***************/
   calendar.nextMonth = calendar.insertTbCell(trRow,3,"&gt;","center");
   calendar.nextMonth.title="下一月";
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
   calendar.nextYear.title="下一年";
   calendar.nextYear.onmousedown=function(){
    calendar.currentDate[0]++;
    calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
   }
   trRow = tbBoard.insertRow(2);
   var cnDateName = new Array("周日","周一","周二","周三","周四","周五","周六");
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
  /************** 加入功能按钮公共样式 *********************/
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
    alert("未设置目标对像. \n方法: ATCALENDAR.show(obj 目标对像,string 默认日期,obj 点击对像);\n\n目标对像:接受日期返回值的对像.\n默认日期:格式为\"yyyy-mm-dd\",缺省为当日日期.\n点击对像:点击这个对像弹出calendar,默认为目标对像.\n");
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
     alert("默认日期的格式不正确\n\n默认日期可接受格式为:'yyyy-mm-dd'");
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
   //清除旧的日历;
   while (calendar.body.rows.length > 0) {
    calendar.body.deleteRow(0)
   }
   //建立新的日历;
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
   //****************调整日历位置**************//
   var offsetPos=calendar.getAbsolutePos(calendar.source);//计算对像的位置;
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
  /****************** 计算对像的位置 *************************/
  this.getAbsolutePos = function(el) {
   var r = { x: el.offsetLeft, y: el.offsetTop };
   if (el.offsetParent) {
    var tmp = calendar.getAbsolutePos(el.offsetParent);
    r.x += tmp.x;
    r.y += tmp.y;
   }
   return r;
  };
  //************* 插入日期单元格 **************/
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
  /************** 取得月份的第一天为星期几 *********************/
  this.getFirstDay=function(theYear, theMonth){
   var firstDate = new Date(theYear,theMonth-1,1);
   return firstDate.getDay();
  }
  /************** 取得月份共有几天 *********************/
  this.getMonthLen=function(theYear, theMonth) {
   theMonth--;
   var oneDay = 1000 * 60 * 60 * 24;
   var thisMonth = new Date(theYear, theMonth, 1);
   var nextMonth = new Date(theYear, theMonth + 1, 1);
   var len = Math.ceil((nextMonth.getTime() - thisMonth.getTime())/oneDay);
   return len;
  }
  /************** 隐藏日历 *********************/
  this.hide=function(){
   //calendar.clearEventKey();
   calendar.calendarPad.style.display="none";
  }
  /************** 从这里开始 *********************/
  this.setup=function(defaultDate){
   calendar.addCalendarPad();
   calendar.addCalendarBoard();
   calendar.setDefaultDate();
  }
  /************** 关于AgetimeCalendar *********************/
  this.about=function(){
   /*//alert("Agetime Calendar V1.0\n\nwww.agetime.com\n");
   popLeft = calendar.calendarPad.style.pixelLeft+4;
   popTop = calendar.calendarPad.style.pixelTop+25;
   var popup = window.createPopup();
   var popupBody = popup.document.body;
   popupBody.style.cssText="border:solid 2 outset;font-size:9pt;background-color:#F0F0F0;";
   var popHtml = "<span style='color:#336699;font-size:12pt;'><U>关于 AgetimeCalendar</U></span><BR><BR>";
   popHtml+="版本: v1.0<BR>日期: 2004-03-13";
   popupBody.innerHTML=popHtml;
   popup.show(popLeft,popTop,240,136,document.body); */
   var strAbout = "关于JS日历控件\n\n";
   strAbout+="-\t: 关于\n";
   strAbout+="x\t: 隐藏\n";
   strAbout+="<<\t: 上一年\n";
   strAbout+="<\t: 上一月\n";
   strAbout+="今日\t: 返回当天日期\n";
   strAbout+=">\t: 下一月\n";
   strAbout+="<<\t: 下一年\n";
   strAbout+="\nJS日历控件\n";
   alert(strAbout);
  }
  calendar.setup();
 }
var CalendarWebControl = new atCalendarControl();


</script>
<body>
	<FORM method=post name="form1" action="/npage/rpt/print_rpt.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">营业厅统计报表</div>
    </div>
    <table cellSpacing="0">
    	<tr>
    		<td class="blue">操作报表</td>
    		<td>
    			<select name="rptType" id="rptType">
    				<option value="1">1-->运营数据横比报表</option>
    				<option value="2">2-->运营数据展现报表</option>
    				<option value="3">3-->营业厅平均服务时间TOP20</option>
    				<option value="4">4-->营业厅平均等待时间TOP20</option>
    			</select>
    		</td>
    		<td class="blue">组织节点</td>
    		<td>
    			<input type="hidden" name="groupId" id="groupId">
    			<input type="text" name="groupName" id="groupName" class="InputGrey" readonly v_must="1" v_type="string" />
    			<font color="orange">*</font>
    			<input type="button" name="selectBtn" class="b_text" value="选择" onclick="selectGroup()" />
    		</td>
    	</tr>
    	<tr>
    		<td class="blue">统计时间</td>
    		<td colspan="3">
    			<input type="text" name="beginTime" id="beginTime" v_must="1" v_type="date" class="button" maxlength="8" readonly/>
    			<input type="button" name="dateButton" alt="弹出日历下拉菜单" class="b_text"
    					onclick='fPopUpCalendarDlg();return false' value="日 历" />
    			时间
    			<select name="hourse" id="hourse">
    				<option value="-1">--请选择--</option>
    				<option value="7">--7时--</option>
    				<option value="8">--8时--</option>
    				<option value="9">--9时--</option>
    				<option value="10">--10时--</option>
    				<option value="11">--11时--</option>
    				<option value="12">--12时--</option>
    				<option value="13">--13时--</option>
    				<option value="14">--14时--</option>
    				<option value="15">--15时--</option>
    				<option value="16">--16时--</option>
    				<option value="17">--17时--</option>
    				<option value="18">--18时--</option>
    				<option value="19">--19时--</option>
    				<option value="20">--20时--</option>
    			</select>
    			<input type="hidden" name="nowFlag" id="nowFlag" value="1" />
    		</td>
    	</tr>
		<tr>
			<td colspan="4" align="center" id="footer">
			<input class="b_foot" name="submits" type="button" onclick="doSubmit()" value="确认" />
			<input class="b_foot" name="reee"    type="button" onClick="form1.reset()" value="清除"/>
			<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="关闭"/>
			</td>
		</tr>
    </table>
    <input type="hidden" name="workNo" id="workNo" value="<%=work_no%>">
    <input type="hidden" name="rptRight" value="T">
    <input type="hidden" name="hDbLogin" value ="dbchange">
    <input type="hidden" name="hParams1" value="">
    <input type="hidden" name="hTableName" value="">
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>