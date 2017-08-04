<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page contentType="text/html;charset=gb2312" %>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");	
			
	String change_flag="N";
	String depend_flag="N";
	String limit_flag ="N";
	 
	String errCode="";
    String errMsg="";
    String paramsIn[] = new String[4];
    paramsIn[0] = workNo;				//工号
    paramsIn[1] = nopass;				//密码
    paramsIn[2] = "5238";				//OP_CODE
    paramsIn[3] = login_accept;			//操作流水

//	acceptList = impl.callFXService("s5238_5Int",paramsIn,"12");
%>

    <wtc:service name="s5238_5Int" outnum="12" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />	
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />		
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />

<%	
	errCode=code;
	errMsg=msg;
	
    change_flag= result_t[0][0];
	depend_flag= result_t[0][1];
	limit_flag = result_t[0][2];	
	
	
	System.out.println("------------change_flag---------------"+change_flag);
	System.out.println("------------depend_flag---------------"+depend_flag);
	System.out.println("------------limit_flag---------------"+limit_flag);
	System.out.println("------------errCode---------------"+errCode);
	System.out.println("------------errMsg---------------"+errMsg);
%>

var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("change_flag","<%=change_flag%>");
response.data.add("depend_flag","<%=depend_flag%>");
response.data.add("limit_flag","<%=limit_flag%>");
core.ajax.receivePacket(response);

