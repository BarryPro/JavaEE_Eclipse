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
	String iLoginAccept = (String)request.getParameter("iLoginAccept");
  String iChnSource = (String)request.getParameter("iChnSource");
	String iOpCode = (String)request.getParameter("iOpCode");
	String opCode = iOpCode;
	
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String iLoginPwd = (String)request.getParameter("iLoginPwd");
	String iPhoneNo = (String)request.getParameter("bphones");
	
	
	String iUserPwd = (String)request.getParameter("userpwds");
	String iSimNo = (String)request.getParameter("simnos");
	String iGroupId = (String)request.getParameter("iGroupId");
	String iCustName = (String)request.getParameter("iCustName");
	String iIdType = (String)request.getParameter("iIdType");
	String iIdValid = (String)request.getParameter("iIdValid");
	String iIdAddress = (String)request.getParameter("iIdAddress");
	
	String iContactPerson = (String)request.getParameter("iContactPerson");
	String iContactAddr = (String)request.getParameter("iContactAddr");
	String iContactPhone = (String)request.getParameter("iContactPhone");
	String iContactFax = (String)request.getParameter("iContactFax");
	String iContactPost = (String)request.getParameter("iContactPost");
	String iContactMail = (String)request.getParameter("iContactMail");
	
	String iOprName = (String)request.getParameter("iOprName");
	String iOprAddr = (String)request.getParameter("iOprAddr");
	String iOprIdType = (String)request.getParameter("iOprIdType");
	String iOprIdIccId = (String)request.getParameter("iOprIdIccId");
	String iOfferId = (String)request.getParameter("iOfferId");
	String iSimFee = (String)request.getParameter("iSimFee");
	String iPrePayfee = (String)request.getParameter("prepays");
	
	String bTrueNames = (String)request.getParameter("bTrueNames");
	String bTrueIdTypes = (String)request.getParameter("bTrueIdTypes");
	String bTrueIdNos = (String)request.getParameter("bTrueIdNos");
	String bTrueAddrs = (String)request.getParameter("bTrueAddrs");
	String bSimFees = (String)request.getParameter("bSimFees");
	
	/*小区代码*/
	String xqdm = (String)request.getParameter("xqdm");
	/*附加销售品信息串*/
	String endStr = (String)request.getParameter("fjxspStr");
	
	
	
	
	
	String iIdIccId = (String)request.getParameter("iIdIccId");

	String iOprName2222 = (String)request.getParameter("iOprName2222");
	String iOprAddr2222 = (String)request.getParameter("iOprAddr2222");
	String iOprIdType2222 = (String)request.getParameter("iOprIdType2222");
	String iOprIdIccId2222 = (String)request.getParameter("iOprIdIccId2222");	
	
	System.out.println("gaopengSeeLogm349=====================iPhoneNo==="+iPhoneNo);
	System.out.println("gaopengSeeLogm349=====================iUserPwd==="+iUserPwd);
	System.out.println("gaopengSeeLogm349=====================iSimNo==="+iSimNo);
	System.out.println("gaopengSeeLogm349=====================iPrePayfee==="+iPrePayfee);

 	String opName = 	(String)request.getParameter("opName");
 	
 	
 	
  String regionCode = (String)session.getAttribute("regCode");		
  
  String[] iPhoneNoArrs = new String[]{""};
  String[] iUserPwdArrs = new String[]{""};
  String[] iSimNoArrs = new String[]{""};
  String[] iPrePayfeeArrs = new String[]{""};	
  
  
  String[] bTrueNamesArrs = new String[]{""};	
  String[] bTrueIdTypesArrs = new String[]{""};	
  String[] bTrueIdNosArrs = new String[]{""};	
  String[] bTrueAddrsArrs = new String[]{""};	
  String[] bSimFeesArrs = new String[]{""};	
  
  
  iPhoneNoArrs = iPhoneNo.split(",");
  iUserPwdArrs = iUserPwd.split(",");
  iSimNoArrs = iSimNo.split(",");
  iPrePayfeeArrs = iPrePayfee.split(",");
  
  bTrueNamesArrs = bTrueNames.split(",");
  bTrueIdTypesArrs = bTrueIdTypes.split(",");
  bTrueIdNosArrs = bTrueIdNos.split(",");
  bTrueAddrsArrs = bTrueAddrs.split(",");
  bSimFeesArrs = bSimFees.split(",");
  
  if(iPhoneNoArrs.length == 0){
		iPhoneNoArrs = new String[]{""};
	}
	if(iUserPwdArrs.length == 0){
		iUserPwdArrs = new String[]{""};
	}
	if(iSimNoArrs.length == 0){
		iSimNoArrs = new String[]{""};
	}
	if(iPrePayfeeArrs.length == 0){
		iPrePayfeeArrs = new String[]{""};
	}
	
	if(bTrueNamesArrs.length == 0){
		bTrueNamesArrs = new String[]{""};
	}
	if(bTrueIdTypesArrs.length == 0){
		bTrueIdTypesArrs = new String[]{""};
	}
	if(bTrueIdNosArrs.length == 0){
		bTrueIdNosArrs = new String[]{""};
	}
	if(bTrueAddrsArrs.length == 0){
		bTrueAddrsArrs = new String[]{""};
	}
	if(bSimFeesArrs.length == 0){
		bSimFeesArrs = new String[]{""};
	}
  
  String inParam[] = new String[30];
  
  inParam[0] =  iLoginAccept  				;                 
  inParam[1] =  iChnSource           ;
  inParam[2] =  iOpCode              ;                  
  inParam[3] =  iLoginNo             ;                  
  inParam[4] =  iLoginPwd            ;                  
  inParam[5] =  iPhoneNo            ;        
  inParam[6] =  iUserPwd            ;        
  inParam[7] =  iSimNo            ;                
  inParam[8] =  iGroupId 			      ;                   
  inParam[9] =  iCustName 			      ;                 
  inParam[10] = iIdType 				      ;  
  inParam[11] = iIdIccId 				      ;  
                    
  inParam[12] = iIdValid 			      ;    
  
              
  inParam[13] = iIdAddress			      ;                 
  inParam[14] = iContactPerson       ;                  
  inParam[15] = iContactAddr 		    ;                   
  inParam[16] = iContactPhone        ;                  
  inParam[17] = iContactFax		      ;                   
  inParam[18] = iContactPost		      ;                 
  inParam[19] = iContactMail 	      ;                   
  inParam[20] = iOprName 			      ;                   
  inParam[21] = iOprAddr 			      ;                   
  inParam[22] = iOprIdType 		      ;                   
  inParam[23] = iOprIdIccId 		      ;                 
  inParam[24] = iOfferId 			      ;                   
  inParam[25] = iSimFee				      ;         
  inParam[26] = iPrePayfee				      ;
  
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[0]="+inParam[0]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[1]="+inParam[1]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[2]="+inParam[2]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[3]="+inParam[3]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[4]="+inParam[4]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[5]="+inParam[5]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[6]="+inParam[6]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[7]="+inParam[7]);
  
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[8]="+inParam[8]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[9]="+inParam[9]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[10]="+inParam[10]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[11]="+inParam[11]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[12]="+inParam[12]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[13]="+inParam[13]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[14]="+inParam[14]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[15]="+inParam[15]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[16]="+inParam[16]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[17]="+inParam[17]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[18]="+inParam[18]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[19]="+inParam[19]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[20]="+inParam[20]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[21]="+inParam[21]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[22]="+inParam[22]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[23]="+inParam[23]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[24]="+inParam[24]);
  System.out.println("gaopengSeeLog=======fm349BatCfm.jsp===========inParam[25]="+inParam[25]);

  
  
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
<wtc:service name="sBatchCustCfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
		<wtc:param value="<%=inParam[0]%>" />
		<wtc:param value="<%=inParam[1]%>" />
		<wtc:param value="<%=inParam[2]%>" />
		<wtc:param value="<%=inParam[3]%>" />
		<wtc:param value="<%=inParam[4]%>" />
		<wtc:params value="<%=iPhoneNoArrs%>" />
		<wtc:params value="<%=iUserPwdArrs%>" />
		<wtc:params value="<%=iSimNoArrs%>" />
		<wtc:param value="<%=inParam[8]%>" />
		<wtc:param value="<%=inParam[9]%>" />
		<wtc:param value="<%=inParam[10]%>" />
		<wtc:param value="<%=inParam[11]%>" />
		<wtc:param value="<%=inParam[13]%>" />
		<wtc:param value="<%=inParam[12]%>" />
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
		<wtc:params value="<%=iPrePayfeeArrs%>" />
		<wtc:param value="<%=iOprIdType2222%>" />
		<wtc:param value="<%=iOprIdIccId2222%>" />
		<wtc:param value="<%=iOprName2222%>" />
		<wtc:param value="<%=iOprAddr2222%>" />
			
		<!-- 小区代码数组 -->
		<wtc:param value="<%=xqdm%>" />
		<!-- 附加销售品信息串 -->
		
		<!-- SMI卡费数组 -->	
		<wtc:params value="<%=bSimFeesArrs%>" />
		<!-- 实际使用人信息数组 -->	
		<wtc:params value="<%=bTrueNamesArrs%>" />
		<wtc:params value="<%=bTrueIdTypesArrs%>" />
		<wtc:params value="<%=bTrueIdNosArrs%>" />
		<wtc:params value="<%=bTrueAddrsArrs%>" />
		
		
			
		
		
		
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end" />
	<wtc:array id="result2" start="2" length="1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务 sBatchCustCfm in fm349BatCfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		
%>
	<script language="JavaScript">
		
	</script>
<%
	}else{
		System.out.println(" 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location.href="/npage/sm349/fm349Main.jsp?opCode=m349&opName=批量普通开户";
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
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">错误信息列表</div>
	</div>
	<div>
		<table>
			<%if(errCode.equals("0")||errCode.equals("000000")){
				if(result2.length > 0){
				%>
			<tr>
				<td colspan="2">失败条数：<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>手机号码</th>
				<th>失败原因</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>
			 <tr> 
					<td align="center" colspan="2" id="footer">
						<input class="b_foot" name="sure"  type="button" value="返回"  onclick="window.location.href='/npage/sm349/fm349Main.jsp?opCode=m349&opName=批量普通开户';">
						<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
					</td>
			 </tr>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

