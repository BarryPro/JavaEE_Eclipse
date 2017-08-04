 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	 String opCode = request.getParameter("opCode");
  	 String opName = request.getParameter("opName");
	
	String work_no = (String)session.getAttribute("workNo");	
	String paraAray[] = new String[9];
	String phoneNo=request.getParameter("phoneNo");
	paraAray[0] = request.getParameter("phoneNo");//手机号码
	paraAray[1] = work_no;//工号
   	paraAray[2] = "1558";//操作代码
	paraAray[3] = request.getParameter("awardId");//奖项级别
	paraAray[4] = request.getParameter("awardNo");//奖品代码
	paraAray[5] = request.getParameter("inTotal").trim();//账号日期
	paraAray[6] = request.getParameter("payAccept").trim();//奖品流水
	paraAray[7] = request.getParameter("opNote").trim();//备注
    	paraAray[8] = request.getParameter("printAccept");//打印流水
    	//String[] ret = impl.callService("s1558Cfm",paraAray,"2","phone",request.getParameter("phoneNo"));
    %>
    	<wtc:service name="s1558Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>		
	</wtc:service>
    <%		
	String errCode=retCode1;
	String errMsg=retMsg1;
	if (errCode.equals("000000"))
	{
%>
		<script language="JavaScript">
		   	rdShowMessageDialog("短信类领奖成功！",2);
		   	history.go(-2);
		</script>
<%
	}else{
%>   
		<script language="JavaScript">
			rdShowMessageDialog("短信类领奖失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
			history.go(-1);
		</script>
<%}%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[8]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />