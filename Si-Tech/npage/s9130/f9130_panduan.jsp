<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="sitech.www.frame.jdbc.SqlQuery" %>
<%@ page import="java.util.Vector" %>

<%
	String phone_no=request.getParameter("phone_no");

	List proList =new ArrayList();
	proList=SqlQuery.findList("select id_no from dcustmsg where phone_no='"+phone_no+"'");

	if(proList.size()>0)
	{
		String[] temp=(String[])proList.get(0);
		out.print("#"+temp[0].trim()+"#");

	}


%>