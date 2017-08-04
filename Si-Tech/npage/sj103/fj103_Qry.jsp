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
        String radiovalue = WtcUtil.repNull(request.getParameter("radiovalue"));
		String queryvalue = WtcUtil.repNull(request.getParameter("queryvalue"));
		String orgcode = (String)session.getAttribute("orgCode");
        String regionCode = (String)session.getAttribute("regCode");
        String returnMessage="";
        String returnCode="";
		String scount = "";
        String[][] callData = null;
        String stringArray="";
        String [] inputParam = new String [10] ;
        inputParam[0]="0";
        inputParam[1]="08";
        inputParam[2]="J101";
        inputParam[3]=login_no;
        inputParam[4]=login_passwd;
        inputParam[5]="";
        inputParam[6]="";
		inputParam[7]=regionCode;
		inputParam[8]=radiovalue;
		inputParam[9]=queryvalue;
%>

        <wtc:service name="sj103Qry" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="13" >
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
		<wtc:array id="sPubCustCheckArr" start="0" length="4" scope="end"/>
		<wtc:array id="sMaxAccept" start="4" length="1" scope="end"/>
        <wtc:array id="sIdValue" start="5" length="1" scope="end"/>
        <wtc:array id="sOprCode" start="6" length="1" scope="end"/>
		<wtc:array id="sMemName" start="7" length="1" scope="end"/>
		<wtc:array id="sMemRole" start="8" length="1" scope="end"/>
		<wtc:array id="sGrpName" start="9" length="1" scope="end"/>
		<wtc:array id="sGrpArea" start="10" length="1" scope="end"/>
		<wtc:array id="sOprTime" start="11" length="1" scope="end"/>
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
			if(sPubCustCheckArr!=null&&sPubCustCheckArr.length>0){
				System.out.println("sPubCustCheckArr[0].length = "+sPubCustCheckArr[0].length);
				scount=sPubCustCheckArr[0][2];
			}
			System.out.println("scount = "+scount);
			System.out.println("sMaxAccept.length = "+sMaxAccept.length);
			if(sMaxAccept!=null&&sMaxAccept.length>0){
				callData=new String[sMaxAccept.length][8];
				for(int i=0;i<sMaxAccept.length;i++){
					callData[i][0]=sMaxAccept[i][0];
					System.out.println("callData[i][0] = "+callData[i][0]);
					callData[i][1]=sIdValue[i][0];
					System.out.println("callData[i][1] = "+callData[i][1]);
					callData[i][2]=sOprCode[i][0];
					System.out.println("callData[i][2] = "+callData[i][2]);
					callData[i][3]=sMemName[i][0];
					System.out.println("callData[i][3] = "+callData[i][3]);
					callData[i][4]=sMemRole[i][0];
					System.out.println("callData[i][4] = "+callData[i][4]);
					callData[i][5]=sGrpName[i][0];
					System.out.println("callData[i][5] = "+callData[i][5]);
					callData[i][6]=sGrpArea[i][0];
					System.out.println("callData[i][6] = "+callData[i][6]);
					callData[i][7]=sOprTime[i][0];
					System.out.println("callData[i][7] = "+callData[i][7]);
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
	for(int i = 0 ; i < callData.length ; i ++){
		for(int j = 0 ; j < callData[i].length ; j ++){
			if(callData[i][j].trim().equals("") || callData[i][j] == null){
				callData[i][j] = "";
			}
			System.out.println("#######################fj103_Qry.jsp->callData["+i+"]["+j+"]=[" + callData[i][j].trim() + "]");
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
