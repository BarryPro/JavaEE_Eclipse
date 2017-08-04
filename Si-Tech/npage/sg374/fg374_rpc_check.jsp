<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 20121225
 ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String login_no = (String)session.getAttribute("workNo");//工号
	String login_passwd = (String)session.getAttribute("password");//工号密码
	String[][] callData = null;
	String[][] callData2 = null;
	String stringArray="";
	String stringArray2="";
	String returnMessage="";
	String returnCode="";
	String basecode="";
	String ordernum="";
	String conlist = "";
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneno"));
	String iLoginPwd = (String)request.getParameter("iLoginPwd");
	String flag = request.getParameter("flag");
	String spid = request.getParameter("spid");
	String bizcode = request.getParameter("bizcode");
	String [] inputParam = new String [10] ;
	inputParam[0]="0";
	inputParam[1]="08";
	inputParam[2]="g374";
	inputParam[3]=login_no;
	inputParam[4]=login_passwd;
	inputParam[5]=phoneNo;
	inputParam[6]="";
	inputParam[7]=flag;
	inputParam[8]=spid;
	inputParam[9]=bizcode;
	
%>
	<wtc:service name="sg374Init" routerKey="phone" routerValue="<%=phoneNo%>" outnum="19" >
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
		<wtc:param value="<%=inputParam[7]%>"/>
		<wtc:param value="<%=inputParam[8]%>"/>
		<wtc:param value="<%=inputParam[9]%>"/>
	</wtc:service>
	<wtc:array id="sPubCustCheckArr" start="0" length="8" scope="end"/>
	<wtc:array id="switchCodeArray"  start="8" length="1" scope="end"/>
	<wtc:array id="switchNameArray"  start="9" length="1" scope="end"/>
	<wtc:array id="switchTypeArray"  start="10" length="1" scope="end"/>
	<wtc:array id="switchTimeArray"  start="11" length="1" scope="end"/>
	<wtc:array id="switchOprArray"   start="12" length="1" scope="end"/>
	<wtc:array id="switchWorkNoArray"  start="13" length="1" scope="end"/>
	<wtc:array id="switchSP"  start="14" length="1" scope="end"/>
	<wtc:array id="switchBIZ"  start="15" length="1" scope="end"/>
	<wtc:array id="switchBIZName"  start="16" length="1" scope="end"/>
	<wtc:array id="switchConList"  start="17" length="1" scope="end"/>
<% 
	String custname="";
	String runcode="";
	String brand="";
	returnCode = retCode;
	returnMessage = retMsg;
	if(returnMessage==null){
		returnMessage = "";
	}
	System.out.println("returnCode = "+returnCode);
	System.out.println("returnMessage = "+returnMessage);
	retCode.trim();
	if(retCode.equals("000000")){
		System.out.println("retCodeInt = "+retCode);
		if(sPubCustCheckArr!=null&&sPubCustCheckArr.length>0){
			custname=sPubCustCheckArr[0][3];
			System.out.println("custname = "+custname);
			runcode=sPubCustCheckArr[0][5];
			System.out.println("runcode = "+runcode);
			ordernum=sPubCustCheckArr[0][7];
			System.out.println("ordernum = "+ordernum);
			basecode=sPubCustCheckArr[0][6];
			System.out.println("basecode = "+basecode);
			
		}
		if(switchConList!=null&&switchConList.length>0){
			conlist = switchConList[0][0];
		}
		else
		{
			conlist = "";
		}
		System.out.println("conlist = "+conlist);
		
		if(switchCodeArray!=null&&switchCodeArray.length>0){
			stringArray = "var arrMsg = new Array(";
			callData=new String[switchCodeArray.length][6];
			for(int i=0;i<switchCodeArray.length;i++){
				callData[i][0]=switchCodeArray[i][0];
				callData[i][1]=switchNameArray[i][0];
				callData[i][2]=switchTypeArray[i][0];
				callData[i][3]=switchTimeArray[i][0];
				callData[i][4]=switchOprArray[i][0];
				callData[i][5]=switchWorkNoArray[i][0];
			}
			int flag1 = 1;
			for (int i = 0; i < callData.length; i++) {
				if (flag1 == 1) {
					stringArray += "new Array()";
					flag1 = 0;
				}else if (flag1 == 0) {
					stringArray += ",new Array()";
				}
	    	}

	  		stringArray += ");";	  
		}else{
			callData=new String[][]{};
			stringArray="var arrMsg = new Array();";
		}
		
		if(switchBIZ!=null&&switchBIZ.length>0)
		{
			stringArray2 = "var arrMsg1 = new Array(";
			callData2=new String[switchBIZ.length][3];
			for(int i=0;i<switchBIZ.length;i++){
				callData2[i][0]=switchSP[i][0];
				callData2[i][1]=switchBIZ[i][0];
				callData2[i][2]=switchBIZName[i][0];
			}
			int flag1 = 1;
			for (int i = 0; i < callData2.length; i++) {
				if (flag1 == 1) {
					stringArray2 += "new Array()";
					flag1 = 0;
				}else if (flag1 == 0) {
					stringArray2 += ",new Array()";
				}
	    	}
			stringArray2 += ");";	
		}
		else
		{
			callData2=new String[][]{};
			stringArray2="var arrMsg1 = new Array();";
		}
	}else{
		callData=new String[][]{};
		callData2=new String[][]{};
		stringArray="var arrMsg = new Array();";
		stringArray2="var arrMsg1 = new Array();";
	}
	
	System.out.println("end1"); 
%>
		<%=stringArray%>
		<%=stringArray2%>
<%
for(int i = 0 ; i < callData.length ; i ++){
  for(int j = 0 ; j < callData[i].length ; j ++){
		if(callData[i][j].trim().equals("") || callData[i][j] == null){
		   callData[i][j] = "";
		}
		System.out.println("#######################fg374_rpc_check.jsp->callData["+i+"]["+j+"]=[" + callData[i][j].trim() + "]");
%>
		arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
  }
}
System.out.println("end21"); 
for(int i = 0 ; i < callData2.length ; i ++){
  for(int j = 0 ; j < callData2[i].length ; j ++){
		if(callData2[i][j].trim().equals("") || callData2[i][j] == null){
		   callData2[i][j] = "";
		}
		System.out.println("#######################fg374_rpc_check.jsp->callData2["+i+"]["+j+"]=[" + callData2[i][j].trim() + "]");
%>
		arrMsg1[<%=i%>][<%=j%>] = "<%=callData2[i][j].trim()%>";
<%
  }
}
System.out.println("end22"); 
%>  
var response = new AJAXPacket();
response.data.add("verifyType","phoneno");
response.data.add("errorCode","<%=returnCode%>");
response.data.add("errorMsg","<%=returnMessage%>");
response.data.add("flag","<%=flag%>");
response.data.add("custname","<%=custname%>");
response.data.add("runcode","<%=runcode%>");
response.data.add("basecode","<%=basecode%>");
response.data.add("ordernum","<%=ordernum%>");
response.data.add("conlist","<%=conlist%>");
response.data.add("backArrMsg",arrMsg);
response.data.add("backArrMsg1",arrMsg1);
core.ajax.receivePacket(response);
