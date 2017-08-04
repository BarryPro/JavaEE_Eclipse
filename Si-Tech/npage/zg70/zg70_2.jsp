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
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zg70";
		String opName = "省级工号关系配置";
		String sjgh = request.getParameter("sjgh");
		String[] inParas2 = new String[2];
		inParas2[0]="select to_char(count(*)) from shighlogin_boss where op_code='zg70' and login_no=:s_no ";
		inParas2[1]="s_no="+sjgh;
		String s_ret="";
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
	if(Integer.parseInt(ret_val[0][0])>0)
	{
		s_ret="1";//有值 则展示内容 并有删除按钮
	}
	else
	{
		s_ret="0";//无值 展示添加按钮
	}
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaa s_ret is "+s_ret);
	//s_ret="1";
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjttj()
{
	//alert("1");
	var login_no = document.all.login_no.value;
	if(login_no=="")
    {
		rdShowMessageDialog("请输入省级工号!");
		return false;
	}
	else
	{
		//1. 展示结果 如果未添加 则可展示添加按钮 如果已添加则展示删除按钮；
		//2. 上线前跟宫剑确认下 是否省级工号的退费权限都按照800001的 都不判断工号权限(跨地市那种)
		document.frm.action="zg70_2.jsp?sjgh="+login_no;
		document.frm.submit();
	}
	
}
 


 function doclear() {
 		frm.reset();
 }
   
 function doCfm(flag)
 {
	//alert(flag);
	//插入 就是插入shighlogin_boss opcode=zg70的工号记录
	//删除 就是删除shighlogin_boss opcode=zg70的工号记录
	var	prtFlag = rdShowConfirmDialog("工号"+"<%=sjgh%>"+",是否确定本次操作?");
	if (prtFlag==1)
	{
		frm.action="zg70_3.jsp?flag="+flag;
		//alert(frm.action);
		frm.submit();
	}
 }
 function dels()
 {
 }
 
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
	<%@ include file="/npage/include/header.jsp" %>
	<%
		if(s_ret=="0" ||s_ret.equals("0"))
		{
			%>
				<table cellspacing="0">
					<tr> 
					  <td class="blue" width="15%">省级工号</td>
					  <td> 
						<input class="button"type="text" name="login_no" size="14" maxlength="14" value="<%=sjgh%>" readonly>
					  </td>
					  
					</tr>
					
				 </table>

				 <table cellSpacing="0">
					<tr> 
					  <td id="footer"> 
						   <input type="button" name="add" class="b_foot" value="添加" onclick="doCfm('a')" >
						  &nbsp;
						  <input type="button" name="return1" class="b_foot" value="返回" onclick="window.location.href='zg70_1.jsp'" >
						  &nbsp;
							  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
					  </td>
					</tr>
				 </table>
			<%
		}
		else
		{
			%>
				<table cellspacing="0">
					<tr> 
					  <td class="blue" width="15%">省级工号</td>
					  <td> 
						<input class="button"type="text" name="login_no" size="14" maxlength="14" value="<%=sjgh%>" readonly>
					  </td>
					  
					</tr>
					
				 </table>

				 <table cellSpacing="0">
					<tr> 
					  <td id="footer"> 
						   <input type="button" name="del" class="b_foot" value="删除" onclick="doCfm('d')" >
						  &nbsp;
						  <input type="button" name="return1" class="b_foot" value="返回" onclick="window.location.href='zg70_1.jsp'" >
						  &nbsp;
							  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
					  </td>
					</tr>
				 </table>
			<%
		}
	%>
  	
	

	
  
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
 </BODY>
</HTML>