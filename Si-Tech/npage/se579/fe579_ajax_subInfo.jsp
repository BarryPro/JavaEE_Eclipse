<%
    /*************************************
    * 功  能: 营销目标客户变更 e579
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-2-3
    **************************************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("-------e579---ajax页面----------");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String addrUrl = WtcUtil.repStr(request.getParameter("addrUrl"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
	String password=WtcUtil.repNull((String)session.getAttribute("password"));
	String operateNoVal=WtcUtil.repStr(request.getParameter("operateNoVal"), "");
	String note = "";
	String note1 = "营销目标客户添加";
	String note2 = "营销目标客户删除";
	if("0".equals(operateNoVal)){
		note = note1 + phoneNo;
	}else if("1".equals(operateNoVal)){
		note = note2+phoneNo;
  }
	System.out.println("note="+note);
	System.out.println("操作标识="+operateNoVal);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneNo%>" id="printAccept"/>

	<wtc:service name="se579Cfm" routerKey="phone" routerValue="<%=phoneNo%>" 
		retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
	  <wtc:param value="<%=operateNoVal%>"/>
	  <wtc:param value="<%=note%>"/>
	  <wtc:param value="<%=addrUrl%>"/>
	  <wtc:param value="233345"/>
	  <wtc:param value="3221"/>
	  <wtc:param value="0"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
		System.out.println("-----------e579---retCode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
core.ajax.receivePacket(response);

