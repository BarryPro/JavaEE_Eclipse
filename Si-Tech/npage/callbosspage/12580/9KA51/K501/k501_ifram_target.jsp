<%
  /*
   * 功能: 目标用户信息
　 * 版本: 1.0.0
　 * 日期: 2009/01/07
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>


<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<html>
  <head>
  		<title>目标用户信息</title>
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
  //chengh判断每个目标号码是否开通秘书服务
    String phone_arr []={};
  	String phone_no = "";
  %>
  <body> 	
  	
  	<%
  	//chengh20090428开始判断目标号码是否开通秘书服务
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
			out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;机主 "+phone_arr[i]+" 已开通移动秘书服务且有效！");
		}else{
		%>
			<wtc:service name="sPubSelect" outnum="1">
				<wtc:param value="<%=ynHasSql %>" />
			</wtc:service>
			<wtc:array id="queryList" start="0" length="1" scope="end" />
			<%
			dataRows = queryList;
			if(dataRows[0][0] != null && !"0".equals(dataRows[0][0])){
				out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;机主 <font color='green'>"+phone_arr[i]+"</font> 已开通移动秘书服务但已失效！");
			}else{
				out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;机主 <font color='green'>"+phone_arr[i]+"</font> 还未开通移动秘书服务！");
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
									out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;已设置留言，留言内容为:<font color='red'>"+dataRows[0][0]+"</font>");
									out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;留言日期范围:"+dataRows[0][1]+"~"+dataRows[0][2]+"");
									out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;每天的留言时间:"+dataRows[0][3]+"~"+dataRows[0][4]+"");
								}else{
									out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;还未设置留言");
								}			
							}else{
								out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;还未设置留言");
							}	
							out.println("<br/>");
					
				}	
			}else{
				out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;无目标用户和主叫号码");
			}			
						%>
  </body>
</html>
