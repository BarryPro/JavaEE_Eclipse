<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团信息查询</TITLE>
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
    String loginPwd  = (String)session.getAttribute("password");//登陆密码
    String opCode = "5082";
	String opName = "集团信息查询";
	
	String idNo = request.getParameter("idNo");
	System.out.println("---liujian5082---idNo=" +  idNo);
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
	<wtc:service name="sGrpMembAttrQry"  outnum="4" retcode="errcode" retmsg="errmsg" 
		routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=loginAccept%>" />
	<wtc:param value="01" />
	<wtc:param value="5082" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="<%=loginPwd%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=idNo%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
</HEAD>
<% if (!"000000".equals(errcode)) {%>
<script language="javascript">
	rdShowMessageDialog("错误代码:<%=errcode%>,错误信息:<%=errmsg%>",0);
	history.go(-1);
</script>
<%}else if(result1.length == 0) {
%>
	<script language="javascript">
		rdShowMessageDialog("没有找到任何数据");
		history.go(-1);
	</script>
<%		
}

else{%>
<body>
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团信息查询</div>
</div>
<div>
		<TABLE cellSpacing=0>
			<TR> 
			  <td class='blue' nowrap>分机状态</TD>
			  <TD><input type="text" readonly class="InputGrey" name="extensionStatus" value="<%=result1[0][0]%>">
			  </TD>
			  <td class='blue' nowrap>分机终端类型</TD>
			  <TD><input type="text" readonly class="InputGrey"  name="extensionType" value="<%=result1[0][1]%>"></TD>
			</TR>
			<TR> 
			  <td class='blue' nowrap>分机号码</TD>
			  <TD><input type="text" readonly  class="InputGrey" name="extensionNo" value="<%=result1[0][2]%>"></TD>
			  <td class='blue' nowrap>计费号码</TD>
			  <TD><input type="text" readonly class="InputGrey" name="phoneNo" value="<%=result1[0][3]%>"></TD>
			</TR>
			           
		  </TABLE>
</div>


    <table cellspacing="0">
      <tr id="footer"> 
		<td>
			  <input class="b_foot" name="back" onClick="history.go(-1)" type="button" value="返回" />
			  <input class="b_foot" name="back" onClick="removeCurrentTab()" type="button" value="关闭" />
		</td>
	  </tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY>
<%}%>
</HTML>