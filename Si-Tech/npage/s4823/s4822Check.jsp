<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  
"http://www.w3.org/TR/html4/loose.dtd">   
   
<html>   
  <head>   
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>   
    <title>checkUser</title>   
  </head>   
<body>  
  	
<%
	String phone_no =(String)request.getParameter("phone_no");  
	String action_id=(String)request.getParameter("action_id");
	//String action_id="2008110511";
	String sql_busi_code="select commend_busi_code,commend_busi_type from dbsalesadm.dFndActCommendRel where action_id ='"+action_id+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sql_busi_code%></wtc:sql>
</wtc:pubselect>
<wtc:array id="param_busi" scope="end"/>
<%
	String sql_busi_tablename="select business_table from dbsalesadm.sFndIsBusiness where commend_busi_type = '?' ";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sql_busi_tablename%></wtc:sql>
	<wtc:param value="<%=param_busi[0][1]%>"/>
	<wtc:sql><%=sql_busi_tablename%></wtc:sql>
	<wtc:param value="<%=param_busi[0][1]%>" />
</wtc:pubselect>
<wtc:array id="param_business_table" scope="end"/>	
<%
	String sql_id_no="select id_no from dbcustadm.Dcustmsg where phone_no ='"+phone_no+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sql_id_no%></wtc:sql>
</wtc:pubselect>
<wtc:array id="param_id_no" scope="end"/>
<% 
		 String busi_type=param_busi[0][1];
		 String tablename = param_business_table[0][0];
		 String flag="0";
%>

<%
	if("1".equals(busi_type))
	{
		String sql_check1 ="select id_no from "+tablename+" where id_no ='?' and function_code ='?' ";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sql_check1%></wtc:sql>
		<wtc:param value="<%=param_id_no[0][0]%>"/>
			<wtc:param value="<%=param_busi[0][0]%>"/>
</wtc:pubselect>
<wtc:array id="param_check1" scope="end"/>
<%
	if(param_check1.length!=0){flag="1";}
	}else if("2".equals(busi_type))
		{ String sql_check2 = "select id_no from "+tablename+" where id_no ='?' and mode_code ='?' and mode_flag=0 and mode_time='Y' and sysdate between begin_time and end_time";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sql_check2%></wtc:sql>
		<wtc:param value="<%=param_id_no[0][0]%>"/>
			<wtc:param value="<%=param_busi[0][0]%>"/>
</wtc:pubselect>
<wtc:array id="param_check2" scope="end"/>
<%
	if(param_check2.length!=0){flag="1";}
	}else if("3".equals(busi_type))
		{String sql_check3="select spbizcode from "+tablename+" where idvalue ='?' and trim(spbizcode) ='?' and oprcode='06' ";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sql_check3%></wtc:sql>
		<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=param_busi[0][0]%>"/>
</wtc:pubselect>
<wtc:array id="param_check3" scope="end"/>
<%
	if(param_check3.length!=0){flag="1";}
}

out.print(flag);
%>	
	 
  </body>   
</html>  
