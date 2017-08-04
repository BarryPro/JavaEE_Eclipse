<%
  /*
   * 功能: e743 全网集团业务订单受理
   * 版本: 1.0
   * 日期: 2012-03-31
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<% 
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String areaId = request.getParameter("areaId");
	System.out.println("liujian===areaId=" + areaId);
%>
<script type=text/javascript>
	//var ContactorInfoJson = eval("(" + $("#json1").val() + ")");
	//var ContactorInfoJson = '{"ContainerPath": "ContactorInfo","ElementType": 3,"ElementTypeName": "商品订购的联系人信息","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "POAuditType","ElementId": 1,"ElementName": "联系人类型","FormType": "select","SelShow": "订单提交人~","SelValue": "audit~","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "刘健","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "联系人姓名","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "13904516789","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "联系人电话","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "POAuditType","ElementId": 1,"ElementName": "联系人类型","FormType": "select","SelShow": "订单审批人~","SelValue": "read~","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "张三","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "联系人姓名","FormType": "text","SelShow": "","SelValue": "","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "13904511111","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "联系人电话","FormType": "text","SelShow": "","SelValue": "","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "POAuditType","ElementId": 1,"ElementName": "联系人类型","FormType": "select","SelShow": "订单发起人~","SelValue": "send~","ElementGroup":2},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "李四","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "联系人姓名","FormType": "text","SelShow": "","SelValue": "","ElementGroup":2},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "13904512222","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "联系人电话","FormType": "text","SelShow": "","SelValue": "","ElementGroup":2}]}';
	//var _json = eval("(" + ContactorInfoJson + ")");
	
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	
	var $opt = {
		json : _json, //json对象
		tableId : '<%=areaId%>_table', //待添加的bodyid
		showAddBtn : true,//是否显示“添加”操作按钮
		showDelBtn : true,//是否显示“删除”操作按钮
		showTitleOnly : false//是否只显示thead
	}
	setListHtml($opt);
	function getContactorInfoObj() {
		rstJson.input.ContactorInfo = [];
		$('#tbody_<%=areaId%>').find('tr').each(function() {
			var obj = {};
		    var $tr = $(this);
		    obj.ContactorType = getTdValByObj($tr.find('td:eq(0)'));
		    obj.ContactorName = getTdValByObj($tr.find('td:eq(1)'));
		    obj.ContactorPhone = getTdValByObj($tr.find('td:eq(2)'));
		    //liujian 2013-3-26 15:52:08 wangleic添加一列
		    if($tr.find('td:eq(3)').find(":text").length > 0) {
				obj.StaffNumber = getTdValByObj($tr.find('td:eq(3)'));
			}
			rstJson.input.ContactorInfo.push(obj);
		});
	}
</script>
<form>
	<table id="<%=areaId%>_table">
	</table>
</form>