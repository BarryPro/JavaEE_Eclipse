   
<%
/********************
 功能: 获取用户的sm_code
 version v2.0
 开发商 si-tech
 update huangrong@2011-2-25
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
String orgCode =(String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String phoneNo = request.getParameter("phoneNo");
String smCodeSql="select sm_code from dcustmsg where phone_no='"+phoneNo+"'";
System.out.println("----------------------smCodeSql--------------------"+smCodeSql);
String smCode="";
%>

	 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
    <wtc:sql><%=smCodeSql%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="smCodeStr" scope="end"/>	
<%         
	if(retCode2.equals("0") || retCode2.equals("000000"))
	{
		if(smCodeStr.length>0)
		{
			smCode = smCodeStr[0][0];
			System.out.println("smCode======="+smCode);
		}
	
 	}	
%>
var response = new AJAXPacket();
var smCode = "<%=smCode%>";
response.data.add("smCode","<%=smCode%>");
core.ajax.receivePacket(response);