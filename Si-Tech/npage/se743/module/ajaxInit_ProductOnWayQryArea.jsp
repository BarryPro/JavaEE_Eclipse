<%
  /*
   * ����: 
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
%>
<script language="javascript" type="text/javascript" src="/npage/se743/json2.js"></script>
<script type=text/javascript>
//	var _json2 ='{"ContainerPath": "PoInstanceQry","ElementType": 3,"ElementTypeName": "��Ʒʵ���б�","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "ʵ��","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "ʵ��","FormType": "select","SelShow": "��Ӱ����~������~����~","SelValue": "1~2~3~","ElementGroup": 0}]}';
//	var _json = eval("(" + _json2 + ")");
	
	function addInsMainArea(mainAreaId,ruleId,subAreas) {
		// �Ͳ�Ʒ���ͬ
		//{ruleId:{mainAreaId:[]}}
		//������
		//1.1 ��ù��Id,����ӵĸ�����id
		//1.2 �������񷵻ص����ݻ��subAreas
		//1.3 ��areaFunctions����ӹ�����
		//1.3.1 ��������󲻴���
		if(!areaFunctions[ruleId]) {
			areaFunctions[ruleId] = {};
		//	areaFunctions[ruleId].subArea = subAreas;
		//	areaFunctions[ruleId][mainAreaId] = subAreas;
		//	areaFunctions[ruleId].mainArea.push(mainAreaId);
		}
		//1.3.2������������
		//else {
		//	areaFunctions[ruleId].mainArea.push(mainAreaId);
		//}
		areaFunctions[ruleId][mainAreaId] = subAreas;
	}
	
	function getProductOnWayQryObj() {
		rstJson.input.ProductOrders = [];
		for(var p in areaFunctions) {
			for(var m in areaFunctions[p]) {
				ProductOrder = {};
				var subAreas = areaFunctions[p][m];
				var areaId = 'productspecqry_' + m + '_Area';
				for(var j=0,len2 = subAreas.length;j<len2;j++) {
					var subArea = subAreas[j];
					new Function('get' + subArea + 'Obj'+ '("' + areaId + '")')();
				}
				rstJson.input.ProductOrders.push(ProductOrder);
			}
		}
	}
	
	/*
		����ҳ��
		getPayCompanysObj(areaId)//֧��ʡ
		getProductOrderCharactersObj(areaId);//��Ʒ����ֵ
		getProductOrderChargeObj(areaId);//��Ʒһ��������
		getproductorderinfoObj(areaId);//��Ʒ������Ϣ
		getProductOrderRatePlansObj(areaId);//��Ʒ���ʷ��б�
		getManageNodeObj(areaId);//ʡBOSS�ϴ�����ڵ�
		getManageNodeGetObj(areaId);//ʡBOSS�´�����ڵ�
	*/
	
	
	$(function() {
		//�����Ʒ������
		var ponum = $('input[name="POOrderNumber"]').val();
		if(!ponum) {	
			ponum = '';
		}
		getServiceMsg("se743QryPSROW", "doQryPSROW",1,sceneId,in_ChanceId,ponum);		
	});
	
	function doQryPSROW(data) {
		var sval = 0;
		var _obj = eval("(" + data + ")");
		var _proIns = _obj.ProductOrders;
		if(_proIns) {
			for(var i=0,len=_proIns.length;i<len;i++) {
				var subAreas = new Array();
				var _ins = 	_proIns[i];
				var _name = _ins.ProductSpecName;
				$('#json1').val(JSON2.stringify(_ins));
				getOnlyTitleArea("productspecqry_sub_" + sval + '_' + i + '_', _name , 0,20,'<%=areaId%>Area',false);
				if (_ins.ElementTypes != null  || _ins.ProductOrderCharacters != null) {
					var funs = new Array();
					//liujian �������񷵻ص�json������չʾ
					for (var a = 0; a < _ins.ElementTypes.length; a ++) {
						var busi_json_elType = _ins.ElementTypes[a];
						subAreas.push(busi_json_elType.ContainerPath);
						getInnerArea(busi_json_elType.ContainerPath, busi_json_elType.ElementTypeName, 0,20,'productspecqry_sub_' + sval + '_' + i + '_Area');
						//liujian 2012-8-17 16:14:01  fromType���ַ�֧   ģ���ܹ���������֧��1����;onWay 2��ʵ��instance 3����������undefined
						var fromType = 'onWay';
						initInnerArea(busi_json_elType.ContainerPath,'productspecqry_sub_' + sval + '_' + i + '_Area',fromType);
					
					}
					if(_ins.ProductOrderCharacters) {
						subAreas.push("ProductOrderCharacters");
						getInnerArea("ProductOrderCharacters", "��Ʒ����ֵ�б�", 0,20,'productspecqry_sub_' + sval + '_' + i + '_Area');	
						initInnerArea("ProductOrderCharacters",'productspecqry_sub_' + sval + '_' + i + '_Area');
					}
					addInsMainArea('sub_' + sval + '_' +  i,sval,subAreas);
				} else {
					rdShowMessageDialog("��ȡ��Ʒ��Ҫ�ع������", 1);
				}
			}
		}
	}
	
	function getProductOnWayQryObj() {
		rstJson.input.ProductOrders = [];
		for(var p in areaFunctions) {
			for(var m in areaFunctions[p]) {
				ProductOrder = {};
				var subAreas = areaFunctions[p][m];
				var areaId = 'productspecqry_' + m + '_Area';
				for(var j=0,len2 = subAreas.length;j<len2;j++) {
					var subArea = subAreas[j];
					new Function('get' + subArea + 'Obj'+ '("' + areaId + '")')();
				}
				rstJson.input.ProductOrders.push(ProductOrder);
			}
		}
	}
</script>

<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>