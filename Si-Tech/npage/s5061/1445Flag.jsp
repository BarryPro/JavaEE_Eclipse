 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>


<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String org_Code = request.getParameter("org_Code");
	String temp8 = request.getParameter("temp8");
	
	System.out.println("phoneNO ===: "+ org_Code);
	System.out.println("phoneNO ===: "+ temp8);

	String flag_code = "";
	String[][]fee = new String [][]{};
	//comImpl co1 = new comImpl();

	//String SqlStr1 = "select a.flag_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + org_Code.substring(0,2) + "' and b.mode_code='" + temp8 + "'";
	String SqlStr1 = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and b.region_code = '" + org_Code.substring(0,2) + "' and a.offer_id = " + temp8;
	System.out.println(SqlStr1);
	//ArrayList arr1 = co1.spubqry32("1", SqlStr1);	
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=SqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="arr1" scope="end" />
	<%
	if(arr1.length != 0){
		//fee = (String[][])arr1.get(0); 
		  fee=arr1;
	}

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
response.data.add("rpc_page",rpcPage); 
response.data.add("flag_code",flag_code); 
core.ajax.receivePacket(response);
