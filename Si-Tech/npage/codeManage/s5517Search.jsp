   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-15
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%      
    String login_no = request.getParameter("login_no");	
    String op_code = request.getParameter("op_code");
		String regionCode = (String)session.getAttribute("regCode");
		String sql="select 1 from dloginmsg where login_no = '"+ login_no +"'";
		
	//arr2 = callView.view_spubqry32("1",sql);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%	
	String result[][] = result_t;
    
	String errcode;
	String ret_msg;
	
	if (result.length==0){
		errcode = "0";
		ret_msg = "此工号["+login_no+"]不存在！";
	} else{
		sql="select 1 from shighlogin where login_no = '"+ login_no +"' and op_code = '"+op_code+"'";
		//arr2 = callView.view_spubqry32("1",sql);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%		
		result = result_t1;
		if(result.length ==0)
		{
			errcode = "1";
			ret_msg = "工号["+login_no+"]不具有["+op_code+"]执行权限";
		}else{
			errcode = "2";
			ret_msg = "工号["+login_no+"]已具有["+op_code+"]执行权限";
		}
	}
%>

var response = new AJAXPacket();
response.data.add("errcode","<%=errcode%>");
response.data.add("ret_msg","<%=ret_msg%>");

core.ajax.receivePacket(response);