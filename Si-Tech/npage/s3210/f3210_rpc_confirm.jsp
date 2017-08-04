 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-14 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%
	String regionCode = (String)session.getAttribute("regCode");  
	//String[] retStr = null;
	int error_code = 0;
	String error_msg="系统错误，请与系统管理员联系";
	int valid = 1;  //0:正确，1：系统错误，2：业务错误
	String iErrorNo ="";
    	String sErrorMessage = " ";

	//String[] callData = null;
	Logger logger = Logger.getLogger("f3210_rpc_confirm.jsp");
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();

	String verifyType = request.getParameter("verifyType");
	String opType = request.getParameter("opType");
	String op_code = request.getParameter("opCode");
	String org_code  = request.getParameter("orgCode");	 /* 机构编码		   */
	String iRegion_Code = org_code.substring(0,2);
	String sSaveName="";
	String[] ParamsIn = null;
	String server_ip_Addr=request.getServerName();//得到主机地址
	String srvIP=request.getServerName();
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+opType);
	if (opType.equals("file")){
	//按文件录入的操作
	String filename = "sim"+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
	sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
	SmartUpload mySmartUpload = new SmartUpload();
	try
    {
        mySmartUpload.initialize(pageContext);
        mySmartUpload.upload();
		System.out.println("上传完毕!!");
    }
    catch(Exception ex) 
    {
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
	try 
    {
        com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
        if (!myFile.isMissing())
		{
			System.out.println("开始存储文件！！");
           myFile.saveAs(sSaveName);
        }
    }
	catch(Exception ex)
	{
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
	}

		ParamsIn = new String[32];
		ParamsIn[0]  = request.getParameter("loginNo");	 /* 操作工号		   */
		ParamsIn[1]  = request.getParameter("orgCode");	 /* 机构编码		   */
		ParamsIn[2]  = request.getParameter("opCode");	  /* 操作代码		   */
		ParamsIn[3]  = request.getParameter("op_note");	 /* 操作备注		   */
		ParamsIn[4]  = request.getParameter("GRPID");	   /* 集团号			 */
		ParamsIn[5]  = request.getParameter("deparment");   /* 用户部门		   */
		ParamsIn[6]  = request.getParameter("CLOSENO1");	/* 闭合群号1		  */
		ParamsIn[7]  = request.getParameter("CLOSENO2");	/* 闭合群号2		  */
		ParamsIn[8]  = request.getParameter("CLOSENO3");	/* 闭合群号3		  */
		ParamsIn[9]  = request.getParameter("CLOSENO4");	/* 闭合群号4		  */
		ParamsIn[10] = request.getParameter("CLOSENO5");	/* 闭合群号5		  */
		ParamsIn[11] = request.getParameter("USERPIN1");	/* 用户密码		   */
		ParamsIn[12] = request.getParameter("LOCKFLAG");	/* 用户封锁标志	   */
		ParamsIn[13] = request.getParameter("FLAGS");	   /* 用户功能权限集	 */
		ParamsIn[14] = request.getParameter("STATUS");	  /* 状态变量集		 */
		ParamsIn[15] = request.getParameter("USERTYPE");	/* 用户类型		   */
		ParamsIn[16] = request.getParameter("OUTGRP");	  /* 网外号码组组号	 */
		ParamsIn[17] = request.getParameter("MAXOUTNUM");   /* 最大网外号码数	 */
		ParamsIn[18] = request.getParameter("FEEFLAG");	 /* 费用限额标志选择   */
		ParamsIn[19] = request.getParameter("LMTFEE");	  /* 月费用限额		 */
		ParamsIn[20] = request.getParameter("CURPKGTYPE");  /* 当月份资费套餐类型 */
		ParamsIn[21] = "0";								  /* 当月用户品牌	   */
		ParamsIn[22] = request.getParameter("PKGTYPE");	 /* 下月份资费套餐类型 */
		ParamsIn[23] = "0";								  /* 下月用户品牌	   */
		ParamsIn[24] = request.getParameter("PKGDAY");		/* 资费套餐生效日期   */
		ParamsIn[25] = request.getParameter("tmpR1");		/* 短号码串		   */
		ParamsIn[26] = request.getParameter("tmpR2");		/* 真实号码串		 */
		ParamsIn[27] = request.getParameter("id_card");		/* 证件号码串		 */
		ParamsIn[28] = request.getParameter("user_name");   /* 用户姓名串		 */
		ParamsIn[29] = request.getParameter("p_comment");   /* 描述信息串		 */
		ParamsIn[30] = sSaveName;							/* 文件名   */
		ParamsIn[31] = server_ip_Addr;						/* 主机IP   */
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
		//callData = callView.callService("s3210Cfm", ParamsIn, "2", "region", iRegion_Code);
//	}
	/*else
	{
		callData = callView.callService("s3214Cfm", ParamsIn, "2", "region", iRegion_Code);
	}
	*/
	
	%>
	<wtc:service name="s3210Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:params value="<%=ParamsIn%>" />
	</wtc:service>
	<wtc:array id="callData" scope="end" />		   
	
	<%
	/*	
	error_code = callView.getErrCode();
	error_msg= callView.getErrMsg(); */
	error_code = retCode1;
	error_msg= retMsg1;
%>

var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= error_code %>");
response.data.add("errorMsg","<%= error_msg %>");
<%
	if (callData != null)
	{
%>
		response.data.add("backArrMsg","<%= callData[0][0]%>" );
		response.data.add("backArrMsg1","<%= callData[0][1] %>" );
<%
	}
%>
core.ajax.receivePacket(response);


