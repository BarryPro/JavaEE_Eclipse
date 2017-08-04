<%
  /*
   * 功能: 套餐
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
	//TODO 名称要修改
	/*
	var POOrderRatePolicysJson = '{"ContainerPath": "POOrderRatePolicys","ElementType": 3,"ElementTypeName": "套餐列表","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "PolicysCode","ElementId": 1,"ElementName": "套餐ID","FormType": "select","SelShow": "请选择~测试0~","SelValue": "-1~1206~","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "PolicysName","ElementId": 1,"ElementName": "资费标识","FormType": "select","SelShow": "请选择~","SelValue": "-1~","ElementGroup": 0}]}';
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
				planHtml.push('<option value="">请选择</option>');
			}else {
				//调用服务获取资费计划标识
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
			//弹出一个页面
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
		planHtml.push('<option value="">请选择</option>');
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
		//设置ICB的列表
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
  	rdShowMessageDialog("参数值必须是大于等于0的，长度小于等于12位的数字！");
  	obj.focus();
  	return;
  } else if (parseInt(obj.value) < 0) {
  	rdShowMessageDialog("参数值必须是大于等于0的，长度小于等于12位的数字！");
  	obj.focus();
  	return;
  }
 	 if (obj.value.indexOf(".")>9) {
    	rdShowMessageDialog("参数值结构必须是9位数字加两位小数！");
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
		//1.创建ICB对象数组
		var ICBs = new Array();
		//2.添加ProductOrderICBs对象
		var $tbody = $('#ICBListTbody');
		$tbody.find("tr").each(function(){
			var $tr = $(this);
			var ICB = {};
			ICB.ParameterNumber = $tr.find('td:eq(0)').text();
			ICB.ParameterName = $tr.find('td:eq(1)').text();
			ICB.ParameterValue = $tr.find('td:eq(2)').find('input').val();
			ICBs.push(ICB);
		});
		//3.RatePlan对象
		var RatePlan = {};
		RatePlan.RatePlanID =  $('#planStatus').val();
		RatePlan.Flag = 'NEW';
		RatePlan.ProductOrderICBs = ICBs;
		//4.POOrderRatePolicy对象  
		var Policy = {};
		Policy.POSpecRatePolicyID = $('#policysID').val();
		Policy.Flag = 'NEW',
		Policy.RatePlans = [];
		Policy.RatePlans.push(RatePlan);
		//5. 完成POOrderRatePolicys
		rstJson.input.POOrderRatePolicys.push(Policy);
	}
	
	
	/*
	function addPolicy(policy,policysID,code,name) {
		var rips = rstJson.input.POOrderRatePolicys;
		alert('rips=' + rips);
		if(rips) {
			//1.判断套餐ID是否为'',如果为‘’，则直接添加policy对象
			if(policysID == '') {
				if(rips.length == 0) {
					rips = [];
				}
				rips.push(policy);	
			}
			//2.如果policysID不为‘’，则直接添加RatePlan
			else {
				for(var i=0,len=rips.length;i<len;i++) {
					var _rip = rips[i];
					//查找套餐ID
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
		//4.显示一条tr数据
		var htmlArray = new Array();
		htmlArray.push('<tr><input type="hidden" value="' + policysID + '"><td>');
		htmlArray.push(code);
		htmlArray.push('</td><td>');
		htmlArray.push(name);
		htmlArray.push('</td><td>');
		htmlArray.push('<input type="button" value="删除" name="delPolicyBtn" class="b_text" onclick="delPolicyRecord(this)" /></td></tr>');
		$('#tbody_POOrderRatePolicys').append(htmlArray.join(''));
	}
	
	
	function delPolicyRecord(k) {
		//删除rstJson.input.POOrderRatePolicys中的数据
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
		<div id="title_zi">ICB参数值列表</div>
	</div>
	<div style="margin-left:20px;margin-top:0px;">
		<table>
			<tr align="center">
				<th>参数编码</th>
				<th>参数名</th>
				<th>参数值</th>
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
				<input type="button" value="新增" id="addPolicysBtn" name="addPolicysBtn" />
			</td>
		</tr>
	</body>
</table>
-->