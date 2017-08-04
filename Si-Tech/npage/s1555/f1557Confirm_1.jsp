<%
/********************
 version v2.0
 开发商: si-tech
 模块：统一领奖
 update zhaohaitao at 2009.1.4
********************/
%>
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%	
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");	
	
	String work_no = (String)session.getAttribute("workNo");
	
	String paraAray[] = new String[10];

	paraAray[0] = request.getParameter("phoneNo");//手机号码
	paraAray[1] = work_no;//工号
    paraAray[2] = "1557";//操作代码
	paraAray[3] = request.getParameter("award_type");//奖品大类
	paraAray[4] = request.getParameter("awardop_type");//业务类型
	paraAray[5] = request.getParameter("awardflag_code");//奖品类型
	paraAray[6] = request.getParameter("money_flag");//价值分档
	paraAray[7] = request.getParameter("awardinfo_code");//奖品代码
	paraAray[8] = request.getParameter("opNote");//备注
    paraAray[9] = request.getParameter("printAccept");//打印流水

	//String[] ret = impl.callService("s1557Cfm",paraAray,"2","phone",request.getParameter("phoneNo"));
%>
	<wtc:service name="s1557Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
		<wtc:param value="<%=paraAray[8]%>" />
		<wtc:param value="<%=paraAray[9]%>" />
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode=1557"+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[9]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("领奖成功！",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("领奖失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
