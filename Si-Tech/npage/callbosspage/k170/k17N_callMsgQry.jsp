<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%
	/**
	 * ����: ���и��˽�����Ϣͳ��
	 * �汾: v1.1
	 * ����: 2011/02/18
	 * ����: songjia
	 * ��Ȩ: sitech
	 * �޸���ʷ 
	 * �޸�����      �޸���      �޸�Ŀ��:���������ػ�
	 */
%> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="java.util.*, java.text.SimpleDateFormat"%>
<%
	String opCode = "K17N";
	String opName = "����ͳ��";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>���˽�����Ϣͳ��</title>
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
 			<div class="title"> <div class="text">ɸѡ����</div></div>
 				<table >
 				<tr >
 						<td> ����</td>
 						<td> <input type="text" id ="accept_login_no" />
 					  <td  nowrap > ��ʼʱ�� </td>
			      <td  nowrap >
						  <input  id="start_date" name ="start_date" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.all('start_date'));">
					    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" style="width:16px;height:22px" align="absmiddle">
					    <font color="orange">*</font>
					  </td>
					  <td  nowrap > ����ʱ�� </td>
			      <td  nowrap >
						  <input id="end_date" name ="end_date" type="text"   value="<%=getCurrDateStr("23:59:59")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});">
					    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.all('end_date'));" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
					    <font color="orange">*</font>
					    <input id = "month_interval" name="month_interval" type="hidden"/>
					  </td>
				</tr>
				<tr >	  
					  <td colspan="6" align="center" id="footer" style="width:600px">
 							<input type="button" class="b_foot" value="ˢ����ʾ" onclick="doRefresh()"/>
 							<input type="button" class="b_foot" value="���Ų�ѯ" onclick="findWorkNo()"/>
 						</td>					
 				</tr>
 				</table>
 			<div class="title"> <div class="text">��ͳ����Ϣ��</div></div>
 			
 			<div class="list">
 			<table >
 				<tr >
 					<th>����ʱ����</th>
 					<td id="workDuration"></td>
 					<th>�ڲ����д�����</th>
					<td id="innerCallCnt"></td>
					<th>ʾæ������</th>
 					<td id="sayBusyCnt"></td>	
 				</tr>	
 				<tr >
 					<th>��ͨ��ʱ����</th>
 					<td id="answerDuration"></td>
 					<th>�ڲ�����������</th>
 					<td id="innerHelpCnt"></td>
 					<th>ʾæʱ����</th>
 					<td id="sayBusyDur"></td>	
 				</tr>
 				<tr >
 					<th>ͨ��������</th>
 					<td id="answerCnt"></td>
 					<th>���ִ�����</th>
 					<td id="holdCnt"></td>
 					<th>����̬ʱ����</th>
 					<td id="workStateDur"></td>		
 				</tr>
 				<tr >	
 				<th>�˹�ת�Զ�������</th>
 					<td id="manToIVRCnt"></td>
 					<th>�ڲ�ת��:</th>
 					<td id="innerTranCnt"></td>		
 				<th>ת��������</th>
 					<td id="transferCnt"></td>	
 				</tr>	
 				<tr >
 					<th>����������</th>
 					<td id="callOutCnt"></td>		
 				<th>����Ч��</th>
 					<td id="online"></td>
 				<th>��ֹ������̬��ʱ��</th>
 					<td id="threeStatus"></td>
 				</th>
 				</tr>			
 			<tr>	
 				<th>��̬ʣ��ʱ��</th>
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
    	   //showTip(document.start_date,"��ʼʱ�䲻��Ϊ��");
    	   rdShowMessageDialog("��ʼʱ�䲻��Ϊ��",1);
    	   start_date.focus();
    	   return;

    }
    if(document.all('end_date').value == ""){
		     //showTip(document.end_date,"����ʱ�䲻��Ϊ��");
		     rdShowMessageDialog("����ʱ�䲻��Ϊ��",1);
    	   end_date.focus();
    	   return;

    }
    if(document.all('end_date').value<=document.all('start_date').value){
		     //showTip(document.end_date,"����ʱ�������ڿ�ʼʱ��");
		     rdShowMessageDialog("����ʱ�������ڿ�ʼʱ��",1);
    	   end_date.focus();
    	   return;

    }
    if(document.all('end_date').value.substring(0,6)>document.all('start_date').value.substring(0,6)){
		     var between_day = endDate-startDate;
		     if((Number(between_day/3600/24/1000) > 31)){
		     		rdShowMessageDialog("ֻ�ܲ�ѯһ�����ڵļ�¼",1);
    	   		end_date.focus();
    	   		return;
		     }
		     
    }
		if(workNo == "") {
			return;
		}
		//����ajax
		var packet = new AJAXPacket("k17N_callMsgQry_ajax.jsp","���ڴ���,���Ժ�...");
		packet.data.add("accept_login_no",workNo);
		packet.data.add("start_date",document.all('start_date').value);
		packet.data.add("end_date",document.all('end_date').value);
		core.ajax.sendPacket(packet,function(packet){
			var message = packet.data.findValueByName("message");
			document.getElementById("workDuration").innerText = time_format(message[1]);//����ʱ��
			document.getElementById("workStateDur").innerText = time_format(message[2]);//����̬ʱ��
			document.getElementById("holdCnt").innerText = message[3]+"��";//���ִ���
			document.getElementById("answerCnt").innerText = message[4]+"��";//ͨ������
			document.getElementById("callOutCnt").innerText = message[5]+"��";//��������
			document.getElementById("innerTranCnt").innerText = message[6]+"��";//�ڲ���ת
			document.getElementById("transferCnt").innerText = message[7]+"��";//ת������
			document.getElementById("innerCallCnt").innerText = message[8]+"��";//�ڲ����д���
			document.getElementById("innerHelpCnt").innerText = message[9]+"��";//�ڲ���������
			document.getElementById("answerDuration").innerText = time_format(message[10]);//��ͨ��ʱ��
			document.getElementById("sayBusyCnt").innerText = message[11]+"��";//ʾæ����
			document.getElementById("sayBusyDur").innerText = time_format(message[12]);//ʾæʱ��
			
			var message_online = packet.data.findValueByName("message_online");
			document.getElementById("online").innerText = message_online[1];//����Ч��
			
			var manToIVRCnt_num = packet.data.findValueByName("manToIVRCnt_num");
			document.getElementById("manToIVRCnt").innerText = manToIVRCnt_num+"��";//�˹�ת�Զ�
			
			var message_threeSatues = packet.data.findValueByName("message_threeSatues");
			document.getElementById("threeStatus").innerText = time_format(message_threeSatues[1]);//��̬ʱ��	
			//��̬ʣ��ʱ��
		 var status_time = packet.data.findValueByName("status_time");

			document.getElementById("lastthreeStatus").innerText = time_format(status_time*60-message_threeSatues[1]);//��̬ʱ��	
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
			rdShowMessageDialog("����ȷ���빤�ţ�",0); 
			return;
		}
		
		queryAgentStaticsInfo(accept_login_no);	
	}
	function findWorkNo(){
  	openWinMid('k17N_getLoginNo.jsp','���Ų�ѯ',240,400);
	}
	function openWinMid(url,name,iHeight,iWidth)
	{
		  //var url; //ת����ҳ�ĵ�ַ;
		  //var name; //��ҳ���ƣ���Ϊ;
		  //var iWidth; //�������ڵĿ��;
		  //var iHeight; //�������ڵĸ߶�;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
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


