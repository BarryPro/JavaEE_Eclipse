<%
  /*
   * 功能: 产品一次性消费
   * 版本: 1.0
   * 日期: 2012-03-31
   * 作者: liujian
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String areaId = request.getParameter("areaId");
	String parentId = request.getParameter("parentId");
	System.out.println("liujian===areaId=" + areaId);
%>
<script type=text/javascript>
	//TODO 名称要修改
	/*
	var testJson = '{"ContainerPath": "ProductOrderCharge","ElementType": 3,"ElementTypeName": "产品一次性消费","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "资费项","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "资费项","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "费用","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "资费项","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "资费项","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 1}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "费用","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 1}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "资费项","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "资费项","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 2}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "费用","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 2}]}';
	var _json = eval("(" + testJson + ")");
	*/
	var areaId = '<%=areaId%>';
	var _id = '';
	var parentId = '<%=parentId%>';
	if(parentId != null && parentId != '' && parentId !='null') {
		_id = parentId + " #<%=areaId%>_table"	;
	}else {
		_id	= '<%=areaId%>_table';
	}
	var _json = getObjFromSrv(areaId);
	var $opt = {
		json : _json, //json对象
		tableId : _id, //待添加的bodyid
		showAddBtn : false,//是否显示“添加”操作按钮
		showDelBtn : false,//是否显示“删除”操作按钮
		showTitleOnly : false,//是否只显示thead
		addHiddenInput : true//是否设置hiddenInput
	}
	setListHtml($opt);
	
	function getProductOrderChargeObj(areaId) {
		ProductOrder.ProductOrderCharge = [];
		var $tbody = $('#tbody_<%=areaId%>');
		if(!isBlack(areaId)) {
			$tbody = $('#' + areaId + ' #tbody_<%=areaId%>');
		}
		$tbody.find("tr").each(function(){
			var obj = {};
		    $(this).find("td").each(function(i){
		    	if(i==0) {
		    		obj.ProductOrderChargeCode = $(this).find('input[type="hidden"]').val();
		    	}if(i==1) {
		    		obj.ProductOrderChargeValue = $(this).find('input').val();
		    	}
			});
			ProductOrder.ProductOrderCharge.push(obj);
		});
	}
</script>

<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>