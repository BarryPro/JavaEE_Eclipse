<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%/*
* 黑龙江BOSS-开关机管理－HLR信息查询 2003-12-13
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>
<%
    String opCode = "1248";
    String opName = "HLR信息查询";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-开关机管理－HLR信息查询</TITLE>
</HEAD>
<!----------------------------------页头显示区域----------------------------------------->
<body>
<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">HLR信息查询</div>
</div>

<TABLE cellSpacing=0>
    <TR>
        <TD class=blue>服务号码</TD>
        <TD colspan=3>
            <input class="InputGrey" readOnly name="i1" size="20" value="<%=activePhone%>" maxlength=11 v_must=1 v_type=mobphone onkeydown="if(event.keyCode==13)if(check(form1))  pageSubmit('1');">
        </TD>
    </TR>
    <TR id="footer">
        <TD colspan=4>
            <input class="b_foot" name=sure  type=button value=确认 onclick="if(check(form1))  pageSubmit();" >
            <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=关闭>
        </TD>
    </TR>
</TABLE>
		<!-------------------------文本隐藏域必须在form1中----------------------------->
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------load页面时读取----------------------------------*/
function pageSubmit(){
    form1.action="f1248_2.jsp";
    form1.submit();
}
</script>
