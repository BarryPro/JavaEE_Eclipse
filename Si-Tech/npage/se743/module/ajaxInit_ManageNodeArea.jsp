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
	String parentId = request.getParameter("parentId");
	System.out.println("liujian===areaId=" + areaId);
%>
<script type=text/javascript>
//	var nodeJson = '{"ContainerPath": "ManageNode","ElementType": 90,"ElementTypeName": "ʡBOSS�ϴ�����ڵ�","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "��������ϵ�绰","ElementAlter": "","ElementCode": "CharacterName","ElementGroup": "1","ElementId": 2014,"ElementName": "������������","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 10,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "CharacterValue","ElementGroup": "1","ElementId": 2015,"ElementName": "��������ֵ","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 11,"EType": "","EUpdate": "1","EValue": "10003","ElementAlter": "","ElementCode": "CharacterID","ElementGroup": "1","ElementId": 2013,"ElementName": "�������Ա���","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "222222������Code","ElementAlter": "","ElementCode": "OperateCode","ElementGroup": "1","ElementId": 2014,"ElementName": "��������Code","FormType": "hidden","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "������Desc","ElementAlter": "","ElementCode": "CharacterDesc","ElementGroup": "1","ElementId": 2014,"ElementName": "��������Desc","FormType": "hidden","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "��������ϵ�绰2","ElementAlter": "","ElementCode": "CharacterName","ElementGroup": "2","ElementId": 2014,"ElementName": "������������","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 10,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "CharacterValue","ElementGroup": "2","ElementId": 2015,"ElementName": "��������ֵ","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 11,"EType": "","EUpdate": "1","EValue": "100032","ElementAlter": "","ElementCode": "CharacterID","ElementGroup": "2","ElementId": 2013,"ElementName": "�������Ա���","FormType": "","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "222222������Code2","ElementAlter": "","ElementCode": "OperateCode","ElementGroup": "2","ElementId": 2014,"ElementName": "��������Code","FormType": "hidden","SelShow": "","SelValue": ""},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "1","EValue": "������Desc2","ElementAlter": "","ElementCode": "CharacterDesc","ElementGroup": "2","ElementId": 2014,"ElementName": "��������Desc","FormType": "hidden","SelShow": "","SelValue": ""}]}';
	
//	var _json = getObjFromSrv(areaId);

	var areaId = '<%=areaId%>';
//	var _json = eval("(" + nodeJson + ")");
	var _id = '';
	var parentId = '<%=parentId%>';
	if(parentId != null && parentId != '' && parentId !='null') {
		_id = parentId + " #<%=areaId%>_table"	;
	}else {
		_id	= '<%=areaId%>_table';
	}
	var _json = getObjFromSrv(areaId);
	var jsonObj = {
		json : _json, //json����
		tableId : _id, //����ӵ�bodyid
		showAddBtn : false,//�Ƿ���ʾ����ӡ�������ť
		showDelBtn : false,//�Ƿ���ʾ��ɾ����������ť
		showTitleOnly : false//�Ƿ�ֻ��ʾthead
	}
	
	$(function() {
		setNodeListHtml(jsonObj);
	});
	/*
	//���ManageNode��ManageNodeGet
	function setNodeListHtml($opt) {
		var _json = $opt.json;
		var body_id = $opt.tableId;
		var containerPath = _json.ContainerPath;
		var addBtnFlag = isBlack($opt.showAddBtn) ? false : $opt.showAddBtn;
		var delBtnFlag = isBlack($opt.showDelBtn) ? false : $opt.showDelBtn;
		var titleOnlyFlag = isBlack($opt.showTitleOnly) ? false : $opt.showTitleOnly;
		var addHiddenFlag = isBlack($opt.addHiddenInput) ? false : $opt.addHiddenInput;
		var tbody_id = 'tbody_' + containerPath; //�趨tbodyid
		//ѭ��һ�����飬��ȡthead�ĸ���
		//˳�����json�����ݵĵ�һ��group���Ⱥ�˳��
		var $head = {};
		var tdLen = 0;//������
		var $body = new Array();
		var headSmt = new Array();
		var bodySmt = new Array();
		var marker = "Group_";//��ı�ʶλ
		var group = {};
		//group���� Group_  ��ͷ
		// { 
		//	Group_ElementGroup : [],
		//	Group_ElementGroup : [],
		// }
		//��ȡ����group����
		for(var i=0,len=_json.Elements.length;i<len;i++) {
			var el = _json.Elements[i];
			var groupNo = el.ElementGroup;
			if(isBlack(group[marker + groupNo]) || group[marker + groupNo].length == 0) {
				group[marker + groupNo] = new Array();
			}
			group[marker + groupNo].push(el);
		}
		//����״̬����һ�ζ�ȡgroup������thead
		var time = 0;
		var $tr = new Array();
		for(var g in group) {
			for(var i=0,len=group[g].length;i<len;i++) {
				var el = group[g][i];
				if(time == 0) {
					$head[el.ElementCode] = {};
					$head[el.ElementCode].name = el.ElementName;
					$head[el.ElementCode].hiddenFlag = el.FormType == 'hidden' ? true:false;
					tdLen++;
				}
				
				//�����ж���
				//var $td = {}; 
				//$td {
				//			el.ElementCode : el.EValue
				//			type           : el.FormType
				//			names          : el.SelShow 
				//          values         : el.SelValue
				//		}
				//�ж�������ж���
			
				$tr.push(el);
			}
			time++;
			//tbody��������ж���
			$body.push($tr);
		}
		
		//��ҳ�����htmlƬ��
		//1. thead segment
		headSmt.push('<thead><tr align="center">');
		for(var h in $head) {
			var _headObj = $head[h];
			if(_headObj.hiddenFlag) {
				headSmt.push('<th style="display:none">');
				headSmt.push($head[h].name);
			}else {
				headSmt.push('<th>');
				headSmt.push($head[h].name);
			}
			headSmt.push('<input type="hidden" value="' + h + '"></th>');
		}
		//��Ӳ�����
		if(delBtnFlag) {
			tdLen++;
			headSmt.push('<th>');
			headSmt.push('����');
			headSmt.push('</th>');
		}
		headSmt.push('</tr></thead>');
		//2. tbody segment
		bodySmt.push('<tbody id="' + tbody_id + '">');
		if(!titleOnlyFlag) {
			var trTime = 0;
			var bodyAddHtml = new Array();
			bodyAddHtml.push('<tr>')
			for(var i=0,len=$body.length;i<len;i++) {
				var _tr = $body[i];
				bodySmt.push('<tr>');
				var m = 0;
				for(var h in $head) {
					m++;
					for(var k=0,len2=_tr.length;k<len2;k++) {
						var _td = _tr[k];
						if(typeof(_td.ElementName) == "undefined" || _td.ElementName == null  || (_td.ElementName != $head[h].name )) {
							continue;
						}
						//addHiddenFlag ���һ�����ʷ�
						//hiddenFlag ��Թ�������
						var _$td = setTdHtml(_td,addHiddenFlag,m);
						bodySmt.push(_$td.tbody);
						bodyAddHtml.push(_$td.tbodyAdd);
						//ɾ�����󣬽�ʡ�´β�ѯ��ʱ��
						_tr.splice(k, 1);
						break;
					}
				}
				if(delBtnFlag) {
					bodySmt.push('<td>');
					bodySmt.push('<input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodySmt.push('</td>');
					bodyAddHtml.push('<td>');
					bodyAddHtml.push('<input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodyAddHtml.push('</td>');
				}
				//��¼tr����ӵ�htmlƬ��
				bodyAddHtml.push('</tr>');
				if(trTime == 0) {
					areaTrHtml[containerPath] =  bodyAddHtml.join('');
				}
				trTime++;
				bodySmt.push('</tr>');
			}
		}
		bodySmt.push('</tbody>');
		//��ӡ���ӡ���ť
		if(addBtnFlag) {
			bodySmt.push('<tbody><tr><td>');
			bodySmt.push('<input type="button" value="���" name="addRecordBtn" class="b_text" onclick="addRecord(\'' + containerPath + '\',\'' + body_id + '\')" />');
			bodySmt.push('</td></tr></tbody>');
		}
		$('#' + body_id).append(headSmt.join(''));
		$('#' + body_id).append(bodySmt.join(''));
	}
	
	function setTdHtml3($td,addHiddenFlag,m) {
		var $tdHtml = {};
		var $tdHead = new Array();
		var $tdBody = new Array();
		var el = $td;
		//1. �жϱ�����
		var attr = '';
		var type = el.FormType;
		//����tbody��td
		if(isBlack(type) || type == 'text') {
			var mustFlag = false;
			$tdBody.push('<td><input type="input" ');
			//�ж�һϵ�е�����
			//ElementGroup��ElementCode û�ӽ�ȥ
			attr = el.EValue;
			if(!isBlack(attr)) {
				$tdBody.push(' value="' + attr + '"');
			}else {
				$tdBody.push(' value=""');
			}
			attr = el.EMaxVal;
			if(!isBlack(attr)) {
				$tdBody.push(' v_maxvalue=' + attr );
			}
			attr = el.EMinVal;
			if(!isBlack(attr)) {
				$tdBody.push(' v_minvalue=' + attr );
			}
			attr = el.EUpdate;//0�ǲ��ɣ�1�ǿ����޸�
			if(!isBlack(attr) && attr == '0' ) {
				$tdBody.push(' readonly class="InputGrey"  ');
			}
			attr = el.EMust;
			if(!isBlack(attr) && attr == '1') {
				mustFlag = true;
				$tdBody.push(' v_must="1" onblur = "checkElement(this)" ');
			}
			attr = el.EFormat;
			if(!isBlack(attr)) {
				$tdBody.push(' v_format=' + attr );
			}
			attr = el.EType;
			if(!isBlack(attr)) {
				$tdBody.push(' v_type=' + attr );
			}
			$tdBody.push(' />');
			//����һЩ�����������ť��������� end
			if(mustFlag) {
				$tdBody.push('<font class="orange">*</font>');
			}
			attr = el.ElementAlter;
			if(!isBlack(attr)) {
				$tdBody.push('<font>' + attr + '</font>');
			}
			if(addHiddenFlag && m ==1) {
				$tdBody.push('<input type="hidden" value="' + el.ElementCode + '" />');	
			}
			$tdBody.push(' </td>');
		}else if(type == 'hidden') {
			$tdBody.push('<td style="display:none"><input type="hidden" value="' + el.EValue + '" /></td>');
		}
		else if(type == 'select') {
			//select
			$tdBody.push('<td>');
			var nameStr = el.SelShow;
			var valueStr = el.SelValue;
			if(!isBlack(nameStr) && !isBlack(valueStr)) {
				var names = split(nameStr,'~');
				var values = split(valueStr,'~');
				var arrLen = names.length > values.length ? values.length : names.length;
				//�趨select�Ƿ����ѡ��
				var updateStr = '';
				if(!isBlack(el.EUpdate) && el.EUpdate == '0') {
					updateStr =' disabled= "disabled" ';
				}				
				$tdBody.push('<select name="' + el.ElementCode + '"' + updateStr + ' v_must="1">');
				if(arrLen == 0) {
					$tdBody.push('<option value="">��ѡ��</option>');
				}else {
					for(var j=0;j<arrLen;j++) {
						if(el.EValue == values[j]) {
							//�趨ѡ����
							$tdBody.push('<option value="' + values[j] + '" selected= "selected">' + names[j] + '</option>');
						}else {
							$tdBody.push('<option value="' + values[j] + '">' + names[j] + '</option>');
						}
					}
				}
				$tdBody.push('</select>');
			}
			attr = el.EMust;
			if(!isBlack(attr) && attr == '1') {
				$tdBody.push('<font class="orange">*</font>');
			}
			attr = el.ElementAlter;
			if(!isBlack(attr)) {
				$tdBody.push('<font style="font-size:12px">' + attr + '</font>');
			}
			$tdBody.push('</td>');
		}
		else if(type == 'file') {
			//TODO ��֪���Ǹ���Щ�����Ƿ�֧��file
			$tdBody.push('<td>');
			$tdBody.push('<input type="file" class="button" name="poAttFile"/>');
			$tdBody.push('</td>');
		}
		//��ȡthead��td
		if(!isBlack(el.CharacterName)) {
			$tdHead.push('<td>' + el.CharacterName + '</td>');
		}else {
			$tdHead.push('<td></td>');
		}
		$tdHtml.thead = $tdHead.join('');
		var _tbody = $tdBody.join('');
		$tdHtml.tbody = _tbody;
		$tdHtml.tbodyAdd = _tbody.replace('value="' + el.EValue + '"','value=""');
		return $tdHtml;
	}
	*/

	function getManageNodeObj(parentId) {
		var $thead = $('#<%=areaId%>_table thead');
		var $tbody = $('#tbody_<%=areaId%>');
		if(!isBlack(parentId)) {
			$thead = $('#' + parentId + ' #<%=areaId%>_table thead');	
			$tbody = $('#' + parentId + ' #tbody_<%=areaId%>');
		}
		
		var headAttrs = new Array();
		$thead.find('th').each(function() {
			var _this = $(this);
			headAttrs.push(_this.find('input').val());
		});
		
		var nodeArr = new Array();
		$tbody.find("tr").each(function(){
			var $this = $(this);
			var manageNode = {};
			var i = 0;
			$this.find('td').each(function() {
				manageNode[headAttrs[i]] = getTdValByObj($(this));
				i++;
			});
			nodeArr.push(manageNode);
		});
		ProductOrder.ManageNode = nodeArr;
	}
	
	
</script>
<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>