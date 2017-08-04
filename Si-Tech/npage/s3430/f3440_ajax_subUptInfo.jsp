<%
  /*************************************
  * 功  能: APN代码维护 修改提交 3474
  * 版  本: version v1.0
  * 开发商: si-tech
  * 创建者: @ 2012-2-28
  **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
  String loginNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCodeUptHidd = (String)request.getParameter("regionCodeUptHidd");
	String apnCodeUptHidd = (String)request.getParameter("apnCodeUptHidd");
	String v_apn_is_change = (String)request.getParameter("v_apn_is_change");
	
	
	String childNodeStr = (String)request.getParameter("childNodeStr");
	String childs[] = childNodeStr.split("\\|");
	System.out.println("------3440---------childNodeStr="+childNodeStr.trim());
	System.out.println("------3440---------childNodeStr.length="+childNodeStr.trim().length());
	System.out.println("------3440---------regionCodeUptHidd="+regionCodeUptHidd);
		System.out.println("------3440---------apnCodeUptHidd="+apnCodeUptHidd);
	System.out.println("------3440---------childs.length="+childs.length);
	System.out.println("------3440---------childs[0].length="+childs[0].trim().length());
	System.out.println("------3440---------childs[1]="+childs[1]);
	
	System.out.println("------3440--------v_apn_is_change="+v_apn_is_change);
	
	System.out.println("------3440---------childs[2]="+childs[2]);
	System.out.println("------3440---------childs[3]="+childs[3]);
	
	String opNote = "APN代码维护修改提交操作";
	String stripadr=(String)request.getRemoteAddr();
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

   <wtc:service name="s3440Upd" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		  
		<wtc:param value="01"/>
		  
		<wtc:param value="<%=opCode%>"/> 
		  
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		  
		<wtc:param value=""/>
		<wtc:param value=""/>
		  
		<wtc:param value="<%=regionCodeUptHidd%>"/>
		<wtc:param value="<%=apnCodeUptHidd%>"/>
		<wtc:param value="<%=childs[0].trim()%>"/>
    <wtc:param value="<%=childs[1].trim()%>"/>
		<wtc:param value="<%=childs[2].trim()%>"/>
		  
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=stripadr%>"/>
		<wtc:param value="<%=v_apn_is_change%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
	  
var response = new AJAXPacket();
var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
response.data.add("retCode",retCode);
response.data.add("retMsg",retMsg);
core.ajax.receivePacket(response);
  