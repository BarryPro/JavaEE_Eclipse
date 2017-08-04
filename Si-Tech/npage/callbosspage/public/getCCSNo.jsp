<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
   String localIp= request.getParameter("localIp");
   String sql="select to_char(count(*)) count from dcrmcallcfg a where 1=1 and substr(agent_ip,0,INSTR(agent_ip ,'.', 1, 3)-1)= substr(:vlocalIp ,0,INSTR(:vvlocalIp ,'.', 1, 3)-1)";
   myParams="vlocalIp="+localIp+",vvlocalIp="+localIp ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
<wtc:array id="row" scope="end"/>
<%
   int rowCountNo = Integer.parseInt(row[0][0]);	
%>
var response = new AJAXPacket();
response.data.add("rowCountNo","<%=rowCountNo%>");
core.ajax.receivePacket(response);

	