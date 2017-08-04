<%
  /*
   * 功能: 产品属性组
   * 版本: 1.0
   * 日期: 2012-03-31
   * 作者: liujian
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String areaId = request.getParameter("areaId");
	String parentId = request.getParameter("parentId");
	System.out.println("liujian===areaId=" + areaId);
	/* 当前时间 */
	Date currentTime = new Date(); 
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
	String currentTimeString = formatter.format(currentTime);
	
	/* 当月最后一天 */
	Calendar cal = Calendar.getInstance();     
	cal.set(cal.DAY_OF_MONTH,cal.getActualMaximum(cal.DAY_OF_MONTH));     
	String lastTime =  new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
	System.out.println("diling===lastTime=" + lastTime);

	/* 下个月最后一天 */
	Calendar calendar = Calendar.getInstance();  
	// 设置Calendar月份数为下一个月  
	calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) + 1);  
	// 设置Calendar日期为下一个月一号  
	calendar.set(Calendar.DATE, 1); 
	calendar.set(calendar.DAY_OF_MONTH,calendar.getActualMaximum(calendar.DAY_OF_MONTH));    
	String lastTimeNextMonth =  new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	System.out.println("diling===lastTimeNextMonth=" + lastTimeNextMonth);
%>
<script language="javascript" type="text/javascript" src="/npage/se743/json2.js"></script>
<script type=text/javascript>
	//TODO 名称要修改
	/*
	var testJson = '{"ElementTypes": [{"ContainerPath": "","ElementType": 100,"ElementTypeName": "产品级资费","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 0,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "Description","ElementId": 1001,"ElementName": "资费描述"}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 0,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "RatePlanID","ElementId": 1000,"ElementName": "资费计划标识"}]}],"ProductOrderCharacters": [{"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "","CharacterName": "成员明细文件","CharacterNumber": "999033717","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "","CharacterName": "确认反馈明细附件","CharacterNumber": "999033734","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "","CharacterName": "开通反馈明细附件","CharacterNumber": "999033735","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "","CharacterName": "成员明细文件","CharacterNumber": "999033717","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "","CharacterName": "确认反馈明细附件","CharacterNumber": "999033734","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "","CharacterName": "开通反馈明细附件","CharacterNumber": "999033735","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"}]}';
	var _json = eval("(" + testJson + ")");
	
		
	
	//测试多选框和文件
	var testJson='{"ElementTypes": [{"ContainerPath": "productorderinfo","ElementType": 60,"ElementTypeName": "产品订单基本信息","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 0,"EType": "","EUpdate": "0","EValue": "2012071109341926829","ElementAlter": "","ElementCode": "ProductOrderNumber","ElementGroup": "0","ElementId": 2000,"ElementName": "产品订单号","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 1,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "ProductID","ElementGroup": "0","ElementId": 2001,"ElementName": "产品订购关系ID","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 2,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "SICode","ElementGroup": "0","ElementId": 2002,"ElementName": "SI编码","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 3,"EType": "","EUpdate": "0","EValue": "111303","ElementAlter": "","ElementCode": "ProductSpecNumber","ElementGroup": "0","ElementId": 2003,"ElementName": "产品规格编号","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 4,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "AccessNumber","ElementGroup": "0","ElementId": 2004,"ElementName": "产品关键号码","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 5,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "PriAccessNumber","ElementGroup": "0","ElementId": 2005,"ElementName": "产品附件号码","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 6,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "Linkman","ElementGroup": "0","ElementId": 2006,"ElementName": "联系人","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 7,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "ContactPhone","ElementGroup": "0","ElementId": 2007,"ElementName": "联系电话","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 8,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "Description","ElementGroup": "0","ElementId": 2008,"ElementName": "产品描述","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "0","EValue": "1","ElementAlter": "","ElementCode": "OperationSubTypeID","ElementGroup": "0","ElementId": 2023,"ElementName": "产品级操作类型","FormType": "select","SelShow": "1-新增产品订购~2-取消产品订购~3-产品暂停~4-产品恢复~5-修改产品资费~6-变更成员（保留）~8-修改缴费关系（保留）~9-修改订购产品属性~10－产品预受理~11-预取消产品订购~12-冷冻期恢复产品订购~13-业务开展省新增或删除~14-配合省协助业务预受理~15-配合省协助业务受理~","SelValue": "1~2~3~4~5~6~7~8~9~10~11~12~13~14~15~"}]}, {"ContainerPath": "ProductOrderRatePlans","ElementType": 100,"ElementTypeName": "产品级资费","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 54,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "RatePlanID","ElementGroup": "0","ElementId": 1000,"ElementName": "资费计划标识","FormType": "select","SelShow": "...请选择...~6-->测试~","SelValue": "~6~"}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 55,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "OfferId","ElementGroup": "0","ElementId": 2022,"ElementName": "产品级资费","FormType": "select","SelShow": "...请选择...~","SelValue": "~"}]}],"ProductOrderCharacters": [{"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "接入方式","CharacterNumber": "1113035000","CharacterOrder": 1,"CharacterType": "select","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "直连~转接~","SelValue": "直连~转接~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0

","CharacterGroupName": "默认组","CharacterName": "接入省","CharacterNumber": "1113035001","CharacterOrder": 2,"CharacterType": "select","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "100-北京~200-广东~210-上海~220-天津~230-重庆~240-辽宁~250-江苏~270-湖北~290-陕西~311-河北~351-山西~371-河南~431-吉林~451-黑龙江~471-内蒙古~531-山东~551-安徽~571-浙江~591-福建~731-湖南~771-广西~791-江西~851-贵州~871-云南~891-西藏~898-海南~931-甘肃~951-宁夏~971-青海~991-新疆~280-四川~","SelValue": "100~200~210~220~230~240~250~270~290~311~351~371~431~451~471~531~551~571~591~731~771~791~851~871~891~898~931~951~971~991~280~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "特服号码","CharacterNumber": "1113035005","CharacterOrder": 3,"CharacterType": "text","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "0_9"}, {"AlterInfo": "全国或省份；如果是多个省份的，接口上传时省份之间用“;”分割，如“北京;上海;天津”","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "业务覆盖范围","CharacterNumber": "1113035006","CharacterOrder": 4,"CharacterType": "text","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "","SelValue": "","ShowFlag": "1","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "业务保障等级","CharacterNumber": "1113035007","CharacterOrder": 5,"CharacterType": "checkbox[~]","DefaultValue": "A~AA","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "AAA~AA~A~普通~","SelValue": "AAA~AA~A~普通~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "是否外呼","CharacterNumber": "1113035008","CharacterOrder": 6,"CharacterType": "select","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "是~否~","SelValue": "是~否~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "其他说明","CharacterNumber": "1113035010","CharacterOrder": 7,"CharacterType": "text","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "全网局数据申请单","CharacterNumber": "1113035011","CharacterOrder": 8,"CharacterType": "file","DefaultValue": "a22222222aa.txt","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "计费规则申请单","CharacterNumber": "1113035012","CharacterOrder": 9,"CharacterType": "file","DefaultValue": "aaaa.txt","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "1","RequireFlag": "1","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "日期：YYYYMMDD","CharacterGroup": "0","CharacterGroupName": "默认组","CharacterName": "局数据最终完成时间","CharacterNumber": "1113037003","CharacterOrder": 13,"CharacterType": "text","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "0","VFormat": "","VType": ""}]}';
	var _json = eval("(" + testJson + ")");
*/
	
	
	
	
	var areaId = '<%=areaId%>';
	
	var _json = eval("(" + $.trim($("#json1").val()) + ")");
	
	checkboxArray=[];
	var _id = '';
	var parentId = '<%=parentId%>';
	if(parentId != null && parentId != '' && parentId !='null') {
		_id = parentId + " #ProductOrderCharacters_table"	;
	}else {
		_id	= 'ProductOrderCharacters_table';
	}
	//各个组点击添加按钮时，添加的表单
	var $trGroupHtml = {};
	var time = 1;
	function groupInfo(trHtml,maxNum) {
		this.trHtml = trHtml;
		this.maxNum = maxNum;
	}
		//trGroupHtml对象： Group_  开头
		// { 
		//	Group_CharacterGroup : {"trHtml":"","maxNum" : ""},
		//	Group_CharacterGroup : {"trHtml":"","maxNum" : ""},
		// }
		
	function Character(ProductSpecCharacterNumber,CharacterValue,Name,CharacterGroup) {
		this.ProductSpecCharacterNumber = ProductSpecCharacterNumber;
		this.CharacterValue = CharacterValue;
		this.Name = Name;
		this.CharacterGroup = CharacterGroup;
	}
	//设置列表的类型
	function setCharListHtml($opt) {
		var _json = $opt.json;
		var body_id = $opt.tableId;
		//循环一遍数组，获取thead的个数
		//顺序就是json传传递的第一个group的先后顺序
		var bodySmt = new Array();//所有的html片段
		var group0Stm = new Array();//0组的html片段
		var groupNot0Stm = new Array();//非0组的html片段
		var marker = "GroupChar_";//组的标识位
		var rower = "RowChar_";//行的标识位
		var group = {};
		//group对象： Group_  开头
		// { 
		//	Group_ElementGroup : [],
		//	Group_ElementGroup : [],
		//获取所有group对象
		/*
		for(var i=0,len=_json.ProductOrderCharacters.length;i<len;i++) {
			var el = _json.ProductOrderCharacters[i];
			var groupNo = el.CharacterGroup;
			if(isBlack(group[marker + groupNo]) || group[marker + groupNo].length == 0) {
				group[marker + groupNo] = new Array();
			}
			group[marker + groupNo].push(el);
		}
		*/
		for(var i=0,len=_json.ProductOrderCharacters.length;i<len;i++) {
			var el = _json.ProductOrderCharacters[i];
			var groupNo = el.CharacterGroup;
			if(typeof(group[marker + groupNo]) == 'undefined') {
				group[marker + groupNo] = new Array();
			}
			
			if(groupNo != '0' && el.CharacterRow) {
				//属性列表回显
				var rowNo = el.CharacterRow;
				var gAttr = marker + groupNo;
				var rAttr = rower + rowNo;
				if(!group[gAttr][rAttr]){
					group[gAttr][rAttr] = [];
				}
				group[gAttr][rAttr].push(el);
			}else {
				//属性表单和(非回显)属性列表
				group[marker + groupNo].push(el);
			}
		}
		
		//设置状态，第一次读取group则设置thead
		var $tr = new Array();
		//区分CharacterGroup是0和非0的情况，非0可以添加删除记录；0则不能添加删除
		
		for(var g in group) {
			var $headHtml = new Array();
			var $bodyHtml = new Array();
			if(g != 'GroupChar_0') {
				
				for(var t in group[g]) {
					
					//属性表单和(非回显)属性列表
					if(t != "getElByValue" && t != "indexOfByValue" && t != "removeElByValue"){
					if(!isArray(eval(group[g][t]))) {
						var $bodyAddHtml = new Array();//添加按钮所添加的字符串
						$headHtml.push('<th>序列号</th>');
						$bodyHtml.push('<td>' + (time++) + '</td>');
						for(var i=0,len=group[g].length;i<len;i++) {
							var el = group[g][i];
							//处理属性对象
							var _$td= setTdHtml2(el);
							$headHtml.push(_$td.thead);
							$bodyHtml.push(_$td.tbody);
							$bodyAddHtml.push(_$td.tbodyAdd);
						}
						$headHtml.push('<th>操作</th>');
						$bodyHtml.push('<td><input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delAttrRecord(this)" /></td>');
						$bodyAddHtml.push('<td><input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delAttrRecord(this)" /></td>');
						if(isBlack($trGroupHtml['Group_' + el.CharacterGroup])) {
							$trGroupHtml[g] = new groupInfo($bodyAddHtml.join(''),1);
						}
						//设置fieldset
						//TODO 不确定这个tableId是否影响后面的取值
						groupNot0Stm.push('	<fieldset style="overflow-x:auto;overflow-y:hidden;padding-bottom:20px">');
						groupNot0Stm.push('		<legend></legend>');
						groupNot0Stm.push('		<table>');
						groupNot0Stm.push('			<thead>');
						groupNot0Stm.push('				<tr  align="center">');
						groupNot0Stm.push(					$headHtml.join(''));
						groupNot0Stm.push('				</tr>');
						groupNot0Stm.push('			</thead>');
						groupNot0Stm.push('			<tbody id="' + g + 'Tbody">');
						groupNot0Stm.push('				<tr>');
						groupNot0Stm.push(					$bodyHtml.join(''));
						groupNot0Stm.push('				</tr>');
						groupNot0Stm.push('			</tbody>');
						groupNot0Stm.push('		</table>');
						groupNot0Stm.push('		<table>');
						groupNot0Stm.push('			<tr>');
						groupNot0Stm.push('				<td>');
						groupNot0Stm.push('    <input type="button" value="添加" class="b_text" name="addRecordBtn" onclick="addAttrRecord(\'' + body_id + '\', \'' + g + '\');"/>');
						groupNot0Stm.push('				</td>');
						groupNot0Stm.push('			</tr>');
						groupNot0Stm.push('		</table>');
						groupNot0Stm.push('	</fieldset>');
						break;
					}else {
						var $bodyAddHtml = new Array();//添加按钮所添加的字符串
						$headHtml.push('<th>序列号</th>');
						var _tmpGroupNo = '';
						var tempInt = 0;
						for(var s in group[g]) {
							if(s != "getElByValue" && s != "indexOfByValue" && s != "removeElByValue"){
							//一行
							if(typeof(group[g][s]) != 'undefined' && typeof(group[g][s]) != 'function') {
								
								for(var i=0,len=group[g][s].length;i<len;i++) {
									var gEl = group[g][s][i];
									//处理属性对象
									var _$td= setTdHtml2(gEl);
									if(i == 0) {
										$bodyHtml.push('<td>' + gEl.CharacterRow + '</td>');	
									}
									if(tempInt == 0) {
										$headHtml.push(_$td.thead);
										$bodyAddHtml.push(_$td.tbodyAdd);
										_tmpGroupNo = gEl.CharacterGroup;
									}
										
									$bodyHtml.push(_$td.tbody);
								}
								if(tempInt == 0) {
									$headHtml.push('<th>操作</th></tr>');
									$bodyAddHtml.push('<td><input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delAttrRecord(this)" /></td>');
								}
								$bodyHtml.push('<td><input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delAttrRecord(this)" /></td>');
								$bodyHtml.push('</tr>');
							}
							tempInt++;
							time = parseInt(gEl.CharacterRow) + 1;
						}
						}
						if(isBlack($trGroupHtml['Group_' + _tmpGroupNo])) {
							$trGroupHtml[g] = new groupInfo($bodyAddHtml.join(''),1);
						}
						//设置fieldset
						//TODO 不确定这个tableId是否影响后面的取值
						groupNot0Stm.push('	<fieldset style="overflow-x:auto;overflow-y:hidden;padding-bottom:20px">');
						groupNot0Stm.push('		<legend></legend>');
						groupNot0Stm.push('		<table>');
						groupNot0Stm.push('			<thead>');
						groupNot0Stm.push('				<tr  align="center">');
						groupNot0Stm.push(					$headHtml.join(''));
						groupNot0Stm.push('				</tr>');
						groupNot0Stm.push('			</thead>');
						groupNot0Stm.push('			<tbody id="' + g + 'Tbody">');
					//	groupNot0Stm.push('				<tr>');
						groupNot0Stm.push(					$bodyHtml.join(''));
					//	groupNot0Stm.push('				</tr>');
						groupNot0Stm.push('			</tbody>');
						groupNot0Stm.push('		</table>');
						groupNot0Stm.push('		<table>');
						groupNot0Stm.push('			<tr>');
						groupNot0Stm.push('				<td>');
						groupNot0Stm.push('    <input type="button" value="添加" class="b_text" name="addRecordBtn" onclick="addAttrRecord(\'' + body_id + '\', \'' + g + '\');"/>');
						groupNot0Stm.push('				</td>');
						groupNot0Stm.push('			</tr>');
						groupNot0Stm.push('		</table>');
						groupNot0Stm.push('	</fieldset>');
						break;
					}	
				}
				}
			}else {
				group0Stm.push('	<fieldset style="border-Color:##c9dbf2;">');
				group0Stm.push('		<legend></legend>');
				group0Stm.push('		<table>');
				group0Stm.push('			<thead>');
				group0Stm.push('				<tr><th>属性代码</th><th>属性名</th><th>属性值</th></tr>');
				group0Stm.push('			</thead>');
				group0Stm.push('			<tbody id="' + g + 'Tbody">');
				$bodyHtml = [];
				for(var i=0,len=group[g].length;i<len;i++) {
					var el = group[g][i];
					//处理属性对象
					//"ShowFlag": "",0不显示，""或者1显示，默认显示
					var pId = 'A';
					var vs = split(parentId,'_');
					if(vs.length > 2) {
						pId = 'A' + vs[2] + '_' + vs[3];	
					}
					//alert("vs[3]="+vs[3]);
					var _$td= setTdHtml2(el,pId,vs[3]);
					if(el.ShowFlag == '0') {
						$bodyHtml.push('<tr style="display:none"><td>' + el.CharacterNumber + '</td>');
					}else {
						$bodyHtml.push('<tr><td>' + el.CharacterNumber + '</td>');
					}
					$bodyHtml.push('<td>' + el.CharacterName + '</td>');
					$bodyHtml.push(_$td.tbody);
					$bodyHtml.push('</tr>');
				}
				group0Stm.push($bodyHtml.join(''));
				group0Stm.push('			</tbody>');
				group0Stm.push('		</table>');
				group0Stm.push('	</fieldset>');
			}
		}
		bodySmt.push('<form>');
		bodySmt.push(group0Stm.join(''));
		bodySmt.push(groupNot0Stm.join(''));
		bodySmt.push('	</form>');
		$('#'+body_id).append(bodySmt.join(''));
		
	}
	
	/*begin  diling add for 查询预约定单号所对应的属性，并进行回填@2012/11/5 */
	function getProdProperty(v){
		var CharacterNumberVal = $(v).parent().parent().find('td:first').text();//属性代码
		var pid = $(v).parents("div[id^=productspecqry_sub_]").attr('id');//父节点
	  var CharacterValue= $('#' + pid).find('#' + CharacterNumberVal).val();//属性值
	  if(CharacterValue==""||CharacterValue==null){
	     rdShowMessageDialog("请填写预约定单号的属性值再进行查询！");
       return false;	
	  }
	  window.open (
			'module/caGetProdProperty.jsp?CharacterNumberVal='+CharacterNumberVal+"&CharacterValue="+CharacterValue+"&parentId=" + pid , 
			"newwindow",
			'dialogHeight:450px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
		);
	}
	
	function doGetProdProperty(pid,data,v_chkCharacterNumberFlag,CharacterNumberVal){
	  var _json = eval("(" + data.trim() + ")");		
		var _html = new Array();
		for(var i=0,len=_json.ProductOrderCharacters.length;i<len;i++) {
			var _cust = _json.ProductOrderCharacters[i];
			$('#' + pid).find('#' +_cust.CharacterNumber).val(_cust.DefaultValue);
			//$("#"+_cust.CharacterNumber).val(_cust.DefaultValue); 
		}
		
		document.getElementById("ProductOfferingID").value = _json.Product_offer_Id ;
		//document.getElementById("ProductID").value = _json.Product_Id;
		$('#' + pid).find('#chkCharacterNumberFlag').val(v_chkCharacterNumberFlag);//属性值验证通过标识
		//$("#chkCharacterNumberFlag").val(v_chkCharacterNumberFlag); //属性值验证通过标识
	}
	
  /*end  diling add @2012/11/5 */
	
	//添加记录行
	function addAttrRecord(parentId,g) {
		//$trGroupHtml[g].maxNum = time;
		$('#' + parentId + ' #' + g + 'Tbody').append('<tr><td>' + (time++) + '</td>' + $trGroupHtml[g].trHtml + '</tr>');
	}
	//删除当前记录行
	function delAttrRecord(k) {
		$(k).parents("tr").remove();
	}

	
	var jsonObj = {
		json : _json, //json对象
		tableId : _id, //待添加的bodyid
		showAddBtn : false,//是否显示“添加”操作按钮
		showDelBtn : false,//是否显示“删除”操作按钮
		showTitleOnly : false//是否只显示thead
	}
	$(function() {
		setCharListHtml(jsonObj);
		bindmultiSelectEvent();
	});
	

	function registerCheckboxEvent(id,parentId,arr,chosedArr,sign) {
		var cb = {};
		cb.id = id;
		cb.parentId = parentId;
		cb.arr= arr;
		cb.chosedArr = chosedArr;
		cb.sign=sign;//分隔符 liujian 2012-8-20 14:53:38
		checkboxArray.push(cb);
	}
	
	function bindmultiSelectEvent() {
		for(var i=0,len=checkboxArray.length;i<len;i++) {
			var _cb= checkboxArray[i];
			var id= _cb.id;
			var parentId = _cb.parentId;
			var arr = _cb.arr;
			var chosedArr = _cb.chosedArr;
			var sign = _cb.sign;
			$("#" + id).multiSelect({
				width : 150,
				height : 100,
				parentId : parentId,
				arr : arr,
				chosedArr:chosedArr,
			//	hiddenFieldID : "hiddenGarden",
				sign:sign,
				callBack:function(array) {
					var t = new Array();
					for(var j=0,len2=array.length;j<len2;j++) {
						t.push( array[j].value + '---');
					}
				}
			});	
		}	
	}
	function getProductOrderCharactersObj(areaId) {
		/*
		 "ProductOrderCharacters"://产品属性值
			[//产品属性组 对应 序列；序列是全局变量，所有的都是递增
				{
					"ProductSpecCharacterNumber":"",//产品属性代码
					"CharacterValue":"",//属性值
					"Name":"",//属性名
					"Action":"",
					"CharacterGroup":"",//产品属性组
					"Flag":""
				}
			]
		*/
		
		var characters = new Array();
		var $tbody = $("tbody[id^='GroupChar']");
		if(!isBlack(areaId)) {
			$tbody = $("#" + areaId + " tbody[id^='GroupChar']");
		}
		$tbody.each(function(){
			var $this = $(this); 
			if($this.attr('id') == 'GroupChar_0Tbody') {
				//1. group为0的情况
				//一定要用chlidren()
				$this.children().each(function(i){
					var $tr = $(this);
					var value = '';
					var $td = $tr.find('td:eq(2)');
					/* start 2013/12/18 15:17:24 gaopeng 关于下发优化呼叫中心业务支撑实施方案的通知 将接入方式返回出来,然后放在隐藏域中*/
					if($tr.find('td:eq(0)').text() == "1113035000"){
							var inType =  $td.find('select').val();
							$("#inType").val(inType);
					}
					/* end 2013/12/18 15:17:24 gaopeng 关于下发优化呼叫中心业务支撑实施方案的通知 将接入方式返回出来,然后放在隐藏域中*/
					//获取值的方法应该抽出去，写成单独的方法
					if($td.find('input[type="file"]').val()) {
						value = $td.find('input[type="file"]').val();
						//设定最后上传的文件名
						
						var codeflag = $tr.find('td:eq(0)').text();
						if(codeflag=="999033734" || codeflag=="999033735" || codeflag=="999033717" || codeflag=="9116014560" || codeflag=="9116014556" || codeflag=="1113035011") {
						
						var d=new Date();
			
					var	ssY=d.getFullYear();
					var	ssM=fillZero(d.getMonth()+1);
					var	ssD=fillZero(d.getDate());
					var	ssH=fillZero(d.getHours());
					var	ssI=fillZero(d.getMinutes());
					var	ssS=fillZero(d.getSeconds());
						
						var sconuts="";
						if(i<10) {
						sconuts="00";
						}
						if(i>=10 && i<99) {
						sconuts="0";
						}
						if(i>=99 ) {
						sconuts="";
						}			
						value = "A451"+ssY+""+ssM+""+ssD+""+ssH+""+ssI+""+ssS+"."+sconuts+""+(i+1);
						//alert(value+"-----qian11111111-------");
						}else {
						value = createFileName(value);
						//alert(value+"-----hou1111-------"+i+1);
						}

						var _area = 'A';
						if(split(areaId,'_').length > 2) {
							_area = 'A' + split(areaId,'_')[2];	
						}
						var _code = $tr.find('td:eq(0)').text();
						var _seq = '0'
						var _count = split(areaId,'_')[3];
						var _name = _area + '_' + _count + '_' + _code + '_' + _seq;
						fileMapping[_name] = value;
						//设置当前input的name为_area + '_' + _count + '_' + _code + '_' + _seq
						$td.find('input[type="file"]').removeAttr('name').attr('name',_name);
					}else if($td.find('p').text()) {
						//回填的文件名，如果file有值，则取其文件名，否则取回填的文件名
						value = $td.find('p').text();
					}else if($td.find('input[type="text"]').val()) {
						value = $td.find('input[type="text"]').val();
					}else if($td.find('select').val()) {
						value = $td.find('select').val();
					}
					characters.push( new Character($tr.find('td:eq(0)').text(),value,$tr.find('td:eq(1)').text(),''));
				});
			}else {
				//2. group非0的情况
				var $head = $this.parent().find('thead');
				var tdLen = $head.find('th').length;
				var headAttrs = new Array();
				var specChars = new Array();
				$head.find('th').each(function(j) {
					if(j != 0 && j != (tdLen-1)) {
						headAttrs.push($(this).text());
						specChars.push($(this).find('input').val());
					}
				});
				$this.children().each(function(j) {
					var $tr = $(this);
					var seq = '';
					$tr.find("td").each(function(k) {
						var $td = $(this);
						if(k == 0) {
							//序列号
							seq = $td.text();
						}else if(k == tdLen -1 ) {
							//操作
						}else {
							var value = '';
					/* start 2013/12/18 15:17:24 gaopeng 关于下发优化呼叫中心业务支撑实施方案的通知 将接入方式返回出来,然后放在隐藏域中*/
					
					if(specChars[k-1] == "1113035000"){
							var inType =  $td.find('select').val();
							$("#inType").val(inType);
					}
					/* end 2013/12/18 15:17:24 gaopeng 关于下发优化呼叫中心业务支撑实施方案的通知 将接入方式返回出来,然后放在隐藏域中*/
							
							if($td.find('input[type="file"]').val()) {
								value = $td.find('input[type="file"]').val();
								//设定最后上传的文件名
								
						var codeflag = specChars[k-1];
						if(codeflag=="999033734" || codeflag=="999033735" || codeflag=="999033717" || codeflag=="9116014560" || codeflag=="9116014556" ) {
						var d=new Date();
			
					var	ssY=d.getFullYear();
					var	ssM=fillZero(d.getMonth()+1);
					var	ssD=fillZero(d.getDate());
					var	ssH=fillZero(d.getHours());
					var	ssI=fillZero(d.getMinutes());
					var	ssS=fillZero(d.getSeconds());
						
						var sconuts="";
						if(k<10) {
						sconuts="00";
						}
						if(k>=10 && k<99) {
						sconuts="0";
						}
						if(k>=99 ) {
						sconuts="";
						}			
						
						value = "A451"+ssY+""+ssM+""+ssD+""+ssH+""+ssI+""+ssS+"."+sconuts+""+(k+1);
						//alert(value+"------2222------");
						}else {
						value = createFileName(value);
						}
						
								var _area = 'A';
								if(split(areaId,'_').length > 2) {
									_area = 'A' + split(areaId,'_')[2];	
								}
								
								var _code = specChars[k-1];
								var _seq = seq
								var _count = split(areaId,'_')[3];
								var _name = _area + '_' + _count + '_' + _code + '_' + _seq;
								fileMapping[_name] = value;
								$td.find('input[type="file"]').removeAttr('name').attr('name',_name);
							}else if($td.find('p').text()) {
								//回填的文件名，如果file有值，则取其文件名，否则取回填的文件名
								value = $td.find('p').text();
							}else if($td.find('input[type="text"]').val()) {
								value = $td.find('input[type="text"]').val();
							}else if($td.find('select').val()) {
								value = $td.find('select').val();
							}
							characters.push(new Character(specChars[k-1],value,headAttrs[k-1],seq));
						}
					});
				});
			}
		});
		ProductOrder.ProductOrderCharacters = characters;
	}
	
	function fillZero(v){
			if(v<10){v='0'+v;}
			return v;
		}
	
/***  begin  公众服务云业务优化@2014/8/11 ***/	
/*资源产品优惠类型 对下方内容的限制*/
function chekResourceInfo(_this,vsum){
	var v_resBeginTime = "resBeginTime_"+vsum;//测试计划开始日期
	var v_resEndTime = "resEndTime_"+vsum;//测试计划结束日期
	var v_resFeeRebate = "resFeeRebate_"+vsum; //费用折扣
	var v_orangeFlag = "orangeFlag_"+vsum;
	var v_feeText = "feeText_"+vsum;
	hiddenTip($("INPUT[v_id='"+v_resBeginTime+"']"));
	hiddenTip($("INPUT[v_id='"+v_resEndTime+"']"));
	hiddenTip($("INPUT[v_id='"+v_resFeeRebate+"']"));
	hiddenTip($("font[v_id='"+v_feeText+"']"));
	if($(_this).val()=="1"){
		$("INPUT[v_id='"+v_resBeginTime+"']").val("<%=currentTimeString%>");
		$("INPUT[v_id='"+v_resBeginTime+"']").attr("v_must","1");
		$("INPUT[v_id='"+v_resBeginTime+"']").attr("readonly",true);
		$("INPUT[v_id='"+v_resBeginTime+"']").attr("class","InputGrey");
		$("INPUT[v_id='"+v_resEndTime+"']").val("<%=lastTime%>");
		$("INPUT[v_id='"+v_resEndTime+"']").attr("v_must","1");
		$("INPUT[v_id='"+v_resEndTime+"']").removeClass("InputGrey").removeAttr('readonly'); 
		$("INPUT[v_id='"+v_resFeeRebate+"']").val("0");
		$("INPUT[v_id='"+v_resFeeRebate+"']").attr("readonly",true);
		$("INPUT[v_id='"+v_resFeeRebate+"']").attr("class","InputGrey");
		$("INPUT[v_id='"+v_resFeeRebate+"']").removeAttr("v_must");
		if($("font[v_id='"+v_orangeFlag+"']").text() != "*"){
			$("font[v_id='"+v_orangeFlag+"']").text("*");
		}
		$("font[v_id='"+v_feeText+"']").text("");
		//新增属性 加入其他元素的值
		$("INPUT[v_id='"+v_resEndTime+"']").attr("v_resTypeFlag","1");
		$("INPUT[v_id='"+v_resFeeRebate+"']").attr("v_resTypeFlag","1");
	}else if($(_this).val()=="2"){
		$("INPUT[v_id='"+v_resBeginTime+"']").val("");
		$("INPUT[v_id='"+v_resBeginTime+"']").removeAttr("v_must");
		$("INPUT[v_id='"+v_resBeginTime+"']").attr("readonly",true);
		$("INPUT[v_id='"+v_resBeginTime+"']").attr("class","InputGrey");
		$("INPUT[v_id='"+v_resEndTime+"']").val("");
		$("INPUT[v_id='"+v_resEndTime+"']").removeAttr("v_must");
		$("INPUT[v_id='"+v_resEndTime+"']").attr("readonly",true);
		$("INPUT[v_id='"+v_resEndTime+"']").attr("class","InputGrey");
		$("INPUT[v_id='"+v_resFeeRebate+"']").val("100");
		$("INPUT[v_id='"+v_resFeeRebate+"']").attr("v_must","1");
		$("INPUT[v_id='"+v_resFeeRebate+"']").removeClass("InputGrey").removeAttr('readonly'); 
		$("font[v_id='"+v_orangeFlag+"']").text("");
		//wuxy alter 20150625 移动云省内最低折扣从60改为50
		$("font[v_id='"+v_feeText+"']").text("（折扣范围为50-100之间）");
		//新增属性 加入其他元素的值
		$("INPUT[v_id='"+v_resEndTime+"']").attr("v_resTypeFlag","2");
		$("INPUT[v_id='"+v_resFeeRebate+"']").attr("v_resTypeFlag","2");
	}else{
		$("INPUT[v_id='"+v_resBeginTime+"']").val("");
		$("INPUT[v_id='"+v_resBeginTime+"']").removeAttr("v_must");
		$("INPUT[v_id='"+v_resBeginTime+"']").removeClass("InputGrey").removeAttr('readonly'); 
		$("INPUT[v_id='"+v_resEndTime+"']").val("");
		$("INPUT[v_id='"+v_resEndTime+"']").removeAttr("v_must");
		$("INPUT[v_id='"+v_resEndTime+"']").removeClass("InputGrey").removeAttr('readonly'); 
		$("INPUT[v_id='"+v_resFeeRebate+"']").val("");
		$("INPUT[v_id='"+v_resFeeRebate+"']").removeClass("InputGrey").removeAttr('readonly'); 
		$("INPUT[v_id='"+v_resFeeRebate+"']").removeAttr("v_must");
		$("font[v_id='"+v_orangeFlag+"']").text("");
		$("font[v_id='"+v_feeText+"']").text("");
		//新增属性 加入其他元素的值
		$("INPUT[v_id='"+v_resEndTime+"']").removeAttr("v_resTypeFlag");
		$("INPUT[v_id='"+v_resFeeRebate+"']").removeAttr("v_resTypeFlag");
	}
}

//校验测试计划结束日期
function chekResEndTime(_this,vsum,num){
	var v_resType = "resType_"+vsum;	
	var resTypeVal = $("select[v_id='"+v_resType+"']").val();
	if(num == 2){
		resTypeVal = $(_this).attr("v_resTypeFlag");
	}
	var val = $(_this).val();
	hiddenTip(_this);
	if(!checkElement(_this)) return false;
	if(resTypeVal == "1"){ //当为免费测试
		if( val != "<%=lastTime%>" && val != "<%=lastTimeNextMonth%>") {
			showTip(_this,"可取值范围不正确");
			return false;
		}
	}
	return true;
}

//校验费用折扣,wuxy alter 20150625 移动云省内最低折扣从60改为50
function checkFeeRebate(_this,vsum,num){
	var v_resType = "resType_"+vsum;	
	var resTypeVal = $("select[v_id='"+v_resType+"']").val();
	hiddenTip(_this);
	if(num == 2){
		resTypeVal = $(_this).attr("v_resTypeFlag");
	}
	if(resTypeVal == "2"){ //当为折扣优惠 
		if(!checkElement(_this)) return false;
		var val = $(_this).val();
		if( val < 50 || val > 100) {
			showTip(_this,"数字范围不正确");
			return false;
		}
	}
	return true;
}
/***  end  公众服务云业务优化@2014/8/11 ***/
		
</script>

<form>
  <input type="hidden" id="chkCharacterNumberFlag" name="chkCharacterNumberFlag" value="N" />
	<div id="ProductOrderCharacters_table">
		
	</div>
</form>
