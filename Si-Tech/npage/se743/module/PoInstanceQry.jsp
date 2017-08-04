<%
  /*
   * ����: e743 ʵ����ѯ
   * �汾: 1.0
   * ����: 2012-03-31
   * ����: liujian
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String opCode = "e743";
	String opName = "ȫ������ҵ�񶩵����� - ʵ����ѯ";
	String sceneVal = request.getParameter("sceneVal");
	String woNo = request.getParameter("woNo"); 
%>

<HEAD>
<TITLE>ȫ������ҵ�񶩵�����</TITLE>
<script language="javascript" type="text/javascript" src="../fe743_mainScript.js"></script>
<SCRIPT type=text/javascript>
	$(function() {
		$('#qryInsBtn').click(function() {
			getServiceMsg("se743QryBIL", "doGetInsList",2,'<%=sceneVal%>','<%=woNo%>' ,$('#qryInsType').val(),$("#keyWords").val());	
		});
		
		$('#insSubmitBtn').click(function() {
			var $tr = $('input:radio[name="insRadio"]:checked').parent().parent();
			var _poi = $tr.find('td:eq(1)').text();//product_offer_id  ��Ʒ������ϵ����
			var _pnum = $tr.find('td:eq(5)').text();//pospec_number    ��Ʒ������
			var _pname = $tr.find('td:eq(6)').text();//pospec_name    ��Ʒ�������
			var _ecId = $tr.find('td:eq(4)').text(); //diling add  EC���ſͻ�����@2012/10/24 
			
			var _prodId =  $tr.find('td:eq(7)').text().trim();
			//1. ��ʾʵ��������Ϣ
			window.opener.$("#PoInstanceQry_table input[name=product_offer_id]").val(_poi);
			window.opener.$("#PoInstanceQry_table input[name=pospec_number]").val(_pnum);
			window.opener.$("#PoInstanceQry_table input[name=pospec_name]").val(_pname);
			window.opener.$("#PoInstanceQry_table input[name=product_ec_idHid]").val(_ecId);//diling add �洢EC���ſͻ�����@2012/10/24 
			//2. ������һ����ʾ��Area
			window.opener.getInsNextArea(_poi,_prodId);
			//3. �رյ�ǰҳ��
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
		<div id="title_zi">��ѯ����</div>
	</div>
	<table cellspacing="0" style="width:96.8%">
		<tr>
			<td colspan="4" align="center" class="blue">
				��ѯ��ʽ��
				<select name="qryInsType" id="qryInsType" style="width:100px">
					<option value="0">���ű��</option>
					<option value="1">EC���ſͻ�����</option>
					<option value="2">���ſͻ�����</option>
					<option value="3">��Ʒ������ϵ����</option>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;
				�ؼ��֣�
				<input type="text" name="keyWords" id="keyWords" size="50" value="">
				<input type="button" class="b_text" name="qryInsBtn" id="qryInsBtn" value="��ѯ">
			</td>
		</tr>
	</table>
	<div class="title" style="margin-top:20px;">
		<div id="title_zi">��ѯ���</div>
	</div>
	<div style="margin-top:0px;">
		<table style="width:96.8%">
			<tr align="center">
				<th>ѡ��</th>
				<th>��Ʒ������ϵ����</th>
				<th>���ſͻ�����</th>
				<th>���ű��</th>
				<th>EC���ſͻ�����</th>
				<th>��Ʒ������</th>
				<th>��Ʒ�������</th>
	
			</tr>
			<tbody id="insListTbody">
			</tbody>
		</table>
		<table style="width:96.8%">
			<TR id="footer">
				<TD align=center>
					<input type="button" class="b_foot" id="insSubmitBtn" value="ȷ��">
					<input type="button" class="b_foot" onclick="window.close()" value="����">
				</TD>
			</TR>
		</table>
	</div>
	
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
