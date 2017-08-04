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
	String strLoginAccept = "";
	String strOldMachineType = "";
	String strOldSimNo = "";
	String strNewMachineType = "";
	String strNewSimNo = "";
	String retCode = "";
	String retMsg = "";
	String SqlStr1 = "";
	String[][]psot = new String [][]{};
	String phoneNo = request.getParameter("phoneNo");
	System.out.println("phoneNO ===: "+ phoneNo);
	

	SqlStr1 = "select b.cust_name,to_number(c.LOGIN_ACCEPT),c.OLD_MACHINE_TYPE,c.OLD_SIM_NO,c.NEW_MACHINE_TYPE,c.NEW_SIM_NO  from dcustmsg a, dCustDoc b, dCommPhoneFeeChg c where a.id_no = c.id_no and a.cust_id = b.cust_id and  a.phone_no ='"+phoneNo+"' and substr(run_code,2,1) < 'a'";
	retMsg = "用户信息资料不存在，不能录入!";
	System.out.println(SqlStr1);

	//ArrayList arr1 = co1.spubqry32("6", SqlStr1);	
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
		<wtc:sql><%=SqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="arr1" scope="end" />
<%
	if(arr1!=null&&arr1.length!=0){
		//psot = (String[][])arr1.get(0); 
		psot=arr1;
	}
	System.out.println("00000");
	if(psot!=null&&psot.length == 1){
		cust_name = psot[0][0];
		strLoginAccept = psot[0][1];
		strOldMachineType = psot[0][2];
		strOldSimNo = psot[0][3];
		strNewMachineType = psot[0][4];
		strNewSimNo = psot[0][5];
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
	var strLoginAccept = "<%=strLoginAccept%>";
	var strOldMachineType = "<%=strOldMachineType%>";
	var strOldSimNo = "<%=strOldSimNo%>";
	var strNewMachineType = "<%=strNewMachineType%>";
	var strNewSimNo = "<%=strNewSimNo%>";
	var rpcPage = "<%=rpcPage%>";
	
	response.data.add("rpc_page",rpcPage); 
	response.data.add("retCode",retCode); 
	response.data.add("retMsg",retMsg); 
	response.data.add("cust_name",cust_name); 
	response.data.add("strLoginAccept",strLoginAccept); 
	response.data.add("strOldMachineType",strOldMachineType); 
	response.data.add("strOldSimNo",strOldSimNo); 
	response.data.add("strNewMachineType",strNewMachineType); 
	response.data.add("strNewSimNo",strNewSimNo); 
	core.ajax.receivePacket(response);
