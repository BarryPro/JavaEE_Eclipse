<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%/*
* ������BOSS-���ػ�����HLR��Ϣ��ѯ 2003-12-13
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<%
    String opCode = "1248";
    String opName = "HLR��Ϣ��ѯ";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-���ػ�����HLR��Ϣ��ѯ</TITLE>
</HEAD>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->
<body>
<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">HLR��Ϣ��ѯ</div>
</div>

<TABLE cellSpacing=0>
    <TR>
        <TD class=blue>�������</TD>
        <TD colspan=3>
            <input class="InputGrey" readOnly name="i1" size="20" value="<%=activePhone%>" maxlength=11 v_must=1 v_type=mobphone onkeydown="if(event.keyCode==13)if(check(form1))  pageSubmit('1');">
        </TD>
    </TR>
    <TR id="footer">
        <TD colspan=4>
            <input class="b_foot" name=sure  type=button value=ȷ�� onclick="if(check(form1))  pageSubmit();" >
            <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=�ر�>
        </TD>
    </TR>
</TABLE>
		<!-------------------------�ı������������form1��----------------------------->
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------loadҳ��ʱ��ȡ----------------------------------*/
function pageSubmit(){
    form1.action="f1248_2.jsp";
    form1.submit();
}
</script>
