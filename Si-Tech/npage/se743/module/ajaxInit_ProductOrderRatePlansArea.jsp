<%
  /*
   * ����: ��Ʒ���ʷ��б�
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
	String fromType = request.getParameter("fromType");
	System.out.println("gaopengSeeLog=============fromType11:"+fromType);
%>
<script type=text/javascript>
	//TODO ����Ҫ�޸�
	/*
	var testJson = '{"ContainerPath": "ProductOrderRatePlans","ElementType": 3,"ElementTypeName": "��Ʒ���ʷ��б�","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "����������","FormType": "select","SelShow": "��ʶ1~��ʶ2~��ʶ3~","SelValue": "1~2~3~","ElementGroup": 0}]}';
	var _json = eval("(" + testJson + ")");
	*/
	var areaId = '<%=areaId%>';
	var _id = '';
	var parentId = '<%=parentId%>';
	if(parentId != null && parentId != '' && parentId !='null') {
		_id = parentId + " #<%=areaId%>_table"	;
	}else {
		_id	= '<%=areaId%>_table';
	}
	var _json = getObjFromSrv(areaId);
	getHtmlSegment(_json.Elements,_id);
	initICB(_json.Elements);
	
	
	$(function() {
		$('#' + _id +' select[name="RatePlanID"]').change(function(){
			ratePlansGroup = $(this).attr("group");
			
			var plID = $('#<%=areaId%>_table select[name="RatePlanID"]').val();
			
			var _parentId = '<%=areaId%>_table';
			var ruleId = '';//��Ʒ�����
			if('<%=parentId%>' != 'null' && '<%=parentId%>' != '') {
				var _temp = split('<%=parentId%>','_');
				if(_temp.length > 2) {
					ruleId = _temp[2];
				}
				plID = $(this).val();
				_parentId = '<%=parentId%> #<%=areaId%>_table';
			}
			if(plID == '') {
				
				$('#ICBDiv').find("div").each(function(){
					if(ratePlansGroup == $(this).attr("ElementGroup")){
						//alert("���  " + ratePlansGroup);
						$(this).find('#prodICBListTbody').empty();
					}
				});
				var _select = $('#' + _id +' select[name="OfferId"][group="'+ratePlansGroup+'"]');
				_select.empty();
				_select.append('<option value="">��ѡ��</option>');
			}else {
				
				//���÷����ȡICB
				selectParent['<%=areaId%>'] = '<%=parentId%>' + ' #<%=areaId%>_table';
				//liujian 2012-8-17 16:23:20 ��;��Ʒ������
				var productOrderNumber = '';
				if('<%=fromType%>' == null || '<%=fromType%>' == 'NULL' || '<%=fromType%>' == 'undefined')  {
				}else if('<%=fromType%>' == 'onWay'){
					/*
					alert($('#<%=parentId%> #productorderinfo_table').html());
					alert($('#ICBDiv').find("div").parent().html());
					
					ruleId = $('input[name="prodsceneid"]').val();
					productOrderNumber = $('input[name="ProductOrderNumber"]').val();
					*/
					
					ruleId = $('#<%=parentId%> #productorderinfo_table').find('input[name="prodsceneid"]').val();
					
					
				}else if('<%=fromType%>' == 'instance') {
					ruleId = $('#<%=parentId%> #productorderinfo_table').find('input[name="prodsceneid"]').val();
				}
				
				
				productOrderNumber = $('#<%=parentId%> #productorderinfo_table').find('input[name="ProductOrderNumber"]').val();
				
				getServiceMsg("sQryProductICB", "doGetProductICB",1,ruleId,plID,productOrderNumber);	
			}
		});	
		
		if($('#<%=areaId%>_table select[name="RatePlanID"]').val()) {
			ruleId = $('#<%=parentId%> #productorderinfo_table').find('input[name="prodsceneid"]').val();
			productOrderNumber = $('#<%=parentId%> #productorderinfo_table').find('input[name="ProductOrderNumber"]').val();
			if(!isBlack(ruleId) && !isBlack(ruleId)){
				$('#' + _id +' select[name="RatePlanID"]').change();
			}
		}
	});
	
	function initICB(jsonObj){
		//alert(78);
		//alert(JSON2.stringify(jsonObj));
		for(var i=0,jsonObjLen=jsonObj.length;i<jsonObjLen;i++) {
			var el = jsonObj[i];
			var groupVal = el.ElementGroup;
			var findFlag = false;
			$("#ICBDiv").find("div").each(function(){
				if($(this).attr("ElementGroup") == groupVal){
					findFlag = true;
				}
			});
			if(!findFlag){
				/*�¼�*/
				var insertStr = "<div ElementGroup=\""+groupVal+"\">"
										+"<table>"
											+"<tr>"
												+"<th colspan=\"3\">ICB����ֵ�б�</th>"
											+"</tr>	"
										+"</table>"
										+"<table>"
											+"<thead align=\"center\">"
												+"<th>��������</th>"
												+"<th>������</th>"
												+"<th>����ֵ</th>"
											+"</thead>"
											+"<tbody id=\"prodICBListTbody\"></tbody>"
										+"</table></div>";
				$("#ICBDiv").append(insertStr);
			}
		}
	}
	
	function doGetProductICB(data) {
		//alert(data);
		var _json = eval("(" + data + ")");
		var parentId = selectParent.ProductOrderRatePlans;
		var offers = _json.ProductOfferIds;
		var ps = _json.ProductOrderIcbs;
		var $offer = $('#' + parentId + ' select[name="OfferId"][group="'+ratePlansGroup+'"]');
		$offer.empty();
		if(offers) {
			var offerHtml = new Array();
			for(var i=0,len=offers.length;i<len;i++) {
				var offer = offers[i];
				offerHtml.push('<option value="' + offer.sProductOfferId + '">');
				offerHtml.push( 	offer.sProductOfferName);
				offerHtml.push('</option>');
			}
			if(offerHtml.length > 0) {
				$offer.append(offerHtml.join(''));	
			}else {
				$offer.append('<option value="">��ѡ��</option>');	
			}
		}else{
			var offerHtml = new Array();
			$offer.append('<option value="">��ѡ��</option>');		
		}
		$('#ICBDiv').find("div").each(function(){
			if(ratePlansGroup == $(this).attr("ElementGroup")){
				//alert("���  " + ratePlansGroup);
				$(this).find('#prodICBListTbody').empty();
			}
		});
		/*
		$('#<%=parentId%>' + ' #prodICBListTbody').empty();
		*/
		var ICBHtml = new Array();
		//����ICB���б�
		if( ps && ps.length > 0) {
			for(var i=0,len=ps.length;i<len;i++) {
				var p = ps[i];
				ICBHtml.push('<tr><td>' + p.ParameterNumber + '</td><td>' + p.ParameterName + '</td><td><input type="text" value="' + p.ParameterValue + '" maxlength="12" v_type="money" v_must="1" onblur="ConfirmChecksFlag(this)" /> </td></tr>');
			}	
			if(ICBHtml.length > 0) {
				var sdsd=ICBHtml.join('');
				$('#ICBDiv').find("div").each(function(){
					//alert("ratePlansGroup  " + ratePlansGroup);
					//alert("ElementGroup  " + $(this).attr("ElementGroup"));
					if(ratePlansGroup == $(this).attr("ElementGroup")){
						//alert($(this).html());
						$(this).find('#prodICBListTbody').append(sdsd);
					}
				});
				/*
				$('#<%=parentId%>'+ ' #prodICBListTbody').append(sdsd);
				*/
			}
		}
	}
	
	function ConfirmChecksFlag(obj){
	
 if (!checkElement(obj)) {
  	rdShowMessageDialog("����ֵ�����Ǵ��ڵ���0�ģ�����С�ڵ���12λ�����֣�");
  	obj.focus();
  	return;
  } else if (parseInt(obj.value) < 0) {
  	rdShowMessageDialog("����ֵ�����Ǵ��ڵ���0�ģ�����С�ڵ���12λ�����֣�");
  	obj.focus();
  	return;
  }
 	 if (obj.value.indexOf(".")>9) {
    	rdShowMessageDialog("����ֵ�ṹ������9λ���ּ���λС����");
    	obj.focus();
      return;	
   }
   
   }
	
	function getProductOrderRatePlansObj(parentId) {
		//1. ��ȡ�ʷѱ�ʶ
		
		var value2 = getFormValueByName('<%=areaId%>_table','OfferId');
		var text2 = $('#' + '<%=areaId%>_table').find('select[name="OfferId"]').find("option:selected").text();
		if(!isBlack(parentId)) {
		    value2 = getFormValueByName(parentId + ' #<%=areaId%>_table','OfferId');
		    text2 = $('#' + parentId + ' #<%=areaId%>_table').find('select[name="OfferId"]').find("option:selected").text();
		}	
		
		
		ProductOrder.ProductOrderRatePlans = new Array();
		var seletValObj = $('#' + "<%=areaId%>_table").find('select[name="RatePlanID"]');
		seletValObj.each(function(i,n){
			var value = $(this).val();
			if(!isBlack(value)){
				var infos = split(value,'-');
				var obj = {};
				obj.RatePlanID = infos[0];
				obj.Description = infos[1];
				
				//2. ��ȡICB
				var ICBs = new Array();
				var groupAttr = $(this).attr("group");
				
				var _tbody = $('#ICBDiv').find("div[ElementGroup='"+groupAttr+"']").find("#prodICBListTbody");
				_tbody.find("tr").each(function(i){
					var $tr = $(this);
					var ICB = {};
					ICB.ParameterNumber = $tr.find('td:eq(0)').text();	
					ICB.ParameterName = $tr.find('td:eq(1)').text();
					ICB.ParameterValue = $tr.find('input').val();
					//alert(JSON.stringify(ICBs));
					ICBs.push(ICB);
				});
				
				obj.ProductOrderICBs = ICBs;
				
				ProductOrder.ProductOrderRatePlans.push(obj);
			}
		});
		
		ProductOrder.OfferId = value2;
		ProductOrder.OfferName = text2;
		
		
		
	}
</script>

<form>
	<table id="<%=areaId%>_table">
		
	</table>
	<div  style="margin-left:0px;margin-top:0px;" id="ICBDiv">	
	</div>
</form>