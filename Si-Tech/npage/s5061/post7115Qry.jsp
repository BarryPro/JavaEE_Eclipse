 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-10 页面改造,修改样式
	********************/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	
	String regionCode= (String)session.getAttribute("regCode");  
	
	String cust_name   = "";
	String retCode = "";
	String retMsg = "";
	String SqlStr1 = "";
	String[][]psot = new String [][]{};
	String phoneNo = request.getParameter("phoneNo");
	System.out.println("phoneNO ===: "+ phoneNo);
	//comImpl co1 = new comImpl();

	SqlStr1 = "select b.cust_name from dcustmsg a, dCustDoc b where a.cust_id = b.cust_id and  a.phone_no ='"+phoneNo+"' and substr(run_code,2,1) < 'a'";
	retMsg = "用户信息资料不存在，不能录入!";
	System.out.println(SqlStr1);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=SqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="arr1" scope="end" />
<%
	//ArrayList arr1 = co1.spubqry32("1", SqlStr1);	
	//if(arr1.size() != 0){
	if(arr1!=null&&arr1.length!=0){
		//psot = (String[][])arr1.get(0); 
		psot=arr1;
	}
	System.out.println("00000");
	if(psot!=null&&psot.length == 1){
		cust_name = psot[0][0];
	}else{
		retCode = "100001";
	}

	System.out.println("1111111");
	String rpcPage = "postSim";

%>
	var response = new AJAXPacket();
	var retCode = "<%=retCode%>";
	var retMsg = "<%=retMsg%>";
	var cust_name = "<%=cust_name%>";
	var rpcPage = "<%=rpcPage%>";

	response.data.add("rpc_page",rpcPage); 
	response.data.add("retCode",retCode); 
	response.data.add("retMsg",retMsg); 
	response.data.add("cust_name",cust_name); 
	core.ajax.receivePacket(response);
