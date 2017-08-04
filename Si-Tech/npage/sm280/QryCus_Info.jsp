<%
/********************
 *version v2.0
 *¿ª·¢ÉÌ: si-tech
 *update by qidp @ 2008-12-29
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%



    String work_No = request.getParameter("work_No");
    String org_Code = request.getParameter("org_Code");
    String work_Pwd = request.getParameter("work_Pwd");
    String op_code = request.getParameter("op_code");
    String phoneNo = request.getParameter("phoneNo");
    String billDate = request.getParameter("billDate");
    String loginAccept = request.getParameter("loginAccept");

        //SPubCallSvrImpl co = new SPubCallSvrImpl();
        //String  inputParsm [] = new String[7];
        //inputParsm[0] = work_No;
        //inputParsm[1] = org_Code;
        //inputParsm[2] = work_Pwd;
        //inputParsm[3] = op_code;
        //inputParsm[4] = phoneNo;
        //inputParsm[5] = billDate;
        //inputParsm[6] = loginAccept;
	
        /*	
        System.out.println("work_No === "+ work_No);
        System.out.println("org_Code === "+ org_Code);
        System.out.println("work_Pwd === "+ work_Pwd);	
        System.out.println("op_code === "+ op_code);
        System.out.println("phoneNO === "+ phoneNo);
        System.out.println("billDate === "+ billDate);
        System.out.println("loginAccept === "+ loginAccept);
        */


        //String [] cussidArr=co.callService("sPubGetOprMsg",inputParsm,"25","phone",phoneNo);
%>
    <wtc:service name="sPubGetOprMsg" routerKey="phone" routerValue="<%=phoneNo%>" retcode="sPubGetOprMsgCode" retmsg="sPubGetOprMsgMsg" outnum="25">
        <wtc:param value="<%=work_No%>"/>
        <wtc:param value="<%=org_Code%>"/>
        <wtc:param value="<%=work_Pwd%>"/>
        <wtc:param value="<%=op_code%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value="<%=billDate%>"/>
        <wtc:param value="<%=loginAccept%>"/>
    </wtc:service>
    <wtc:array id="sPubGetOprMsgArr" scope="end"/>
<%
    String retCode= sPubGetOprMsgCode;
    String retMsg = sPubGetOprMsgMsg;
    System.out.println("retCode === "+ retCode);
    System.out.println("retMsg === "+ retMsg);

    String userId = "";
    String custName = "";
    String passWord = "";
    String asIdtape = "";
    String asIdname = "";
    String asIdiccid = "";
    String smTape = "";
    String smName = "";
    String runCode = "";
    String runName = "";
    String cardName = "";
    String blocName = "";
    String base_No = "";
    String base_Name = "";
    String base_Date = "";
    String oldFee = "";
    String back_flag = "";
    String test = "";
    String test1 = "";
    String test2 = "";
    String test3 = "";
    String VloginAccept = "";
    String oldsim = "";
    String newsim = "";
    
    String rpcPage = "QryCus_Info";

if(sPubGetOprMsgArr.length>0 && sPubGetOprMsgCode.equals("000000"))

{

	userId        = sPubGetOprMsgArr[0][0];
	custName      = sPubGetOprMsgArr[0][1];
	passWord    = sPubGetOprMsgArr[0][2];
	asIdtape    = sPubGetOprMsgArr[0][3];
	asIdname    = sPubGetOprMsgArr[0][4];
	asIdiccid   = sPubGetOprMsgArr[0][5];
	smTape      = sPubGetOprMsgArr[0][6];
	smName      = sPubGetOprMsgArr[0][7];
	runCode     = sPubGetOprMsgArr[0][8];
	runName     = sPubGetOprMsgArr[0][9];
	cardName    = sPubGetOprMsgArr[0][10];
	blocName    = sPubGetOprMsgArr[0][11];
	base_No     = sPubGetOprMsgArr[0][12];
	base_Name   = sPubGetOprMsgArr[0][13];
	base_Date   = sPubGetOprMsgArr[0][14];
	oldFee      = sPubGetOprMsgArr[0][15];
	back_flag      = sPubGetOprMsgArr[0][17];
	test      = sPubGetOprMsgArr[0][18];
	test1      = sPubGetOprMsgArr[0][19];
	test2      = sPubGetOprMsgArr[0][20];
	test3      = sPubGetOprMsgArr[0][21];
	VloginAccept    = sPubGetOprMsgArr[0][22];
	oldsim    = sPubGetOprMsgArr[0][23];
	newsim    = sPubGetOprMsgArr[0][24];


}


String cussidStr="";
//if(((String[][])cussidArr.get(0)).length>0)
//  cussidStr=((String[][])cussidArr.get(0))[0][0];
%>

var response = new AJAXPacket();

var retCode 		= "<%=retCode%>";
var retMsg 		= "<%=retMsg%>";
var userId     	= "<%=userId%>";
var custName   	= "<%=custName%>";
var passWord   	= "<%=passWord%>";
var asIdtape   	= "<%=asIdtape%>";
var asIdname   	= "<%=asIdname%>";
var asIdiccid  	= "<%=asIdiccid%>";
var smTape     	= "<%=smTape%>";
var smName     	= "<%=smName%>";
var runCode    	= "<%=runCode%>";
var runName    	= "<%=runName%>";
var cardName   	= "<%=cardName%>";
var blocName   	= "<%=blocName%>";
var base_No    	= "<%=base_No%>";
var base_Name  	= "<%=base_Name%>";
var base_Date  	= "<%=base_Date%>";
var oldFee     	= "<%=oldFee%>";
var back_flag     	= "<%=back_flag%>";
var test     	= "<%=test%>";
var test1     	= "<%=test1%>";
var test2     	= "<%=test2%>";
var test3     	= "<%=test3%>";
var VloginAccept = "<%=VloginAccept%>";
var oldsim = "<%=oldsim%>";
var newsim = "<%=newsim%>";

var rpcPage = "<%=rpcPage%>";

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("rpcpage",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("userId",userId); 
response.data.add("custName",custName); 
response.data.add("passWord",passWord); 
response.data.add("asIdtape",asIdtape); 
response.data.add("asIdname",asIdname); 
response.data.add("asIdiccid",asIdiccid); 
response.data.add("smTape",smTape); 
response.data.add("smName",smName); 
response.data.add("runCode",runCode); 
response.data.add("runName",runName); 
response.data.add("cardName",cardName); 
response.data.add("blocName",blocName); 
response.data.add("base_No",base_No); 
response.data.add("base_Name",base_Name); 
response.data.add("base_Date",base_Date); 
response.data.add("oldFee",oldFee); 
response.data.add("backFlag",back_flag); 
response.data.add("test",test); 
response.data.add("test1",test1); 
response.data.add("test2",test2); 
response.data.add("test3",test3); 
response.data.add("VloginAccept",VloginAccept); 
response.data.add("oldsim",oldsim); 
response.data.add("newsim",newsim); 

core.ajax.receivePacket(response);
