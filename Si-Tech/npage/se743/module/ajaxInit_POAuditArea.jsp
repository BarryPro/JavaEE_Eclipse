<%
  /*
   * 功能: 业务审批信息列表
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
	System.out.println("liujian===areaId=" + areaId);
%>
<script type=text/javascript>
	//TODO 名称要修改
	/*
	var POAuditJson = '{"ContainerPath": "POAudit","ElementType": 3,"ElementTypeName": "业务审批信息列表","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "审批人姓名","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "POAuditTime","ElementId": 1,"ElementName": "审批时间(格式：YYYYMMDDhhmiss)","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "question","ElementId": 1,"ElementName": "审批意见","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0}]}';
	var _json = eval("(" + POAuditJson + ")");
	*/
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	var $opt = {
		json : _json, //json对象
		tableId : '<%=areaId%>_table', //待添加的bodyid
		showAddBtn : false,//是否显示“添加”操作按钮
		showDelBtn : false,//是否显示“删除”操作按钮
		showTitleOnly : false//是否只显示thead
	}
	setListHtml($opt);
	
	function getPOAuditObj() {
		rstJson.input.POAudit = [];
		var _POAudit = rstJson.input.POAudit;
		var $tbody = $('#tbody_<%=areaId%>');
		$tbody.find("tr").each(function(){
			var obj = {};
		    $(this).find("td").each(function(i){
		    	var value = getTdValByObj($(this));
		    	if(i==0) {
		    		obj.Auditor = value;
		    	}if(i==1) {
		    		obj.AuditTime = value;
		    	}if(i==2) {
		    		obj.AuditDesc = value;
		    	}if(i==3) {
		    		obj.AuditResult = value;
		    	}
			});
			_POAudit.push(obj);
		});
	}
</script>
<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>