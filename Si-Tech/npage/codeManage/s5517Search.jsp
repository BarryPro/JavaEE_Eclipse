   
<%
/********************
 version v2.0
 ������ si-tech
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
		ret_msg = "�˹���["+login_no+"]�����ڣ�";
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
			ret_msg = "����["+login_no+"]������["+op_code+"]ִ��Ȩ��";
		}else{
			errcode = "2";
			ret_msg = "����["+login_no+"]�Ѿ���["+op_code+"]ִ��Ȩ��";
		}
	}
%>

var response = new AJAXPacket();
response.data.add("errcode","<%=errcode%>");
response.data.add("ret_msg","<%=ret_msg%>");

core.ajax.receivePacket(response);