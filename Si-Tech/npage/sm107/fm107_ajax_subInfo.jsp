<%
    /*************************************
    * 功  能:   成员叠加包订购 m107
    * 版  本:   version v1.0
    * 开发商:   si-tech
    * 创建时间: 2014-4-20
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String loginNo= (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String relationID = WtcUtil.repStr(request.getParameter("relationID"), "");
	String suitID = WtcUtil.repStr(request.getParameter("suitID"), "");
	String memberNoList = WtcUtil.repStr(request.getParameter("memberNoList"), "");
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
	
<wtc:service name="sm107Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/> 
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=password%>"/> 
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=relationID%>"/>
	<wtc:param value="<%=suitID%>"/>
  <wtc:param value="<%=memberNoList%>"/>
</wtc:service>
<wtc:array id="serverResult"  scope="end"/>

var retArray = new Array();//定义返回数组
var liangStr="";

<%
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
%> 

var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
response.data.add("retArray", retArray);
core.ajax.receivePacket(response);
