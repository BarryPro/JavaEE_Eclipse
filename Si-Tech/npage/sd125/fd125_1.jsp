<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
    /*
   * ����: APN����
   * �汾: 1.0
   * ����: 2011/1/17
   * ����: jianglei
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");

	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">

function frmCfm()
{
	frm.submit();
}

function printCommit()
{
	if(document.all.phoneNo.value == "")
	{
		rdShowMessageDialog("����д�ֻ��ţ�");
		return false;
	}
	if(document.all.bizType.value == "")
	{
		rdShowMessageDialog("��ѡ��ҵ�����ͣ�");
		return false;
	}
	
	document.all.commit.disabled = true;//Ϊ��ֹ����ȷ��

	//�ύ��
	frmCfm();
	
	return true;
}

</script>

</head>
<body>
<form name="frm" method="post" action="fd125Info.jsp" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input  type="hidden" name="opCode" id="opCode" value="<%=opCode%>" size="20" >
	<input  type="hidden" name="opName" id="opName" value="<%=opName%>" size="20" >
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>�ֻ�����</td>
	    <td width="35%">
	    	<input  type="text" name="phoneNo" id="phoneNo" value="" size="20" >
	    </td>
	    <td class="blue" width="15%" nowrap>ҵ������</td>
	    <td width="35%">
	    	<select name="bizType" id="bizType" >
	    		<!--<option value="">--��ѡ��--</option>-->
			    <option value="57">MM</option>
      		</select>
	    </td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="ȷ��" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp;
			<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
			&nbsp;
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
