<%
  /*
   * 功能: 短信日志重发短信
　 * 版本: 1.0.0
　 * 日期: 2009/03/19
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%
	String aimphone = request.getParameter("aphone")==null?"":request.getParameter("aphone");//目标号码
	String callerphone = request.getParameter("callphone")==null?"":request.getParameter("callphone");//主叫号码
	String contentMsg = request.getParameter("content")==null?"":request.getParameter("content");//短信内容
	
	String dateStr = new SimpleDateFormat("yyyy-MM-dd").format(new Date());//当前日期
	String timeStr = new SimpleDateFormat("hh:mm:ss").format(new Date());//当前时间
%>
<html>
  <head>
  	<title>短信重发</title>
  	<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
 	  <script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
 	  <script language="javascript">
	 		 function sendMsg(){
			  
		    if(document.sitechform.aimphone.value == ""){
		    	
					showTip(document.sitechform.aimphone,"目标号码不能为空！请从新选择后输入");
					
					sitechform.aimphone.focus();
						
		    }else if(!f_check_mobile(document.sitechform.aimphone.value)){
		    	
					showTip(document.sitechform.aimphone,"目标号码格式不正确！请从新选择后输入");
					
					sitechform.aimphone.focus();
					
				}else if(document.sitechform.contentMsg.value == ""){
		    	
					showTip(document.sitechform.contentMsg,"短信内容不能为空！请从新选择后输入");
					
					sitechform.contentMsg.focus();
					
				}else {
					
					if(rdShowConfirmDialog("确实要发送吗?",2) != 1){
				
					}else{
						
						sendSubmit();  
					}					
					
				}
		}
		
		function sendSubmit(){
			var long_serv_no = "";//发送短信源地址
			var obj = document.sitechform.radiobutton;
			var fl = "";
			for(var i = 0; i < obj.length; i++){
				if(obj[i].checked){
					fl = obj[i].value;
				}
			}
			if(fl=='1'){
				long_serv_no = "10658088";
			}else if(fl=='2'){
				long_serv_no = document.sitechform.callerphone.value;
			}
			var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/12580/9KA54/K507/k507_msgSend_rpc.jsp","正在发送短信，请稍候......");
			mypacket.data.add("aimphone",document.sitechform.aimphone.value);
			mypacket.data.add("long_sevr_no",long_serv_no);
			mypacket.data.add("callerphone",document.sitechform.callerphone.value);
			
			mypacket.data.add("contactid",window.opener.parent.parent.document.getElementById("contactIdnew").innerHTML);
			mypacket.data.add("contentMsg",document.sitechform.contentMsg.value);
			mypacket.data.add("VALID_TIME",document.sitechform.sdate.value+" "+document.sitechform.stime.value);			
		  core.ajax.sendPacket(mypacket,doProcess,true);
			mypacket=null;
		}
		
		function doProcess(packet){
		  window.opener.parent.parent.similarMSNPop("短信发送成功");
			window.close();			
		}
	 	</script>
  </head>
  
  <body>
  	<form name="sitechform" action="" method="post">
  	<div id="Operation_Table">
  	<table width="638" height="196" border="0">
		  <tr>
		    <td colspan="2" rowspan="5">	
		    	短信内容<br>	    	
		      <textarea name="contentMsg" rows="8" cols="45"><%=contentMsg==null?"":contentMsg %></textarea>
		    </td>
		    <td rowspan="2">指定发送时间</td>
		    <td>
		      日期&nbsp;<input type="text" name="sdate" size="12" value="<%=dateStr %>">
		      <img onclick="WdatePicker({el:$dp.$('sdate'),dateFmt:'yyyy-MM-dd',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    </td>
		  </tr>
		  <tr>
		    <td>
		    	
		      时间&nbsp;<input type="text" name="stime" size="12" value="<%=timeStr %>">
		      <img onclick="WdatePicker({el:$dp.$('stime'),dateFmt:'HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    </td>
		  </tr>
		  <tr>
		    <td>优先级</td>
		    <td>
		      <select name="select">
		      	<option>普通</option>
		      	<option>紧急</option>
		      	</option>
		      </select>
		    </td>
		  </tr>
		  <tr>
		    <td rowspan="2">指定发送号码方式</td>
		    <td>
		      <input type="radio" checked name="radiobutton" value="1">
					系统生成    
		    </td>
		  </tr>
		  <tr>
		    <td>
		      <input type="radio" name="radiobutton" value="2">
					主叫    
		    </td>
		  </tr>
		  <tr align="center">
		    <td>
		      目标号码&nbsp;<input type="text" name="aimphone" size="12" value="<%=aimphone==null?"":aimphone %>">
		    </td>
		    <td>
		      主叫号码&nbsp;<input type="text" name="callerphone" size="12" disabled value="<%=callerphone==null?"":callerphone %>">
		    </td>
		    <td colspan="2">
		      <input type="button" class="b_foot" name="send" value="发送" onClick="sendMsg();">
					&nbsp;
		      <input type="reset" class="b_foot" name="cancel" value="重置">
		      &nbsp;
		      <input type="button" class="b_foot" name="close" value="关闭" onClick="window.close();">
		    </td>
		  </tr>
		</table>
	  </div>
		</form>
  </body>
</html>