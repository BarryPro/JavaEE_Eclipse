<%
    /********************
     version v2.0
     ������: si-tech
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
<title>������˻��ֽ��ֵ</title>
<%
    String opCode = "9452";
    String opName = "������˻��ֽ��ֵ";
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


//----------------��֤���ύ����-----------------
function doCfm()
{
	if(document.all.srv_no.value.trim().len()==0)
	{
		rdShowMessageDialog("�������ֻ�����!");
		document.frm.srv_no.focus();
		return false;
	}
	
	if(document.all.srv_no.value.trim().length<=10)
	{
		rdShowMessageDialog("�����ֻ����벻��ȷ��");
		document.all.srv_no.value="";
		document.all.srv_no.focus();
		return false;
	}
	
	if(document.all.cCPassWd.value.trim()=="")
	{
		if((document.all.idCardType.value=="") || (document.all.idCardNum.value.trim()==""))
		{
			rdShowMessageDialog("�ͷ�������ͻ�֤��������һ����Ϊ�գ�");
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
            <td width="14%" class="blue">�������</td>
            <td width="34">
                <input class="button" type="text" value="<%=phoneNo%>" maxlength="15" size="20" name="srv_no" id="srv_no1" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">&nbsp<font color="red">*</font>
            </td>
            <td width="14%" class="blue">�ͷ�����</td>
            <td width="33">
            	<input class="password" type="password" maxlength="32" size="32" name="cCPassWd" id="cCPassWd">
            </td>
        </tr>
        <tr>
            <td width="14%" class="blue">֤������</td>
            <td width="34">
                <select class="button" type="text" name="idCardType" id="idCardType" >
                	<option value="" selected>-��ѡ��-</option>
                	<option value="00">00-->���֤��</option>
                	<option value="01">01-->VIP��</option>
                	<option value="02">02-->����</option>
                	<option value="04">04-->����֤</option>
                	<option value="05">05-->��װ�������֤</option>
                	<option value="99">99-->����֤��</option>
                </select>
            </td>
            <td width="14%" class="blue">֤������</td>
            <td width="33">
            	<input class="button" type="text" maxlength="32" size="32" name="idCardNum" id="idCardNum">
            </td>
        </tr>

        <tr>
            <td id="footer" colspan="4">
                <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()">
                &nbsp;
                <input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
