<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��Ʒ��ȡ��ѯ1245
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode="1245";
	String opName="��Ʒ��ȡ��ѯ";
	String phoneNo = (String)request.getParameter("activePhone");
%>
<%
/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-��Ϣ�㲥����Ʒ��ȡ��ѯ</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1">
 	<%@ include file="/npage/include/header.jsp" %>
 	<div class="title">
		<div id="title_zi">��Ʒ��ȡ��ѯ</div>
	</div>
<TABLE cellSpacing="0">
	<TR>
		<TD class="blue">�ֻ�����</TD>
		<TD>
			<input class="InputGrey" readOnly name="i1" size="20" value="<%=phoneNo%>" maxlength=11 v_must=1 v_type=int>
		</TD>
	</TR>
	<TR>
		<TD align="center" id="footer" colspan="2">
			<input class="b_foot" name=sure  type=button value=ȷ�� onclick="if(check(form1))  pageSubmit();" >
			<input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=�ر�>
		</TD>
	</TR>
</TABLE>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------loadҳ��ʱ��ȡ----------------------------------*/
document.all.i1.focus();                      //ҳ���ʼ��ʱ������ָ��������

function pageSubmit(){
	form1.action="f1245_2.jsp";
	form1.submit();
}

</script>


