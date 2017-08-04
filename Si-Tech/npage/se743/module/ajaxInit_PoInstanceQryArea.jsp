<%
  /*
   * 功能: 实例
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
	var _json2 = '{"ContainerPath": "PoInstanceQry","ElementType": 1,"ElementTypeName": "实例查询","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "product_offer_id","ElementGroup": "0","ElementId": 1,"ElementName": "商品订购关系编码","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "pospec_number","ElementGroup": "0","ElementId": 2,"ElementName": "商品规格编码","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 13,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "pospec_name","ElementGroup": "0","ElementId": 13,"ElementName": "商品规格名称","FormType": "","SelShow": "","SelValue": ""}]}';
	var _json = eval("(" + _json2 + ")");
	getHtmlSegment(_json.Elements,"<%=areaId%>_table");
	
	function getInstance(){
		window.open (
			'module/PoInstanceQry.jsp?sceneVal=' + sceneId + '&woNo=' + in_ChanceId, 
			"newwindow",
			'dialogHeight:500px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
		);
	}
	
	function getInsNextArea(offerId,prodId) {
		insOfferId = offerId;
		setEcCodeBtnHide();
		
		getServiceMsg("se743QryBSR", "doGetInstanceAreas",1, sceneId,in_ChanceId,offerId,prodId);	
	}
	
	function doGetInstanceAreas(data) {
		$('#json1').val(data.trim());
		showMainAreas();	
	}
	
	function getPoInstanceQryObj() {

	}
</script>

<form>
	<table id="<%=areaId%>_table">
  <input type="hidden" name="product_ec_idHid" id="product_ec_idHid" value="" />
	</table>
</form>