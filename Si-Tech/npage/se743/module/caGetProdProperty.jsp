<%
  /*
   * 功能: e743 全网集团业务订单受理
   * 版本: 1.0
   * 日期: 2012-03-31
   * 作者: wanghfa
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
	String opName = "全网集团业务产品属性值列表 - 属性信息查询";
	String CharacterNumberVal = request.getParameter("CharacterNumberVal");//属性代码 
  String CharacterValue = request.getParameter("CharacterValue");//属性值
  String parentId = request.getParameter("parentId");
%>

<HEAD>
<TITLE>全网集团业务订单受理</TITLE>
<script language="javascript" type="text/javascript" src="../fe743_mainScript.js"></script>
<SCRIPT type=text/javascript>
	$(function() {
		getServiceMsg("sQryGZPCR", "doGetCharacterInfo",2,'<%=CharacterNumberVal%>','<%=CharacterValue%>');	
		
		$('#custSubmitBtn').click(function() {
			window.opener.doGetProdProperty('<%=parentId%>',$("#data").val(),$("#v_chkCharacterNumberFlag").val(),"<%=CharacterNumberVal%>");
			window.close();
		});
	});
	function doGetCharacterInfo(data) {
		//$("#json1").val(data.trim());
		//测试数据
		var _json = eval("(" + data + ")");
		if(_json==null||_json==""){
		  $("#v_chkCharacterNumberFlag").val("N"); //属性值是否校验标识 N 不通过
	    rdShowMessageDialog("无查询结果！请重新填写预约定单号的属性！");
	    window.close();
      return false;	
	  }else{
	    $("#v_chkCharacterNumberFlag").val("Y"); //Y 通过
	  }
		if(isBlack(_json.ProductOrderCharacters)) {
			return false;	
		}
		var ProductId = _json.Product_Id;
		var ProductOfferId = _json.Product_offer_Id;
    $("#data").val(data);
    
		var v1_html = new Array();
    v1_html.push('<tr>');
    v1_html.push('	<td align="center" class="blue">');
    v1_html.push('	商品订购关系ID：');
    v1_html.push('	</td>');
		v1_html.push('	<td >');
		v1_html.push(		_json.Product_offer_Id);
		v1_html.push('	</td>');
		v1_html.push('</tr>');
		
		$('#productOfferIdListTbody').empty();
		if(v1_html.length > 0) {
			$('#productOfferIdListTbody').append(v1_html.join(''));	
		}
			
		var _html = new Array();
		for(var i=0,len=_json.ProductOrderCharacters.length;i<len;i++) {
			var _cust = _json.ProductOrderCharacters[i]; 
			_html.push('<tr>');
			_html.push('	<td>');
			_html.push(			_cust.CharacterNumber);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_cust.CharacterName);
			_html.push('	</td>');
			_html.push('	<td>');
			_html.push(			_cust.DefaultValue);
			_html.push('	</td>');
			_html.push('</tr>');
		}
		$('#prodPropertyListTbody').empty();
		if(_html.length > 0) {
			$('#prodPropertyListTbody').append(_html.join(''));	
		}
	}
	
	
</SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" id="data" name="data" value="" />
	<input type="hidden" id="productOfferIdHiden" name="productOfferIdHiden" value="" />
	<input type="hidden" id="v_chkCharacterNumberFlag" name="v_chkCharacterNumberFlag" value="" />
	<div class="title">
		<div id="title_zi">查询结果</div>
	</div>
	<table cellspacing="0" style="width:96.8%">
	  <tbody id="productOfferIdListTbody"></tbody>
	</table>
		<div class="title" style="margin-top:20px;">
			<div id="title_zi">属性值查询结果</div>
		</div>
	<div id="prodDiv" style="height:250px; border:0px;padding:3px; PADDING:0px; OVERFLOW: auto; ">
		<table style="width:96.8%">
			<tr align="center">
				<th>属性代码</th>
				<th>属性名称</th>
				<th>属性值</th> 
			</tr>
			<tbody id="prodPropertyListTbody">
			</tbody>
		</table>
	</div>
		<table style="width:96.8%">
			<TR id="footer">
				<TD align=center>
					<input type="button" class="b_foot" id="custSubmitBtn" value="确认">
					<input type="button" class="b_foot" onclick="window.close()" value="返回">
				</TD>
			</TR>
		</table>

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
