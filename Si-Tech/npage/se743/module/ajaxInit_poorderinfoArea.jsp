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
	System.out.println("liujian===areaId=" + areaId);
%>
<script type=text/javascript>
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	getHtmlSegment(_json.Elements,'<%=areaId%>_table');
	function getpoorderinfoObj() {
		rstJson.input.OrderSourceID = getFormValueByName('<%=areaId%>_table','OrderSourceID');//������Դ
		rstJson.input.OfferId = getFormValueByName('<%=areaId%>_table','OfferId');//��Ʒ���ʷѱ��
		rstJson.input.POOrderNumber = getFormValueByName('<%=areaId%>_table','POOrderNumber');//��Ʒ������
		rstJson.input.POSpecNumber = getFormValueByName('<%=areaId%>_table','POSpecNumber');//��Ʒ�����
		rstJson.input.ProductOfferingID = getFormValueByName('<%=areaId%>_table','ProductOfferingID');//��Ʒ������ϵID
		rstJson.input.SICode = getFormValueByName('<%=areaId%>_table','SICode');//SI����
		rstJson.input.OperationSubTypeID = getFormValueByName('<%=areaId%>_table','OperationSubTypeID');//��Ʒ��ҵ�����
		rstJson.input.BusinessMode = getFormValueByName('<%=areaId%>_table','BusinessMode');//��Ʒ��ҵ�����
		rstJson.input.BusNeedDegree = getFormValueByName('<%=areaId%>_table','BusNeedDegree');//ҵ���ϵȼ�
		rstJson.input.Notes = getFormValueByName('<%=areaId%>_table','Notes');//��ע
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