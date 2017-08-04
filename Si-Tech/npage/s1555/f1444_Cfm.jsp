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
    String pringAccept = request.getParameter("printAccept");
    
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");

	String paraAray[] = new String[11];

	paraAray[0] = request.getParameter("id_no");			//手机号码
	paraAray[1] = work_no;									//工号
    paraAray[2] = request.getParameter("phoneNo");			//电话号码
	paraAray[3] = request.getParameter("usePoint");			//用户消费积分
	paraAray[4] = org_code;									//兑奖工号归属
	paraAray[5] = request.getParameter("num1");				//10元奖品数量
	paraAray[6] = request.getParameter("num2");				//20元奖品数量
	paraAray[7] = request.getParameter("num3");				//50元奖品数量
	paraAray[8] = request.getParameter("num4");				//100元奖品数量
	paraAray[9] = request.getParameter("num5");				//200元奖品数量
    paraAray[10] = request.getParameter("leavePoint");		//剩余点数

 	
	//String[] ret = impl.callService("s1444Cfm",paraAray,"2","phone",request.getParameter("phoneNo"));
%>
	<wtc:service name="s1444Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
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
		<wtc:param value="<%=paraAray[10]%>" />
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode=1557"+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+pringAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
<script language="JavaScript">
   rdShowMessageDialog("兑奖成功！",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("兑奖失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
