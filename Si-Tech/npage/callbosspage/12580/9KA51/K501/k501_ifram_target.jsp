<%
  /*
   * ����: Ŀ���û���Ϣ
�� * �汾: 1.0.0
�� * ����: 2009/01/07
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>


<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<html>
  <head>
  		<title>Ŀ���û���Ϣ</title>
  		<link
			href="<%=request.getContextPath()%>/nresources/default/css/FormText.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/font_color.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css"
			rel="stylesheet" type="text/css"></link>
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
  	<style type="text/css">
			body{
			font-size:12px;
			}
			.style1 {
				font-family: Geneva, Arial, Helvetica, sans-serif;
				color: #0033FF;
				font-size: 16px;
				font-weight: bold;
			}
		</style>
  </head>
  <%
  //chengh�ж�ÿ��Ŀ������Ƿ�ͨ�������
    String phone_arr []={};
  	String phone_no = "";
  %>
  <body> 	
  	
  	<%
  	//chengh20090428��ʼ�ж�Ŀ������Ƿ�ͨ�������
  	if( request.getParameter("rphone") != null&&!request.getParameter("rphone").equals("")&&!request.getParameter("rphone").equals("null")){
  		phone_no = (String) request.getParameter("rphone");
  		phone_arr = phone_no.split(" ");
  	  for(int i=0;i<phone_arr.length;i++){
  	  	 
  	     String ynHasSql = "select to_char(count(*)) from dsrvmsg where id_no=(select id_no from dcustmsg where phone_no='"+phone_arr[i]+"') and service_code='tf32'";
  	     String ynAvaSql = "select to_char(count(*)) from dsrvmsg where id_no=(select id_no from dcustmsg where phone_no='"+phone_arr[i]+"') and service_code='tf32' and begin_time<=to_char(sysdate-1,'yyyy-mm-dd hh24:mi:mm') and end_time>=to_char(sysdate-1,'yyyy-mm-dd hh24:mi:mm')";
  	%>
  	<wtc:service name="sPubSelect" outnum="1">
			<wtc:param value="<%=ynAvaSql %>" />
		</wtc:service>
		<wtc:array id="queryList" start="0" length="1" scope="end" />
		<%
		String[][] dataRows = new String[][] {};
		dataRows = queryList;
		if(dataRows[0][0] != null && !"0".equals(dataRows[0][0])){
			out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;���� "+phone_arr[i]+" �ѿ�ͨ�ƶ������������Ч��");
		}else{
		%>
			<wtc:service name="sPubSelect" outnum="1">
				<wtc:param value="<%=ynHasSql %>" />
			</wtc:service>
			<wtc:array id="queryList" start="0" length="1" scope="end" />
			<%
			dataRows = queryList;
			if(dataRows[0][0] != null && !"0".equals(dataRows[0][0])){
				out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;���� <font color='green'>"+phone_arr[i]+"</font> �ѿ�ͨ�ƶ����������ʧЧ��");
			}else{
				out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;���� <font color='green'>"+phone_arr[i]+"</font> ��δ��ͨ�ƶ��������");
			}
		}

		%>
	
		<%
						String lwSql = "select max(serial_no) from DTAKEMSG where msg_type = '1' and accept_no = '"+phone_arr[i]+"' and begin_time <= sysdate and end_time >= sysdate";
						
						%>
						<wtc:service name="s151Select" outnum="1">
								<wtc:param value="<%=lwSql %>" />
						</wtc:service>
						<wtc:array id="lwList" start="0" length="1" scope="end" />
						<%
							dataRows = lwList;
							if(dataRows[0][0] != null){
							String lwSqlv = "select msg_content,to_char(begin_time,'yyyy-MM-dd'),to_char(end_time,'yyyy-MM-dd'),to_char(begin_time,'HH24:mi:ss'),to_char(end_time,'HH24:mi:ss') from DTAKEMSG where serial_no = '"+dataRows[0][0]+"'";
						%>
						<wtc:service name="s151Select" outnum="5">
								<wtc:param value="<%=lwSqlv %>" />
						</wtc:service>
						<wtc:array id="lwListv" start="0" length="5" scope="end" />
						<%
								dataRows = lwListv;
								if(dataRows.length > 0){
									out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;���������ԣ���������Ϊ:<font color='red'>"+dataRows[0][0]+"</font>");
									out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;�������ڷ�Χ:"+dataRows[0][1]+"~"+dataRows[0][2]+"");
									out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;ÿ�������ʱ��:"+dataRows[0][3]+"~"+dataRows[0][4]+"");
								}else{
									out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;��δ��������");
								}			
							}else{
								out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;��δ��������");
							}	
							out.println("<br/>");
					
				}	
			}else{
				out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;��Ŀ���û������к���");
			}			
						%>
  </body>
</html>
