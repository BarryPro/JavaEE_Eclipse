<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangwg @ 20150511
 ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String login_no = (String)session.getAttribute("workNo");//工号
        String login_passwd = (String)session.getAttribute("password");//工号密码
		String orgcode = (String)session.getAttribute("orgCode");
        String regionCode = (String)session.getAttribute("regCode");
		String queryvalue = WtcUtil.repNull(request.getParameter("queryvalue"));
		
        String returnMessage="";
        String returnCode="";
		String scount = "";
        String[][] callData = null;
        String stringArray="";
		
		String [] inputParam = new String [7] ;
        inputParam[0]="0";
        inputParam[1]="08";
        inputParam[2]="G897";
        inputParam[3]=login_no;
        inputParam[4]=login_passwd;
        inputParam[5]=queryvalue;
        inputParam[6]="";
%>

	<wtc:service name="sMktPresQry" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="11" >
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
	</wtc:service>
	<wtc:array id="PayedMobile" start="0" length="1" scope="end"/>
	<wtc:array id="OrderMobile" start="1" length="1" scope="end"/>
	<wtc:array id="offerno" start="2" length="1" scope="end"/>
	<wtc:array id="monthfee" start="3" length="1" scope="end"/>
	<wtc:array id="monthnum" start="4" length="1" scope="end"/>
	<wtc:array id="totalFee" start="5" length="1" scope="end"/>
	<wtc:array id="OpNote" start="6" length="1" scope="end"/>
	<wtc:array id="optime" start="7" length="1" scope="end"/>
	<wtc:array id="EndTime" start="8" length="1" scope="end"/>
	<wtc:array id="vChnName" start="9" length="1" scope="end"/>
	<wtc:array id="offername" start="10" length="1" scope="end"/>


<%
	returnCode = retCode;
	returnMessage = retMsg;
	
	if(returnMessage==null){
		returnMessage = "";
	}

	System.out.println("returnCode = "+returnCode);
	System.out.println("returnMessage = "+returnMessage);
	retCode.trim();
	
	if(retCode.equals("000000")){
		scount = ""+PayedMobile.length;
		System.out.println("scount = "+scount);
		System.out.println("PayedMobile.length = "+PayedMobile.length);
		if(PayedMobile!=null&&PayedMobile.length>0){
			callData=new String[PayedMobile.length][11];
			for(int i=0;i<PayedMobile.length;i++){
				callData[i][0]=PayedMobile[i][0];
				callData[i][1]=OrderMobile[i][0];
				callData[i][2]=offerno[i][0];
				callData[i][3]=monthfee[i][0];
				callData[i][4]=monthnum[i][0];
				callData[i][5]=totalFee[i][0];
				callData[i][6]=OpNote[i][0];
				callData[i][7]=optime[i][0];
				callData[i][8]=EndTime[i][0];
				callData[i][9]=vChnName[i][0];
				callData[i][10]=offername[i][0];
			}
			stringArray = "var arrMsg = new Array(";
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
	}
	else
	{
		callData=new String[][]{};
		stringArray="var arrMsg = new Array();";
	}
	System.out.println("end1");
%>
<%=stringArray%>
<%
System.out.println("callData.length = "+callData.length);
	for(int i = 0 ; i < callData.length ; i ++){
		System.out.println("callData["+i+"].length = "+callData[i].length);
		for(int j = 0 ; j < callData[i].length ; j ++){
			if( callData[i][j] == null || callData[i][j].trim().equals("") ){
				callData[i][j] = "";
			}
			System.out.println("#######################fg897_2.jsp->callData["+i+"]["+j+"]=[" + callData[i][j].trim() + "]");
			%>
				arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
			<%
		}
	}
	System.out.println("end2");
%>
var response = new AJAXPacket();
response.data.add("verifyType" ,"phoneno");
response.data.add("errorCode","<%=returnCode%>");
response.data.add("errorMsg","<%=returnMessage%>");
response.data.add("scount","<%=scount%>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);