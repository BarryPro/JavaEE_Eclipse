<% 
  /*
   * ����: �������������ܺ������ۺ�����_���������ѯ
�� * �汾: v1.00
�� * ����: 2010/03/22
�� * ����: dujl
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
<title>�������������ܺ������ۺ�����_���������ѯ</title>

<%
String opCode = "6945";
String opName = "�������������ܺ������ۺ�����_���������ѯ";

String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
/*String phoneNoPw = WtcUtil.repNull(request.getParameter("phoneNoPw"));*/
String phoneNoPw = "";

String isBlackName="";
String isGsmsName="";

String printAccept="";
printAccept = getMaxAccept();

System.out.println("#######################################phoneNo->" + phoneNo);
System.out.println("#######################################phoneNoPw->" + phoneNoPw);
%>

<wtc:service name="s6945Qry" routerKey="phone" routerValue="<%=phoneNo%>" retCode="initRetCode" retMsg="initRetMsg" outnum="10">
<wtc:param value="0"/>
<wtc:param value="01"/>
<wtc:param value="6945"/>
<wtc:param value="<%=work_no%>"/>
<wtc:param value="<%=loginNoPass%>"/>
<wtc:param value="<%=phoneNo%>"/>
<wtc:param value="<%=phoneNoPw%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
System.out.println("initRetCode=================="+initRetCode);
System.out.println("initRetMsg==================="+initRetMsg);

System.out.println("result[0][0]=================="+result[0][0]);
System.out.println("result[0][1]=================="+result[0][1]);
System.out.println("result[0][2]=================="+result[0][2]);
System.out.println("result[0][3]=================="+result[0][3]);
System.out.println("result[0][4]=================="+result[0][4]);
System.out.println("result[0][5]=================="+result[0][5]);
System.out.println("result[0][6]=================="+result[0][6]);
System.out.println("result[0][7]=================="+result[0][7]);
System.out.println("result[0][8]=================="+result[0][8]);

if(!(initRetCode.equals("000000")))
{
%>
	<script language=javascript>
		rdShowMessageDialog("������Ϣ��<%=initRetMsg%>");
		window.location="s6945Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
if((result==null) || (result.length == 0))
{
%>
	<script language=javascript>
		rdShowMessageDialog("������Ϣ��<%=initRetMsg%>");
		window.location="f6945_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
if(result[0][0].equals("Y"))
{
	isBlackName="��";
}
else if(result[0][0].equals("N"))
{
	isBlackName="��";
}
if(result[0][4].equals("Y"))
{
	isGsmsName="��";
}
else if(result[0][4].equals("N"))
{
	isGsmsName="��";
}

if((result[0][0].equals("N")) && (result[0][4].equals("N")))
{

}
%>

<script language=javascript>
onload=function()
{
	init();
}

function init()
{
	if(("<%=result[0][0]%>" != "Y") && ("<%=result[0][4]%>" != "Y"))
	{
		document.all.b_add.disabled=false;
		document.all.b_change.disabled=true;
	}
	else
	{
		document.all.b_add.disabled=true;
		document.all.b_change.disabled=false;
	}
}

function add()
{
	frm.action="f6945_add.jsp";
	frm.submit();
}

function change()
{
	frm.action="f6945_chg.jsp?";
	frm.submit();
}

</script>

</head>
<body>
<form name="frm" method="POST" action="">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>�ֻ�����</td>
	    <td colspan="3">
	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="30" readonly>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>�Ƿ��Ǻ������û�</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="isBlack" id="isBlack" value="<%=isBlackName%>" size="30" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>�����������ԭ��</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="blackReason" id="blackReason" value="<%=result[0][1]%>" size="30" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>�������Ĳ�������</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="blackLogin" id="blackLogin" value="<%=result[0][2]%>" size="30" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>�������Ĳ���ʱ��</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="blackTime" id="blackTime" value="<%=result[0][3]%>" size="30" readonly>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>�Ƿ������������û�</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="isGsms" id="isGsms" value="<%=isGsmsName%>" size="30" readonly>
	    </td>
	  	<td class="blue" width="15%" nowrap>��������ȡ��ʱ��</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="gsmsCancle" id="gsmsCancle" value="<%=result[0][8]%>" size="30" readonly>
	    </td>

	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>�������ŵĲ�������</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="gsmsLogin" id="gsmsLogin" value="<%=result[0][6]%>" size="30" readonly>
	    </td>
	    <td nowrap class="blue" width="15%">�������ŵĲ���ʱ��</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="gsmsTime" id="gsmsTime"  value="<%=result[0][7]%>" size="30" readonly>
	    </td>
	</tr>
	<tr>
    <!--huangrong update ���� 2011-6-22--> 
    <td nowrap class="blue" width="15%">�����������ŵ�ԭ��</td>
    <td colspan="3">
    	<input class="InputGrey" type="text" name="gsmsReason" id="gsmsReason"  value="<%=result[0][5]%>" size="140" readonly>
    </td>	    
	</tr>
    <tr>
        <td colspan="4" id="footer">
            <input class="b_foot" type="button" name="b_add" value="���" onClick="add();" disabled>
            &nbsp;
            <input class="b_foot" type="button" name="b_change" value="�޸�" onClick="change();" disabled>
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="����" onClick="history.go(-1);">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="�ر�" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="loginAccept" value="<%=printAccept%>">
<input type="hidden" name="isBlack1" value="<%=result[0][0]%>">
<input type="hidden" name="isGsms1" value="<%=result[0][4]%>">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>