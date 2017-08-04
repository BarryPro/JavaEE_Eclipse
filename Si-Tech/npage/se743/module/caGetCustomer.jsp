<%
  /*
   * ����: e743 ȫ������ҵ�񶩵�����
   * �汾: 1.0
   * ����: 2012-03-31
   * ����: wanghfa
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
	String opName = "ȫ������ҵ�񶩵����� - �ͻ���ѯ";
	String sceneVal = request.getParameter("sceneVal");
	String chanceId = request.getParameter("chanceId"); 
%>

<HEAD>
<TITLE>ȫ������ҵ�񶩵�����</TITLE>
<script language="javascript" type="text/javascript" src="../fe743_mainScript.js"></script>
<SCRIPT type=text/javascript>
	$(function() {
		$('#qryCustomerBtn').click(function() {
			getServiceMsg("se743QryCustL", "doGetCusts",2,'<%=sceneVal%>','<%=chanceId%>',$('#qryCustomerType').val(),$("#qryKeyWords").val());	
		});
		
		$('#custSubmitBtn').click(function() {
			var $tr = $('input:radio[name="custRadio"]:checked').parent().parent();
			var _name = $tr.find('td:eq(1)').text();
			var _ecId = $tr.find('td:eq(2)').text();
			var _unitId = $tr.find('td:eq(3)').text();
			var _provId = $tr.find('td:eq(4)').text();
			/*
			var _provName = '';
			for(var i=0,len=provArr.length;i<len;i++) {
				var _prov = provArr[i];
				if(_prov.code == _provId.trim()) {
					_provName = _prov.name;	
					break;
				}
			}
			*/
			//1. ��ʾ�ͻ�������Ϣ
			window.opener.$("#customer_table input[name=CustomerName]").val($.trim(_name));
			window.opener.$("#customer_table input[name=CustomerNumber]").val($.trim(_ecId));
			window.opener.$("#customer_table input[name=unit_id]").val($.trim(_unitId));
			window.opener.$("#customer_table input[name=CustomerProNumber]").val($.trim(_provId));
			//2. ������һ����ʾ��Area
			window.opener.getNextArea(_ecId);
			//3. �رյ�ǰҳ��
			window.close();
		});
	});
	function doGetCusts(data) {
		$("#json1").val(data.trim());
		//��������
		var _json = eval("(" + data + ")");
		if(isBlack(_json.CustList)) {
			return false;	
		}
		var _html = new Array();
		for(var i=0,len=_json.CustList.length;i<len;i++) {
			var _cust = _json.CustList[i]; 
			_html.push('<tr>');
			_html.push('	<td>');
			_html.push('		<input type="radio" name="custRadio"/>');
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_cust.CustomerName);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_cust.CustomerNumber);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_cust.unit_id);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_cust.CustomerProNumber);
			_html.push('	</td>');
			_html.push('</tr>');
		}
		$('#custListTbody').empty();
		if(_html.length > 0) {
			$('#custListTbody').append(_html.join(''));	
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
				<select name="qryCustomerType" id="qryCustomerType" style="width:100px">
					<option value="0">���ű��</option>
					<option value="1">EC���ſͻ�����</option>
					<option value="2">���ſͻ�����</option>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;
				�ؼ��֣�
				<input type="text" name="qryKeyWords" id="qryKeyWords" size="50" value="">
				<input type="button" class="b_text" name="qryCustomerBtn" id="qryCustomerBtn" value="��ѯ">
			</td>
		</tr>
	</table>
	<div class="title" style="margin-top:20px;">
		<div id="title_zi">��ѯ���</div>
	</div>
	<table style="width:96.8%">
		<tr align="center">
			<th>ѡ��</th>
			<th>�ͻ�����</th>
			<th>�ͻ�����</th>
			<th>�ͻ�����ȼ�</th>
			<th>�ͻ�����ʡ</th>
		</tr>
		<tbody id="custListTbody">
		</tbody>
	</table>
	<table style="width:96.8%">
		<TR id="footer">
			<TD align=center>
				<input type="button" class="b_foot" id="custSubmitBtn" value="ȷ��">
				<input type="button" class="b_foot" onclick="window.close()" value="����">
			</TD>
		</TR>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
