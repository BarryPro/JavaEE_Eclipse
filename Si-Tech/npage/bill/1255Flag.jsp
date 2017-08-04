<%
/**********************
version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-09-18 页面改造,修改样式
*
**********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String org_Code = request.getParameter("org_Code");
	String new_rate_code = request.getParameter("new_rate_code");
	System.out.println("phoneNO ===: "+ org_Code);
	System.out.println("phoneNO ===: "+ new_rate_code);
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String flag_code = "";
	String SqlStr1 = "select a.flag_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + org_Code.substring(0,2) + "' and b.mode_code='" + new_rate_code + "'";
	System.out.println(SqlStr1);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:sql><%=SqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="fee" scope="end" />
<%
	if(fee.length > 1){
		flag_code="2";
	
	}else{
		flag_code="1";
	}

	String rpcPage = "1295chgSim";
%>
	var response = new AJAXPacket();
	var flag_code = "<%=flag_code%>";
	var rpcPage = "<%=rpcPage%>";
	response.data.add("verifyType",rpcPage); 
	response.data.add("flag_code",flag_code); 
	core.ajax.receivePacket(response);
