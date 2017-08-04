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
	var businessSceneRuleJson = eval("(" + $("#json1").val() + ")");
	var areaId = '<%=areaId%>';
	var showType = "-1";
	for(var i=0,len=businessSceneRuleJson.ElementTypes.length;i<len;i++) {
		var elType = businessSceneRuleJson.ElementTypes[i];
		if(elType.ContainerPath == areaId) {
			if(elType.Elements != null && elType.Elements.length > 0) {
				getHtmlSegment(elType.Elements,"customer_table");
			}
		}
	}
	
	function getCustomer(){
		window.open (
			'module/caGetCustomer.jsp?sceneVal=' + sceneId + '&chanceId=' + in_ChanceId , 
			"newwindow",
			'dialogHeight:500px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
		);
	}
	
	function getNextArea(ecCode) {
		getServiceMsg("se743QryPSL", "doGetProductRule",1,sceneId,in_ChanceId,ecCode);
	}
	
	function doGetProductRule(data) {
		setProdRuleSelect(data);
	}
	
	function doGetOrderRelation(data) {
		//var _v = '{"ProductSpecList":[{"ProductSpecNumber":"24701","ProductSpecName":"一卡通业务普通短信","ProductSpecDesc":"一卡通业务普通短信（AJT0015201）","ProSceneId":1}]}';	
		setOrderRelationSelect(data);
	}
	
	function getcustomerObj() {
		rstJson.input.CustomerNumber = getFormValueByName('customer_table','CustomerNumber');
		rstJson.input.CustomerName = getFormValueByName('customer_table','CustomerName');
	}
</script>

<form>
	<table id="customer_table">
		
	</table>
</form>