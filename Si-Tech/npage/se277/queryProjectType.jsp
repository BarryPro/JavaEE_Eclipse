<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
System.out.println("12344444-------------");
   //得到输入参数
	String sale_project_code = WtcUtil.repStr(request.getParameter("sale_project_code")," ");
    String regionCode = (String)session.getAttribute("regCode");
    String retType = WtcUtil.repStr(request.getParameter("retType")," ");
	String errorCode="";
	String sqlStr1 = "";
	String errorMsg="";
	sqlStr1="select project_type from sprojectcode where region_code='"+regionCode+"' and sale_project_code="+sale_project_code;
	System.out.println("sqlStr1="+sqlStr1);
	System.out.println("调用服务sPubSelect in queryimei.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@="+sqlStr1);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retResult" retmsg="retMsg" outnum="1">
	<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />

<%
	if(retResult.equals("0")||retResult.equals("000000"))
	{
          System.out.println("调用服务sPubSelect in queryimei.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@="+sqlStr1);
 		  retResult = (result1[0][0]).trim();
 		  System.out.println("============"+retResult);
 		  errorCode="000000";
 		  errorMsg ="查询成功";
 	}
 	else
 	{
 		errorCode = "999999";
 		errorMsg = "查询失败";
		System.out.println("调用服务sPubSelect in queryimei.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	}


	System.out.println("&&&&&&&&&&&&  retResult="+retResult);
	System.out.println("&&&&&&&&&&&&  retType="+retType);
	System.out.println("&&&&&&&&&&&&  errorCode="+errorCode);
%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var retType = "<%=retType%>";
var errorCode ="<%=errorCode%>";
var errorMsg ="<%=errorMsg%>";

response.data.add("retType","<%= retType %>");
response.data.add("retResult","<%=retResult%>");
response.data.add("errorCode","<%=errorCode%>");
response.data.add("errorMsg","<%=errorMsg%>");

core.ajax.receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>



