<%
  /*
   * ����: �ײ�
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
	//TODO ����Ҫ�޸�
	/*
	var POOrderRatePolicysJson = '{"ContainerPath": "POOrderRatePolicys","ElementType": 3,"ElementTypeName": "�ײ��б�","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "PolicysCode","ElementId": 1,"ElementName": "�ײ�ID","FormType": "select","SelShow": "��ѡ��~����0~","SelValue": "-1~1206~","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "PolicysName","ElementId": 1,"ElementName": "�ʷѱ�ʶ","FormType": "select","SelShow": "��ѡ��~","SelValue": "-1~","ElementGroup": 0}]}';
	var _json = eval("(" + POOrderRatePolicysJson + ")");
	*/
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	getHtmlSegment(_json.Elements,"<%=areaId%>_table");
	
	$(function() {
		$('#<%=areaId%>_table').find('select:eq(0)').attr('id','policysID');
		$('#<%=areaId%>_table').find('select:eq(1)').attr('id','planStatus');
		$('#planStatus').css('width','200px');
		$('#policysID').change(function() {
			var plID = $('#policysID').val();
			var planHtml = new Array();
			if(plID == '') {
				$('#planStatus').val('');
				planHtml.push('<option value="">��ѡ��</option>');
			}else {
				//���÷����ȡ�ʷѼƻ���ʶ
				getServiceMsg("sQryPoRate", "doGetPoRate",1,sceneId,plID);	
			}
		});
		$('#planStatus').change(function() {
			var plID = $('#policysID').val();
			var planVal = $('#planStatus').val();
			if(planVal != '') {
				getServiceMsg("sQryPoICB", "doGetPoICB",1,sceneId,plID,planVal);	
			}
		});
		/*
		$('#addPolicysBtn').click(function() {
			//����һ��ҳ��
			var path="module/POOrderRatePolicys.jsp";
			window.open(path,"newwindow",
					"height=450, width=900,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");	
		});
		*/
	});
	function doGetPoRate(data) {
		$('#ICBListTbody').empty();
		$('#planStatus').empty();
		var _json = eval("(" + data + ")");
		var ps = _json.planStatus;
		var planHtml = new Array();
		planHtml.push('<option value="">��ѡ��</option>');
		if( ps && ps.length > 0) {
			for(var i=0,len=ps.length;i<len;i++) {
				var p = ps[i];
				planHtml.push('<option value="' + p.RatePlanID + '">' + p.Description + '</option>');
			}
		}	
		$('#planStatus').append(planHtml.join(''));
	}
	
	function doGetPoICB(data) {
		$('#ICBListTbody').empty();
		var ICBHtml = new Array();
		//����ICB���б�
		var _json = eval("(" + data + ")");
		var ps = _json.PoOrderIcbs;
		if( ps && ps.length > 0) {
			for(var i=0,len=ps.length;i<len;i++) {
				var p = ps[i];
				ICBHtml.push('<tr><td>' + p.ParameterNumber + '</td><td>' + p.ParameterName + '</td><td><input type="text" value="' + p.ParameterValue + '" maxlength="12" v_must="1" v_type="money" onblur="ConfirmChecksFlag(this)"/> </td>');
			}	
			if(ICBHtml.length > 0) {
				$('#ICBListTbody').append(ICBHtml.join(''));
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
  
	
	function keyupEvent(v){
		v.value=v.value.replace(/\D/g,'');
	}
	function afterpasteEvent(v){
		v.value=v.value.replace(/\D/g,'');
	}
	
	function getPOOrderRatePolicysObj() {
		rstJson.input.POOrderRatePolicys = [];
		//1.����ICB��������
		var ICBs = new Array();
		//2.���ProductOrderICBs����
		var $tbody = $('#ICBListTbody');
		$tbody.find("tr").each(function(){
			var $tr = $(this);
			var ICB = {};
			ICB.ParameterNumber = $tr.find('td:eq(0)').text();
			ICB.ParameterName = $tr.find('td:eq(1)').text();
			ICB.ParameterValue = $tr.find('td:eq(2)').find('input').val();
			ICBs.push(ICB);
		});
		//3.RatePlan����
		var RatePlan = {};
		RatePlan.RatePlanID =  $('#planStatus').val();
		RatePlan.Flag = 'NEW';
		RatePlan.ProductOrderICBs = ICBs;
		//4.POOrderRatePolicy����  
		var Policy = {};
		Policy.POSpecRatePolicyID = $('#policysID').val();
		Policy.Flag = 'NEW',
		Policy.RatePlans = [];
		Policy.RatePlans.push(RatePlan);
		//5. ���POOrderRatePolicys
		rstJson.input.POOrderRatePolicys.push(Policy);
	}
	
	
	/*
	function addPolicy(policy,policysID,code,name) {
		var rips = rstJson.input.POOrderRatePolicys;
		alert('rips=' + rips);
		if(rips) {
			//1.�ж��ײ�ID�Ƿ�Ϊ'',���Ϊ��������ֱ�����policy����
			if(policysID == '') {
				if(rips.length == 0) {
					rips = [];
				}
				rips.push(policy);	
			}
			//2.���policysID��Ϊ��������ֱ�����RatePlan
			else {
				for(var i=0,len=rips.length;i<len;i++) {
					var _rip = rips[i];
					//�����ײ�ID
					if(plID == _rip.POSpecRatePolicyID) {
						_rip.RatePlans = [];
						_rip.RatePlans.push(policy.RatePlans[0]);
					}
				}	
			}
		}else {
			rstJson.input.POOrderRatePolicys = [];
			rstJson.input.POOrderRatePolicys.push(policy);
			alert(rstJson.input.POOrderRatePolicys.length);
		}	
		//4.��ʾһ��tr����
		var htmlArray = new Array();
		htmlArray.push('<tr><input type="hidden" value="' + policysID + '"><td>');
		htmlArray.push(code);
		htmlArray.push('</td><td>');
		htmlArray.push(name);
		htmlArray.push('</td><td>');
		htmlArray.push('<input type="button" value="ɾ��" name="delPolicyBtn" class="b_text" onclick="delPolicyRecord(this)" /></td></tr>');
		$('#tbody_POOrderRatePolicys').append(htmlArray.join(''));
	}
	
	
	function delPolicyRecord(k) {
		//ɾ��rstJson.input.POOrderRatePolicys�е�����
		var rips = rstJson.input.POOrderRatePolicys;
		var policyID = $(k).parents("tr").find('input').val();
		var planID = $(k).parents("tr").find('td:eq(0)').text();
		var _policy = rips.getElByValue(policyID,"POSpecRatePolicyID");
		if(_policy) {
			_policy.removeElByValue(planID,"RatePlanID");
		}
		$(k).parents("tr").remove();
	}
	*/
</script>
<form>
	<table id="<%=areaId%>_table">
		
	</table>
	<div class="title" style="margin-left:20px;margin-top:0px;">
		<div id="title_zi">ICB����ֵ�б�</div>
	</div>
	<div style="margin-left:20px;margin-top:0px;">
		<table>
			<tr align="center">
				<th>��������</th>
				<th>������</th>
				<th>����ֵ</th>
			</tr>
			<tbody id="ICBListTbody">
			</tbody>
		</table>
	</div>
</form>
<!--
<table>
	<body id="">
		<tr>
			<td>
				<input type="button" value="����" id="addPolicysBtn" name="addPolicysBtn" />
			</td>
		</tr>
	</body>
</table>
-->