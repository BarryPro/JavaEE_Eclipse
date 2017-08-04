<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opName ="黑龙江BOSS-错误提示";
%> 	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-错误提示</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY >
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">对不起，检测到特殊字符，请停止业务办理并与管理员联系</div>
	</div>
	<table cellspacing="0">
		<tr><td>
			<span>
				对不起，检测到特殊字符，请停止业务办理并与管理员联系
			</span>
		</td></tr>
		<tr><td>
			<div align="center">
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
		</td></tr>
	</span>
	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>