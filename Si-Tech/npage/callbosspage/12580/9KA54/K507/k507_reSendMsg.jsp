<%
  /*
   * ����: ������־�ط�����
�� * �汾: 1.0.0
�� * ����: 2009/03/19
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
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
	String aimphone = request.getParameter("aphone")==null?"":request.getParameter("aphone");//Ŀ�����
	String callerphone = request.getParameter("callphone")==null?"":request.getParameter("callphone");//���к���
	String contentMsg = request.getParameter("content")==null?"":request.getParameter("content");//��������
	
	String dateStr = new SimpleDateFormat("yyyy-MM-dd").format(new Date());//��ǰ����
	String timeStr = new SimpleDateFormat("hh:mm:ss").format(new Date());//��ǰʱ��
%>
<html>
  <head>
  	<title>�����ط�</title>
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
		    	
					showTip(document.sitechform.aimphone,"Ŀ����벻��Ϊ�գ������ѡ�������");
					
					sitechform.aimphone.focus();
						
		    }else if(!f_check_mobile(document.sitechform.aimphone.value)){
		    	
					showTip(document.sitechform.aimphone,"Ŀ������ʽ����ȷ�������ѡ�������");
					
					sitechform.aimphone.focus();
					
				}else if(document.sitechform.contentMsg.value == ""){
		    	
					showTip(document.sitechform.contentMsg,"�������ݲ���Ϊ�գ������ѡ�������");
					
					sitechform.contentMsg.focus();
					
				}else {
					
					if(rdShowConfirmDialog("ȷʵҪ������?",2) != 1){
				
					}else{
						
						sendSubmit();  
					}					
					
				}
		}
		
		function sendSubmit(){
			var long_serv_no = "";//���Ͷ���Դ��ַ
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
			var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/12580/9KA54/K507/k507_msgSend_rpc.jsp","���ڷ��Ͷ��ţ����Ժ�......");
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
		  window.opener.parent.parent.similarMSNPop("���ŷ��ͳɹ�");
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
		    	��������<br>	    	
		      <textarea name="contentMsg" rows="8" cols="45"><%=contentMsg==null?"":contentMsg %></textarea>
		    </td>
		    <td rowspan="2">ָ������ʱ��</td>
		    <td>
		      ����&nbsp;<input type="text" name="sdate" size="12" value="<%=dateStr %>">
		      <img onclick="WdatePicker({el:$dp.$('sdate'),dateFmt:'yyyy-MM-dd',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    </td>
		  </tr>
		  <tr>
		    <td>
		    	
		      ʱ��&nbsp;<input type="text" name="stime" size="12" value="<%=timeStr %>">
		      <img onclick="WdatePicker({el:$dp.$('stime'),dateFmt:'HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    </td>
		  </tr>
		  <tr>
		    <td>���ȼ�</td>
		    <td>
		      <select name="select">
		      	<option>��ͨ</option>
		      	<option>����</option>
		      	</option>
		      </select>
		    </td>
		  </tr>
		  <tr>
		    <td rowspan="2">ָ�����ͺ��뷽ʽ</td>
		    <td>
		      <input type="radio" checked name="radiobutton" value="1">
					ϵͳ����    
		    </td>
		  </tr>
		  <tr>
		    <td>
		      <input type="radio" name="radiobutton" value="2">
					����    
		    </td>
		  </tr>
		  <tr align="center">
		    <td>
		      Ŀ�����&nbsp;<input type="text" name="aimphone" size="12" value="<%=aimphone==null?"":aimphone %>">
		    </td>
		    <td>
		      ���к���&nbsp;<input type="text" name="callerphone" size="12" disabled value="<%=callerphone==null?"":callerphone %>">
		    </td>
		    <td colspan="2">
		      <input type="button" class="b_foot" name="send" value="����" onClick="sendMsg();">
					&nbsp;
		      <input type="reset" class="b_foot" name="cancel" value="����">
		      &nbsp;
		      <input type="button" class="b_foot" name="close" value="�ر�" onClick="window.close();">
		    </td>
		  </tr>
		</table>
	  </div>
		</form>
  </body>
</html>