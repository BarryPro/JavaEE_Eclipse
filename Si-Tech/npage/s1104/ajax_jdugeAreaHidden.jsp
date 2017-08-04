<%
    /*************************************
    * 功  能: 参数配置 e982
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-8-10
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));//资费代码
		String offerName = WtcUtil.repNull(request.getParameter("offerName"));//资费名称
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regCode = (String)session.getAttribute("regCode");
		String hiddenFlag = "";//是否显示小区代码
		String retCode11 = "";
		String retMsg11 = "";
		try{
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
    
	<wtc:service name="sOfferAttrCheck" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="3">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=offerId%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="1"  scope="end"/>
	<wtc:array id="result2" start="1" length="2"  scope="end"/>

var _code = new Array();
var _text = new Array();

<%
	retCode11 = retCode;
	retMsg11 = retMsg;
  if("000000".equals(retCode)){
    if(result1.length>0){
      hiddenFlag = result1[0][0];
    }
    if(result2.length>0){
      for(int outter = 0 ; result2 != null && outter < result2.length; outter ++){
%>
      	_code[<%=outter%>] = "<%=result2[outter][0]%>";
      	_text[<%=outter%>] = "<%=result2[outter][1]%>";
<%
        
      }
    }
  }
}catch(Exception e){
	e.printStackTrace();
	retCode11 = "444444";
	retMsg11 = "服务未启动或不正常，请联系管理员！";
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
response.data.add("hiddenFlag","<%=hiddenFlag%>");
response.data.add("offerId","<%=offerId%>");
response.data.add("offerName","<%=offerName%>");

response.data.add("code",_code);
response.data.add("text",_text);
core.ajax.receivePacket(response);
