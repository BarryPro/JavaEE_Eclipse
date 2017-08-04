<%
  /*增加对移动400短信和语言只能添加黑名单限制
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2009年5月5日
　 * 作者: rendi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	
	String productId = request.getParameter("productId");
	String retType = request.getParameter("retType");
	String productSpecNum = "";
	int i=0;
	String sqlStr="select productspec_number from dproductorderdet "
				+"where Product_Id='"+productId+"'";

	System.out.println("getProductSpecNumber.jsp sqlStr="+sqlStr);
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>
<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		    <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
	if(retCode.equals("000000")){
  		if(result.length>0){
  			productSpecNum=result[0][0];
  			productSpecNum.trim();
  		}
  		System.out.println("length="+result.length+",productSpecNum="+productSpecNum);
  	}
%>
	var response = new AJAXPacket();
	
	var retType = "";
	var retCode = "";
	var retMessage = "";
	var productSpecNum = "";
	
	retType = "<%=retType%>";
	retCode = "<%=retCode%>";
	retMessage = "<%=retMsg%>";
	productSpecNum = "<%=productSpecNum%>";
	response.data.add("retType",retType);
	response.data.add("retCode",retCode);
	response.data.add("retMessage",retMessage);
	response.data.add("productSpecNum",productSpecNum);
	core.ajax.receivePacket(response);

