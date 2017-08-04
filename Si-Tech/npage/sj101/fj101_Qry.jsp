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
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneno"));
	String returnMessage="";
	String returnCode="";
	String[][] callData = null;
	String stringArray="";
	String [] inputParam = new String [7] ;
	inputParam[0]="0";
	inputParam[1]="08";
	inputParam[2]="J101";
	inputParam[3]=login_no;
	inputParam[4]=login_passwd;
	inputParam[5]=phoneNo;
	inputParam[6]="";
%> 
	<wtc:service name="sj101Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="11" >
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
	</wtc:service>
	<wtc:array id="sPubCustCheckArr" start="0" length="8" scope="end"/>
	<wtc:array id="sMIDValue" start="8" length="1" scope="end"/>
	<wtc:array id="sMemName" start="9" length="1" scope="end"/>
	<wtc:array id="sOpTime" start="10" length="1" scope="end"/>
<% 
	String custname="";
	String runcode="";
	String ordernum="";
	String qqqstatus="";
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
			custname=sPubCustCheckArr[0][3];
			System.out.println("custname = "+custname);
			runcode=sPubCustCheckArr[0][5];
			System.out.println("runcode = "+runcode);
			ordernum=sPubCustCheckArr[0][6];
			System.out.println("ordernum = "+ordernum);
			qqqstatus=sPubCustCheckArr[0][7];
			System.out.println("qqqstatus = "+qqqstatus);
		}
		if(sMIDValue!=null&&sMIDValue.length>0){
			callData=new String[sMIDValue.length][3];
			for(int i=0;i<sMIDValue.length;i++){
				callData[i][0]=sMIDValue[i][0];
				callData[i][1]=sMemName[i][0];
				callData[i][2]=sOpTime[i][0];
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
                System.out.println("#######################fj101_Qry.jsp->callData["+i+"]["+j+"]=[" + callData[i][j].trim() + "]");
%>
                arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
  }
}
System.out.println("end2");
%>
	
var response = new AJAXPacket();
response.data.add("verifyType" ,"phoneno"           );
response.data.add("errorCode","<%=returnCode%>");
response.data.add("errorMsg","<%=returnMessage%>");
response.data.add("custname","<%=custname%>");
response.data.add("runcode","<%=runcode%>");
response.data.add("ordernum","<%=ordernum%>");
response.data.add("qqqstatus","<%=qqqstatus%>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);
