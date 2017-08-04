<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 温馨家庭取消1252
   * 版本: 1.0
   * 日期: 2008/12/24
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>

<%
	String opCode="1252";
	String opName="温馨家庭取消";
	String phoneNo = (String)request.getParameter("activePhone");
	String work_no =(String)session.getAttribute("workNo");    		         //工号
	String loginName =(String)session.getAttribute("workName");               //工号名称
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");		//优惠权限信息
	String regionCode = (String)session.getAttribute("regCode");
	String org_Code =(String)session.getAttribute("orgCode");				//归属代码（机构代码）
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>温馨家庭取消 </title>
<%
	boolean workNoFlag=false;
	if(work_no.substring(0,1).equals("k"))
	  workNoFlag=true;
	
    String[] favStr=new String[favInfo.length];
	for(int i=0;i<favStr.length;i++)
	 favStr[i]=favInfo[i][0].trim();
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
  onload=function()
  {
	  self.status="";
	  document.all.srv_no.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	controlButt(subButton);					//延时控制按钮的可用性
  if(check(frm))
  {
	  frm.action="f1252Main.jsp";
	  frm.submit();	
  }
}
</script>
</head>
<body>
<form name="frm" method="POST">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作</div>
	</div>
	<table cellspacing="0">
		<tr> 
			<td class="blue" width="20%">手机号码(主卡) </td>
			<td> 
				<input type="text" size="12" name="srv_no" v_must="1" id="srv_no" value=<%=phoneNo%> class="InputGrey" readOnly>
				<font color="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td colspan="2" align="center" id="footer"> 
				<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
				<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
			</td>
		</tr>
	</table>
 	<%@ include file="../../npage/common/pwd_comm.jsp" %>
 	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>