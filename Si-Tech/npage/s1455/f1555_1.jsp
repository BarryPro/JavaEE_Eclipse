<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 入网奖品领取1455
   * 版本: 1.0
   * 日期: 2008/12/30
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>入网奖品领取</title>
<%
	String opCode="1455";
	String opName=" 入网奖品领取";
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;

    String[] favStr=new String[favInfo.length];
    for(int i=0;i<favStr.length;i++)
    	favStr[i]=favInfo[i][0].trim();
    
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
  onload=function()
  {
	 	self.status="";
	    document.all.srv_no.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	controlButt(subButton);				//延时控制按钮的可用性
	if(!check(frm)) return false;
	frm.action="f1555_query.jsp";
	frm.submit();	  
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">入网预存领奖</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">手机号码</td> 
		<td> 
			<input type="text" size="12" name="srv_no" id="srv_no" value=<%=phoneNo%> v_minlength=1 v_maxlength=16 v_type="mobphone" maxlength="11" index="0" class="InputGrey" readOnly>
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td align="center" id="foot" colspan="2"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
 	<%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>