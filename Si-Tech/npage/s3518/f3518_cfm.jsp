<%
   /*
   * 功能: 调用RPC修改集团产品议价调整
　 * 版本: v1.0
　 * 日期: 2006/09/01
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));              //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              	//工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));               //登陆密码
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	//错误信息，错误代码
	String errCode = "";
	String errMsg = "";
	
	String qryType = request.getParameter("qryType");
	String idNo = request.getParameter("idNo");
	String productCode = request.getParameter("productCode");
	String priceType = request.getParameter("priceType");
	String priceValue = request.getParameter("priceValue");
	String beginTime = request.getParameter("beginTime");
	String endTime = request.getParameter("endTime");
	String hiddenBeginTime = request.getParameter("hiddenBeginTime");
	String hiddenEndTime = request.getParameter("hiddenEndTime");
	String service_type = request.getParameter("service_type");
	String service_code = request.getParameter("service_code");
	String price_code = request.getParameter("price_code");
	String login_accept = request.getParameter("login_accept");
	String yyhzs = request.getParameter("yyhzs");
	
	
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
	System.out.println("# productCode="+productCode);
	String[] productCodeArray=productCode.split(",");
	String[] priceTypeArray=priceType.split(",");
	String[] priceValueArray=priceValue.split(",");
	String[] beginTimeArray=beginTime.split(",");
	String[] endTimeArray=endTime.split(",");
	String[] hiddenBeginTimeArray=hiddenBeginTime.split(",");
	String[] hiddenEndTimeArray=hiddenEndTime.split(",");
	String[] service_typeArray=service_type.split(",");
	String[] service_codeArray=service_code.split(",");
	String[] price_codeArray=price_code.split(",");
	String[] login_acceptArray=login_accept.split(",");
	String[] yyhzsArray=yyhzs.split(",");
	
	String opNote="操作员"+workNo+"对"+idNo+"进行集团产品议价调整";
	
	
	// ArrayList paramsIn = new ArrayList(17);
	// paramsIn.add(workNo);
	// paramsIn.add(nopass);
	// paramsIn.add("3518");
	// paramsIn.add(opNote);
	// paramsIn.add(idNo);
	// paramsIn.add(ip_Addr);
	// paramsIn.add(productCodeArray);
	// paramsIn.add(priceTypeArray);
	// paramsIn.add(priceValueArray);
	// paramsIn.add(beginTimeArray);
	// paramsIn.add(endTimeArray);
	// paramsIn.add(service_typeArray);
	// paramsIn.add(service_codeArray);
	// paramsIn.add(price_codeArray);
	// paramsIn.add(login_acceptArray);
	// paramsIn.add(hiddenBeginTimeArray);
	// paramsIn.add(hiddenEndTimeArray);
	System.out.println("***************************");
%>
   <wtc:service name="s3518PriModEXC" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="2" >
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=nopass%>"/>
        <wtc:param value="3518"/>
        <wtc:param value="<%=opNote%>"/>
        <wtc:param value="<%=idNo%>"/>
        <wtc:param value="<%=ip_Addr%>"/>
        <wtc:params value="<%=productCodeArray%>"/>
        <wtc:params value="<%=priceTypeArray%>"/>
        <wtc:params value="<%=priceValueArray%>"/>
        <wtc:params value="<%=beginTimeArray%>"/>
        <wtc:params value="<%=endTimeArray%>"/>
        <wtc:params value="<%=service_typeArray%>"/>
        <wtc:params value="<%=service_codeArray%>"/>
        <wtc:params value="<%=price_codeArray%>"/>
        <wtc:params value="<%=login_acceptArray%>"/>
        <wtc:params value="<%=hiddenBeginTimeArray%>"/>
        <wtc:params value="<%=hiddenEndTimeArray%>"/>			
        <wtc:params value="<%=yyhzsArray%>"/>					
	</wtc:service>
<% 
	errCode=retCode;   
	errMsg=retMsg;	
%>

var response = new AJAXPacket();
response.data.add("qryType","<%=qryType%>");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);