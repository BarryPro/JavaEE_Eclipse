<%
/********************
 version v2.0
开发商: si-tech 
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.io.*" %>


<%


String loginAccept = request.getParameter("loginAccept");
String opCode= request.getParameter("opCode");
String workNo= request.getParameter("workNo");
String noPass = (String)session.getAttribute("password");
String opName = "二次密码设置";
String passwd = request.getParameter("passwd");
String newPass = Encrypt.encrypt(passwd);
System.out.println("newPass"+newPass);
String phoneNo=request.getParameter("activePhone");
System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+phoneNo);
String orgCode= request.getParameter("orgCode");
String idNo= request.getParameter("idNo");
String handFee= request.getParameter("handFee");
String factPay= request.getParameter("factPay");
String sysRemark= request.getParameter("sysRemark");
String remark= request.getParameter("remark");
String ipAdd= request.getParameter("ipAdd");
String qryFlag = request.getParameter("qryFlag");
String qryNote = request.getParameter("qryNote");
String asCustName = request.getParameter("asCustName");
String asCustPhone = request.getParameter("asCustPhone");
String asIdType = request.getParameter("asIdType");
String asIdIccid = request.getParameter("asIdIccid");
String asIdAddress = request.getParameter("asIdAddress");
String asContractAddress = request.getParameter("asContractAddress");
String asNotes = request.getParameter("asNotes");

//SPubCallSvrImpl callWrapper = new SPubCallSvrImpl();

String []  inputParam = new String [24] ;
inputParam[0]=loginAccept;
inputParam[1]="01";
inputParam[2]=opCode;
inputParam[3]=workNo;
inputParam[4]=noPass;
inputParam[5]=activePhone;
inputParam[6]=passwd;
inputParam[7]=orgCode;
inputParam[8]=idNo ;
inputParam[9]=qryFlag;
inputParam[10]=qryNote;
inputParam[11]=handFee;
inputParam[12]=factPay;
inputParam[13]=sysRemark;
inputParam[14]=remark;
inputParam[15]=ipAdd;
inputParam[16]=asCustName;
inputParam[17]=asCustPhone;
inputParam[18]=asIdType;
inputParam[19]=asIdIccid;
inputParam[20]=asIdAddress;
inputParam[21]=asContractAddress;
inputParam[22]=asNotes; 
inputParam[23]=newPass;
                             

 
//String retCode ="";                 
//String retMessage = "";
//String backUserInfo[][] = new String[][]{{"","",""}};
                                   
//String [] userInfo = callWrapper.callService("s1236Cfm",inputParam,"3");
//backUserInfo[0] = userInfo;
//retCode = String.valueOf(callWrapper.getErrCode());
//retMessage = callWrapper.getErrMsg();
//System.out.println("retCode = " + retCode);
//System.out.println(" retMessage = " + retMessage);                                   
%>
		<wtc:service name="s1236Cfm"   routerKey="region" routerValue="<%=orgCode.substring(0,2)%>" outnum="3" retmsg="retMessage" retcode="retCode">
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
				<wtc:param value="<%=inputParam[10]%>"/>
				<wtc:param value="<%=inputParam[11]%>"/>
				<wtc:param value="<%=inputParam[12]%>"/>
				<wtc:param value="<%=inputParam[13]%>"/>
				<wtc:param value="<%=inputParam[14]%>"/>
				<wtc:param value="<%=inputParam[15]%>"/>
				<wtc:param value="<%=inputParam[16]%>"/>
				<wtc:param value="<%=inputParam[17]%>"/>
				<wtc:param value="<%=inputParam[18]%>"/>
				<wtc:param value="<%=inputParam[19]%>"/>
				<wtc:param value="<%=inputParam[20]%>"/>
				<wtc:param value="<%=inputParam[21]%>"/>
				<wtc:param value="<%=inputParam[22]%>"/>
				<wtc:param value="<%=inputParam[23]%>"/>
		</wtc:service>
		<wtc:array id="backUserInfo" scope="end" />
<%
for(int i=0;i<backUserInfo.length;i++){
	for(int j=0;j<backUserInfo[i].length;j++){
		System.out.println("backUserInfo["+i+"]["+j+"]"+backUserInfo[i][j]);
	}
}
String strArray = CreatePlanerArray.createArray("backUserInfo",backUserInfo.length);
String opBeginTime1  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//业务开始时间
String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode +"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMessage+"&opBeginTime="+opBeginTime1;
%>
<jsp:include page="<%=url%>" flush="true" />
<%=strArray%>
<%
for(int i = 0 ; i < backUserInfo[0].length ; i ++){
//System.out.println("1111111111:" + backUserInfo[0][i]);
%>

backUserInfo[0][<%=i%>] = "<%=backUserInfo[0][i]%>";

<%}%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("backString",backUserInfo);
response.data.add("flag","1");
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMessage%>");
core.ajax.receivePacket(response);
