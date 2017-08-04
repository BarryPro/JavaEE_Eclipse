<%
  /*
   * 功能: e743 实例查询
   * 版本: 1.0
   * 日期: 2012-03-31
   * 作者: liujian
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String opCode = "e743";
	String opName = "全网集团业务订单受理 - 实例查询";
	String sceneVal = request.getParameter("sceneVal");
	String woNo = request.getParameter("woNo"); 
%>

<HEAD>
<TITLE>全网集团业务订单受理</TITLE>
<script language="javascript" type="text/javascript" src="../fe743_mainScript.js"></script>
<SCRIPT type=text/javascript>
	$(function() {
		$('#qryInsBtn').click(function() {
			getServiceMsg("se743QryBIL", "doGetInsList",2,'<%=sceneVal%>','<%=woNo%>' ,$('#qryInsType').val(),$("#keyWords").val());	
		});
		
		$('#insSubmitBtn').click(function() {
			var $tr = $('input:radio[name="insRadio"]:checked').parent().parent();
			var _poi = $tr.find('td:eq(1)').text();//product_offer_id  商品订购关系编码
			var _pnum = $tr.find('td:eq(5)').text();//pospec_number    商品规格编码
			var _pname = $tr.find('td:eq(6)').text();//pospec_name    商品规格名称
			var _ecId = $tr.find('td:eq(4)').text(); //diling add  EC集团客户编码@2012/10/24 
			
			var _prodId =  $tr.find('td:eq(7)').text().trim();
			//1. 显示实例基础信息
			window.opener.$("#PoInstanceQry_table input[name=product_offer_id]").val(_poi);
			window.opener.$("#PoInstanceQry_table input[name=pospec_number]").val(_pnum);
			window.opener.$("#PoInstanceQry_table input[name=pospec_name]").val(_pname);
			window.opener.$("#PoInstanceQry_table input[name=product_ec_idHid]").val(_ecId);//diling add 存储EC集团客户编码@2012/10/24 
			//2. 设置下一步显示的Area
			window.opener.getInsNextArea(_poi,_prodId);
			//3. 关闭当前页面
			window.close();
		});
	});
	function doGetInsList(data) {
		$("#json1").val(data.trim());
		var _json = eval("(" + data + ")");
		if(isBlack(_json.BusiInsList)) {
			return false;	
		}
		var _html = new Array();
		for(var i=0,len=_json.BusiInsList.length;i<len;i++) {
			var _ins = _json.BusiInsList[i]; 
			_html.push('<tr>');
			_html.push('	<td>');
			_html.push('		<input type="radio" name="insRadio"/>');
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_ins.product_offer_id);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_ins.customer_name);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_ins.customer_id);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_ins.custmoter_ec_id);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_ins.pospec_number);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_ins.pospec_name);
			_html.push('	</td>');
			
			_html.push('	<td style=\"display:none\">');
			_html.push(			_ins.poorder_id);
			_html.push('	</td>');
			
			_html.push('</tr>');
		}
		$('#insListTbody').empty();
		if(_html.length > 0) {
			$('#insListTbody').append(_html.join(''));	
		}
	}
	
	
</SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">查询条件</div>
	</div>
	<table cellspacing="0" style="width:96.8%">
		<tr>
			<td colspan="4" align="center" class="blue">
				查询方式：
				<select name="qryInsType" id="qryInsType" style="width:100px">
					<option value="0">集团编号</option>
					<option value="1">EC集团客户编码</option>
					<option value="2">集团客户名称</option>
					<option value="3">商品订购关系编码</option>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;
				关键字：
				<input type="text" name="keyWords" id="keyWords" size="50" value="">
				<input type="button" class="b_text" name="qryInsBtn" id="qryInsBtn" value="查询">
			</td>
		</tr>
	</table>
	<div class="title" style="margin-top:20px;">
		<div id="title_zi">查询结果</div>
	</div>
	<div style="margin-top:0px;">
		<table style="width:96.8%">
			<tr align="center">
				<th>选择</th>
				<th>商品订购关系编码</th>
				<th>集团客户名称</th>
				<th>集团编号</th>
				<th>EC集团客户编码</th>
				<th>商品规格编码</th>
				<th>商品规格名称</th>
	
			</tr>
			<tbody id="insListTbody">
			</tbody>
		</table>
		<table style="width:96.8%">
			<TR id="footer">
				<TD align=center>
					<input type="button" class="b_foot" id="insSubmitBtn" value="确认">
					<input type="button" class="b_foot" onclick="window.close()" value="返回">
				</TD>
			</TR>
		</table>
	</div>
	
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
