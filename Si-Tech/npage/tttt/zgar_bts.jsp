<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-19 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 
<%
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
  
    //路由
	String regionCode = org_code.substring(0,2);
	 
	String invoice_number = WtcUtil.repNull(request.getParameter("invoice_number"));
	String invoice_code = WtcUtil.repNull(request.getParameter("invoice_code"));
	String s_phone_no = WtcUtil.repNull(request.getParameter("s_phone_no"));
	String invoice_accept = WtcUtil.repNull(request.getParameter("invoice_accept"));
	String s_dates = WtcUtil.repNull(request.getParameter("s_dates"));

 	String outPath="";
    String out_file="";
    String exePath = "";
	File temp1 = null;
	int secNum=0;
	
	 //zgar_bts.jsp?s_phone_no="+phone_no+"&invoice_number="+fphm+"&invoice_code="+fpdm+"&invoice_accept="+ls+"&s_dates="+s_dates
 
%>	 
  
<wtc:service name="bs_EInvPush" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
	<wtc:param value="zgar"/> 
    <wtc:param value="<%=workNo%>"/> 
	<wtc:param value="<%=nopass%>"/>
	<wtc:param value="<%=s_phone_no%>"/>
	<wtc:param value=""/>
	<wtc:param value="zgar补推送"/>
	<wtc:param value=""/>
	<wtc:param value="<%=invoice_code%>"/>
	<wtc:param value="<%=invoice_number%>"/>
	<wtc:param value="<%=invoice_accept%>"/>
	<wtc:param value="<%=s_dates%>"/>
	<wtc:param value=""/>
</wtc:service>
<wtc:array id="sretcode" scope="end" />
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;
	if(retCode=="000000" ||retCode.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("补推送成功!");
				window.location.href="zgar_1.jsp";
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("补推送失败!错误代码:"+"<%=retCode%>"+",错误原因:"+"<%=retMsg%>");
				window.location.href="zgar_1.jsp";
			</script>
		<%
	}
%>

 
 

	
 
