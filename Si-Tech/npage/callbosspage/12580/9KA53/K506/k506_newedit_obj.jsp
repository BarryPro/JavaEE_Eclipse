
<%
	 /*
	 * ����: 12580���Ի���������
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%! 
  public  String getCurrDateStr(String str) {
	java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");
	return objSimpleDateFormat.format(new java.util.Date())+" "+str;
  }
  
%>

<%
  
  String opCode = "K506";
  String opName = "���Ի���������";
  
  String loginNo = (String) session.getAttribute("workNo");
  String orgCode = (String) session.getAttribute("orgCode");
  String kf_longin_no = (String) session.getAttribute("kfWorkNo");
  String ACCEPT_NO = request.getParameter("ACCEPT_NO");
  String outStr = "select max(to_char(end_time,'yyyy-MM-dd HH24:mi:ss')), min(to_char(begin_time,'yyyy-MM-dd HH24:mi:ss')) from DTAKEMSG where msg_type = '1' and ACCEPT_NO = '"+ACCEPT_NO+"'";//�ж��Ƿ������ԣ���������Ե�ʱ��ʱ�䲻���ص�������ص���ʾ��Ϣ
  String outEndTime = "";//������ʱ��
  String outBeginTime = "";//��С��ʼʱ��
  
  String SERIAL_NO = request.getParameter("SERIAL_NO");
  
  String strINType = "button";
  String strUPType = "hidden";
  
  String BEGIN_TIME = "";
  String END_TIME = "";
  String MSG_CONTENT = "";
  
  if(SERIAL_NO==null||"".equals(SERIAL_NO)){
  	
  
  }else{
	
  strINType = "hidden";
  strUPType = "button";
 
  String sSql ="select to_char(BEGIN_TIME,'yyyy-MM-dd HH24:mi:ss'),to_char(END_TIME,'yyyy-MM-dd HH24:mi:ss'),MSG_CONTENT from DTAKEMSG where MSG_TYPE = '1' and SERIAL_NO = '"+SERIAL_NO+"'";
%>  
<wtc:service name="s151Select" outnum="8">
	<wtc:param value="<%=sSql %>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />

<% 
  if(queryList.length > 0){   
  	
  	BEGIN_TIME =(queryList[0][0].length() != 0) ? queryList[0][0]: "";
  	END_TIME =(queryList[0][1].length() != 0) ? queryList[0][1]: "";
  	MSG_CONTENT =(queryList[0][2].length() != 0) ? queryList[0][2]: "";
  }
  
  }
%>
<!--��ѯ�Ƿ��������ԣ������ǽ���ʱ�䣬�����ж����������ʱ���Ƿ���ʱ���ص� -->
<wtc:service name="s151Select" outnum="8">
	<wtc:param value="<%=outStr %>" />
</wtc:service>
<wtc:array id="querydata" scope="end" />
<%
if(querydata.length > 0){
	
	outEndTime = (querydata[0][0].length() != 0) ? querydata[0][0]: "";
	outBeginTime = (querydata[0][1].length() != 0) ? querydata[0][1]: "";
} 
%>

<html>
	<head>
		<title>���Ի���������</title>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
		<script language=javascript>
		function modCfm(){
			
			var BEGIN_TIME = document.getElementById("BEGIN_TIME").value;
			var BEGIN_TIME1 = document.getElementById("BEGIN_TIME1").value;
			var END_TIME = document.getElementById("END_TIME").value;
			var END_TIME1 = document.getElementById("END_TIME1").value;
			var MSG_CONTENT = document.getElementById("MSG_CONTENT").value;
			
			var outendtime = document.getElementById("outendtime").value;//�Ժ����Խ���ʱ��
			
			if(BEGIN_TIME == ""){
				
				showTip(document.sitechform.BEGIN_TIME,"��ʼ���ڲ���Ϊ�գ������ѡ�������");
		        sitechform.BEGIN_TIME.focus();
		        return;
			}
			
			if(BEGIN_TIME1 == ""){
				
				showTip(document.sitechform.BEGIN_TIME1,"��ʼʱ�䲻��Ϊ�գ������ѡ�������");
		        sitechform.BEGIN_TIME1.focus();
		        return;
			}
			if(!judagetime(BEGIN_TIME1)){
				showTip(document.sitechform.BEGIN_TIME1,"������00:00:00~23:59:59֮���ʱ��");
		        sitechform.BEGIN_TIME1.focus();
		        return;
			}
			if(END_TIME == ""){
				
				showTip(document.sitechform.END_TIME,"�������ڲ���Ϊ�գ������ѡ�������");
		        sitechform.END_TIME.focus();
		        return;
			}
			if(END_TIME1 == ""){
				
				showTip(document.sitechform.END_TIME1,"����ʱ�䲻��Ϊ�գ������ѡ�������");
		        sitechform.END_TIME1.focus();
		        return;
			}
			if(!judagetime(END_TIME1)){
				showTip(document.sitechform.END_TIME1,"������00:00:00~23:59:59֮���ʱ��");
		        sitechform.END_TIME1.focus();
		        return;
			}
			if((BEGIN_TIME+BEGIN_TIME1)>=(END_TIME+END_TIME)){
				
				showTip(document.sitechform.END_TIME,"�������ڲ���С�ڻ���ڿ�ʼ���ڣ������ѡ�������");
		    
		        sitechform.END_TIME.focus();
		        return;
			}
			
			//if((BEGIN_TIME+BEGIN_TIME1)<=outendtime){
			//	if(rdShowConfirmDialog("�½����Ժ�ԭ������ʱ���ص������Ƿ�������",2) != 1){
			//		document.getElementById("innerH").style.display="";
			//		return;
			//	}
				//else{
					
				//}
				//showTip(document.sitechform.BEGIN_TIME,"�½����Ժ�ԭ������ʱ���ص���ԭ�����Խ���ʱ��Ϊ"+outendtime+"�������ѡ�������");
		    
		      //  sitechform.END_TIME.focus();
		        //return;
			//}
			
			if(MSG_CONTENT == ""){
				
				showTip(document.sitechform.MSG_CONTENT,"�������ݲ���Ϊ�գ������ѡ�������");
		        sitechform.MSG_CONTENT.focus();
		        return;
			}
			
			var myPacket = new AJAXPacket("k506_newsave_obj.jsp","�����ύ�����Ժ�......");	
			myPacket.data.add("BEGIN_TIME",BEGIN_TIME+" "+BEGIN_TIME1);	
			myPacket.data.add("END_TIME",END_TIME+" "+END_TIME1);
			myPacket.data.add("MSG_CONTENT",MSG_CONTENT);
			myPacket.data.add("ACCEPT_NO",<%=ACCEPT_NO%>);
			
			core.ajax.sendPacket(myPacket,doProcess,true);
			myPacket=null;
		}
		function modCfmUP(){
			
			var BEGIN_TIME = document.getElementById("BEGIN_TIME").value;
			var BEGIN_TIME1 = document.getElementById("BEGIN_TIME1").value;
			var END_TIME = document.getElementById("END_TIME").value;
			var END_TIME1 = document.getElementById("END_TIME1").value;
			var MSG_CONTENT = document.getElementById("MSG_CONTENT").value;
			
			var outendtime = document.getElementById("outendtime").value;//�Ժ����Խ���ʱ��
			
			if(BEGIN_TIME == ""){
				
				showTip(document.sitechform.BEGIN_TIME,"��ʼ���ڲ���Ϊ�գ������ѡ�������");
		        sitechform.BEGIN_TIME.focus();
		        return;
			}
			if(BEGIN_TIME1 == ""){
				
				showTip(document.sitechform.BEGIN_TIME1,"��ʼʱ�䲻��Ϊ�գ������ѡ�������");
		        sitechform.BEGIN_TIME1.focus();
		        return;
			}
			if(END_TIME == ""){
				
				showTip(document.sitechform.END_TIME,"�������ڲ���Ϊ�գ������ѡ�������");
		        sitechform.END_TIME.focus();
		        return;
			}
			if(END_TIME1 == ""){
				
				showTip(document.sitechform.END_TIME1,"����ʱ�䲻��Ϊ�գ������ѡ�������");
		        sitechform.END_TIME1.focus();
		        return;
			}

			if((BEGIN_TIME+BEGIN_TIME1)>=(END_TIME+END_TIME)){
				
				showTip(document.sitechform.END_TIME,"�������ڲ���С�ڻ���ڿ�ʼ���ڣ������ѡ�������");
		    
		        sitechform.END_TIME.focus();
		        return;
			}
			
			//if((BEGIN_TIME+BEGIN_TIME1)<=outendtime){
			//	if(rdShowConfirmDialog("�޸ĵ�����ʱ���ԭ������ʱ���ص������Ƿ�������",2) != 1){
			//		document.getElementById("innerH").style.display="";
			//		return;
			//	}
				//else{
					
				//}
				//showTip(document.sitechform.BEGIN_TIME,"�½����Ժ�ԭ������ʱ���ص���ԭ�����Խ���ʱ��Ϊ"+outendtime+"�������ѡ�������");
		    
		      //  sitechform.END_TIME.focus();
		        //return;
			//}
			
			if(MSG_CONTENT == ""){
				
				showTip(document.sitechform.MSG_CONTENT,"�������ݲ���Ϊ�գ������ѡ�������");
		        sitechform.MSG_CONTENT.focus();
		        return;
			}
			
			var myPacket = new AJAXPacket("k506_editsave_obj.jsp","�����ύ�����Ժ�......");	
			myPacket.data.add("BEGIN_TIME",BEGIN_TIME+" "+BEGIN_TIME1);	
			myPacket.data.add("MSG_CONTENT",MSG_CONTENT);
			myPacket.data.add("END_TIME",END_TIME+" "+END_TIME1);
			myPacket.data.add("SERIAL_NO",<%=SERIAL_NO%>);
			
			core.ajax.sendPacket(myPacket,doProcess,true);
			myPacket=null;
		}
		function doProcess(myPacket)
		{
		
		  var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
			if(retCode=="000000"){
				
				rdShowMessageDialog("�ɹ�",2);
				window.dialogArguments.submitMe('1');
			    window.close();
			}else{
				
				rdShowMessageDialog("ʧ��",0);
				return false;
			}
		}	
		</script>
	</head>
	<body>
		<%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
	    	<!-- �������������� -->
	    	<input type="hidden" name="outendtime" value="<%=outEndTime %>" />
		    <div id="Operation_Table">
		    	<table  cellspacing="0">
		    		<tr align="center">
		    			<td>
		    				���ڷ�Χ
		    			</td>
		    			<td>
		    				ʱ�䷶Χ
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    				��ʼ����
		    				<input id="BEGIN_TIME" name ="BEGIN_TIME" type="text"  value="<%=("".equals(BEGIN_TIME))?"":BEGIN_TIME.split(" ")[0]%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',position:{top:'under'}});hiddenTip(document.sitechform.BEGIN_TIME);return false;">
		    				<img onclick="WdatePicker({el:$dp.$('BEGIN_TIME'),dateFmt:'yyyy-MM-dd',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    				<font color="orange">*</font>
		    				
		    			</td>
		    			<td>
		    				��ʼʱ��
		    				<input id="BEGIN_TIME1" name ="BEGIN_TIME1" type="text"  value="<%=("".equals(BEGIN_TIME))?"00:00:00":BEGIN_TIME.split(" ")[1]%>" <!--onclick="WdatePicker({dateFmt:'HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.BEGIN_TIME);return false;"--  >
		    				<!--<img onclick="WdatePicker({el:$dp.$('BEGIN_TIME1'),dateFmt:'HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">-->
		    				<font color="orange">*</font>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    				��������
		    				<input id="END_TIME" name ="END_TIME" type="text"  value="<%=("".equals(END_TIME))?"":END_TIME.split(" ")[0]%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',position:{top:'under'}});hiddenTip(document.sitechform.END_TIME);return false;">
		    				<img onclick="WdatePicker({el:$dp.$('END_TIME'),dateFmt:'yyyy-MM-dd',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    				<font color="orange">*</font>
		    			</td>
		    			<td>
		    				����ʱ��		    				
		    				<input id="END_TIME1" name ="END_TIME1" type="text"  value="<%=("".equals(END_TIME))?"23:59:59":END_TIME.split(" ")[1]%>" <!--onclick="WdatePicker({dateFmt:'HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.BEGIN_TIME);return false;"--  >
		    				<!--<img onclick="WdatePicker({el:$dp.$('END_TIME1'),dateFmt:'HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">-->
		    				<font color="orange">*</font>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="2">
		    				�û�������Ϣ<br>
		    				<textarea rows="10" cols="80" name="MSG_CONTENT" id="MSG_CONTENT"><%=MSG_CONTENT %></textarea>
		    			</td>
		    		</tr>
		    		<tr id="innerH" style="display:none ">
		    			<td colspan="2">
		    				<font color="orange">���������Ե�ʱ�䷶Χ����ʼʱ��<%=outBeginTime %>-----����ʱ��<%=outEndTime %></font>
		    			</td>
		    		</tr>
		    	</table>
		    	<br/>
				 <div id="" align="right">
				     <input type="<%=strINType %>" name="cfm" class="b_foot" value="ȷ��" onclick="modCfm();"/>
				     <input type="<%=strUPType %>" name="cfm" class="b_foot" value="ȷ��" onclick="modCfmUP();"/>
					 <input type="button" name="clo" class="b_foot" value="�ر�" onclick="javascript:window.close();"/>
				 </div>
		    </div>
		</form>
	    <%@ include file="/npage/include/footer.jsp"%>
	</body>	
</html>