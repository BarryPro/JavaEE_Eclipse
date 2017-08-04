<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String opCode = request.getParameter("opCode");
	String sale_type = request.getParameter("sale_type");//营销案类型
	String type_code = request.getParameter("type_code");//手机类型
	String targFlag = request.getParameter("targFlag");//手机类型
	String sResCode = request.getParameter("sResCode");//手机类型
	double sale_price = 0.00 ;//合约价格
	String prepay_limit = "";//优惠比例
	String sale_code = "";//营销案代码
	double cost_price = 0.00 ;//采购价格
	
  String  inParams [] = new String[2];
  inParams[0] = "select sale_price, prepay_limit,sale_code,cost_price "
                +" from dphonesalecode a "
                +" where sale_type =:saletype "
                +" and region_code =:regioncode "
                +" and type_code =:typecode "
                +" and valid_flag='Y' ";

	String prc_save = sResCode.indexOf( type_code ) == -1 
		?  ( sResCode.equals("all") ?"1":"0" ) : "1";
	 inParams[0] +=   " and price_save = '"+prc_save+"' ";
  
  inParams[1] = "saletype="+sale_type+",regioncode="+regionCode+",typecode="+type_code;
  
  System.out.println("zhangyan-getParameter-inParams[0]="+inParams[0]);
  System.out.println("zhangyan-getParameter-inParams[1]="+inParams[1]);
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
	  if(("000000").equals(retCode1)) {
	    if(ret.length>0){
	      sale_price = Double.parseDouble(ret[0][0]);
	      prepay_limit = ret[0][1];
	      sale_code = ret[0][2];
	      cost_price = Double.parseDouble(ret[0][3]);
	    }
	 }	
%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode1%>");
	response.data.add("retMsg","<%=retMsg1%>");
	response.data.add("sale_price","<%=sale_price%>");
	response.data.add("prepay_limit","<%=prepay_limit%>");
	response.data.add("sale_code","<%=sale_code%>");
	response.data.add("cost_price","<%=cost_price%>");
	core.ajax.receivePacket(response);
