
<%
	 /*
	 * ����: 12580ԤԼ����
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:chengh 
	 */
	 
%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
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
  
  String ACCEPT_NO = request.getParameter("ACCEPT_NO");//Ŀ�����
  String SERIAL_NO = request.getParameter("SERIAL_NO");
  
  String strINType = "button";
  String strUPType = "hidden";
  
  String PRE_TIME = "";
  String MSG_CONTENT = "";
  String TARGET_PHONE_NO = "";
  String TIMES = "";
  String INTERV_TIME = "";
	String flagdiabled = "";
  String TIMES_FLAG = "";
  
  if(SERIAL_NO==null||"".equals(SERIAL_NO)){
  
  }else{
	flagdiabled = "disabled";
  strINType = "hidden";
  strUPType = "button";
  String sSql = "select to_char(PRE_TIME,'yyyy-MM-dd HH:mi:ss'),MSG_CONTENT,TARGET_PHONE_NO,TIMES,INTERV_TIME,TIMES_FLAG,ACCEPT_NO from DPRESERVICE where PRE_TYPE ='1' and SERIAL_NO = '"+SERIAL_NO+"'";
	
	String tSql = "select interval from DPRESERVICETIME where serial_no = '"+SERIAL_NO+"' order by order_no";
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
%>

<wtc:service name="s151Select" outnum="2">
	<wtc:param value="<%=tSql %>" />
</wtc:service>
<wtc:array id="tqryList" scope="end" />

<%
	if(tqryList.length > 0){
  	
  	for(int i = 0; i < tqryList.length; i++){
  		
  		INTERV_TIME += ((tqryList[i][0].length() != 0) ? tqryList[i][0]:"")+";";
  		
  	}
  }
  
  }
%>


<html>
	<head>
		<title>ԤԼ����</title>
		<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language=javascript>
		function modCfm(){
			//chengh ��ȡ��ǰʱ��
			var now_Time = new Date();
			var PRE_TIME = document.getElementById("PRE_TIME").value;
			var MSG_CONTENT = document.getElementById("MSG_CONTENT").value;
			var TARGET_PHONE_NO = document.getElementById("TARGET_PHONE_NO").value;
			var INTERV_TIME = document.getElementById("INTERV_TIME").value;
			var TIMES_FLAG = document.getElementById("TIMES_FLAG").value;
			var TIMES = document.getElementById("TIMES").value;
			var arr_now_Time = now_Time.getTime();
			if(!f_check_mobile(TARGET_PHONE_NO)){
				rdShowMessageDialog("Ŀ������ʽ����ȷ��",0);
				return;
			}

			if(INTERV_TIME == ""){
				
				rdShowMessageDialog("���ʱ��û�����ã�",0);
				return;
			}
			
			if(PRE_TIME == ""){
				
				showTip(document.sitechform.PRE_TIME,"ԤԼʱ�䲻��Ϊ�գ������ѡ�������");
		        sitechform.PRE_TIME.focus();
		        return;
			}
			//chengh ��YYYY-MM-DD hh:mm:ssת����ʱ���ʽ
			var get_Date=new Date(PRE_TIME.replace(/\-/g,"\/"));
			var arr_PRE_TIME = get_Date.getTime();
			if(arr_PRE_TIME<arr_now_Time){
				showTip(document.sitechform.PRE_TIME,"ԤԼʱ�䲻��С������ʱ��");
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
			myPacket.data.add("PRE_TIME",PRE_TIME);//ԤԼʱ��
			myPacket.data.add("MSG_CONTENT",MSG_CONTENT);//ԤԼ����
			myPacket.data.add("TARGET_PHONE_NO",TARGET_PHONE_NO);//Ŀ�����
			myPacket.data.add("INTERV_TIME",INTERV_TIME);//ʱ����ֵ �磺10;15;10;5;
			myPacket.data.add("TIMES_FLAG",TIMES_FLAG);//�Ƿ��������
			myPacket.data.add("TIMES",TIMES);//���Ѵ���
			myPacket.data.add("ACCEPT_NO",<%=ACCEPT_NO%>);//������ϢԴ��ַ
			
			core.ajax.sendPacket(myPacket,doProcess,true);
			
			myPacket=null;	
		}
		function modCfmUP(){
			
			var PRE_TIME = document.getElementById("PRE_TIME").value;
			var MSG_CONTENT = document.getElementById("MSG_CONTENT").value;
			var TARGET_PHONE_NO = document.getElementById("TARGET_PHONE_NO").value;
			var INTERV_TIME = document.getElementById("INTERV_TIME").value;
			
			var TIMES_FLAG = document.getElementById("TIMES_FLAG").value;
			var TIMES = document.getElementById("TIMES").value;
			
			if(!f_check_mobile(TARGET_PHONE_NO)){
				rdShowMessageDialog("Ŀ������ʽ����ȷ��",0);
				return;
			}
			
			if(INTERV_TIME == ""){
				
				rdShowMessageDialog("���ʱ��δ���ã�",0);
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
			myPacket.data.add("PRE_TIME",PRE_TIME);	//ԤԼʱ��
			myPacket.data.add("MSG_CONTENT",MSG_CONTENT);//ԤԼ����
			myPacket.data.add("TARGET_PHONE_NO",TARGET_PHONE_NO);//Ŀ�����
			myPacket.data.add("INTERV_TIME",INTERV_TIME);//ʱ����ֵ �磺10;15;10;5;
			
			myPacket.data.add("TIMES_FLAG",TIMES_FLAG);//�Ƿ��������
			myPacket.data.add("TIMES",TIMES);//���Ѵ���
			myPacket.data.add("SERIAL_NO",<%=SERIAL_NO%>);//ԤԼ������ˮ
			
			core.ajax.sendPacket(myPacket,doProcess,true);
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
		function setSpace(){
			//chengh
			var num = document.sitechform.TIMES.value;
			//var interv_time = document.sitechform.INTERV_TIME.value;
			var interv_time = "";
			for(var i=1;i<=parseInt(num);i++){

				 if(i==1){				 	
				 	 var frist = "0;";
				 	 interv_time=interv_time+frist;
				 }else{
				 	 var other = "5;"
				 	 interv_time=interv_time+other;
				 }
		  }
			var retValue = window.showModalDialog('k503_setup_space.jsp?times='+num+'&interv_time='+interv_time,'','dialogWidth:600px;dialogHeight:400px;center:1');
			if(retValue != undefined){
				document.sitechform.INTERV_TIME.value = retValue;
			}
			if(document.sitechform.INTERV_TIME.value != ""){
				document.getElementById("words").innerText = "�����ù�";
			}
		}
		//�ı����ô�����ʱ����������ʱ����
		function octn(){
			document.sitechform.INTERV_TIME.value = "";
			document.getElementById("words").innerText = "";
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
		    				<input id="PRE_TIME" name ="PRE_TIME" type="text" <%=flagdiabled %> value="<%=("".equals(PRE_TIME))?"":PRE_TIME%>" >
		    				<img onclick="WdatePicker({el:$dp.$('PRE_TIME'),dateFmt:'yyyy-MM-dd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    				<font color="orange">*</font>
		    			</td >
		    			<td rowspan="5">
		    				ԤԼ����
		    				<div>
		    					<textarea rows="10" cols="20" name="MSG_CONTENT" id="MSG_CONTENT"><%=MSG_CONTENT %></textarea>
		    				</div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td nowrap="nowrap">
		    				Ŀ�����
		    			</td>
		    			<td nowrap="nowrap">
		    				<input id="TARGET_PHONE_NO" name="TARGET_PHONE_NO" <%=flagdiabled %> value="<%=TARGET_PHONE_NO==""?ACCEPT_NO:TARGET_PHONE_NO %>" type="text" disabled >
		    				<font color="orange">*</font>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td nowrap="nowrap">
		    				���Ѵ���
		    			</td>
		    			<td nowrap="nowrap">
		    				<select id="TIMES" name="TIMES" onChange="octn();" <%=flagdiabled %> style="width: 10mm;">
		    				<%for(int i =1;i<6;i++){%>
								<option value="<%=i %>" <%if((""+i).equals(TIMES)){%>selected="selected"<%}%>><%=i %></option>
							<%} %>
		    				</select>
		    				ÿ��ʱ����Ĭ��Ϊ5����
		    			</td>
		    		</tr>
		    		<tr>
		    			<td nowrap="nowrap">
		    				���ʱ��&nbsp;<font color="orange" id="words"><% if(INTERV_TIME != "") { out.println("�����ù�");  } %></font>
		    			</td>
		    			<td nowrap="nowrap">
		    				
		    				<input type="button" class="b_foot_long" value="����ʱ����" <%=flagdiabled %> onClick="setSpace();">
		    			<!--	<input id="INTERV_TIME" name="INTERV_TIME" value="<%=INTERV_TIME %>" type="hidden">	-->
		    				<input id="INTERV_TIME" name="INTERV_TIME" value="5" type="hidden">	    				
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