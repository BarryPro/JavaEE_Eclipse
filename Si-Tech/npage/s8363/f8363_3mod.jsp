<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:营业厅与mac地址绑定配置修改界面
   * 版本: 1.0
   * 日期: 2009/12/18
   * 作者: gaolw
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "8363";
	String opName = "营业厅与mac地址绑定配置";
	String iLoginAccept = "";
	iLoginAccept = getMaxAccept();
	
	String groupId = request.getParameter("groupId"); 
	String groupName = request.getParameter("groupName");
	String macAddr = request.getParameter("macAddr");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">

function commJsp(){//确认按钮
	if(document.form1.macAddr.value.length != 17) {
		rdShowMessageDialog("mac地址必须是17位，请重新输入！");
		document.getElementById("macAddr").focus();
		return false;
	}
	var macAddrOld = document.form1.macAddrOld.value;
	//alert("macAddrOld========"+macAddrOld);
	if(rdShowConfirmDialog('确认要提交修改信息吗？')==1)
	{
		document.form1.action="f8363_3modCfm.jsp?macAddrOld="+macAddrOld;
	 	form1.submit();
	}
}

</script> 
 
<title>修改营业厅与mac地址绑定配置信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="form1"  >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">修改营业厅与mac地址绑定配置信息</div>
	</div>
<table cellspacing="0">  
	<tr>
		<td class="blue" width="15%">营业厅代码</td>
		<td colspan="3">
			<input type="text" name="groupId" value="<%=groupId%>" id="groupId" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly size="40">
		</td>
	</tr>           
	<tr>
		<td class="blue" width="15%">营业厅名称</td>
		<td colspan="3">
			<input type="text" name="groupName" value="<%=groupName%>" id="groupName" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly size="40">	
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">mac地址</td>
		<td colspan="3">
			<input type="text" name="macAddr" value="<%=macAddr%>" id="macAddr" v_must="1" v_type="string" maxlength="17" size="30">
		</td>
	</tr>	
	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="确认" onclick="commJsp()">
			&nbsp;&nbsp;&nbsp;
			<input type="button" name="return" class="b_foot" value="返回" onclick="location='f8363_3.jsp?groupId=<%=groupId%>'">
		</td>
	</tr>
</table>
  <input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="iLoginAccept" value="<%=iLoginAccept%>">
	<input type="hidden" name="macAddrOld" value="<%=macAddr%>">
	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>