<%
  /*************************************
  * 功  能: 集团客户密码变更 e801
  * 版  本: version v1.0
  * 开发商: si-tech
  * 创建者: diling @ 2012-4-26
  **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String custId = (String)request.getParameter("custId");
	String unitIdStrNull ="isNull";
  String[] inParamA = new String[2];
  inParamA[0] ="SELECT to_char(unit_id) FROM dgrpcustmsg WHERE cust_id=to_number(:custId)";
  inParamA[1] ="custId="+custId;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCodeA" retmsg="retMsgA" outnum="3">
  <wtc:param value="<%=inParamA[0]%>"/>
  <wtc:param value="<%=inParamA[1]%>"/>
  </wtc:service>
  <wtc:array id="result"  scope="end"/>
<%
  System.out.println("--------------e801-----result.length="+result.length);
  System.out.println("--------------e801-----inParamA[0]="+inParamA[0]);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCodeA%>");
response.data.add("retmsg","<%=retMsgA%>");
<%
  if("000000".equals(retCodeA)){
    if(result.length!=0){
%>
      response.data.add("unitIdBack","<%=result[0][0]%>");
<%
       System.out.println("--------------e801-----result[0][0]="+result[0][0]);
    }else{
%>
      response.data.add("unitIdBack","<%=unitIdStrNull%>");
<%
    }
  }else{
%>
    response.data.add("unitIdBack","<%=unitIdStrNull%>");
<%  
  }
%>
core.ajax.receivePacket(response);