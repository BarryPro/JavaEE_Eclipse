<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String opCode = "e743";
	String opName = "全网集团业务订单受理 - 省份查询";
	String cps = request.getParameter("cps");
	String bodyId = request.getParameter("bodyId");
	System.out.println("----liujian----------bodyId=" + bodyId);
%>
<HEAD>
<TITLE>全网集团业务订单受理</TITLE>
<script language="javascript" type="text/javascript" src="../fe743_mainScript.js"></script>
<script type=text/javascript>
	
	$(function() {
		var cps = '<%=cps%>';
		var cpsArr = new Array();
		if(cps != null && cps != '' && cps != 'null') {
			cpsArr = split(cps,',');
		}
		var _html = new Array();
		for(var i = 0, len = provArr.length; i < len; i++) {
			var _prov = provArr[i];
			var _flag = false;
			if(cpsArr.length > 0) {
				for(var j=0,len2 = cpsArr.length;j<len2;j++) {
					if(cpsArr[j] == _prov.code) {
						_flag = true;
						_html.push('<tr><td><input type="checkbox" name="checkProv" checked /></td><td>');
						cpsArr.splice(j, 1);	
						break;
					}
				}
				if(!_flag) {
					_html.push('<tr><td><input type="checkbox" name="checkProv" /></td><td>');
				}
			}else {
				_html.push('<tr><td><input type="checkbox" name="checkProv" /></td><td>');
			}
				_html.push(_prov.code);
				_html.push('</td><td>');
				_html.push(_prov.name);
				_html.push('</td></tr>');
		}
		$('#provTbody').append(_html.join(''));
		$('#submitBtn').click(function() {
			var checkedProvs = new Array();
			$("input:checkbox").each(function(i) {
				if ($(this).attr("checked")) {
					checkedProvs.push(provArr[i]);
				}
			});
			//调用父页面的方法
			window.opener.setProvTrHtml(checkedProvs,'<%=bodyId%>');
			window.close();
		});
	});

</script>
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
<div id="Main">
<DIV id="Operation_Table"> 
	<div class="title"><div id="title_zi">支付省选择</div></div>	
	<table cellspacing="0">
	    <tr align="center">
	    	<th nowrap>选择</th>
	        <th nowrap>支付省编码</th>
	        <th nowrap>支付省名称</th>      
	    </tr>
	    <tbody id="provTbody"> 
	    	
	    </tbody>
	</table>
	<table>
		<tr>
			<td colspan="4" align="center" id="footer">
				<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认">
				<input class="b_foot" type=button name="backBtn" id="backBtn" value="重置" onclick="window.location='Companys.jsp'">
			</td>
		</tr>
	</table>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>