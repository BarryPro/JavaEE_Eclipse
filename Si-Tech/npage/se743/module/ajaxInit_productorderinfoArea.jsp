<%
  /*
   * ����: ��Ʒ������Ϣ
   * �汾: 1.0
   * ����: 2012-03-31
   * ����: liujian
   * ��Ȩ: si-tech
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
		ProductOrder.ProductID = getFormValueByName(bodyId,'ProductID');//��Ʒ������ϵID
		ProductOrder.SICode = getFormValueByName(bodyId,'SICode');//SI����     ע��SI�ĺ������ͱ�����03��������
		ProductOrder.ProductSpecNumber = getFormValueByName(bodyId,'ProductSpecNumber');//��Ʒ�����
		ProductOrder.AccessNumber = getFormValueByName(bodyId,'AccessNumber');//��Ʒ�ؼ�����
		ProductOrder.PriAccessNumber = getFormValueByName(bodyId,'PriAccessNumber');//��Ʒ��������
		ProductOrder.Linkman = getFormValueByName(bodyId,'Linkman');//��ϵ��
		ProductOrder.ContactPhone = getFormValueByName(bodyId,'ContactPhone');//��ϵ�绰
		ProductOrder.Description = getFormValueByName(bodyId,'Description');//��Ʒ����
		ProductOrder.ServiceLevelID = getFormValueByName(bodyId,'ServiceLevelID');//����ͨ�ȼ�ID
		ProductOrder.OperationSubTypeID = getFormValueByName(bodyId,'OperationSubTypeID');//��������	A
		ProductOrder.OfferId = getFormValueByName(bodyId,'OfferId');
		ProductOrder.PARTER_ID = getFormValueByName(bodyId,'PARTER_ID');
		ProductOrder.gongnengfei = getFormValueByName(bodyId,'gongnengfei');
		//liujian 2012-7-25 15:49:45 ������������ҵ����ϵͳ��������ĺ�-���Ų��� 
		ProductOrder.ParterId = getFormValueByName(bodyId,'ParterId');
	}

</script>
<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>