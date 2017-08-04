<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%		
    int error_code = 0;
    String error_msg = "";

	String opCode = "7413";
	String opName = "动力100业务包退订";
    String iLoginAccept    = request.getParameter("login_accept");     //操作流水号
    String iOpCode         = request.getParameter("op_code");          //操作代码
    String iWorkNo         = request.getParameter("WorkNo");           //操作员工号
    String iLogin_Pass     = request.getParameter("NoPass");           //操作员密码
    String iOrgCode        = request.getParameter("OrgCode");          //操作员机构代码
    String iSys_Note       = request.getParameter("sysnote");          //系统操作备注
    String iOp_Note        = request.getParameter("tonote");           //用户操作备注
    String iIpAddr         = request.getParameter("ip_Addr");          //操作员IP地址
    String iGrp_Id         = request.getParameter("grp_id");           //集团用户ID
    String delMemFlag      = "0";           						   //需要删除成员标志(0:不删除， 1：删除)
    String iRegion_Code = iOrgCode.substring(0,2);
    
    String resLoginAccept = "";
%>
<wtc:service name="s7413Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iWorkNo%>"/>
	<wtc:param value="<%=iLogin_Pass%>"/>
	<wtc:param value="<%=iOrgCode%>"/>
	
	<wtc:param value="<%=iSys_Note%>"/>
	<wtc:param value="<%=iOp_Note%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
	<wtc:param value="<%=iGrp_Id%>"/>
	<wtc:param value="<%=delMemFlag%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>	
<%
	error_code = retCode1==""?999999:Integer.parseInt(retCode1);
	error_msg  = retMsg1;
	resLoginAccept = result.length>0?result[0][0]:"";
	
	if(error_code == 0){
%>
	<script language='jscript'>
        rdShowMessageDialog("动力100业务包退订成功！",2);
        location = "f7413.jsp";
    </script>
<%
	}
	else 
	{
%>
    <script language='jscript'>
        rdShowMessageDialog("错误代码：" + "<%=error_code%>" + "，错误信息：" + "<%=error_msg%>",0);
        history.go(-1);
    </script>
<%
    }
%>
    
<%
	 System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
	 String cnttOpCode = opCode;
	 String cttOpName = opName;
	 String cnttWorkNo = iWorkNo;
	 String retCodeForCntt = String.valueOf(error_code);
	 String cnttLoginAccept = resLoginAccept;
	 String cnttContactId = iGrp_Id;
	 String cnttUserType = "grp";
	 
	 String url = "/npage/contact/upCnttInfo.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+cttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&contactId="+cnttContactId+"&contactType="+cnttUserType;
	 System.out.println("--------------url----:"+url);
	 System.out.println("--------------iLoginAccept----:"+iLoginAccept);
%>
		
	<jsp:include page="<%=url%>" flush="true" />

<%
	 System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
%>
