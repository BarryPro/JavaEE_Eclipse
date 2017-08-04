<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.09
 模块:改号通知
********************/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	
	String loginNo = (String)session.getAttribute("workNo");
	
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
	String inPwd = request.getParameter("t_new_pass");
	
	String  inputParsm [] = new String[3];
	inputParsm[0] = loginNo;
	inputParsm[1] = phoneNo;
	inputParsm[2] = opCode;
	System.out.println("phoneNO === "+ phoneNo);
	//String [] cussidArr=co.callService("s1446Init",inputParsm,"20","phone",phoneNo);
%>
	<wtc:service name="s1446Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="20">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>	
	</wtc:service>	
	<wtc:array id="cussidArr" scope="end"/>
<%
	String retCode= retCode1;
	String retMsg = retMsg1;
	
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	//co.printRetValue();
	
	String idNo ="";
	String smCode ="";
	String smName ="";
	String belongCode ="";
	String custName ="";
	String userPassword ="";
	String runCode ="";
	String runName ="";
	String idName ="";
	String idIccid ="";
	String ownerGrade ="";
	String gradeName ="";
	String card_name ="";
	String totalPrepay ="";
	String totalOwe ="";
	String loginAccept ="";
	String opName ="";
	String transPhone ="";
	String paymoney ="";
	
	String rpcPage = "qryCus_sim";

if(cussidArr.length>0)
{
	idNo = cussidArr[0][0];
	smCode = cussidArr[0][1];
	smName = cussidArr[0][2];
	belongCode = cussidArr[0][3];
	custName = cussidArr[0][4];
	userPassword = cussidArr[0][5];
	runCode = cussidArr[0][6];
	runName = cussidArr[0][7];
	idName = cussidArr[0][8];
	idIccid = cussidArr[0][9];
	ownerGrade = cussidArr[0][10];
	gradeName = cussidArr[0][11];
	card_name = cussidArr[0][12];
	totalPrepay	 = cussidArr[0][13];
	totalOwe = cussidArr[0][14];
	loginAccept	 = cussidArr[0][15];
	opCode = cussidArr[0][16];
	opName = cussidArr[0][17];
	transPhone = cussidArr[0][18];
	paymoney = cussidArr[0][19];

//System.out.println((cussidArr[6].trim()).equals(enPwd));
}


String cussidStr="";
//if(((String[][])cussidArr.get(0)).length>0)
//  cussidStr=((String[][])cussidArr.get(0))[0][0];
%>

var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";

var idNo = "<%=idNo%>";
var smCode = "<%=smCode%>";
var smName = "<%=smName%>";
var belongCode = "<%=belongCode	%>";
var custName = "<%=custName	%>";
var userPassword = "<%=userPassword%>";
var runCode = "<%=runCode%>";
var runName = "<%=runName%>";
var idName = "<%=idName  	%>";
var idIccid = "<%=idIccid%>";
var ownerGrade = "<%=ownerGrade	%>";
var gradeName = "<%=gradeName	%>";
var card_name = "<%=card_name	%>";
var totalPrepay = "<%=totalPrepay	%>";
var totalOwe = "<%=totalOwe	%>";
var loginAccept = "<%=loginAccept	%>";
var opCode = "<%=opCode%>";
var opName = "<%=opName%>";
var transPhone = "<%=transPhone%>";
var paymoney = "<%=paymoney%>";


var rpcPage = "<%=rpcPage%>";

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 

response.data.add("idNo",idNo); 
response.data.add("smCode",smCode);
response.data.add("smName",smName);
response.data.add("belongCode",belongCode);
response.data.add("custName",custName);
response.data.add("userPassword",userPassword); 
response.data.add("runCode",runCode);
response.data.add("runName",runName);
response.data.add("idName  ",idName);
response.data.add("idIccid",idIccid);
response.data.add("ownerGrade",ownerGrade); 
response.data.add("gradeName",gradeName);
response.data.add("card_name",card_name);
response.data.add("totalPrepay",totalPrepay);
response.data.add("totalOwe",totalOwe);
response.data.add("loginAccept",loginAccept); 
response.data.add("opCode",opCode);
response.data.add("opName",opName);
response.data.add("transPhone",transPhone);
response.data.add("paymoney",paymoney);
 
core.ajax.receivePacket(response);
