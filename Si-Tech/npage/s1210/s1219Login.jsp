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

<%
    request.setCharacterEncoding("GBK");
    HashMap hm = new HashMap();
    hm.put("1", "该用户对应的客户客户ID不存在！");
    hm.put("3", "用户密码错误，请重新输入！");
    hm.put("4", "手续费不确定，您不能进行任何操作！");

    hm.put("2", "用户信息不全，禁止操作，请联系系统管理员！");
    hm.put("8", "出帐期间，禁止办理此业务！");
    hm.put("10", "用户特服信息不存在!");
    hm.put("11", "用户资料不存在->11!");
    hm.put("12", "调用服务返回参数失败->12!");
    hm.put("13", "该地区下无特服配置信息->13!");
    hm.put("14", "用户资料不存在->14!");
%>
<html>
<head>
    <title>特服变更</title>
    <%
        String opCode = "1219";
        String opName = "特服变更";
        String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
        activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
        System.out.println("##########################s1219Login.jsp->activePhone->"+activePhone);
    %>

    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
    <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
    <script language=javascript>
        onload = function()
        {
            self.status = "";

        <%
            if(ReqPageName.equals("s1219Main")){
                String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
                if(!retMsg.equals("100") && !retMsg.equals("101")){
        %>
            			rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
        <%
              	}else if(retMsg.equals("100")){
        %>
            		  rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费<%=WtcUtil.repNull(request.getParameter("oweFee"))%>元，不能办理业务！');
        <%
                }else if(retMsg.equals("101")){
        %>
            		  rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%>：<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
        <%
                }
        %>
        				parent.removeTab("<%=opCode%>");
        <%      
              } /*else{*/
        %>
	        			/*doCfm(); */
        <%    	
             /*}*/
        %>
        }


        //----------------验证及提交函数-----------------
        function doCfm()
        {
        		if(document.all.srv_no.value.trim().len()==0){
        			parent.removeTab("<%=opCode%>");
        			return false;
        		}
            frm.action = "s1219Main.jsp";
            frm.submit();
        }
        
        //alert(parent.g_activateTab);
    </script>
</head>
<body>

<form name="frm" method="POST">
    <%@ include file="/npage/include/header.jsp" %>
    <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1219Login">
    <input type="hidden" name="activePhone" value="<%=activePhone%>">
<!--
    <div class="title">
        <div id="title_zi">如页面未自动跳转,请手动点击"确认"按钮</div>
    </div>  -->

    <table cellspacing="0">
        <tr>
            <td width="16%" class="blue">服务号码</td>
            <td>
                <input class="InputGrey" value="<%=activePhone%>" name="srv_no" id="srv_no" readonly>
            </td>
        </tr>

        <tr>
            <td id="footer" colspan="2">
                <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2">
                <input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>')">
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
