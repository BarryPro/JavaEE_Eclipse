<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zgbj";
    String opName = "托收电子发票购买方设置";
	String hth=request.getParameter("hth");
	String gmf ="";//  request.getParameter("gmf");
	String stype =  request.getParameter("stype");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String s_op_note="托收电子发票购买方设置";
%>
 <%@ include file="/npage/include/header.jsp" %>   
<wtc:service name="bs_zgbjCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4">
			<wtc:param value="<%=hth%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=gmf%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=s_op_note%>"/>
			<wtc:param value="<%=stype%>"/>
		 
 
		 	
</wtc:service>
  
<wtc:array id="result1" scope="end" />
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>托收电子发票购买方设置</TITLE>
<script language="javascript">
	function del1()
	{
		var gfhm = document.all.gfhm.value;
		//var gfhmmc = document.all.gfhmmc.value; 
		var gfhmmc = "";
		//alert("2 gfhm is "+gfhm);
		var prtFlag=0;
		prtFlag=rdShowConfirmDialog("是否确认删除操作?");
		if (prtFlag==1)
		{
			document.frm_print.action="zgbj_del3.jsp?gfhm="+gfhm+"&stype=del"+"&gfhmmc="+gfhmmc+"&hth="+"<%=hth%>";
			document.frm_print.submit();
		}
		else
		{
			return false;
		}
		
	}
</script>
</HEAD>
<body>
	<form action="" name="frm_print" method="post">
<%
	if(retCode2=="000000" ||retCode2.equals("000000") )
	{
		//展示
		%>
	 
				
					<table cellspacing="0">
						<tr>
							<td class="blue">购买方号码:<input type="text" name="gfhm" value="<%=result1[0][2]%>" ></td>
						</tr>
						<!--
						<tr>
							<td class="blue">购买方名称:<input type="text" name="gfhmmc" value="<%=result1[0][3]%>" maxlength="60" size="60"></td>
						</tr>
						 -->
					</table>
				<table cellSpacing="0">
					<tr> 
					  <td id="footer"> 
						   <input type="button" name="query" class="b_foot" value="删除" onclick="del1()" >
						  &nbsp;
						  <input type="button" name="return1" class="b_foot" value="返回" onclick="window.location.href='zgbj_update.jsp'" >
						  &nbsp;
						 <!--
						  <input type="button" name="reprint"  class="b_foot" value="重打发票" onclick="doreprint()">
						  -->
						  &nbsp;
						  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
					   </td>
					</tr>
				  </table>
					<%@ include file="/npage/include/footer_simple.jsp"%>
		 
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询失败！错误代码:"+"<%=retCode2%>,错误原因:"+"<%=retMsg2%>");
				history.go(-1);
			</script>
		<%
	}
%>

 </form>
</BODY></HTML>

