<%
    /*************************************
    * 功  能: 手机支付主账户现金充值冲正 9995
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-11-2
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>手机支付主账户现金充值冲正</title>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String activePhone1=request.getParameter("activePhone");
%>
</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
function query()
{
    if (document.getElementById("operateAccept").value == "") {
        rdShowMessageDialog("请输入操作流水信息！");
        document.frm.operateAccept.focus();
        return false;
	} 
    if(!check(frm)) return false;
	frm.action="f9995_showCustInfo.jsp";
  	frm.submit();
}

</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
        <table cellspacing="0">
            <tr> 
                <td class="blue">手机号码 </td>
                <td> 
                	<input type="text" size="12" name="activePhone" value="<%=activePhone1%>" id="activePhone" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly />
                	<font color="orange">*</font>
                </td>
            </tr>
            <TR>
                <TD class="blue">操作流水</TD>
                <TD colspan="3">
                    <input type="text" name="operateAccept" v_type="0_9" v_must="1" maxlength="14" id="operateAccept" value="" />
                </TD>
            </TR>
            <tr>
                <td colspan="4" align="center" id="footer">
                <input class="b_foot" type="button" name="queryBtn" value="查询" onClick="query()" />    
                <input class="b_foot" type="button" name="clearBtn" value="清除" onClick="location.reload();" />
                <input class="b_foot" type="button" name="closeBtn" value="关闭" onClick="removeCurrentTab();" />
                </td>
            </tr>
        </table>
<input type="hidden" name="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" value="<%=opName%>" />
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
   
</body>
</html>
