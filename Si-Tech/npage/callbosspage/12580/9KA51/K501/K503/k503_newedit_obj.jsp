
<%
	 /*
	 * ����: 12580ԤԼ����
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>

<%! 
  public  String getCurrDateStr(String str) {
	java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");
	return objSimpleDateFormat.format(new java.util.Date())+" "+str;
  }

  public String[] getTimeStr(String str){
  	int sum = Integer.parseInt(str);
  	int hours;
  	int minutes;
  	int seconds;
  	hours = sum/3600;
  	sum = sum%3600;
  	minutes = sum/60;
  	seconds = sum%60;
  	
  	return new String[]{hours+"",minutes+"",seconds+""};
  }
%>

<%
  
  String opCode = "K503";
  String opName = "ԤԼ����";
  
  String loginNo = (String) session.getAttribute("workNo");
  String orgCode = (String) session.getAttribute("orgCode");
  String kf_longin_no = (String) session.getAttribute("kfWorkNo");
  String ACCEPT_NO = request.getParameter("ACCEPT_NO");
  String SERIAL_NO = request.getParameter("SERIAL_NO");
  
  String strINType = "button";
  String strUPType = "hidden";
  
  String PRE_TIME = "";
  String MSG_CONTENT = "";
  String TARGET_PHONE_NO = "";
  String TIMES = "";
  String INTERV_TIME = "";
  String Hours = "";
  String Minutes = "";
  String Seconds = "";
  String TIMES_FLAG = "";
  
  if(SERIAL_NO==null||"".equals(SERIAL_NO)){
  
  }else{

  strINType = "hidden";
  strUPType = "button";
  String sSql = "select PRE_TIME,MSG_CONTENT,TARGET_PHONE_NO,TIMES,INTERV_TIME,TIMES_FLAG,ACCEPT_NO from DPRESERVICE where PRE_TYPE ='1' and SERIAL_NO = '"+SERIAL_NO+"'";
%> 

<wtc:service name="s151Select" outnum="8">
	<wtc:param value="<%=sSql%>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />

<% 

  if(queryList.length>0){
  	
  	PRE_TIME =(queryList[0][0].length() != 0) ? queryList[0][0]: "";
  	MSG_CONTENT =(queryList[0][1].length() != 0) ? queryList[0][1]: "";
  	TARGET_PHONE_NO =(queryList[0][2].length() != 0) ? queryList[0][2]: "";
  	TIMES =(queryList[0][3].length() != 0) ? queryList[0][3]: "";
  	INTERV_TIME =(queryList[0][4].length() != 0) ? queryList[0][4]: "";
  	TIMES_FLAG =(queryList[0][5].length() != 0) ? queryList[0][5]: "";
  	ACCEPT_NO = (queryList[0][6].length() != 0) ? queryList[0][6]: "";
  }
  
  if(!"".equals(INTERV_TIME)){
  	String Time[] = getTimeStr(INTERV_TIME);
  	
  	Hours = Time[0];
  	Minutes = Time[1];
  	Seconds = Time[2];
  }
  }
%>


<html>
	<head>
		<title>ԤԼ����</title>
		<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
		<script language=javascript>
		function modCfm(){
			
			var PRE_TIME = document.getElementById("PRE_TIME").value;
			var MSG_CONTENT = document.getElementById("MSG_CONTENT").value;
			var TARGET_PHONE_NO = document.getElementById("TARGET_PHONE_NO").value;
			var Hours = document.getElementById("Hours").value;
			var Minutes = document.getElementById("Minutes").value;
			var Seconds = document.getElementById("Seconds").value;
			var TIMES_FLAG = document.getElementById("TIMES_FLAG").value;
			var TIMES = document.getElementById("TIMES").value;
			
			if(Hours ==""&&Minutes ==""&&Seconds==""){
				
				rdShowMessageDialog("���ʱ�䲻��Ϊ�գ�",0);
				return;
			}
			if(Hours =="0"&&Minutes =="0"&&Seconds=="0"){
				
				rdShowMessageDialog("���ʱ�䲻��Ϊ0��",0);
				return;
			}
			if(PRE_TIME == ""){
				
				showTip(document.sitechform.PRE_TIME,"ԤԼʱ�䲻��Ϊ�գ������ѡ�������");
		        sitechform.PRE_TIME.focus();
		        return;
			}
			if(MSG_CONTENT == ""){
				
				showTip(document.sitechform.MSG_CONTENT,"ԤԼ���ݲ���Ϊ�գ������ѡ�������");
		        sitechform.MSG_CONTENT.focus();
		        return;
			}
			if(TARGET_PHONE_NO == ""){
				
				showTip(document.sitechform.TARGET_PHONE_NO,"Ŀ����벻��Ϊ�գ������ѡ�������");
		        sitechform.TARGET_PHONE_NO.focus();
		        return;
			}
			
			var myPacket = new AJAXPacket("k503_newsave_obj.jsp","�����ύ�����Ժ�......");	
			myPacket.data.add("PRE_TIME",PRE_TIME);	
			myPacket.data.add("MSG_CONTENT",MSG_CONTENT);
			myPacket.data.add("TARGET_PHONE_NO",TARGET_PHONE_NO);
			myPacket.data.add("Hours",Hours);
			myPacket.data.add("Minutes",Minutes);
			myPacket.data.add("Seconds",Seconds);
			myPacket.data.add("TIMES_FLAG",TIMES_FLAG);
			myPacket.data.add("TIMES",TIMES);
			myPacket.data.add("ACCEPT_NO",<%=ACCEPT_NO%>);
			
			core.ajax.sendPacket(myPacket,doProcess);
			myPacket=null;	
		}
		function modCfmUP(){
			
			var PRE_TIME = document.getElementById("PRE_TIME").value;
			var MSG_CONTENT = document.getElementById("MSG_CONTENT").value;
			var TARGET_PHONE_NO = document.getElementById("TARGET_PHONE_NO").value;
			var Hours = document.getElementById("Hours").value;
			var Minutes = document.getElementById("Minutes").value;
			var Seconds = document.getElementById("Seconds").value;
			var TIMES_FLAG = document.getElementById("TIMES_FLAG").value;
			var TIMES = document.getElementById("TIMES").value;
			
			if(Hours ==""&&Minutes ==""&&Seconds==""){
				
				rdShowMessageDialog("���ʱ�䲻��Ϊ�գ�",0);
				return;
			}
			if(Hours =="0"&&Minutes =="0"&&Seconds=="0"){
				
				rdShowMessageDialog("���ʱ�䲻��Ϊ0��",0);
				return;
			}
			if(PRE_TIME == ""){
				
				showTip(document.sitechform.PRE_TIME,"ԤԼʱ�䲻��Ϊ�գ������ѡ�������");
		        sitechform.PRE_TIME.focus();
		        return;
			}
			if(MSG_CONTENT == ""){
				
				showTip(document.sitechform.MSG_CONTENT,"ԤԼ���ݲ���Ϊ�գ������ѡ�������");
		        sitechform.MSG_CONTENT.focus();
		        return;
			}
			if(TARGET_PHONE_NO == ""){
				
				showTip(document.sitechform.TARGET_PHONE_NO,"Ŀ����벻��Ϊ�գ������ѡ�������");
		        sitechform.TARGET_PHONE_NO.focus();
		        return;
			}
			
			var myPacket = new AJAXPacket("k503_editsave_obj.jsp","�����ύ�����Ժ�......");	
			myPacket.data.add("PRE_TIME",PRE_TIME);	
			myPacket.data.add("MSG_CONTENT",MSG_CONTENT);
			myPacket.data.add("TARGET_PHONE_NO",TARGET_PHONE_NO);
			myPacket.data.add("Hours",Hours);
			myPacket.data.add("Minutes",Minutes);
			myPacket.data.add("Seconds",Seconds);
			myPacket.data.add("TIMES_FLAG",TIMES_FLAG);
			myPacket.data.add("TIMES",TIMES);
			myPacket.data.add("SERIAL_NO",<%=SERIAL_NO%>);
			
			core.ajax.sendPacket(myPacket,doProcess);
			myPacket=null;
		}
		function doProcess(myPacket)
		{
		
		    var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
			if(retCode=="000000"){
				//alert("����ɹ�");
				rdShowMessageDialog("�ɹ�",2);
				window.dialogArguments.submitMe('1');
			    window.close();
			}else{
				//alert("����ʧ��!");
				rdShowMessageDialog("ʧ��",0);
				return false;
			}
		}
		
		</script>
	</head>
	<body>
		<%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
		    <div id="Operation_Table">
		    	<table  cellspacing="0">
		    		<tr>
		    			<td nowrap="nowrap">
		    				Լ��ʱ�䰲��
		    			</td>
		    			<td nowrap="nowrap">
		    				<input id="PRE_TIME" name ="PRE_TIME" type="text"  value="<%=("".equals(PRE_TIME))?getCurrDateStr("00:00:00"):PRE_TIME%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.PRE_TIME);return false;">
		    				<img onclick="WdatePicker({el:$dp.$('PRE_TIME'),dateFmt:'yyyy-MM-dd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    				<font color="orange">*</font>
		    			</td >
		    			<td rowspan="5">
		    				ԤԼ����
		    				<div>
		    					<textarea rows="18" cols="50" name="MSG_CONTENT" id="MSG_CONTENT"><%=MSG_CONTENT %></textarea>
		    				</div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td nowrap="nowrap">
		    				Ŀ�����
		    			</td>
		    			<td nowrap="nowrap">
		    				<input id="TARGET_PHONE_NO" name="TARGET_PHONE_NO" value="<%=TARGET_PHONE_NO %>" type="text">
		    				<font color="orange">*</font>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td nowrap="nowrap">
		    				���Ѵ���
		    			</td>
		    			<td nowrap="nowrap">
		    				<select id="TIMES" name="TIMES" style="width: 10mm;">
		    				<%for(int i =1;i<21;i++){%>
								<option value="<%=i %>" <%if((""+i).equals(TIMES)){%>selected="selected"<%}%>><%=i %></option>
							<%} %>
		    				</select>
		    				
		    			</td>
		    		</tr>
		    		<tr>
		    			<td nowrap="nowrap">
		    				���ʱ��
		    			</td>
		    			<td nowrap="nowrap">
		    				<input id="INTERV_TIME" name="INTERV_TIME" value="<%=INTERV_TIME %>" type="hidden">
		    				<input id="Hours" name="Hours" value="<%=Hours %>" type="text" size="4">Сʱ&nbsp;
		    				<input id="Minutes" name="Minutes" value="<%=Minutes %>" type="text" size="4">����&nbsp;
		    				<input id="Seconds" name="Seconds" value="<%=Seconds %>" type="text" size="4">��&nbsp;
		    				<font color="orange">*</font>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td nowrap="nowrap">
		    				ִ��ѡ��
		    			</td>
		    			<td nowrap="nowrap">
		    				<input id="TIMES_FLAG" name="TIMES_FLAG" type="radio" value="Y" checked="checked">ִ��ָ�������Ѵ���
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