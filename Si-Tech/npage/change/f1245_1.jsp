<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠品领取查询1245
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode="1245";
	String opName="赠品领取查询";
	String phoneNo = (String)request.getParameter("activePhone");
%>
<%
/*
* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-信息点播－赠品领取查询</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1">
 	<%@ include file="/npage/include/header.jsp" %>
 	<div class="title">
		<div id="title_zi">赠品领取查询</div>
	</div>
<TABLE cellSpacing="0">
	<TR>
		<TD class="blue">手机号码</TD>
		<TD>
			<input class="InputGrey" readOnly name="i1" size="20" value="<%=phoneNo%>" maxlength=11 v_must=1 v_type=int>
		</TD>
	</TR>
	<TR>
		<TD align="center" id="footer" colspan="2">
			<input class="b_foot" name=sure  type=button value=确认 onclick="if(check(form1))  pageSubmit();" >
			<input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=关闭>
		</TD>
	</TR>
</TABLE>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------load页面时读取----------------------------------*/
document.all.i1.focus();                      //页面初始化时将焦点指向服务号码

function pageSubmit(){
	form1.action="f1245_2.jsp";
	form1.submit();
}

</script>


