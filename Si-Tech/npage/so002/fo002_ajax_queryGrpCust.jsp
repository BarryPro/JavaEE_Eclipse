<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><TITLE>������Ϣ��ѯ</TITLE>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String opCode = "5082";
	String opName = "������Ϣ��ѯ";
	
	String unitId = request.getParameter("unitId");//��ѯ����
%>

	<wtc:service name="sGrpInfoQry"  outnum="16" retcode="errcode" retmsg="errmsg" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="5082" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=unitId%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
		
	

</HEAD>

<% if (!"000000".equals(errcode) || result1[0][0].trim().equals("")) {%>
<script language="javascript">
	rdShowMessageDialog("û���ҵ��κ�����");
	history.go(-1);
</script>
<%}else{%>
<body>
<form method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������Ϣ��ѯ</div>
</div>
		<table cellSpacing=0>
			<tr> 
			  <td class='blue' nowrap>���ű��</TD>
			  <td><input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value="<%=result1[0][0]%>">
			  </TD>
			  <td class='blue' nowrap>��������</TD>
			  <TD><input type="text" readonly class="InputGrey"  name="beginFlag" size="20" maxlength="1" value="<%=result1[0][1]%>"></TD>
			</TR>
			<TR> 
			  <td class='blue' nowrap>VPMN����</TD>
			  <TD><input type="text" readonly  class="InputGrey" name="openTime" size="20" maxlength="20" value="<%=result1[0][2]%>"></TD>
			  <td class='blue' nowrap>�ͻ�ID</TD>
			  <TD><input type="text" readonly class="InputGrey" name="oldExpire" size="20" maxlength="20" value="<%=result1[0][10]%>"></TD>
			</TR>
			<TR> 
			  <td class='blue' nowrap>�ͻ�������</TD>
			  <TD><input type="text" readonly class="InputGrey" name="expireTime" size="20" maxlength="20" value="<%=result1[0][11]%>" ></TD>
			  <td class='blue' nowrap>��������</TD>
			  <TD><input type="text" readonly class="InputGrey" name="remain_fee" size="20" maxlength="20" value="<%=result1[0][3]%>"></TD>
			</TR>  
			<TR> 
			  <td class='blue' nowrap>��ϵ�绰</TD>
			  <TD colspan =1><input type="text" readonly class="InputGrey" name="opNote" size="20" maxlength="60" value="<%=result1[0][4]%>"></TD>
			  <td class='blue' nowrap>֤������</TD>
			  <TD><input type="text" readonly class="InputGrey" name="id_iccid" size="20" maxlength="20" value="<%=result1[0][12]%>"></TD>
			</TR>               
		  </table>

<div id="Operation_Table">
    <table cellspacing=0>
      <tr id="footer"> 
		<td>
			  <input class="b_foot" type=button value="ȷ��"  onClick="selectCustId('<%=result1[0][10]%>','<%=result1[0][1]%>','<%=result1[0][11]%>');" />
			  <input class="b_foot" name=back onClick="window.location.href='fo001_custQuery.jsp'" type=button value=����>
			  <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
		</td>
	  </tr>
	</table>
</div>

<%@ include file="/npage/include/footer.jsp" %>
</form>

<script language="javascript">
	
	function selectCustId(AddCustId,AddCustName,AddCustLogin)
	{
		//parent.parent.setCustId(AddCustId,AddCustName,AddCustLogin);
		window.opener.setCustId(AddCustId,AddCustName,AddCustLogin);
		window.close();
	}

</script>

</body></html>
<%}%>