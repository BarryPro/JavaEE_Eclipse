<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *废弃了页面密码验证功能
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "7160";
	String opName = "订报送好礼";
%>
<html>
<head>
<title>订报送好礼</title>

    <script language=javascript>
				onload=function(){
				    //如果号码为空,则关闭此页面
				    if (<%=activePhone%>==null||<%=activePhone%>=="") {
				        parent.removeTab('<%=opCode%>');
				        return false;
				    }					
					  /*doCfm();*/	
				}
				
        function doCfm()
        {
			document.all.opcode.value="7160";
			frm.action="f7160_1.jsp";
			frm.submit();
        }
    </script>
	</head>

	<body>
	<form name="frm" method="POST">
    	<input type="hidden" name="opcode">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">订报送好礼</div>
			</div>
	    <table cellspacing="0">
	        <tr>
	          <td width="16%" class="blue">服务号码</td>
	          <td>
	             <input class="InputGrey" type="text" value="<%=activePhone%>" size="12" name="srv_no" id="srv_no" readonly>
	          </td>
	        </tr>
	        <tr>
	            <td colspan="2" id="footer">
	                <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm()">
	                <input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>')">
	            </td>
	        </tr>
	    </table>
	    <%@ include file="/npage/include/footer_simple.jsp" %>
	</form>
</body>
</html>