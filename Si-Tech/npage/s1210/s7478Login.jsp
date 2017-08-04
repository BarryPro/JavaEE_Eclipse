<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-28 页面改造,修改样式
     *删除了根据免密码权限校验的密码校验功能.
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
    <title>黑名单变更</title>
    <%
        String opCode = "7478";
        String opName = "取消网管黑名单功能";
        String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
        activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
        System.out.println("##########################s7478Login.jsp->activePhone->"+activePhone);
    %>

    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
    <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
    <script language=javascript>
        //----------------验证及提交函数-----------------
        function doCfm()
        {
        		if(document.all.srv_no.value.trim().len()==0){
        			parent.removeTab("<%=opCode%>");
        			return false;
        		}
            frm.action = "s7478Cfm.jsp";
            frm.submit();
        }
        
        //alert(parent.g_activateTab);
    </script>
</head>
<body>

<form name="frm" method="POST">
    <%@ include file="/npage/include/header.jsp" %>
    <input type="hidden" name="ReqPageName" id="ReqPageName" value="s6945Login">
    <input type="hidden" name="activePhone" value="<%=activePhone%>">
<!--
    <div class="title">
        <div id="title_zi">如页面未自动跳转,请手动点击"确认"按钮</div>
    </div>  -->

    <table cellspacing="0">
        <tr>
            <td width="16%" align=center class="blue"><font color="red">注意事项</font></td>
            <td width="84%" class="blue"><font color="red">此页面只针对网管黑名单业务，做黑名单取消功能使用</font>
            </td>	
        </tr>    
        <tr>
            <td width="16%" align=center class="blue">服务号码</td>
            <td>
                <input class="InputGrey" value="<%=activePhone%>" name="srv_no" id="srv_no" readonly>
            </td>
        </tr>

        <tr>
            <td id="footer" colspan="2">
                <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2">
                &nbsp;
                <input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>')">
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
