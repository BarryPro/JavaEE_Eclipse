<% 
  /*
   * ����: �������������ܺ������ۺ�����_��������ѯ_���
�� * �汾: v1.00
�� * ����: 2012/05/16
�� * ����: diling
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>�������������ܺ������ۺ�����_��������ѯ_���</title>

<%
String opCode = "e851";
String opName = "�������������ܺ������ۺ�����_��������ѯ_���";

String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));

System.out.println("#######################################phoneNo->" + phoneNo);
%>

<script language=javascript>

function confirm()
{
	if(document.all.opType.value == "")
	{
		rdShowMessageDialog("�������Ͳ���Ϊ�գ�");
		return -1;
	}
	if(document.all.delayType.value == "")
	{
		rdShowMessageDialog("���ڱ�־����Ϊ�գ�");
		return -2;
	}
	frm.submit();
}

function goBack(){
  window.location.href="f6945_netsPhoneNoQry.jsp?phoneNo=<%=phoneNo%>";
}

</script>

</head>
<body>
<form name="frm" method="POST" action="f6945_netsPhoneNoQryCfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="10%" nowrap>�ֻ�����</td>
	    <td class="blue" width="20%">
	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="30" readonly>
	    </td>
	    <td class="blue" width="10%" nowrap>��������</td>
	    <td class="blue" width="20%">
	    	<select name="opType" id="opType" class="button" >
	    		<option value="A">���Ϊ����������û�</option>
	    	</select>
	    </td>
	    <td class="blue" width="10%" nowrap>���ڱ�־</td>
	    <td class="blue" width="20%">
	    	<select name="delayType" id="delayType" class="button" >
	    		<option value="N">��ͣ7��</option>
	    		<option value="T" selected>���ڹ�ͣ</option>
	    	</select>
	    </td>	    
	</tr>
    <tr>
        <td colspan="6" id="footer">
            <input class="b_foot" type="button" name="b_add" value="ȷ��" onClick="confirm();">
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="����" onClick="goBack()">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="�ر�" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>