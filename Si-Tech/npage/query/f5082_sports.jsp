<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String opCode = "5082";
	String opName = "������Ϣ��ѯ";
	String idNo = request.getParameter("idNo");
	String  inParams [] = new String[2];
	inParams[0] = "Select field_value from dcustmsgadd a where a.id_no= to_number(:idno) and a.field_code='81046'";
	inParams[1] = "idno="+idNo;
%>	
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="ret"  scope="end"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<TITLE>������Ϣ��ѯ</TITLE>
</HEAD>
<%if (!"000000".equals(retCode1)){%>
		<script language="javascript">
			rdShowMessageDialog("�������:<%=retCode1%>,������Ϣ:<%=retMsg1%>",0);
			history.go(-1);
		</script>
<%}else if(ret.length == 0){
%>
	<script language="javascript">
		rdShowMessageDialog("û���ҵ��κ�����!");
		history.go(-1);
	</script>
<%		
	}else{%>
<body>
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������Ϣ��ѯ</div>
	</div>
	<div>
		<TABLE cellSpacing=0>
			<TR> 
			  <td class='blue' nowrap>��������</TD>
			  <TD colspan="3"><input type="text" readonly class="InputGrey" name="extensionStatus" value="<%=ret[0][0]%>">
			  </TD>
			</TR>
		</TABLE>
	</div>
  <table cellspacing="0">
    <tr id="footer"> 
			<td>
			  <input class="b_foot" name="back" onClick="history.go(-1)" type="button" value="����" />
			  <input class="b_foot" name="back" onClick="removeCurrentTab()" type="button" value="�ر�" />
			</td>
	  </tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
	<%}%>
</HTML>