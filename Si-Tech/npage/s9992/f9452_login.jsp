<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>异地主账户现金充值</title>
<%
    String opCode = "9452";
    String opName = "异地主账户现金充值";
    String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
    activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
    System.out.println("##########################f9992_login.jsp->activePhone->"+activePhone);
    
    String phoneNo = (String)request.getParameter("activePhone");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
onload = function()
{
    self.status = "";
}


//----------------验证及提交函数-----------------
function doCfm()
{
	if(document.all.srv_no.value.trim().len()==0)
	{
		rdShowMessageDialog("请输入手机号码!");
		document.frm.srv_no.focus();
		return false;
	}
	
	if(document.all.srv_no.value.trim().length<=10)
	{
		rdShowMessageDialog("输入手机号码不正确！");
		document.all.srv_no.value="";
		document.all.srv_no.focus();
		return false;
	}
	
	if(document.all.cCPassWd.value.trim()=="")
	{
		if((document.all.idCardType.value=="") || (document.all.idCardNum.value.trim()==""))
		{
			rdShowMessageDialog("客服密码与客户证件必须有一个不为空！");
			document.all.idCardType.value="";
			document.all.idCardNum.value="";
			return false;
		}
	}
    
    frm.submit();
}
    
</script>
</head>
<body>

<form name="frm" method="POST" action="f9452_1.jsp">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
	    <div id="title_zi"><%=opName%></div>
	</div>
    <input type="hidden" name="activePhone" value="<%=activePhone%>">

    <table cellspacing="0">
        <tr>
            <td width="14%" class="blue">服务号码</td>
            <td width="34">
                <input class="button" type="text" value="<%=phoneNo%>" maxlength="15" size="20" name="srv_no" id="srv_no1" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">&nbsp<font color="red">*</font>
            </td>
            <td width="14%" class="blue">客服密码</td>
            <td width="33">
            	<input class="password" type="password" maxlength="32" size="32" name="cCPassWd" id="cCPassWd">
            </td>
        </tr>
        <tr>
            <td width="14%" class="blue">证件类型</td>
            <td width="34">
                <select class="button" type="text" name="idCardType" id="idCardType" >
                	<option value="" selected>-请选择-</option>
                	<option value="00">00-->身份证件</option>
                	<option value="01">01-->VIP卡</option>
                	<option value="02">02-->护照</option>
                	<option value="04">04-->军官证</option>
                	<option value="05">05-->武装警察身份证</option>
                	<option value="99">99-->其他证件</option>
                </select>
            </td>
            <td width="14%" class="blue">证件号码</td>
            <td width="33">
            	<input class="button" type="text" maxlength="32" size="32" name="idCardNum" id="idCardNum">
            </td>
        </tr>

        <tr>
            <td id="footer" colspan="4">
                <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()">
                &nbsp;
                <input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>')">
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
