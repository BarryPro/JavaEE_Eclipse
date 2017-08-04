<%
    /*************************************
    * 功  能: 网上终端销售出库 应付金额变成大写 e899
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
 <%@ page import="java.text.*"%>
 <%@ page import="java.math.BigDecimal"%>
<%
	String prepayMoney = WtcUtil.repStr(request.getParameter("prepayMoney"), "");
	String v_prepayMoney_cut = WtcUtil.formatNumber(prepayMoney,2);
	String chinaFeeD069 = "";
	 String regCode = (String)session.getAttribute("regCode");
%>
  <wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
    <wtc:param value="<%=v_prepayMoney_cut%>"/>
  </wtc:service>
  <wtc:array id="result112" scope="end"/>
<%
  if("000000".equals(retCode)||"0".equals(retCode)){
    if(result112.length>0){
      chinaFeeD069 = result112[0][2];
    }
  }else{
    chinaFeeD069 = "";
  }
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("chinaFeeD069","<%=chinaFeeD069%>");
response.data.add("v_prepayMoney_cut","<%=v_prepayMoney_cut%>");
core.ajax.receivePacket(response);
 
	    