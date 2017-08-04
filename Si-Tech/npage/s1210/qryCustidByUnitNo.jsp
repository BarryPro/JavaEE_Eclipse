<%
    /*************************************
    * 功  能: 通过集团编号获取客户ID 1210
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-5-3
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode = (String)session.getAttribute("regCode");
	String unitNo = WtcUtil.repStr(request.getParameter("unitNo"), "");
	String[] inParams = new String[2];
	inParams[0] = "SELECT to_char(cust_id) FROM dgrpcustmsg WHERE unit_id=to_number(:unit_no)";
	inParams[1] = "unit_no="+unitNo;
	String cussid = "";
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
    </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  System.out.println("---1210----retCode="+retCode);
  if("000000".equals(retCode)){
    if(ret.length>0){
      cussid = ret[0][0];
    }
  }
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("cussid","<%=cussid%>");
core.ajax.receivePacket(response);