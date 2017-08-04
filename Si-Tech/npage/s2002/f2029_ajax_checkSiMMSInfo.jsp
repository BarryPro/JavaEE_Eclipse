<%
    /*************************************
    * 功  能: 商品订单订购关系管理 校验修改后的SI彩信应用基本接入号 2029 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-5-31
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode = (String)session.getAttribute("regCode");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String loginNo = WtcUtil.repStr(request.getParameter("loginNo"), "");
	String password = WtcUtil.repStr(request.getParameter("password"), "");
	String groupId = (String)session.getAttribute("groupId");
	String vSiMMSInfo = WtcUtil.repStr(request.getParameter("vSiMMSInfo"), "");//验证号码
	
	System.out.println("--------------2029---------vSiMMSInfo="+vSiMMSInfo);
	System.out.println("--------------2029---------regCode="+regCode);
	System.out.println("--------------2029---------groupId="+groupId);
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
    
  <wtc:service name="sPubProcCfmNew" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
  	<wtc:param value="<%=printAccept%>"/>
  	<wtc:param value="01"/>
  	<wtc:param value="<%=opCode%>"/> 
  	<wtc:param value="<%=loginNo%>"/>
  	<wtc:param value="<%=password%>"/> 
  	<wtc:param value=""/>
  	<wtc:param value=""/>
  	<wtc:param value="<%=vSiMMSInfo%>"/>
  	<wtc:param value="<%=regCode%>"/>
  	<wtc:param value="G0003"/> <%/* 资源类型(MAS类短彩接入号码：G0001，MAS类wappush：G0002，ADC类 行业手机报：G0003)*/%>
    <wtc:param value="0"/>     <%/* 操作类型（0：正常，1：短信接入（MAS），1：彩信接入（MAS））*/%>
  </wtc:service>
  <wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---2029----retCode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    