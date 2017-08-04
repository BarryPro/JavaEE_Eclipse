<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
<%
	//String opCode ="g806"; //"d223";
	String opCode= request.getParameter("opCodeType");	
	String opName = "校园放号激活返费金额配置";//"退费统计";
	String regionCode= (String)session.getAttribute("regCode"); 
	String s_login_no = request.getParameter("s_login_no");	
	String pzdsname = request.getParameter("pzdsname");	
	String nopass      = (String)session.getAttribute("password");

	String ljffje="";
	String myffje="";
	String ffys="";
	String ljtype="";	
	String ffzklx="";
	String xfys="";	
	String sfljcy="";
	myffje = request.getParameter("myffje");
	ffzklx =  request.getParameter("ffzklx");	
	ffys = request.getParameter("ffys");
	xfys =  request.getParameter("xfys");	
	sfljcy = request.getParameter("sfljcy");
	ljffje=myffje;
	ljtype=ffzklx;
	ffys=(Integer.parseInt(ffys)-1)+"";	
	System.out.println("ljffje---------------"+ljffje);
	System.out.println("ljtype---------------"+ljtype);
	System.out.println("ffys---------------"+ffys);
	

/*
	 ;
 
	strcpy(s_lj_paytype,	input_parms[2]);
	f_lj_money = atof(input_parms[3]);
 	strcpy(s_lj_time,	input_parms[4]);
	strcpy(s_rest_paytype,	input_parms[5]);
	f_rest_money = atof(input_parms[6]);
 	strcpy(s_rest_time,	input_parms[7]);
  strcpy(s_region_code,	input_parms[8]);
*/
%>
	<wtc:service name="bg806" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="scode" retmsg="sret" outnum="2">
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=s_login_no%>"/>
		<wtc:param value="<%=ljtype%>"/> 
		<wtc:param value="<%=ljffje%>"/> 
 
		<wtc:param value="<%=ffzklx%>"/> 
		<wtc:param value="<%=myffje%>"/>
		<wtc:param value="<%=ffys%>"/> 
		<wtc:param value="<%=pzdsname%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=xfys%>"/>
		<wtc:param value="<%=sfljcy%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
	if((!scode.equals("0"))&& (!scode.equals("000000")))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("配置失败！错误代码"+"<%=scode%>"+",错误原因:"+"<%=sret%>");
				history.go(-1);
			</script>
		<%
	}
	else
	{
		System.out.println("AAAAAAAAAAAAAAAAAA 配置成功");
		%>
			<script language="javascript">
				rdShowMessageDialog("配置成功");
				window.location="g806_1.jsp";
			</script>
		<%
	}
%> 
 	
 

