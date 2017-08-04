<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:R_CMI_HLJ_xueyz_2014_1365513@关于开发批量添加vip功能的需求
   * 版本: 1.0
   * 日期: 2014/03/12 16:22:30
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	
		path += "&sInOpCode="+sInOpCode;
		path += "&sInLoginNo="+sInLoginNo;
		path += "&sInLoginPasswd="+sInLoginPasswd;
		path += "&sInOrgCode="+sInOrgCode;
		path += "&sInIdNo="+sInIdNo;
		path += "&sInCmdCode="+sInCmdCode;
		path += "&sInNewRun="+sInNewRun;
		path += "&sInPayFee="+sInPayFee;
		path += "&sInRealFee="+sInRealFee;
		path += "&sInExpDays="+sInExpDays;
		path += "&sInOpNote="+sInOpNote;
		path += "&sInIpAddr="+sInIpAddr;
		path += "&sForceType="+sForceType;
		path += "&sFourceReason="+sFourceReason;
		path += "&sForceJudgement="+sForceJudgement;
		path += "&sLargeTicketTime="+sLargeTicketTime;
		path += "&sLargeTicketFee="+sLargeTicketFee;
		path += "&sOwningFee="+sOwningFee;
		path += "&sSubOffice="+sSubOffice;
		path += "&sSubOfficePhone="+sSubOfficePhone;
		path += "&sDocumentNumber="+sDocumentNumber;
		path += "&sDocumentDate="+sDocumentDate;
		path += "&sOperatorName="+sOperatorName;
		path += "&sOperatorPhone="+sOperatorPhone;
		path += "&sContactName="+sContactName;
		path += "&sContactPhone="+sContactPhone;
		path += "&inFileName="+inFileName;
		path += "&inServerIP="+inServerIP;
		path += "&inFileDir="+inFileDir;
*/

	/*===========获取参数============*/
	String sInLoginAccept = (String)request.getParameter("sInLoginAccept");
  String sInOpCode = (String)request.getParameter("sInOpCode");
	String sInLoginNo = (String)request.getParameter("sInLoginNo");
	String sInLoginPasswd = (String)request.getParameter("sInLoginPasswd");
	String sInOrgCode = (String)request.getParameter("sInOrgCode");
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code 操作权限归属
	String sInIdNo = (String)request.getParameter("sInIdNo");
	String sInCmdCode = (String)request.getParameter("sInCmdCode");
	String sInNewRun = (String)request.getParameter("sInNewRun");
	String sInPayFee = (String)request.getParameter("sInPayFee");
	String sInRealFee = (String)request.getParameter("sInRealFee");
	String sInExpDays = (String)request.getParameter("sInExpDays");
	String sInOpNote = (String)request.getParameter("sInOpNote");
	String sInIpAddr = (String)request.getParameter("sInIpAddr");
	String sForceType = (String)request.getParameter("sForceType");
	String sFourceReason = (String)request.getParameter("sFourceReason");
	String sForceJudgement = (String)request.getParameter("sForceJudgement");
	String sLargeTicketTime = (String)request.getParameter("sLargeTicketTime");
	String sLargeTicketFee = (String)request.getParameter("sLargeTicketFee");
	String sOwningFee = (String)request.getParameter("sOwningFee");
	String sSubOffice = (String)request.getParameter("sSubOffice");
	String sSubOfficePhone = (String)request.getParameter("sSubOfficePhone");
	String sDocumentNumber = (String)request.getParameter("sDocumentNumber");
	String sDocumentDate = (String)request.getParameter("sDocumentDate");
	String sOperatorName = (String)request.getParameter("sOperatorName");
	String sOperatorPhone = (String)request.getParameter("sOperatorPhone");
	String sContactName = (String)request.getParameter("sContactName");
	String sContactPhone = (String)request.getParameter("sContactPhone");
	String inFileName = (String)request.getParameter("inFileName");
	String inServerIP = (String)request.getParameter("inServerIP");
	String inFileDir = (String)request.getParameter("inFileDir");
	String errFileNmae = (String)request.getParameter("errFileNmae");

 	String opName = 	(String)request.getParameter("opName");
 	String phoneNo = 	(String)request.getParameter("phoneNo");
 	
 	
  String regionCode = (String)session.getAttribute("regCode");			
  
  String inParam[] = new String[30];
  
  inParam[0] = sInLoginAccept   ; 
  inParam[1] = sInOpCode				 ;
  inParam[2] = sInLoginNo       ; 
  inParam[3] = sInLoginPasswd   ; 
  inParam[4] = hdorg_code       ; 
  inParam[5] = sInIdNo          ; 
  inParam[6] = sInCmdCode       ; 
  inParam[7] = sInNewRun        ; 
  inParam[8] = sInPayFee        ; 
  inParam[9] = sInRealFee       ; 
  inParam[10] =sInExpDays       ; 
  inParam[11] =sInOpNote        ; 
  inParam[12] =sInIpAddr        ; 
  inParam[13] =sForceType       ; 
  inParam[14] =sFourceReason    ; 
  inParam[15] =sForceJudgement  ; 
  inParam[16] =sLargeTicketTime ; 
  inParam[17] =sLargeTicketFee  ; 
  inParam[18] =sOwningFee       ; 
  inParam[19] =sSubOffice       ; 
  inParam[20] =sSubOfficePhone  ; 
  inParam[21] =sDocumentNumber  ; 
  inParam[22] =sDocumentDate    ; 
  inParam[23] =sOperatorName    ; 
  inParam[24] =sOperatorPhone   ; 
  inParam[25] =sContactName     ; 
  inParam[26] =sContactPhone    ; 
  inParam[27] =inFileName       ; 
  inParam[28] =inServerIP       ; 
  inParam[29] =inFileDir        ; 
  
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[0]="+inParam[0]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[1]="+inParam[1]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[2]="+inParam[2]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[3]="+inParam[3]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[4]="+inParam[4]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[5]="+inParam[5]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[6]="+inParam[6]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[7]="+inParam[7]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[8]="+inParam[8]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[9]="+inParam[9]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[10]="+inParam[10]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[11]="+inParam[11]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[12]="+inParam[12]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[13]="+inParam[13]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[14]="+inParam[14]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[15]="+inParam[15]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[16]="+inParam[16]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[17]="+inParam[17]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[18]="+inParam[18]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[19]="+inParam[19]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[20]="+inParam[20]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[21]="+inParam[21]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[22]="+inParam[22]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[23]="+inParam[23]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[24]="+inParam[24]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[25]="+inParam[25]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[26]="+inParam[26]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[27]="+inParam[27]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[28]="+inParam[28]);
  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[29]="+inParam[29]);
  
  
%>
<%
			/********************************************
				*@服务名称：服务名称：s1246BatCfm
				*@编码日期：2014/03/12
				*@服务版本：Ver1.0
				*@编码人员：fusk
				*@功能描述：
				*@输入参数：
				*@ iLoginAccept 业务流水
				*@ iChnSource 渠道标识
				*@ iOpCode 操作代码
				*@ iLoginNo 操作工号
				*@ iLoginPwd 工号密码
				*@ iPhoneNo 服务号码
				*@ iUserPwd 号码密码
				*@ iFileNo 文件编号
				*@ iFileName 文件名称
				*@ iOpNote 操作备注
				*@ iOpSource 操作来源：地市/省公司
				*@ iInputFile 文件路径
				*@ iFileIpAddr 文件IP地址
				
				*@返回参数：
				*@ oRetCode 返回代码
				*@ oRetMsg 返回信息
			*********************************************/
		%>
<wtc:service name="s1246BatCfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=inParam[0]%>" />
		<wtc:param value="<%=inParam[1]%>" />
		<wtc:param value="<%=inParam[2]%>" />
		<wtc:param value="<%=inParam[3]%>" />
		<wtc:param value="<%=inParam[4]%>" />
		<wtc:param value="<%=inParam[5]%>" />
		<wtc:param value="<%=inParam[6]%>" />
		<wtc:param value="<%=inParam[7]%>" />
		<wtc:param value="<%=inParam[8]%>" />
		<wtc:param value="<%=inParam[9]%>" />
		<wtc:param value="<%=inParam[10]%>" />
		<wtc:param value="<%=inParam[11]%>" />
		<wtc:param value="<%=inParam[12]%>" />
		<wtc:param value="<%=inParam[13]%>" />
		<wtc:param value="<%=inParam[14]%>" />
		<wtc:param value="<%=inParam[15]%>" />
		<wtc:param value="<%=inParam[16]%>" />
		<wtc:param value="<%=inParam[17]%>" />
		<wtc:param value="<%=inParam[18]%>" />
		<wtc:param value="<%=inParam[19]%>" />
		<wtc:param value="<%=inParam[20]%>" />
		<wtc:param value="<%=inParam[21]%>" />
		<wtc:param value="<%=inParam[22]%>" />
		<wtc:param value="<%=inParam[23]%>" />
		<wtc:param value="<%=inParam[24]%>" />
		<wtc:param value="<%=inParam[25]%>" />
		<wtc:param value="<%=inParam[26]%>" />
		<wtc:param value="<%=inParam[27]%>" />
		<wtc:param value="<%=inParam[28]%>" />
		<wtc:param value="<%=inParam[29]%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务s1246BatCfm in f1246BatCfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		var errFileName = "<%=errFileNmae%>";
		var msg = "<%=result1[0][0]%>";	
		var path = "/npage/s1246/f1246Error.jsp?fileName="+errFileName;
		path += "&msg="+msg;
		window.parent.location.href="/npage/s1246/f1246_1.jsp?opCode=1246&opName=强制开关机&activePhone=<%=phoneNo%>";
		window.parent.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		
	</script>
<%
	}else{
		System.out.println(" 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.parent.location.href="/npage/s1246/f1246_1.jsp?opCode=1246&opName=强制开关机&activePhone=<%=phoneNo%>";
	</script>
<%
	}		
%>	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
	</script>
</head>
<body>
	
</body>
</html>