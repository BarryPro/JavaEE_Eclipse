<%
  /*
   * ����: ��Ʒ����б�
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
<script type=text/javascript>
	/*
	var _json2 ='{"ContainerPath": "productspecqry","ElementType": 3,"ElementTypeName": "��Ʒ����б�","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "�ʷ���","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "�ʷ���","FormType": "select","SelShow": "��Ӱ����~������~����~","SelValue": "1~2~3~","ElementGroup": 0}]}';
	var areaId = '<%=areaId%>';
	var _json = eval("(" + _json2 + ")");
	*/
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	getHtmlSegment(_json.Elements,"<%=areaId%>_table");
	
	var count = 0;
	function addRule() {
		var sval = $('#<%=areaId%>_table select').val();
		if(sval == '') {
			return false;	
		}
		var sname = $('#<%=areaId%>_table select').find("option:selected").text();
		count++;
		//productspecqry_sub_ruleId_count
		getOnlyTitleArea("<%=areaId%>_sub_" + sval + '_' + count + '_', "��Ʒ����굥--" + sname , 0,20,'<%=areaId%>Area',true);
		var sval = $('#<%=areaId%>_table select').val();
		getServiceMsg("se743QryPSR", "doGetDetail",1,sceneId,'',sval);	
	}
	function setProdRuleSelect(k) {
		//alert("setProdRuleSelect");
		var obj = eval("(" + k + ")");
		var selArr = new Array();
		if(!isBlack(obj)) {
			var ps = obj.ProductSpecList;
			if(!isBlack(ps)) {
				for(var i=0,len=ps.length;i<len;i++) {
					selArr.push('<option value=' + ps[i].ProSceneId + '/>');
					selArr.push(ps[i].ProductSpecName);
					selArr.push('</option>');	
				}	
			}
			if(selArr.length > 0) {
				$('#<%=areaId%>_table select').empty();
				$('#<%=areaId%>_table select').append(selArr.join(''));
			}
		}
	}
	//��¼����ҳ���ContainerPath
	
	function doGetDetail(data) {
		var subAreas = new Array();
		var sval = $('#<%=areaId%>_table select').val();
		/*
		var testObj = '';
		
		if(sval == 1) {
			testObj = '{"ElementTypes": [{"ContainerPath": "ProductOrderCharge","ElementType": 3,"ElementTypeName": "��Ʒһ��������","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "�ʷ���","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "�ʷ���","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "����","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "�ʷ���","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "�ʷ���","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 1}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "����","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 1}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "�ʷ���","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "�ʷ���","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 2}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "����","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 2}]}],"ProductOrderCharacters": [{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "��1","CharacterName": "Ԥ���������","CharacterNumber": "999033700","CharacterOrder": 1,"CharacterType": "select","DefaultValue": "4444444444444","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "����~����~����~~","SelValue": "aa~bb~cc~","ShowFlag": "","VFormat": "","VType": "string"}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "��0","CharacterName": "�ͻ�����","CharacterNumber": "999033701","CharacterOrder": 2,"CharacterType": "select","DefaultValue": "333333333333","FieldCode": "","MaxLength": "2","MaxVal": "3","MinVal": "1","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "����~����~����~~","SelValue": "aa~bb~cc~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "��0","CharacterName": "��ϸ���󸽼�","CharacterNumber": "999033702","CharacterOrder": 3,"CharacterType": "","DefaultValue": "222222222","FieldCode": "","MaxLength": "11","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "33","VType": ""}, {"AlterInfo": "","CharacterGroup": "2","CharacterGroupName": "��2","CharacterName": "�Ƿ�ͳһ�ʷ�","CharacterNumber": "999033703","CharacterOrder": 4,"CharacterType": "","DefaultValue": "11111111111","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "2","CharacterGroupName": "��2","CharacterName": "��ϸ���󸽼�","CharacterNumber": "999033702","CharacterOrder": 3,"CharacterType": "","DefaultValue": "222222222","FieldCode": "","MaxLength": "11","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "33","VType": ""}]}';
		}else if(sval == 2) {
			testObj = '{"ElementTypes": [{"ContainerPath": "PayCompanys","ElementType": 3,"ElementTypeName": "֧��ʡ","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "֧��ʡ����","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditTime","ElementId": 1,"ElementName": "֧��ʡ����","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}]}],"ProductOrderCharacters": [{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "��1","CharacterName": "Ԥ���������","CharacterNumber": "999033700","CharacterOrder": 1,"CharacterType": "select","DefaultValue": "4444444444444","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "����~����~����~~","SelValue": "aa~bb~cc~","ShowFlag": "","VFormat": "","VType": "string"}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "��0","CharacterName": "�ͻ�����","CharacterNumber": "999033701","CharacterOrder": 2,"CharacterType": "select","DefaultValue": "333333333333","FieldCode": "","MaxLength": "2","MaxVal": "3","MinVal": "1","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "����~����~����~~","SelValue": "aa~bb~cc~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "��0","CharacterName": "��ϸ���󸽼�","CharacterNumber": "999033702","CharacterOrder": 3,"CharacterType": "","DefaultValue": "222222222","FieldCode": "","MaxLength": "11","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "33","VType": ""}, {"AlterInfo": "","CharacterGroup": "2","CharacterGroupName": "��2","CharacterName": "�Ƿ�ͳһ�ʷ�","CharacterNumber": "999033703","CharacterOrder": 4,"CharacterType": "","DefaultValue": "11111111111","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "2","CharacterGroupName": "��2","CharacterName": "��ϸ���󸽼�","CharacterNumber": "999033702","CharacterOrder": 3,"CharacterType": "","DefaultValue": "222222222","FieldCode": "","MaxLength": "11","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "33","VType": ""}]}';
		}else if(sval == 3) {
			testObj = '	{	"ElementTypes": [	{	"ContainerPath": "ProductOrderBase",	"ElementType": 3,	"ElementTypeName": "��Ʒ����������Ϣ222",	"Elements": [	{	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "0",	"EOrder": 0,	"EType": "",	"EUpdate": "1",	"EValue": "",	"ElementAlter": "",	"ElementCode": "POAuditName",	"ElementId": 1,	"ElementName": "����������",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}, {	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "1",	"EOrder": 1,	"EType": "",	"EUpdate": "0",	"EValue": "",	"ElementAlter": "",	"ElementCode": "POAuditTime",	"ElementId": 1,	"ElementName": "����ʱ��(��ʽ��YYYYMMDDhhmiss)",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}, {	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "1",	"EOrder": 2,	"EType": "",	"EUpdate": "1",	"EValue": "",	"ElementAlter": "",	"ElementCode": "question",	"ElementId": 1,	"ElementName": "�������",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}	]	}, {	"ContainerPath": "ProductOrderList",	"ElementType": 3,	"ElementTypeName": "��Ʒ�����б�222",	"Elements": [	{	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "0",	"EOrder": 0,	"EType": "",	"EUpdate": "1",	"EValue": "",	"ElementAlter": "",	"ElementCode": "POAuditName",	"ElementId": 1,	"ElementName": "����������",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}, {	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "1",	"EOrder": 1,	"EType": "",	"EUpdate": "0",	"EValue": "",	"ElementAlter": "",	"ElementCode": "POAuditTime",	"ElementId": 1,	"ElementName": "����ʱ��(��ʽ��YYYYMMDDhhmiss)",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}, {	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "1",	"EOrder": 2,	"EType": "",	"EUpdate": "1",	"EValue": "",	"ElementAlter": "",	"ElementCode": "question",	"ElementId": 1,	"ElementName": "�������",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}	]	}	]	}';
		}
		
		var _obj = eval("(" + testObj + ")");
		*/
		//subAreasJson = data;
		setJson1Val(data);
		var _obj = eval("(" + data + ")");
		if (_obj.ElementTypes != null  || _obj.ProductOrderCharacters != null) {
			var funs = new Array();
			//liujian �������񷵻ص�json������չʾ
			for (var a = 0; a < _obj.ElementTypes.length; a ++) {
				var busi_json_elType = _obj.ElementTypes[a];
				
				subAreas.push(busi_json_elType.ContainerPath);
				getInnerArea(busi_json_elType.ContainerPath, busi_json_elType.ElementTypeName, 0,20,'<%=areaId%>_sub_' + sval + '_' + count + '_Area');
				initInnerArea(busi_json_elType.ContainerPath,'<%=areaId%>_sub_' + sval + '_' + count + '_Area');
			}
			if(_obj.ProductOrderCharacters) {
				subAreas.push("ProductOrderCharacters");
				getInnerArea("ProductOrderCharacters", "��Ʒ����ֵ�б�", 0,20,'<%=areaId%>_sub_' + sval + '_' + count + '_Area');	
				initInnerArea("ProductOrderCharacters",'<%=areaId%>_sub_' + sval + '_' + count + '_Area');
			}
			addMainArea('sub_' + sval + '_' +  count,sval,subAreas);
			removeBtnDisabled();
		} else {
			rdShowMessageDialog("��ȡ��Ʒ��Ҫ�ع������", 1);
		}
	}
	function addMainArea(mainAreaId,ruleId,subAreas) {
		//������
		//1.1 ��ù��Id,����ӵĸ�����id
		//1.2 �������񷵻ص����ݻ��subAreas
		//1.3 ��areaFunctions����ӹ�����
		//1.3.1 ��������󲻴���
		if(!areaFunctions[ruleId]) {
			areaFunctions[ruleId] = {};
			areaFunctions[ruleId].subArea = subAreas;
			areaFunctions[ruleId].mainArea = [];
			areaFunctions[ruleId].mainArea.push(mainAreaId);
		}
		//1.3.2������������
		else {
			areaFunctions[ruleId].mainArea.push(mainAreaId);
		}
	}
	
	function getproductspecqryObj() {
		rstJson.input.ProductOrders = [];
		for(var p in areaFunctions) {
			var mainAreas = areaFunctions[p].mainArea;
			var subAreas = areaFunctions[p].subArea;
			for(var i=0,len=mainAreas.length;i<mainAreas.length;i++) {
				ProductOrder = {};
				var areaId = '<%=areaId%>_' + mainAreas[i] + '_Area';
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
</script>

<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>