 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-14 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.text.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
	String loginAccept=request.getParameter("loginAccept"); 
	
	/*ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    	String[][] baseInfoSession = (String[][])arrSession.get(0);
        String[][] otherInfoSession = (String[][])arrSession.get(2);
        String[][] pass = (String[][])arrSession.get(4);

        String loginNo = baseInfoSession[0][2];
        String loginName = baseInfoSession[0][3];
        String powerCode= otherInfoSession[0][4];  
        String orgCode = baseInfoSession[0][16];
        */        
        String loginNo=(String)session.getAttribute("loginNo");    //工号 
        String loginName =(String)session.getAttribute("workName");//工号名称 
      	String orgCode = (String)session.getAttribute("orgCode");  
        String ip_Addr = request.getRemoteAddr();
        String regionCode = (String)session.getAttribute("regCode");  
        String userPhone = (String)request.getParameter("ISDNNO");
        
	String[] retStr = null;
	String error_code = "";
	String error_msg="系统错误，请与系统管理员联系";
	int valid = 1;  //0:正确，1：系统错误，2：业务错误
	String iErrorNo ="";
        String sErrorMessage = " ";
	//
	String grpName=request.getParameter("grpName");	 /* 集团名称 baixf add 20070606   */
	//
	//ArrayList callData = null;
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String opType = request.getParameter("opType");
	String op_code ="3210";
        String org_code  = request.getParameter("orgCode");	 /* 机构编码		   */
	String iRegion_Code = org_code.substring(0,2);
	String sSaveName="";
	String[] ParamsIn = null;
	//String server_ip_Addr=request.getServerName();//得到主机地址
	String server_ip_Addr=realip;//0.100主机隐藏ip用上面方法得到的是0.100非真实ip
      //System.out.println("luxc:server_ip_Addr="+server_ip_Addr);
	String srvIP=request.getServerName();
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
	//String  temp11="";  //传给xls文件，用于保存错误手机号     baixf 20070606
	//String  temp22="";  //传给xls文件，用于保存错误信息       baixf 20070606    
	SmartUpload mySmartUpload = new SmartUpload();
	if (opType.equals("file")){
	//按文件录入的操作
	String filename = "vpmn"+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
	sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
	}
	else
	sSaveName="";
	try {
        mySmartUpload.initialize(pageContext);
        mySmartUpload.upload();
		System.out.println("上传完毕!!");
    }
    catch(Exception ex)   {
		System.out.println("异常抛出!!");
		ex.printStackTrace();
        iErrorNo = "321099";
        sErrorMessage = "上载文件传输中出错！";
	
%>
            
	<script language='jscript'>
                 
		rdShowMessageDialog('上载文件传输中出错！',0);
                 
		location = "f3210.jsp";
            
	</script>
	
<%
	
	}
	
		try {
        
			com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
        
			if (!myFile.isMissing())
			{
           
				myFile.saveAs(sSaveName);
        
			}
    
		}
	
		catch(Exception ex)	{
        
			iErrorNo = "321098";
        
			sErrorMessage = "上载文件存储时出错！";

	%>
        
			<script language='jscript'>
           
				rdShowMessageDialog('上载文件存储时出错！',0);
           
				location = "f3210.jsp";
        
			</script>

	<%
	
	}
	//按文件录入操作结束
		
		ParamsIn = new String[35];		   
		ParamsIn[0]  = mySmartUpload.getRequest().getParameter("loginNo");
		//ParamsIn[0]  = request.getParameter("loginNo");	 /* 操作工号		   */
		ParamsIn[1]  = mySmartUpload.getRequest().getParameter("orgCode");	 /* 机构编码		   */
		ParamsIn[2]  = mySmartUpload.getRequest().getParameter("opCode");	  /* 操作代码		   */
		ParamsIn[3]  = mySmartUpload.getRequest().getParameter("opNote");	 /* 操作备注		   */
		ParamsIn[4]  = mySmartUpload.getRequest().getParameter("GRPID");	   /* 集团号			 */
		ParamsIn[5]  = mySmartUpload.getRequest().getParameter("DEPT");   /* 用户部门		   */
		ParamsIn[6]  = mySmartUpload.getRequest().getParameter("CLOSENO1");	/* 闭合群号1		  */
		ParamsIn[7]  = mySmartUpload.getRequest().getParameter("CLOSENO2");	/* 闭合群号2		  */
		ParamsIn[8]  = mySmartUpload.getRequest().getParameter("CLOSENO3");	/* 闭合群号3		  */
		ParamsIn[9]  = mySmartUpload.getRequest().getParameter("CLOSENO4");	/* 闭合群号4		  */
		ParamsIn[10] = mySmartUpload.getRequest().getParameter("CLOSENO5");	/* 闭合群号5		  */
		ParamsIn[11] = mySmartUpload.getRequest().getParameter("USERPIN1");	/* 用户密码		   */
		ParamsIn[12] = mySmartUpload.getRequest().getParameter("LOCKFLAG");		/* 用户封锁标志	   */
		ParamsIn[13] = mySmartUpload.getRequest().getParameter("FLAGS");		/* 用户功能权限集	 */
		ParamsIn[14] = mySmartUpload.getRequest().getParameter("STATUS");		/* 状态变量集		 */
		ParamsIn[15] = mySmartUpload.getRequest().getParameter("USERTYPE");		/* 用户类型		   */
		ParamsIn[16] = mySmartUpload.getRequest().getParameter("OUTGRP");		/* 网外号码组组号	 */
		ParamsIn[17] = mySmartUpload.getRequest().getParameter("MAXOUTNUM");	/* 最大网外号码数	 */
		ParamsIn[18] = mySmartUpload.getRequest().getParameter("FEEFLAG");		/* 费用限额标志选择   */
		ParamsIn[19] = mySmartUpload.getRequest().getParameter("LMTFEE");		/* 月费用限额		 */
		ParamsIn[20] = mySmartUpload.getRequest().getParameter("CURPKGTYPE");	/* 当月份资费套餐类型 */
		ParamsIn[21] = "0";														/* 当月用户品牌	   */
		ParamsIn[22] = mySmartUpload.getRequest().getParameter("PKGTYPE");		/* 下月份资费套餐类型 */
		ParamsIn[23] = "0";														/* 下月用户品牌	   */
		ParamsIn[24] = mySmartUpload.getRequest().getParameter("PKGDAY");		/* 资费套餐生效日期   */
		ParamsIn[25] = mySmartUpload.getRequest().getParameter("tmpR1");		/* 短号码串		   */
		ParamsIn[26] = mySmartUpload.getRequest().getParameter("tmpR2");		/* 真实号码串		 */
		ParamsIn[27] = mySmartUpload.getRequest().getParameter("tmpR3");		/* 证件号码串		 */
		ParamsIn[28] = mySmartUpload.getRequest().getParameter("tmpR4");   /* 用户姓名串		 */
		ParamsIn[29] = mySmartUpload.getRequest().getParameter("tmpR5");   /* 描述信息串		 */
		ParamsIn[30] = sSaveName;							/* 文件名   */
		ParamsIn[31] = server_ip_Addr;						/* 主机IP   */
		ParamsIn[32] = mySmartUpload.getRequest().getParameter("unit_id").substring(0,10); 
    ParamsIn[33] = mySmartUpload.getRequest().getParameter("ZHWW"); 
    ParamsIn[34] = mySmartUpload.getRequest().getParameter("phone_type"); 
//	else
//	{
//		ParamsIn = new String[25];
//		ParamsIn[0]  = request.getParameter("loginNo");	 /* 操作工号		   */
//		ParamsIn[1]  = request.getParameter("orgCode");	 /* 机构编码		   */
//		ParamsIn[2]  = request.getParameter("opCode");	  /* 操作代码		   */
//		ParamsIn[3]  = request.getParameter("op_note");	 /* 操作备注		   */
//		ParamsIn[4]  = request.getParameter("GRPID");	   /* 集团号			 */
//		ParamsIn[5]  = request.getParameter("deparment");   /* 用户部门		   */
//		ParamsIn[6]  = request.getParameter("CLOSENO1");	/* 闭合群号1		  */
//		ParamsIn[7]  = request.getParameter("CLOSENO2");	/* 闭合群号2		  */
//		ParamsIn[8]  = request.getParameter("CLOSENO3");	/* 闭合群号3		  */
//		ParamsIn[9]  = request.getParameter("CLOSENO4");	/* 闭合群号4		  */
//		ParamsIn[10] = request.getParameter("CLOSENO5");	/* 闭合群号5		  */
//		ParamsIn[11] = request.getParameter("USERPIN1");	/* 用户密码		   */
//		ParamsIn[12] = request.getParameter("LOCKFLAG");	/* 用户封锁标志	   */
//		ParamsIn[13] = request.getParameter("FLAGS");	   /* 用户功能权限集	 */
//		ParamsIn[14] = request.getParameter("STATUS");	  /* 状态变量集		 */
//		ParamsIn[15] = request.getParameter("USERTYPE");	/* 用户类型		   */
//		ParamsIn[16] = request.getParameter("OUTGRP");	  /* 网外号码组组号	 */
//		ParamsIn[17] = request.getParameter("MAXOUTNUM");   /* 最大网外号码数	 */
//		ParamsIn[18] = request.getParameter("FEEFLAG");	 /* 费用限额标志选择   */
//		ParamsIn[19] = request.getParameter("LMTFEE");	  /* 月费用限额		 */
//		ParamsIn[20] = request.getParameter("PKGTYPE");	 /* 下月份资费套餐类型 */
//		ParamsIn[21] = "0";								  /* 下月用户品牌	   */
//		ParamsIn[22] = request.getParameter("PKGDAY");	  /* 资费套餐生效日期   */
//		ParamsIn[23] = request.getParameter("tmpR1");	   /* 号码类型		   */
//		ParamsIn[24] = request.getParameter("tmpR2");	   /* 号码串类型		 */
//	} 

	//if( opType.equals("a") )
//	{
	//	callData = callView.callFXService("s3210Cfm", ParamsIn, "3", "region", iRegion_Code);
//	}
	/*else
	{
		callData = callView.callService("s3214Cfm", ParamsIn, "2", "region", iRegion_Code);
	}
	*/
	
	%>
	<wtc:service name="s3210Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
			<wtc:params value="<%=ParamsIn%>"/>
	</wtc:service>
	<wtc:array id="callData" scope="end" />		
	
	<%
	/*error_code = callView.getErrCode();
	error_msg= callView.getErrMsg();
	*/
	error_code=retCode1;
	error_msg= retMsg1;
	/*String[][] temp1 =(String[][])callData.get(1);
	String[][] temp2 =(String[][])callData.get(2);
	System.out.println("@@@@@@@@@@@@@@@@temp1"+temp1[0][0]);
	System.out.println("@@@@@@@@@@@@@@@@temp2"+temp2[0][0]);	*/
	System.out.println("================="+callData[0][1]);
	System.out.println("================="+callData[0][2]);
	strToken1=new StringTokenizer(callData[0][1],"|");
	strToken2=new StringTokenizer(callData[0][2],"|"); 
	 //temp11= temp1[0][0] ;
	 //temp22= temp2[0][0]  ;
	if(!error_code.equals("000000")){
		   %>
	 <SCRIPT type=text/javascript>
		
		 var path="<%=request.getContextPath()%>/npage/s3210/f3210_2_printxls.jsp?phoneNo=" + "<%=callData[0][1]%>";

	   		if (rdShowConfirmDialog("<br>错误代码:"+"<%=error_code%></br>"+"错误信息:"+"<%=error_msg%>"+"<br>是否保存错误信息？")==1)	
			{
				path = path + "&returnMsg=" + "<%=callData[0][2]%>"+ "&unitID=" + "<%=ParamsIn[4]%>";
	  			path = path + "&loginAccept=" + "<%=error_code%>"  ;
	  			path = path + "&op_Code=" + "<%=op_code%>"+"&grpName="+"<%=grpName%>";
	  			path = path + "&orgCode=" + "<%=org_code%>";
          			window.open(path);
			}	
		
	      history.go(-1);
		
	 </SCRIPT>
		<%
	}
		%>
<html>
<head>
<title>用户信息</title>
</head>
<SCRIPT type=text/javascript>
function previouStep(){
	frm.action="f3210.jsp";
	frm.method="post";
	frm.submit();
}


 function print_xls()
 {
   var path="<%=request.getContextPath()%>/npage/s3210/f3210_2_printxls.jsp?phoneNo=" + "<%=callData[0][1]%>";
   path = path + "&returnMsg=" + "<%=callData[0][2]%>"+ "&unitID=" + "<%=ParamsIn[4]%>";
   path = path + "&loginAccept=" + "<%=error_code%>"  ;
   path = path + "&op_Code=" + "<%=op_code%>"+"&grpName="+"<%=grpName%>";
   path = path + "&orgCode=" + "<%=org_code%>"; 
   window.open(path);         	 	
  
 }
				


</SCRIPT>
<body>
<%
	String opCode = "3210";	
	String opName = "未成功号码列表";	//header.jsp需要的参数   
%>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">未成功号码列表</div>
	</div>	
        <table cellspacing="0" >
                <TR> 			
                  <TD class="blue">未添加成功号码(如果列表为空，则全部号码添加成功。)</TD>
                  <TD class="blue">失败原因</TD>
                </TR>		
<%			
	while (strToken1.hasMoreTokens()) {
%>
				<TR>
				<td> <%= strToken1.nextToken()%> </td>
				<td> <%= strToken2.nextToken()%> </td>
				</TR>
<%
			}
%>	
        </table>    
	<table cellspacing="0">
		<tr> 
			<td id="footer"> 
				<input class="b_foot" name="previous"  type=button value="返回" onclick="previouStep()">&nbsp;
				<input class="b_foot_long" name="prtxls"  type=button value="保存XLS文件" onclick="print_xls()" style="cursor:hand">&nbsp; &nbsp;
				<input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">			    		
			</td>
		</tr>
  	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>



<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1
	+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept
	+"&pageActivePhone="+userPhone+"&opBeginTime="+opBeginTime+"&contactId="+ParamsIn[4]
	+"&contactType=grp";
%>
<jsp:include page="<%=url%>" flush="true" />
