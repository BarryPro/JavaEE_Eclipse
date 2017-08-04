 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-15 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<% 

	String regionCode = (String)session.getAttribute("regCode");   
	String opName=(String)request.getParameter("opName");
	String error_code = "0";
	String error_msg="系统错误，请与系统管理员联系";
	
	String[][] callData = new String[][]{};	
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String verifyType = request.getParameter("verifyType");
	String opType = request.getParameter("opType");	
	String org_code  = request.getParameter("orgCode");	 /* 机构编码		   */
	String iRegion_Code = org_code.substring(0,2);
	String userPhone = (String)request.getParameter("lNo");
		
	String[] ParamsIn = null;		
	System.out.println("verifyType="+verifyType);

	ParamsIn = new String[26];
	ParamsIn[0]  = request.getParameter("loginNo");	 	/* 操作工号		   */
	ParamsIn[1]  = request.getParameter("orgCode");	 	/* 机构编码		   */
	ParamsIn[2]  = request.getParameter("opCode");	  /* 操作代码		   */
	ParamsIn[3]  = request.getParameter("op_note");	 	/* 操作备注		   */
	ParamsIn[4]  = request.getParameter("GRPID");	   	/* 集团号			 */
	ParamsIn[5]  = "0";   														/* 用户部门		   */
	ParamsIn[6]  = request.getParameter("CLOSENO1");	/* 闭合群号1		  */
	ParamsIn[7]  = request.getParameter("CLOSENO2");	/* 闭合群号2		  */
	ParamsIn[8]  = request.getParameter("CLOSENO3");	/* 闭合群号3		  */
	ParamsIn[9]  = request.getParameter("CLOSENO4");	/* 闭合群号4		  */
	ParamsIn[10] = request.getParameter("CLOSENO5");	/* 闭合群号5		  */
	ParamsIn[11] = request.getParameter("USERPIN1");	/* 用户密码		   */
	ParamsIn[12] = request.getParameter("LOCKFLAG");	/* 用户封锁标志	   */
	ParamsIn[13] = request.getParameter("FLAGS");	   	/* 用户功能权限集	 */
	ParamsIn[14] = request.getParameter("STATUS");	  /* 状态变量集		 */
	ParamsIn[15] = request.getParameter("USERTYPE");	/* 用户类型		   */
	ParamsIn[16] = request.getParameter("OUTGRP");	  /* 网外号码组组号	 */
	ParamsIn[17] = request.getParameter("MAXOUTNUM"); /* 最大网外号码数	 */
	ParamsIn[18] = request.getParameter("FEEFLAG");	 	/* 费用限额标志选择   */
	ParamsIn[19] = request.getParameter("LMTFEE");	  /* 月费用限额		 */
	ParamsIn[20] = request.getParameter("PKGTYPE");	 	/* 下月份资费套餐类型 */
	ParamsIn[21] = "0";								  							/* 下月用户品牌	   */
	ParamsIn[22] = request.getParameter("PKGDAY");	  /* 资费套餐生效日期   */
	ParamsIn[23] = request.getParameter("strType");	   	/* 号码类型		   */
	ParamsIn[24] = request.getParameter("tmpR2");	   	/* 号码串类型		 */
	ParamsIn[25] = request.getParameter("unit_id_id"); /*真实unit_id luxc10070117add*/
%>

<%
	if( opType.equals("u") ){
		//callData = callView.callService("s3214Cfm", ParamsIn, "2", "region", iRegion_Code);
	%>
	 <wtc:service name="s3214Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:params value="<%=ParamsIn%>" />
   	</wtc:service>
    	<wtc:array id="callData1" scope="end" />	
	<%	
	callData=callData1;
	error_code=retCode1;
	error_msg=retMsg1;
	
}	

	//error_code = callView.getErrCode();
	//error_msg= callView.getErrMsg(); 
	
	
	System.out.println("error_code========="+error_code);
    	System.out.println("error_msg============"+error_msg);
%>


var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= error_code %>");
response.data.add("errorMsg","<%= error_msg %>");

<%
	if (callData != null)
	{
%>
		response.data.add("backArrMsg","<%= callData[0][0] %>" );
		response.data.add("backArrMsg1","<%= callData[0][1] %>" );
<%      	System.out.println("backArrMsg========="+ callData[0][0] ); 
		System.out.println("backArrMsg1========"+callData[0][1]); 
	}else{
	%>
		response.data.add("backArrMsg","" );
		response.data.add("backArrMsg1","" );
	<%}
%>
core.ajax.receivePacket(response);
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<% System.out.println("wwwwwwwwwwwwwwwwwwf3214rpc_confirm");%>
<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+ParamsIn[2]+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg
		+"&opName="+opName+"&workNo="+ParamsIn[0]+"&loginAccept="+loginAccept+"&pageActivePhone="+userPhone
		+"&opBeginTime="+opBeginTime+"&contactId="+ParamsIn[4]+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />
