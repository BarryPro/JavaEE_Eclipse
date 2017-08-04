<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-24 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	String opCode = request.getParameter("opcode");
	String opName = (String)request.getParameter("opName");	
	String regionCode= (String)session.getAttribute("regCode");
	System.out.println("opCode==================="+opCode);
	System.out.println("opName==================="+opName);
	String work_no =(String)session.getAttribute("workNo");
	String ip_Addr =  (String)session.getAttribute("ipAddr");
		
	String paraAray[] = new String[10];	
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("opcode");
	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("pay_money");
	paraAray[5] = request.getParameter("gprs_phone");
	paraAray[6] = request.getParameter("opNote");
	paraAray[7] = request.getParameter("ip_Addr");           
    paraAray[8] = request.getParameter("order_code");
    paraAray[9] = request.getParameter("bind_mode");
	//String[] ret = impl.callService("s8074Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s8074Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
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
<%
	String errCode = retCode1;
	System.out.println("errCode================"+errCode);
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("确认成功！",2);
			history.go(-2);
		</script>
<%
	}else{
%>   
		<script language="JavaScript">
			rdShowMessageDialog("预存话费送笔记本确认失败!(<%=errMsg%>",0);
			history.go(-2);
		</script>
<%}%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
