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
	/*
	var businessSceneRuleJson = eval("(" + $("#json1").val() + ")");
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
	getHtmlSegment(_json.Elements,_id);

	function getproductorderinfoObj(areaId) {
		var bodyId = '<%=areaId%>_table';
		if(!isBlack(areaId)) {
			bodyId = areaId + ' #<%=areaId%>_table';
		}
		ProductOrder.ProductOrderNumber = getFormValueByName(bodyId,'ProductOrderNumber');
		ProductOrder.ProductID = getFormValueByName(bodyId,'ProductID');//产品订购关系ID
		ProductOrder.SICode = getFormValueByName(bodyId,'SICode');//SI编码     注：SI的合作类型必须是03－销售类
		ProductOrder.ProductSpecNumber = getFormValueByName(bodyId,'ProductSpecNumber');//产品规格编号
		ProductOrder.AccessNumber = getFormValueByName(bodyId,'AccessNumber');//产品关键号码
		ProductOrder.PriAccessNumber = getFormValueByName(bodyId,'PriAccessNumber');//产品附件号码
		ProductOrder.Linkman = getFormValueByName(bodyId,'Linkman');//联系人
		ProductOrder.ContactPhone = getFormValueByName(bodyId,'ContactPhone');//联系电话
		ProductOrder.Description = getFormValueByName(bodyId,'Description');//产品描述
		ProductOrder.ServiceLevelID = getFormValueByName(bodyId,'ServiceLevelID');//服务开通等级ID
		ProductOrder.OperationSubTypeID = getFormValueByName(bodyId,'OperationSubTypeID');//操作类型	A
		ProductOrder.OfferId = getFormValueByName(bodyId,'OfferId');
		ProductOrder.PARTER_ID = getFormValueByName(bodyId,'PARTER_ID');
		ProductOrder.gongnengfei = getFormValueByName(bodyId,'gongnengfei');
		//liujian 2012-7-25 15:49:45 关于新增集团业务酬金系统功能需求的函-集团部分 
		ProductOrder.ParterId = getFormValueByName(bodyId,'ParterId');
	}

</script>
<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>