<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-28 ҳ�����,�޸���ʽ
     *ɾ���˸���������Ȩ��У�������У�鹦��.
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
<title>�ط����</title>
<%
    String opCode = "9992";
    String opName = "�ֻ�֧�����˻�����";
    String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
    activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
    System.out.println("##########################f9992_login.jsp->activePhone->"+activePhone);
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
onload = function()
{
    self.status = "";
}


//----------------��֤���ύ����-----------------
function doCfm()
{
	if(document.all.srv_no.value.trim().len()==0)
	{
		parent.removeTab("<%=opCode%>");
		return false;
	}
	frm.qryPage.disabled=true;
    
    frm.submit();
}
    
</script>
</head>
<body>

<form name="frm" method="POST" action="f9992_1.jsp">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
	    <div id="title_zi"><%=opName%></div>
	</div>
    <input type="hidden" name="activePhone" value="<%=activePhone%>">

    <table cellspacing="0">
        <tr>
            <td width="16%" class="blue">�������</td>
            <td>
                <input class="InputGrey" value="<%=activePhone%>" name="srv_no" id="srv_no" readonly>
            </td>
        </tr>

        <tr>
            <td id="footer" colspan="2">
                <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()" index="2">
                &nbsp;
                <input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
