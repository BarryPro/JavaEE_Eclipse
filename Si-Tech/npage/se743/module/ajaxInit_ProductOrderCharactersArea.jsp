<%
  /*
   * ����: ��Ʒ������
   * �汾: 1.0
   * ����: 2012-03-31
   * ����: liujian
   * ��Ȩ: si-tech
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
	/* ��ǰʱ�� */
	Date currentTime = new Date(); 
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
	String currentTimeString = formatter.format(currentTime);
	
	/* �������һ�� */
	Calendar cal = Calendar.getInstance();     
	cal.set(cal.DAY_OF_MONTH,cal.getActualMaximum(cal.DAY_OF_MONTH));     
	String lastTime =  new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
	System.out.println("diling===lastTime=" + lastTime);

	/* �¸������һ�� */
	Calendar calendar = Calendar.getInstance();  
	// ����Calendar�·���Ϊ��һ����  
	calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) + 1);  
	// ����Calendar����Ϊ��һ����һ��  
	calendar.set(Calendar.DATE, 1); 
	calendar.set(calendar.DAY_OF_MONTH,calendar.getActualMaximum(calendar.DAY_OF_MONTH));    
	String lastTimeNextMonth =  new SimpleDateFormat("yyyyMMdd").format(calendar.getTime());
	System.out.println("diling===lastTimeNextMonth=" + lastTimeNextMonth);
%>
<script language="javascript" type="text/javascript" src="/npage/se743/json2.js"></script>
<script type=text/javascript>
	//TODO ����Ҫ�޸�
	/*
	var testJson = '{"ElementTypes": [{"ContainerPath": "","ElementType": 100,"ElementTypeName": "��Ʒ���ʷ�","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 0,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "Description","ElementId": 1001,"ElementName": "�ʷ�����"}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 0,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "RatePlanID","ElementId": 1000,"ElementName": "�ʷѼƻ���ʶ"}]}],"ProductOrderCharacters": [{"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "","CharacterName": "��Ա��ϸ�ļ�","CharacterNumber": "999033717","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "","CharacterName": "ȷ�Ϸ�����ϸ����","CharacterNumber": "999033734","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "","CharacterName": "��ͨ������ϸ����","CharacterNumber": "999033735","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "","CharacterName": "��Ա��ϸ�ļ�","CharacterNumber": "999033717","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "","CharacterName": "ȷ�Ϸ�����ϸ����","CharacterNumber": "999033734","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"},{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "","CharacterName": "��ͨ������ϸ����","CharacterNumber": "999033735","CharacterOrder": 1,"CharacterType": "file","DefaultValue": "","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "string"}]}';
	var _json = eval("(" + testJson + ")");
	
		
	
	//���Զ�ѡ����ļ�
	var testJson='{"ElementTypes": [{"ContainerPath": "productorderinfo","ElementType": 60,"ElementTypeName": "��Ʒ����������Ϣ","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 0,"EType": "","EUpdate": "0","EValue": "2012071109341926829","ElementAlter": "","ElementCode": "ProductOrderNumber","ElementGroup": "0","ElementId": 2000,"ElementName": "��Ʒ������","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 1,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "ProductID","ElementGroup": "0","ElementId": 2001,"ElementName": "��Ʒ������ϵID","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 2,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "SICode","ElementGroup": "0","ElementId": 2002,"ElementName": "SI����","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 3,"EType": "","EUpdate": "0","EValue": "111303","ElementAlter": "","ElementCode": "ProductSpecNumber","ElementGroup": "0","ElementId": 2003,"ElementName": "��Ʒ�����","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 4,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "AccessNumber","ElementGroup": "0","ElementId": 2004,"ElementName": "��Ʒ�ؼ�����","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 5,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "PriAccessNumber","ElementGroup": "0","ElementId": 2005,"ElementName": "��Ʒ��������","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 6,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "Linkman","ElementGroup": "0","ElementId": 2006,"ElementName": "��ϵ��","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 7,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "ContactPhone","ElementGroup": "0","ElementId": 2007,"ElementName": "��ϵ�绰","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 8,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "Description","ElementGroup": "0","ElementId": 2008,"ElementName": "��Ʒ����","FormType": "","SelShow": "","SelValue": ""}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 9,"EType": "","EUpdate": "0","EValue": "1","ElementAlter": "","ElementCode": "OperationSubTypeID","ElementGroup": "0","ElementId": 2023,"ElementName": "��Ʒ����������","FormType": "select","SelShow": "1-������Ʒ����~2-ȡ����Ʒ����~3-��Ʒ��ͣ~4-��Ʒ�ָ�~5-�޸Ĳ�Ʒ�ʷ�~6-�����Ա��������~8-�޸Ľɷѹ�ϵ��������~9-�޸Ķ�����Ʒ����~10����ƷԤ����~11-Ԥȡ����Ʒ����~12-�䶳�ڻָ���Ʒ����~13-ҵ��չʡ������ɾ��~14-���ʡЭ��ҵ��Ԥ����~15-���ʡЭ��ҵ������~","SelValue": "1~2~3~4~5~6~7~8~9~10~11~12~13~14~15~"}]}, {"ContainerPath": "ProductOrderRatePlans","ElementType": 100,"ElementTypeName": "��Ʒ���ʷ�","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 54,"EType": "","EUpdate": "","EValue": "","ElementAlter": "","ElementCode": "RatePlanID","ElementGroup": "0","ElementId": 1000,"ElementName": "�ʷѼƻ���ʶ","FormType": "select","SelShow": "...��ѡ��...~6-->����~","SelValue": "~6~"}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "","EOrder": 55,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "OfferId","ElementGroup": "0","ElementId": 2022,"ElementName": "��Ʒ���ʷ�","FormType": "select","SelShow": "...��ѡ��...~","SelValue": "~"}]}],"ProductOrderCharacters": [{"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "���뷽ʽ","CharacterNumber": "1113035000","CharacterOrder": 1,"CharacterType": "select","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "ֱ��~ת��~","SelValue": "ֱ��~ת��~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0

","CharacterGroupName": "Ĭ����","CharacterName": "����ʡ","CharacterNumber": "1113035001","CharacterOrder": 2,"CharacterType": "select","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "100-����~200-�㶫~210-�Ϻ�~220-���~230-����~240-����~250-����~270-����~290-����~311-�ӱ�~351-ɽ��~371-����~431-����~451-������~471-���ɹ�~531-ɽ��~551-����~571-�㽭~591-����~731-����~771-����~791-����~851-����~871-����~891-����~898-����~931-����~951-����~971-�ຣ~991-�½�~280-�Ĵ�~","SelValue": "100~200~210~220~230~240~250~270~290~311~351~371~431~451~471~531~551~571~591~731~771~791~851~871~891~898~931~951~971~991~280~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "�ط�����","CharacterNumber": "1113035005","CharacterOrder": 3,"CharacterType": "text","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": "0_9"}, {"AlterInfo": "ȫ����ʡ�ݣ�����Ƕ��ʡ�ݵģ��ӿ��ϴ�ʱʡ��֮���á�;���ָ�硰����;�Ϻ�;���","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "ҵ�񸲸Ƿ�Χ","CharacterNumber": "1113035006","CharacterOrder": 4,"CharacterType": "text","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "","SelValue": "","ShowFlag": "1","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "ҵ���ϵȼ�","CharacterNumber": "1113035007","CharacterOrder": 5,"CharacterType": "checkbox[~]","DefaultValue": "A~AA","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "AAA~AA~A~��ͨ~","SelValue": "AAA~AA~A~��ͨ~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "�Ƿ����","CharacterNumber": "1113035008","CharacterOrder": 6,"CharacterType": "select","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "��~��~","SelValue": "��~��~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "����˵��","CharacterNumber": "1113035010","CharacterOrder": 7,"CharacterType": "text","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "ȫ�����������뵥","CharacterNumber": "1113035011","CharacterOrder": 8,"CharacterType": "file","DefaultValue": "a22222222aa.txt","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "1","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "�Ʒѹ������뵥","CharacterNumber": "1113035012","CharacterOrder": 9,"CharacterType": "file","DefaultValue": "aaaa.txt","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "1","RequireFlag": "1","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "���ڣ�YYYYMMDD","CharacterGroup": "0","CharacterGroupName": "Ĭ����","CharacterName": "�������������ʱ��","CharacterNumber": "1113037003","CharacterOrder": 13,"CharacterType": "text","DefaultValue": "","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "0","VFormat": "","VType": ""}]}';
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
	//����������Ӱ�ťʱ����ӵı�
	var $trGroupHtml = {};
	var time = 1;
	function groupInfo(trHtml,maxNum) {
		this.trHtml = trHtml;
		this.maxNum = maxNum;
	}
		//trGroupHtml���� Group_  ��ͷ
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
	//�����б������
	function setCharListHtml($opt) {
		var _json = $opt.json;
		var body_id = $opt.tableId;
		//ѭ��һ�����飬��ȡthead�ĸ���
		//˳�����json�����ݵĵ�һ��group���Ⱥ�˳��
		var bodySmt = new Array();//���е�htmlƬ��
		var group0Stm = new Array();//0���htmlƬ��
		var groupNot0Stm = new Array();//��0���htmlƬ��
		var marker = "GroupChar_";//��ı�ʶλ
		var rower = "RowChar_";//�еı�ʶλ
		var group = {};
		//group���� Group_  ��ͷ
		// { 
		//	Group_ElementGroup : [],
		//	Group_ElementGroup : [],
		//��ȡ����group����
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
				//�����б����
				var rowNo = el.CharacterRow;
				var gAttr = marker + groupNo;
				var rAttr = rower + rowNo;
				if(!group[gAttr][rAttr]){
					group[gAttr][rAttr] = [];
				}
				group[gAttr][rAttr].push(el);
			}else {
				//���Ա���(�ǻ���)�����б�
				group[marker + groupNo].push(el);
			}
		}
		
		//����״̬����һ�ζ�ȡgroup������thead
		var $tr = new Array();
		//����CharacterGroup��0�ͷ�0���������0�������ɾ����¼��0�������ɾ��
		
		for(var g in group) {
			var $headHtml = new Array();
			var $bodyHtml = new Array();
			if(g != 'GroupChar_0') {
				
				for(var t in group[g]) {
					
					//���Ա���(�ǻ���)�����б�
					if(t != "getElByValue" && t != "indexOfByValue" && t != "removeElByValue"){
					if(!isArray(eval(group[g][t]))) {
						var $bodyAddHtml = new Array();//��Ӱ�ť����ӵ��ַ���
						$headHtml.push('<th>���к�</th>');
						$bodyHtml.push('<td>' + (time++) + '</td>');
						for(var i=0,len=group[g].length;i<len;i++) {
							var el = group[g][i];
							//�������Զ���
							var _$td= setTdHtml2(el);
							$headHtml.push(_$td.thead);
							$bodyHtml.push(_$td.tbody);
							$bodyAddHtml.push(_$td.tbodyAdd);
						}
						$headHtml.push('<th>����</th>');
						$bodyHtml.push('<td><input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delAttrRecord(this)" /></td>');
						$bodyAddHtml.push('<td><input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delAttrRecord(this)" /></td>');
						if(isBlack($trGroupHtml['Group_' + el.CharacterGroup])) {
							$trGroupHtml[g] = new groupInfo($bodyAddHtml.join(''),1);
						}
						//����fieldset
						//TODO ��ȷ�����tableId�Ƿ�Ӱ������ȡֵ
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
						groupNot0Stm.push('    <input type="button" value="���" class="b_text" name="addRecordBtn" onclick="addAttrRecord(\'' + body_id + '\', \'' + g + '\');"/>');
						groupNot0Stm.push('				</td>');
						groupNot0Stm.push('			</tr>');
						groupNot0Stm.push('		</table>');
						groupNot0Stm.push('	</fieldset>');
						break;
					}else {
						var $bodyAddHtml = new Array();//��Ӱ�ť����ӵ��ַ���
						$headHtml.push('<th>���к�</th>');
						var _tmpGroupNo = '';
						var tempInt = 0;
						for(var s in group[g]) {
							if(s != "getElByValue" && s != "indexOfByValue" && s != "removeElByValue"){
							//һ��
							if(typeof(group[g][s]) != 'undefined' && typeof(group[g][s]) != 'function') {
								
								for(var i=0,len=group[g][s].length;i<len;i++) {
									var gEl = group[g][s][i];
									//�������Զ���
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
									$headHtml.push('<th>����</th></tr>');
									$bodyAddHtml.push('<td><input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delAttrRecord(this)" /></td>');
								}
								$bodyHtml.push('<td><input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delAttrRecord(this)" /></td>');
								$bodyHtml.push('</tr>');
							}
							tempInt++;
							time = parseInt(gEl.CharacterRow) + 1;
						}
						}
						if(isBlack($trGroupHtml['Group_' + _tmpGroupNo])) {
							$trGroupHtml[g] = new groupInfo($bodyAddHtml.join(''),1);
						}
						//����fieldset
						//TODO ��ȷ�����tableId�Ƿ�Ӱ������ȡֵ
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
						groupNot0Stm.push('    <input type="button" value="���" class="b_text" name="addRecordBtn" onclick="addAttrRecord(\'' + body_id + '\', \'' + g + '\');"/>');
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
				group0Stm.push('				<tr><th>���Դ���</th><th>������</th><th>����ֵ</th></tr>');
				group0Stm.push('			</thead>');
				group0Stm.push('			<tbody id="' + g + 'Tbody">');
				$bodyHtml = [];
				for(var i=0,len=group[g].length;i<len;i++) {
					var el = group[g][i];
					//�������Զ���
					//"ShowFlag": "",0����ʾ��""����1��ʾ��Ĭ����ʾ
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
	
	/*begin  diling add for ��ѯԤԼ����������Ӧ�����ԣ������л���@2012/11/5 */
	function getProdProperty(v){
		var CharacterNumberVal = $(v).parent().parent().find('td:first').text();//���Դ���
		var pid = $(v).parents("div[id^=productspecqry_sub_]").attr('id');//���ڵ�
	  var CharacterValue= $('#' + pid).find('#' + CharacterNumberVal).val();//����ֵ
	  if(CharacterValue==""||CharacterValue==null){
	     rdShowMessageDialog("����дԤԼ�����ŵ�����ֵ�ٽ��в�ѯ��");
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
		$('#' + pid).find('#chkCharacterNumberFlag').val(v_chkCharacterNumberFlag);//����ֵ��֤ͨ����ʶ
		//$("#chkCharacterNumberFlag").val(v_chkCharacterNumberFlag); //����ֵ��֤ͨ����ʶ
	}
	
  /*end  diling add @2012/11/5 */
	
	//��Ӽ�¼��
	function addAttrRecord(parentId,g) {
		//$trGroupHtml[g].maxNum = time;
		$('#' + parentId + ' #' + g + 'Tbody').append('<tr><td>' + (time++) + '</td>' + $trGroupHtml[g].trHtml + '</tr>');
	}
	//ɾ����ǰ��¼��
	function delAttrRecord(k) {
		$(k).parents("tr").remove();
	}

	
	var jsonObj = {
		json : _json, //json����
		tableId : _id, //����ӵ�bodyid
		showAddBtn : false,//�Ƿ���ʾ����ӡ�������ť
		showDelBtn : false,//�Ƿ���ʾ��ɾ����������ť
		showTitleOnly : false//�Ƿ�ֻ��ʾthead
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
		cb.sign=sign;//�ָ��� liujian 2012-8-20 14:53:38
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
		 "ProductOrderCharacters"://��Ʒ����ֵ
			[//��Ʒ������ ��Ӧ ���У�������ȫ�ֱ��������еĶ��ǵ���
				{
					"ProductSpecCharacterNumber":"",//��Ʒ���Դ���
					"CharacterValue":"",//����ֵ
					"Name":"",//������
					"Action":"",
					"CharacterGroup":"",//��Ʒ������
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
				//1. groupΪ0�����
				//һ��Ҫ��chlidren()
				$this.children().each(function(i){
					var $tr = $(this);
					var value = '';
					var $td = $tr.find('td:eq(2)');
					/* start 2013/12/18 15:17:24 gaopeng �����·��Ż���������ҵ��֧��ʵʩ������֪ͨ �����뷽ʽ���س���,Ȼ�������������*/
					if($tr.find('td:eq(0)').text() == "1113035000"){
							var inType =  $td.find('select').val();
							$("#inType").val(inType);
					}
					/* end 2013/12/18 15:17:24 gaopeng �����·��Ż���������ҵ��֧��ʵʩ������֪ͨ �����뷽ʽ���س���,Ȼ�������������*/
					//��ȡֵ�ķ���Ӧ�ó��ȥ��д�ɵ����ķ���
					if($td.find('input[type="file"]').val()) {
						value = $td.find('input[type="file"]').val();
						//�趨����ϴ����ļ���
						
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
						//���õ�ǰinput��nameΪ_area + '_' + _count + '_' + _code + '_' + _seq
						$td.find('input[type="file"]').removeAttr('name').attr('name',_name);
					}else if($td.find('p').text()) {
						//������ļ��������file��ֵ����ȡ���ļ���������ȡ������ļ���
						value = $td.find('p').text();
					}else if($td.find('input[type="text"]').val()) {
						value = $td.find('input[type="text"]').val();
					}else if($td.find('select').val()) {
						value = $td.find('select').val();
					}
					characters.push( new Character($tr.find('td:eq(0)').text(),value,$tr.find('td:eq(1)').text(),''));
				});
			}else {
				//2. group��0�����
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
							//���к�
							seq = $td.text();
						}else if(k == tdLen -1 ) {
							//����
						}else {
							var value = '';
					/* start 2013/12/18 15:17:24 gaopeng �����·��Ż���������ҵ��֧��ʵʩ������֪ͨ �����뷽ʽ���س���,Ȼ�������������*/
					
					if(specChars[k-1] == "1113035000"){
							var inType =  $td.find('select').val();
							$("#inType").val(inType);
					}
					/* end 2013/12/18 15:17:24 gaopeng �����·��Ż���������ҵ��֧��ʵʩ������֪ͨ �����뷽ʽ���س���,Ȼ�������������*/
							
							if($td.find('input[type="file"]').val()) {
								value = $td.find('input[type="file"]').val();
								//�趨����ϴ����ļ���
								
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
								//������ļ��������file��ֵ����ȡ���ļ���������ȡ������ļ���
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
	
/***  begin  ���ڷ�����ҵ���Ż�@2014/8/11 ***/	
/*��Դ��Ʒ�Ż����� ���·����ݵ�����*/
function chekResourceInfo(_this,vsum){
	var v_resBeginTime = "resBeginTime_"+vsum;//���Լƻ���ʼ����
	var v_resEndTime = "resEndTime_"+vsum;//���Լƻ���������
	var v_resFeeRebate = "resFeeRebate_"+vsum; //�����ۿ�
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
		//�������� ��������Ԫ�ص�ֵ
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
		//wuxy alter 20150625 �ƶ���ʡ������ۿ۴�60��Ϊ50
		$("font[v_id='"+v_feeText+"']").text("���ۿ۷�ΧΪ50-100֮�䣩");
		//�������� ��������Ԫ�ص�ֵ
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
		//�������� ��������Ԫ�ص�ֵ
		$("INPUT[v_id='"+v_resEndTime+"']").removeAttr("v_resTypeFlag");
		$("INPUT[v_id='"+v_resFeeRebate+"']").removeAttr("v_resTypeFlag");
	}
}

//У����Լƻ���������
function chekResEndTime(_this,vsum,num){
	var v_resType = "resType_"+vsum;	
	var resTypeVal = $("select[v_id='"+v_resType+"']").val();
	if(num == 2){
		resTypeVal = $(_this).attr("v_resTypeFlag");
	}
	var val = $(_this).val();
	hiddenTip(_this);
	if(!checkElement(_this)) return false;
	if(resTypeVal == "1"){ //��Ϊ��Ѳ���
		if( val != "<%=lastTime%>" && val != "<%=lastTimeNextMonth%>") {
			showTip(_this,"��ȡֵ��Χ����ȷ");
			return false;
		}
	}
	return true;
}

//У������ۿ�,wuxy alter 20150625 �ƶ���ʡ������ۿ۴�60��Ϊ50
function checkFeeRebate(_this,vsum,num){
	var v_resType = "resType_"+vsum;	
	var resTypeVal = $("select[v_id='"+v_resType+"']").val();
	hiddenTip(_this);
	if(num == 2){
		resTypeVal = $(_this).attr("v_resTypeFlag");
	}
	if(resTypeVal == "2"){ //��Ϊ�ۿ��Ż� 
		if(!checkElement(_this)) return false;
		var val = $(_this).val();
		if( val < 50 || val > 100) {
			showTip(_this,"���ַ�Χ����ȷ");
			return false;
		}
	}
	return true;
}
/***  end  ���ڷ�����ҵ���Ż�@2014/8/11 ***/
		
</script>

<form>
  <input type="hidden" id="chkCharacterNumberFlag" name="chkCharacterNumberFlag" value="N" />
	<div id="ProductOrderCharacters_table">
		
	</div>
</form>
