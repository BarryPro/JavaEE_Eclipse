<%
  /*
   * 功能: 产品基本信息
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
	//var nodeJson = '{"ContainerPath": "ManageNode","ElementType": 90,"ElementTypeName": "省BOSS上传管理节点","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "审批人联系电话","ElementAlter": "","ElementCode": "CharacterName","ElementGroup": "1","ElementId": 2014,"ElementName": "管理属性名称","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 10,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "CharacterValue","ElementGroup": "1","ElementId": 2015,"ElementName": "管理属性值","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 11,"EType": "","EUpdate": "1","EValue": "10003","ElementAlter": "","ElementCode": "CharacterID","ElementGroup": "1","ElementId": 2013,"ElementName": "管理属性编码","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "222222审批人Code","ElementAlter": "","ElementCode": "OperateCode","ElementGroup": "1","ElementId": 2014,"ElementName": "管理属性Code","FormType": "hidden","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "审批人Desc","ElementAlter": "","ElementCode": "CharacterDesc","ElementGroup": "1","ElementId": 2014,"ElementName": "管理属性Desc","FormType": "hidden","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "审批人联系电话2","ElementAlter": "","ElementCode": "CharacterName","ElementGroup": "2","ElementId": 2014,"ElementName": "管理属性名称","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 10,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "CharacterValue","ElementGroup": "2","ElementId": 2015,"ElementName": "管理属性值","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 11,"EType": "","EUpdate": "1","EValue": "100032","ElementAlter": "","ElementCode": "CharacterID","ElementGroup": "2","ElementId": 2013,"ElementName": "管理属性编码","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "222222审批人Code2","ElementAlter": "","ElementCode": "OperateCode","ElementGroup": "2","ElementId": 2014,"ElementName": "管理属性Code","FormType": "hidden","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "审批人Desc2","ElementAlter": "","ElementCode": "CharacterDesc","ElementGroup": "2","ElementId": 2014,"ElementName": "管理属性Desc","FormType": "hidden","SelShow": "","SelValue": ""}]}';
	//var _json = eval("(" + nodeJson + ")");
	var areaId = '<%=areaId%>';
	var _id = '';
	var parentId = '<%=parentId%>';
	if(parentId != null && parentId != '' && parentId !='null') {
		_id = parentId + " #<%=areaId%>_table"	;
	}else {
		_id	= '<%=areaId%>_table';
	}
	var _json = getObjFromSrv(areaId);
	var jsonObj = {
		json : _json, //json对象
		tableId : _id, //待添加的bodyid
		showAddBtn : false,//是否显示“添加”操作按钮
		showDelBtn : false,//是否显示“删除”操作按钮
		showTitleOnly : false//是否只显示thead
	}
	
	$(function() {
		setNodeListHtml(jsonObj);
	});

	function getManageNodeGetObj(parentId) {
		var $thead = $('#<%=areaId%>_table thead');
		var $tbody = $('#tbody_<%=areaId%>');
		if(!isBlack(parentId)) {
			$thead = $('#' + parentId + ' #<%=areaId%>_table thead');	
			$tbody = $('#' + parentId + ' #tbody_<%=areaId%>');
		}
		
		var headAttrs = new Array();
		$thead.find('th').each(function() {
			var _this = $(this);
			headAttrs.push(_this.find('input').val());
		});

		var nodeArr = new Array();
		$tbody.find("tr").each(function(){
			var $this = $(this);
			var manageNode = {};
			var i = 0;
			$this.find('td').each(function() {
				manageNode[headAttrs[i]] = getTdValByObj($(this));
				i++;
			});
			nodeArr.push(manageNode);
		});
		ProductOrder.ManageNodeGet = nodeArr;
	}
	
	
</script>
<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>