<%
  /*
   * ����: ��Ʒʵ���б�
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
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	getHtmlSegment(_json.Elements,"<%=areaId%>_table");
	
	var count = 0;
	function addRule() {
		var sval = $('#<%=areaId%>_table select').val();
		if(sval == '') {
			return false;	
		}
		if(areaFunctions[sval]) {
			rdShowMessageDialog("һ����Ʒ������ϵ����ֻ�����һ�Σ�");	
			return false;	
		}
		var sname = $('#<%=areaId%>_table select').find("option:selected").text();
		count++;
		//productspecqry_sub_ruleId_count
		getOnlyTitleArea("<%=areaId%>_sub_" + sval + '_' + count + '_', "��Ʒʵ���굥--" + sname , 0,20,'<%=areaId%>Area',true);
		var sval = $('#<%=areaId%>_table select').val();
		getServiceMsg("se743QryPSR", "doGetDetail",1,sceneId,'','',sval, $('input[name="POOrderNumber"]').val());		
	}
	
	//��¼����ҳ���ContainerPath
	function doGetDetail(data) {
		var subAreas = new Array();
		var sval = $('#<%=areaId%>_table select').val();
		setJson1Val(data);
		var _obj = eval("(" + data + ")");
		if (_obj.ElementTypes != null  || _obj.ProductOrderCharacters != null) {
			var funs = new Array();
			//liujian �������񷵻ص�json������չʾ
			for (var a = 0; a < _obj.ElementTypes.length; a ++) {
				var busi_json_elType = _obj.ElementTypes[a];
				
				subAreas.push(busi_json_elType.ContainerPath);
				getInnerArea(busi_json_elType.ContainerPath, busi_json_elType.ElementTypeName, 0,20,'<%=areaId%>_sub_' + sval + '_' + count + '_Area');
				//liujian 2012-8-17 16:14:01  fromType���ַ�֧   ģ���ܹ���������֧��1����;onWay 2��ʵ��instance 3����������undefined
				var fromType = 'instance';
				initInnerArea(busi_json_elType.ContainerPath,'<%=areaId%>_sub_' + sval + '_' + count + '_Area',fromType);
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
	
	function getProdInsQryObj() {
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
	
	$(function() {
		//�����Ʒ������
		var ponum = $('input[name="POOrderNumber"]').val();
		if(!ponum) {	
			ponum = '';
		}
		//insOfferId:��Ʒ������ϵ����
		//getServiceMsg("se743QryPSROW", "doQryPSROW",1,sceneId,in_ChanceId,ponum,insOfferId);			
	});
</script>

<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>