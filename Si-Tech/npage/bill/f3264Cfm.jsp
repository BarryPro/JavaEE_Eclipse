<%
/********************
* 功能: 可选套餐包年冲正 3264
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-11-27
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
    //SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String paraAray[] = new String[6];	

	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
    paraAray[3] = work_no;
    paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
%>
    <wtc:service name="s3264Confirm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="err_code_s3264Confirm" retmsg="err_msg_s3264Confirm" outnum="2">
        <wtc:param value="<%=paraAray[0]%>"/>
        <wtc:param value="<%=paraAray[1]%>"/>
        <wtc:param value="<%=paraAray[2]%>"/>
        <wtc:param value="<%=paraAray[3]%>"/>
        <wtc:param value="<%=paraAray[4]%>"/>
        <wtc:param value="<%=paraAray[5]%>"/>
    </wtc:service>
<%
	//String[] ret = impl.callService("s3264Confirm",paraAray,"2","region",org_code.substring(0,2));
	String errCode = err_code_s3264Confirm;
	String errMsg = err_msg_s3264Confirm;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+"3264"+"&retCodeForCntt="+errCode+"&opName="+"可选套餐包年冲正"+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	if (errCode.equals("000000") )
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("可选资费包年冲正成功！",2);
	window.location="f3250_login.jsp?activePhone=<%=paraAray[1]%>&opCode=3264&opName=可选套餐包年冲正";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("可选包年套餐冲正失败!(<%=errMsg%>",0);
	window.location="f3250_login.jsp?activePhone=<%=paraAray[1]%>&opCode=3264&opName=可选套餐包年冲正";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true" />
