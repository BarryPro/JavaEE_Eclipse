<%
    /********************
     version v2.0
     开发商: si-tech
			*
			*update:zhanghonga@2008-08-15 页面改造,修改样式
			*废弃了页面密码验证的功能
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "1255";
		String opName = "包年申请";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>包年申请</title>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
    <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
    <script language=javascript>
        onload = function()
        {
        	if(<%=activePhone%>==null||<%=activePhone%>==""){
        		parent.removeTab('<%=opCode%>');
        		return false;
        	}
        	
        	//doCfm();
        }

        //----------------验证及提交函数-----------------
        function doCfm()
        {
            frm.action = "f1255Main.jsp";
            frm.submit();
        }
    </script>
</head>
<body>

<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi">包年申请</div>
		</div>
    <table cellspacing="0">
        <tr>
            <td class="blue" nowrap>
                <div align="left">服务号码</div>
            </td>
            <td nowrap>
                <div align="left">
                    <input class="InputGrey" type="text" name="srv_no" value="<%=activePhone%>"id="srv_no" readonly>
                </div>
            </td>
         </tr>
        <tr>
            <td id="footer" colspan="2">
                <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm()">
                <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>
