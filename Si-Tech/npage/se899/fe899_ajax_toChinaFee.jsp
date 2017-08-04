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
	String selSalePrice = WtcUtil.repStr(request.getParameter("selSalePrice"), "");
	String v_xx_money=WtcUtil.formatNumber(selSalePrice,2);
	String regCode = (String)session.getAttribute("regCode");
	String chinaFee = "";
	System.out.println("---e899--DILING--selSalePrice="+selSalePrice);
%>
  <wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="3">
    <wtc:param value="<%=v_xx_money%>"/>
  </wtc:service>
  <wtc:array id="ret" scope="end"/>
<%
  System.out.println("---e899--toChinaFee--retCode="+retCode);
  if("000000".equals(retCode)||"0".equals(retCode)){
    if(ret.length>0){
      chinaFee = ret[0][2];
    }
  }else{
    chinaFee = "";
  }
  
    System.out.println("---e899--toChinaFee--chinaFee="+chinaFee);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("chinaFee","<%=chinaFee%>");
response.data.add("v_xx_money","<%=v_xx_money%>");
core.ajax.receivePacket(response);
 
	    