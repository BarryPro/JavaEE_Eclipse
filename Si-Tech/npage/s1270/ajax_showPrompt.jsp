<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/05/24 liangyl 关于集中优化含数据业务主资费服务内容的开发需求
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>

<% 
	String iChnSource = "01";
	String iOpCode = WtcUtil.repStr(request.getParameter("iOpCode"),"");
	String iLoginNo = (String)session.getAttribute("workNo");
	String iLoginPwd = (String)session.getAttribute("password");
	String iPhoneNo = WtcUtil.repStr(request.getParameter("iPhoneNo"),"");
	String iUserPwd = WtcUtil.repStr(request.getParameter("iUserPwd"),"");
	String iOfferId = WtcUtil.repStr(request.getParameter("iOfferId"),"");
	String regionCode = (String)session.getAttribute("regCode");
	String retResult1="";
	String retResult2="";
  	%>
    	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
    	<wtc:service name="s1270Notice" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4">			
				<wtc:param value="<%=printAccept%>"/>
				<wtc:param value="<%=iChnSource%>"/>	
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iLoginNo%>"/>
				<wtc:param value="<%=iLoginPwd%>"/>
				<wtc:param value="<%=iPhoneNo%>"/>
				<wtc:param value="<%=iUserPwd%>"/>
				<wtc:param value="<%=iOfferId%>"/>
		  </wtc:service>	
			<wtc:array id="resultList"  scope="end"/>
<%
if("000000".equals(retCode)){
	retResult1=resultList[0][1];
	retResult2=resultList[0][3];
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retCode%>");
response.data.add("retResult1","<%=retResult1%>");
response.data.add("retResult2","<%=retResult2%>");
core.ajax.receivePacket(response);