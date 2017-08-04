<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.27
********************/
%>


<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%	
	String opName = "详单查询短信提醒";
	
	String op_code = request.getParameter("op_code");
	String loginAccept = "";
	String phoneno = request.getParameter("phoneno");
	String r_cus = request.getParameter("r_cus");
	String remind_type = request.getParameter("remind_type");
	String t_sys_remark = request.getParameter("t_sys_remark");
	
	String work_no = (String)session.getAttribute("workNo");
	String regCode = (String)session.getAttribute("regCode");
	
	String paraAray[] = new String[10];   
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneno%>"  id="seq"/>
<%
	loginAccept = seq;
	paraAray[0] = loginAccept; //流水
	paraAray[1] = ""; //渠道标示
	paraAray[2] = op_code;	//功能代码
	paraAray[3] = work_no;  //操作工号
	paraAray[4] = "";  //工号密码
	paraAray[5] = phoneno;	//手机号码
	paraAray[6] = "";	//手机密码
	paraAray[7] = r_cus; //类型
	paraAray[8] = remind_type;	//邮寄类型
	paraAray[9] = t_sys_remark;	//用户备注
	
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("op_code============"+op_code);
	System.out.println("work_no============"+work_no);
	System.out.println("phoneno============"+phoneno);
	System.out.println("r_cus============"+r_cus);
	System.out.println("remind_type============"+remind_type);
	System.out.println("t_sys_remark============"+t_sys_remark);
	
	
	//String[] ret = impl.callService("sPrintRemCfm",paraAray,"1","phone",phoneno);
%>
	<wtc:service name="sPrintRemCfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	String retCode= retCode1;
	String retMsg = retMsg1;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+op_code+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	//int errCode = impl.getErrCode();
	
	String errMsg = retMsg1;
	//String loginAccept = "";
	if (result1.length>0 && retCode.equals("000000"))
	{
		loginAccept = result1[0][0];

%>

<script language="JavaScript">
	rdShowMessageDialog("详单查询短信提醒业务处理成功！",2);
	removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("详单查询短信提醒业务处理失败: <%=errMsg%>",0);
	history.go(-1);
</script>
<%}
%>

