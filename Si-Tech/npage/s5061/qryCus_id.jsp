 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-14 页面改造,修改样式
	********************/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
   
    	String loginNo = (String)session.getAttribute("workNo");	
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
	inPwd = request.getParameter("t_new_pass");



	//SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[4];
	inputParsm[0] = phoneNo;
	inputParsm[1] = opCode;
	inputParsm[2] = "0";
	inputParsm[3] = loginNo;
	System.out.println("phoneNO === "+ phoneNo);
	//String [] cussidArr=co.callService("s2419Init",inputParsm,"7","phone",phoneNo);
	%>
		<wtc:service name="s2419Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="7" >
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>		
			<wtc:param value="<%=inputParsm[3]%>"/>			
		<wtc:param value="<%=%>"/>
		</wtc:service>
		<wtc:array id="cussidArr" scope="end"/>
	<%
	String retCode= retCode1;
	String retMsg = retMsg1;



	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	String vIdNo = "";
	String vCustName = "";
	String vIdIccid = "";
	String vIdAddr = "";
	String vCurrentPoint = "";
	String vHandFee = "";

	String pwdFlag = "0";

	String rpcPage = "qryCus_id";

	if(cussidArr!=null&&cussidArr.length>0)
	{
		vIdNo = cussidArr[0][0];
		vCustName = cussidArr[0][1];
		vIdIccid = cussidArr[0][2];
		vIdAddr = cussidArr[0][3];
		vCurrentPoint = cussidArr[0][4];
		vHandFee = cussidArr[0][5];		
		
		String enPwd = (String)Encrypt.encrypt(inPwd);
		System.out.println("retPwd =" + cussidArr[0][6] + "]");
		System.out.println("enPwd =" + enPwd + "]");	
	
		if(0==Encrypt.checkpwd2(cussidArr[0][6].trim(),enPwd))
		{
			pwdFlag = "1";
		}	
		//System.out.println((cussidArr[0][6].trim()).equals(enPwd));
	}


	String cussidStr="";
%>

var response = new AJAXPacket();

var retCode 		= "<%=retCode	%>";
var retMsg 		= "<%=retMsg	%>";
var vIdNo 		= "<%=vIdNo	%>";
var vCustName 		= "<%=vCustName	%>";
var vIdIccid 		= "<%=vIdIccid	%>";
var vIdAddr 		= "<%=vIdAddr	%>";
var vCurrentPoint    = "<%=vCurrentPoint%>";
var vHandFee 		= "<%=vHandFee	%>";

var pwdFlag 		= "<%=pwdFlag	%>";
var rpcPage = "<%=rpcPage%>";

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("vIdNo",vIdNo); 
response.data.add("vCustName",vCustName); 
response.data.add("vIdIccid",vIdIccid); 
response.data.add("vIdAddr",vIdAddr); 
response.data.add("vCurrentPoint",vCurrentPoint); 
response.data.add("vHandFee",vHandFee); 
response.data.add("pwdFlag",pwdFlag);
core.ajax.receivePacket(response);
