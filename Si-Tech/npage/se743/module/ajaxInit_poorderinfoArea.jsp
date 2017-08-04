<%
  /*
   * 功能: 商品基本信息
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
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	getHtmlSegment(_json.Elements,'<%=areaId%>_table');
	function getpoorderinfoObj() {
		rstJson.input.OrderSourceID = getFormValueByName('<%=areaId%>_table','OrderSourceID');//订单来源
		rstJson.input.OfferId = getFormValueByName('<%=areaId%>_table','OfferId');//商品级资费编号
		rstJson.input.POOrderNumber = getFormValueByName('<%=areaId%>_table','POOrderNumber');//商品订单号
		rstJson.input.POSpecNumber = getFormValueByName('<%=areaId%>_table','POSpecNumber');//商品规格编号
		rstJson.input.ProductOfferingID = getFormValueByName('<%=areaId%>_table','ProductOfferingID');//商品订购关系ID
		rstJson.input.SICode = getFormValueByName('<%=areaId%>_table','SICode');//SI编码
		rstJson.input.OperationSubTypeID = getFormValueByName('<%=areaId%>_table','OperationSubTypeID');//商品级业务操作
		rstJson.input.BusinessMode = getFormValueByName('<%=areaId%>_table','BusinessMode');//商品级业务操作
		rstJson.input.BusNeedDegree = getFormValueByName('<%=areaId%>_table','BusNeedDegree');//业务保障等级
		rstJson.input.Notes = getFormValueByName('<%=areaId%>_table','Notes');//备注
		rstJson.input.DemandName = getFormValueByName('<%=areaId%>_table','DemandName');
		rstJson.input.PARTER_ID = getFormValueByName('<%=areaId%>_table','PARTER_ID');
		rstJson.input.HostCompany = getFormValueByName('<%=areaId%>_table','HostCompany');	
		rstJson.input.FinishTime = getFormValueByName('<%=areaId%>_table','FinishTime');	
		rstJson.input.PORatePolicyEffRule = getFormValueByName('<%=areaId%>_table','PORatePolicyEffRule');
		rstJson.input.busi_req_type = getFormValueByName('<%=areaId%>_table','busi_req_type');
		rstJson.input.ParterId = getFormValueByName('<%=areaId%>_table','ParterId');
	}
</script>
<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>