<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.sitech.boss.s5010.viewBean.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "e356";
	String opName = "�ʻ�������ѷ�����";
  String workno =(String)session.getAttribute("workNo");
  String workname = (String)session.getAttribute("workName");
  String orgcode =((String)session.getAttribute("orgCode")).substring(0, 2);//��������
  String userPhoneNo = (String)request.getParameter("activePhone");
%>

<head>
<title>������BOSS-�ʻ�������ѷ�����</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0) {
		if(s_keycode>=48 && s_keycode<=57) {
			return true;
		} else {
			return false;
		}
    } else if (ifdot==1) {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46) {
		      return true;
		} else if(s_keycode==45) {
		    rdShowMessageDialog('���������븺ֵ,����������!');
		    return false;
		} else {
		    return false;
		}
    } else if (ifdot==2) {
        if((s_keycode>=48 && s_keycode<=57) || s_keycode==46 || s_keycode==45) {
		      return true;
		} else {
		    return false;
		}
    }
}


function dosubmit()
{
	
  if (document.mainForm.busyType.value.length == 0) 
	{
      rdShowMessageDialog("��ѡ��������ͣ���")
      return false;
  }
  
	if ( document.mainForm.busyType.value == "I"
		&& document.mainForm.i_awake_fee.value.length == 0) 
	{
      rdShowMessageDialog("���ѷ�ֵ����Ϊ�գ����������� !!")
      document.mainForm.i_awake_fee.focus();
      return false;
  }
  
  document.mainForm.submit();
}

</script>
</head>

<body >

<form action="e356_2.jsp" method="post" name="mainForm">
	<%@ include file="/npage/include/header.jsp" %>
  <input type="hidden" id="opCode" name="opCode" value="<%=opCode%>">
		<div class="title">
			<div id="title_zi">�ʻ�������ѷ�����</div>
		</div>   

				<table cellspacing="0">
					<tr>
						<td nowrap class="blue">�������</td>
						<td >
							<input class="button" type="text" name="phone_no" maxlength="11" value=<%=userPhoneNo%>
							<font class="orange"> *</font>
						</td>
						

				<td nowrap class="blue">��������</td>
				<td width="20%">
					<select name="busyType" onClick="" >
						<option value="" selected>--��ѡ���������</option>
						<option value="U">����</option>
						<option value="D">ɾ��</option>

					</select>
				</td>
				
						<td class="blue" nowrap>���ѷ�ֵ</td>
						<td width="35%">
							<input class="button" type="text" name="i_awake_fee" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
							<font class="orange"> *</font>
						</td>
					</tr>

				</table>

				<!-- ���ܰ�ť��ʼ -->
				<table cellspacing="1">
					<tr>
						<td noWrap id="footer" colspan="6">
						<input type="button" name="sure" class="b_foot" value="ȷ��"	onClick="dosubmit()"> &nbsp; 
						<input type="button" name="close" class="b_foot" value="�ر�" onClick="window.close()">
						</td>
					</tr>
				</table>
				  	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
