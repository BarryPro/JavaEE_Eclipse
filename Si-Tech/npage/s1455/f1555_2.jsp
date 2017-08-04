<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 入网预存领奖1455
   * 版本: 1.0
   * 日期: 2008/12/30
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>

<%	
	String opCode="1455";
	String opName=" 入网奖品领取 ";
	String phoneNo = (String)request.getParameter("phoneNo");
	String workNo = (String)session.getAttribute("workNo");
	String loginAccept=(String)request.getParameter("printAccept");
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	String paraAray[] = new String[9];
	paraAray[0] = request.getParameter("phoneNo");		//手机号码
	paraAray[1] = workNo;						  		//工号
    paraAray[2] = "1455";								//操作代码
	paraAray[3] = request.getParameter("awardId");		//奖项级别
	paraAray[4] = request.getParameter("awardNo");		//奖品代码
	paraAray[5] = request.getParameter("inTotal");		//账号日期
	paraAray[6] = request.getParameter("payAccept");	//奖品流水
	paraAray[7] = request.getParameter("opNote");		//备注
    paraAray[8] = request.getParameter("printAccept");	//打印流水
 	
//	String[] ret = impl.callService("s1455Cfm",paraAray,"2","phone",request.getParameter("phoneNo"));
	%>
		<wtc:service name="s1455Cfm" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" retcode="retCode" retmsg="retMsg">
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
		<wtc:array id="result" scope="end"/>
	<%
	String errCode = retCode;
	String errMsg = retMsg;
	
	if (errCode.equals("000000") )
	{
		
%>
<script language="JavaScript">
   rdShowMessageDialog("入网奖品领取成功！",2);
   location="f1555_1.jsp?activePhone=<%=phoneNo%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("入网预存领奖失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
<jsp:include page="<%=url%>" flush="true" />