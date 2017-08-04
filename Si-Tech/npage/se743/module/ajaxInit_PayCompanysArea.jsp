<%
  /*
   * 功能: 支付省
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
%>
<script type=text/javascript>
	//TODO 名称要修改
	/*
	var testJson = '{"ContainerPath": "PayCompanys","ElementType": 3,"ElementTypeName": "支付省","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "支付省编码","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditTime","ElementId": 1,"ElementName": "支付省编码","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}]}';
	var _json = eval("(" + testJson + ")");
	*/
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	var _id = '';
	var parentId = '<%=parentId%>';
	if(parentId != null && parentId != '' && parentId !='null') {
		_id = parentId + " #<%=areaId%>_table"	;
	}else {
		_id	= '<%=areaId%>_table';
	}
	
	var $opt = {
		json : _json, //json对象
		tableId : _id, //待添加的bodyid
		showAddBtn : false,//是否显示“添加”操作按钮
		showDelBtn : true,//是否显示“删除”操作按钮
		showTitleOnly : true//是否只显示thead
	}
	setListHtml($opt);

	function addNewProv(parentId,areaId) {
		var checkedProvCodeArr = new Array();
		$('#' + parentId + ' #' + areaId +'_table tbody tr').each(function(i) {
			checkedProvCodeArr.push($(this).find("td:eq(0)").text());	
		});
		var cps = '';
		if(checkedProvCodeArr.length > 0) {
			cps = checkedProvCodeArr.join(',');	
		}
		var path="module/Companys.jsp?cps=" + cps + '&bodyId=' + _id;
		window.open(path,"newwindow","height=450, width=900,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");	
	}
	
	function setProvTrHtml(arr,bodyId) {
		var _arr = arr;
		var rstArr = new Array();
		//处理支付省对象
		var _PayCompanys = new Array();
		for(var i=0,len=_arr.length;i<len;i++) {
			rstArr.push('<tr><td>');
			rstArr.push(arr[i].code);
			rstArr.push('</td><td>');
			rstArr.push(arr[i].name);
			rstArr.push('</td><td><input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delCompRecord(this)" /></td></tr>');
			var obj = {};
			obj.PayCompanyID = arr[i].code;
			_PayCompanys.push(obj);
		}
		ProductOrder.PayCompanys = _PayCompanys;
		if(rstArr.length > 0) {
			$('#' + bodyId + ' #tbody_<%=areaId%>').empty();
			$('#' + bodyId + ' #tbody_<%=areaId%>').append(rstArr.join(''));
		}
	}
	
	function delCompRecord(k) {
		var compId = $(k).parents("tr").find('td:eq(0)').text();
		//在ProductOrder.PayCompanys中查找，然后删除
		//TODO 这个只在ProductOrder中出现？可以考虑使用parentId
		var _comps = ProductOrder.PayCompanys;
		if(_comps != null) {
			for(var i=0,len=_comps.length;i<len;i++) {
				var _comp = _comps[i];
				if(_comp.PayCompanyID == compId) {
					_comps.splice(i, 1);
					break;
				}	
			}	
		}
		$(k).parents("tr").remove();
	}
	function getPayCompanysObj(areaId) {
		var $body = $('#tbody_<%=areaId%>');
		if(!isBlack(areaId)) {
			$body = $('#' + areaId + ' #tbody_<%=areaId%>');
		}
		var comps = [];
		$body.find("tr").each(function(i){
			var comp = {};
			var $tr = $(this);
			comp.PayCompanyID = $tr.find('td:eq(0)').text();
			comps.push(comp);
		});
		ProductOrder.PayCompanys = comps;
	}
</script>

<table id="<%=areaId%>_table">
	
</table>
<table>
	<body>
		<tr>
			<td>
				<input type="button" value="新增"  name="addProvBtn" onclick="addNewProv('<%=parentId%>','<%=areaId%>');"/>
			</td>
		</tr>
	</body>
</table>

