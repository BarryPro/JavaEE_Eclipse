   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>


<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>

<%	
	//读取用户session信息
	String regionCode = (String)session.getAttribute("regCode");

	String role_code_parter = request.getParameter("role_code_parter");
	String retType = request.getParameter("retType");
	
  String sqlStr="";
	sqlStr ="select max(trim(power_code)) from spowercodemop where  length(trim(power_code))=(length(trim('"+role_code_parter+"'))+2) and power_code like '"+role_code_parter+"%' ";
	//retList = impl.sPubSelect("1",sqlStr,"region",regionCode);
	
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%	
	String[][] maxRoleCode = result_t;
	String maxR =maxRoleCode[0][0];
	int errCode=0;
	String errMsg="success";
	if (maxRoleCode != null)
	{
		if (maxRoleCode[0][0].equals("")) 
		{
			maxRoleCode =null;
			errCode =-1;
			errMsg="取角色代码错误！";
		}
	}
	
	if (errCode == -1)
	{
		
		maxR = role_code_parter +"00";

				errCode=0;
				 errMsg="success";

	}
	
%>

var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("retType","<%=retType%>");
response.data.add("role_code","<%=maxR%>");
core.ajax.receivePacket(response);