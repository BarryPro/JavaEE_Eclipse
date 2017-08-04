<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>


<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
	System.out.println("-----------------------------here------------------");
	String func_code = request.getParameter("func_code");     
	String rpcType = request.getParameter("rpcType");     

  String errCode="-1";
  String errMsg="此映射代码系统中已存在！";
  
  
  String sqlStr = "select reflect_code from sPopeDomCode where reflect_code =  '"+func_code+"'";
 	//retList = impl.sPubSelect("1",sqlStr); 	
 	String regionCode = (String)session.getAttribute("regCode");
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<% 	
 	String[][] retArry = result_t;		
 	
 	if (retArry != null)
	{
		if (code.equals("000000")) 
		{
			retArry = null;
		}
	}	
		
	if(retArry==null)
	{
		errCode="0";
		errMsg="验证通过!";
	}
		
%>
var response = new AJAXPacket();

response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("rpcType","<%=rpcType%>");

core.ajax.receivePacket(response);