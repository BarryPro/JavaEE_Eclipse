<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%
	/**
	 * 功能: 进行个人接续信息统计
	 * 版本: v1.1
	 * 日期: 2011/02/18
	 * 作者: songjia
	 * 版权: sitech
	 * 修改历史 
	 * 修改日期      修改人      修改目的:黑龙江本地化
	 */
%> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="java.util.*, java.text.SimpleDateFormat"%>
<%
	String opCode = "K17N";
	String opName = "接续统计";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>个人接续信息统计</title>
</head>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<%!
 public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}


%>
<body overflow="auto" >
<div id="operation">
 	<div id="operation_table">
 			<div class="title"> <div class="text">筛选条件</div></div>
 				<table >
 				<tr >
 						<td> 工号</td>
 						<td> <input type="text" id ="accept_login_no" />
 					  <td  nowrap > 开始时间 </td>
			      <td  nowrap >
						  <input  id="start_date" name ="start_date" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.all('start_date'));">
					    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" style="width:16px;height:22px" align="absmiddle">
					    <font color="orange">*</font>
					  </td>
					  <td  nowrap > 结束时间 </td>
			      <td  nowrap >
						  <input id="end_date" name ="end_date" type="text"   value="<%=getCurrDateStr("23:59:59")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});">
					    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.all('end_date'));" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
					    <font color="orange">*</font>
					    <input id = "month_interval" name="month_interval" type="hidden"/>
					  </td>
				</tr>
				<tr >	  
					  <td colspan="6" align="center" id="footer" style="width:600px">
 							<input type="button" class="b_foot" value="刷新显示" onclick="doRefresh()"/>
 							<input type="button" class="b_foot" value="工号查询" onclick="findWorkNo()"/>
 						</td>					
 				</tr>
 				</table>
 			<div class="title"> <div class="text">主统计信息：</div></div>
 			
 			<div class="list">
 			<table >
 				<tr >
 					<th>工作时长：</th>
 					<td id="workDuration"></td>
 					<th>内部呼叫次数：</th>
					<td id="innerCallCnt"></td>
					<th>示忙次数：</th>
 					<td id="sayBusyCnt"></td>	
 				</tr>	
 				<tr >
 					<th>总通话时长：</th>
 					<td id="answerDuration"></td>
 					<th>内部求助次数：</th>
 					<td id="innerHelpCnt"></td>
 					<th>示忙时长：</th>
 					<td id="sayBusyDur"></td>	
 				</tr>
 				<tr >
 					<th>通话次数：</th>
 					<td id="answerCnt"></td>
 					<th>保持次数：</th>
 					<td id="holdCnt"></td>
 					<th>工作态时长：</th>
 					<td id="workStateDur"></td>		
 				</tr>
 				<tr >	
 				<th>人工转自动次数：</th>
 					<td id="manToIVRCnt"></td>
 					<th>内部转移:</th>
 					<td id="innerTranCnt"></td>		
 				<th>转出次数：</th>
 					<td id="transferCnt"></td>	
 				</tr>	
 				<tr >
 					<th>呼出次数：</th>
 					<td id="callOutCnt"></td>		
 				<th>在线效率</th>
 					<td id="online"></td>
 				<th>截止当日三态总时长</th>
 					<td id="threeStatus"></td>
 				</th>
 				</tr>			
 			<tr>	
 				<th>三态剩余时长</th>
 				<td id="lastthreeStatus"></td>
 				</tr>
 			</table>
			</div>
 		</div>
	<%@ include file="/npage/include/footer_pop.jsp" %>	
  
  <script type="text/javascript">
	function queryAgentStaticsInfo(workNo) {
	 var startDate = new Date(document.all('start_date').value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var endDate = new Date(document.all('end_date').value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var month_interval = getMonths(startDate,endDate);
	 document.all('month_interval').value = month_interval;
   if( document.all('start_date').value == ""){
    	   //showTip(document.start_date,"开始时间不能为空");
    	   rdShowMessageDialog("开始时间不能为空",1);
    	   start_date.focus();
    	   return;

    }
    if(document.all('end_date').value == ""){
		     //showTip(document.end_date,"结束时间不能为空");
		     rdShowMessageDialog("结束时间不能为空",1);
    	   end_date.focus();
    	   return;

    }
    if(document.all('end_date').value<=document.all('start_date').value){
		     //showTip(document.end_date,"结束时间必须大于开始时间");
		     rdShowMessageDialog("结束时间必须大于开始时间",1);
    	   end_date.focus();
    	   return;

    }
    if(document.all('end_date').value.substring(0,6)>document.all('start_date').value.substring(0,6)){
		     var between_day = endDate-startDate;
		     if((Number(between_day/3600/24/1000) > 31)){
		     		rdShowMessageDialog("只能查询一个月内的记录",1);
    	   		end_date.focus();
    	   		return;
		     }
		     
    }
		if(workNo == "") {
			return;
		}
		//调用ajax
		var packet = new AJAXPacket("k17N_callMsgQry_ajax.jsp","正在处理,请稍后...");
		packet.data.add("accept_login_no",workNo);
		packet.data.add("start_date",document.all('start_date').value);
		packet.data.add("end_date",document.all('end_date').value);
		core.ajax.sendPacket(packet,function(packet){
			var message = packet.data.findValueByName("message");
			document.getElementById("workDuration").innerText = time_format(message[1]);//工作时长
			document.getElementById("workStateDur").innerText = time_format(message[2]);//工作态时长
			document.getElementById("holdCnt").innerText = message[3]+"次";//保持次数
			document.getElementById("answerCnt").innerText = message[4]+"次";//通话次数
			document.getElementById("callOutCnt").innerText = message[5]+"次";//呼出次数
			document.getElementById("innerTranCnt").innerText = message[6]+"次";//内部互转
			document.getElementById("transferCnt").innerText = message[7]+"次";//转出次数
			document.getElementById("innerCallCnt").innerText = message[8]+"次";//内部呼叫次数
			document.getElementById("innerHelpCnt").innerText = message[9]+"次";//内部求助次数
			document.getElementById("answerDuration").innerText = time_format(message[10]);//总通话时长
			document.getElementById("sayBusyCnt").innerText = message[11]+"次";//示忙次数
			document.getElementById("sayBusyDur").innerText = time_format(message[12]);//示忙时长
			
			var message_online = packet.data.findValueByName("message_online");
			document.getElementById("online").innerText = message_online[1];//在线效率
			
			var manToIVRCnt_num = packet.data.findValueByName("manToIVRCnt_num");
			document.getElementById("manToIVRCnt").innerText = manToIVRCnt_num+"次";//人工转自动
			
			var message_threeSatues = packet.data.findValueByName("message_threeSatues");
			document.getElementById("threeStatus").innerText = time_format(message_threeSatues[1]);//三态时长	
			//三态剩余时长
		 var status_time = packet.data.findValueByName("status_time");

			document.getElementById("lastthreeStatus").innerText = time_format(status_time*60-message_threeSatues[1]);//三态时长	
		},true);
	}
	
	function time_format(seconds) {
		var hours = fill_zero(parseInt(seconds / 3600));
		var temp = fill_zero(parseInt(seconds % 3600)); 
		var minutes = fill_zero(parseInt(temp / 60));
		temp = fill_zero(temp % 60);
		return hours + ":" + minutes + ":" + temp; 
	}
	
	function fill_zero(num) {
		if(num < 10) {
			return "0" + num;
		}
		return num;
	}
	function doRefresh(){
		var accept_login_no = document.getElementById("accept_login_no").value;
		if(accept_login_no == "" || isNaN(accept_login_no)){
			rdShowMessageDialog("请正确输入工号！",0); 
			return;
		}
		
		queryAgentStaticsInfo(accept_login_no);	
	}
	function findWorkNo(){
  	openWinMid('k17N_getLoginNo.jsp','工号查询',240,400);
	}
	function openWinMid(url,name,iHeight,iWidth)
	{
		  //var url; //转向网页的地址;
		  //var name; //网页名称，可为;
		  //var iWidth; //弹出窗口的宽度;
		  //var iHeight; //弹出窗口的高度;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
	}

	window.onload = function () {
		var kf_no = window.opener.document.getElementById("workNo").value;
		document.getElementById("accept_login_no").value=kf_no;
		queryAgentStaticsInfo(kf_no);	
	}
	function getMonths(startDate,endDate){
 number = 0;
 yearToMonth = (endDate.getFullYear() - startDate.getFullYear()) * 12;
 number += yearToMonth;
 monthToMonth = endDate.getMonth() - startDate.getMonth();
 number += monthToMonth;

 return number;
}
</script>
</div>
</body>
</html>


