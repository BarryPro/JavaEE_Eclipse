<%
  /*
   * ����: ��Ʒ������Ӧ�ĸ�����Ϣ
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
	var POAuditJson = '{"ContainerPath": "POAttachment","ElementType": 3,"ElementTypeName": "��Ʒ������Ӧ�ĸ�����Ϣ","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "��������1","ElementAlter": "","ElementCode": "POAttType","ElementId": 1,"ElementName": "��������","FormType": "select","SelShow": "��ͬ����~","SelValue": "��������������������~","ElementGroup":0},{"EFormat": "1","EMaxVal": "2","EMinVal": "2","EMust": "1","EOrder": 1,"EType": "3","EUpdate": "1","EValue": "��ͬ����1","ElementAlter": "","ElementCode": "POAttCode","ElementId": 1,"ElementName": "��ͬ����","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "��ͬ����1","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "��ͬ����","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 3,"EType": "","EUpdate": "0","EValue": "��Ʒ����ظ�������1","ElementAlter": "","ElementCode": "POAttName","ElementId": 1,"ElementName": "��Ʒ����ظ�������","FormType": "file","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "1","EMaxVal": "2","EMinVal": "2","EMust": "1","EOrder": 1,"EType": "3","EUpdate": "1","EValue": "��ͬ����2","ElementAlter": "","ElementCode": "POAttCode","ElementId": 1,"ElementName": "��ͬ����","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "��������2","ElementAlter": "","ElementCode": "POAttType","ElementId": 1,"ElementName": "��������","FormType": "select","SelShow": "��ͨ����~","SelValue": "2~","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "��ͬ����2","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "��ͬ����","FormType": "text","SelShow": "","SelValue": "","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 3,"EType": "","EUpdate": "0","EValue": "��Ʒ����ظ�������2","ElementAlter": "","ElementCode": "POAttName","ElementId": 1,"ElementName": "��Ʒ����ظ�������","FormType": "file","SelShow": "","SelValue": "","ElementGroup":1}]}';
	var _json = eval("(" + POAuditJson + ")");
	*/
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	var $opt = {
		json : _json, //json����
		tableId : '<%=areaId%>_table', //����ӵ�bodyid
		showAddBtn : false,//�Ƿ���ʾ����ӡ�������ť
		showDelBtn : false,//�Ƿ���ʾ��ɾ����������ť
		showTitleOnly : false//�Ƿ�ֻ��ʾthead
	}
	setListHtml($opt);
	
	//2012-6-1 16:49:07 ����ӻ�ȡjson���ķ���
	/*
	{
		"POAttType":"",//��������
		"POAttCode":"",//��ͬ����
		"ContName":"",//��ͬ����
		"POAttName":""//��Ʒ����ظ�������
	}
	*/
	/*
	function POAtt(POAttType,POAttCode,ContName,POAttName) {
		this.POAttType = POAttType;
		this.POAttCode = POAttCode;
		this.ContName = ContName;
		this.POAttName = POAttName;
	}
	*/
	function getPOAttachmentObj() {
		rstJson.input.POAttachment = [];
		var _POAttachment = rstJson.input.POAttachment;
		var $tbody = $('#tbody_<%=areaId%>');
		$tbody.find("tr").each(function(k){
			var POAtt = {};
		    $(this).find("td").each(function(i){
		    	if(i==0) {
		    		POAtt.POAttType = $(this).find('select').val();
		    	}if(i==1) {
		    		POAtt.POAttCode = $(this).find('input').val();
		    	}if(i==3) {
		    		if($(this).find('input[type="file"]').val()) {
		    			var $file = $(this).find('input[type="file"]');
			    		$file.removeAttr('name').attr('name',"poAttFile_" + k);
		    			var value = createFileName($file.val());
		    			fileMapping["poAttFile_" + k] = value;
			    		POAtt.ContName = value;
			    		//ȷ�Ϻ󣬺�ContNameһ��
			    		POAtt.POAttName = value;
		    		}else {
		    			POAtt.ContName = $(this).find('input').val();
			    		//ȷ�Ϻ󣬺�ContNameһ��
			    		POAtt.POAttName = $(this).find('input').val();
		    		}
		    	}
		    	if(i==4) {
		    		POAtt.ContEffdate = $(this).find('input').val();
		    	}
		    	if(i==5) {
		    		POAtt.ContExpdate = $(this).find('input').val();
		    	}
		    	
		    	if(i==6) {
		    		POAtt.IsAutoRecont = $(this).find('select').val();
		    	}
		    	
		    	if(i==7) {
		    		POAtt.RecontExpdate = $(this).find('input').val();
		    	}
		    	
		    	if(i==8) {
		    		POAtt.ContFee = $(this).find('input').val();
		    	}
		    	
		    	if(i==9) {
		    		POAtt.PerferPlan = $(this).find('input').val();
		    	}
		    	
		    	if(i==10) {
		    		POAtt.AutoRecontCyc = $(this).find('input').val();
		    	}
		    	
		    	if(i==11) {
		    		POAtt.IsRecont = $(this).find('select').val();
		    	}
		    	
			});
			_POAttachment.push(POAtt);
		});
	}
	
	/*
	function timeoutCreateFileName(k,value) {
		
		return 
	}
	
	function uploadFiles() {
		var flag = false;
		$("input[@name=poAttFile]").each(function() {
			if($(this).val() == '') {
				flag = true;
			}
		});
		if(!flag) {
			document.poattFrm.target="hidden_frame";
		    document.poattFrm.encoding="multipart/form-data";
		 	document.poattFrm.action="fe743_upload.jsp";
		  	document.poattFrm.method="post";
		  	document.poattFrm.submit();		
		}else {
			rdShowMessageDialog("���ϴ����и����ļ���");
		}
	}
	
	//���ú�ͬ����
	function setContName() {
		var $tbody = $('#tbody_<%=areaId%>');
		$tbody.find("tr").each(function(i){
		    $(this).find("td:eq(2)").find('input').val();
		});
	}
	function timeoutOpr(msg,ns) {
		setContName(ns);
		setTimeout("showRstDialog('" +msg+ "')",500);
	}

	function showRstDialog(msg) {
		rdShowMessageDialog(msg);	
	}
	*/
</script>
<form name="poattFrm">
	<table id="POAttachment_table">
		
	</table>
	<!--
	<table >
		<tr>
			<td>
				<input type="button" value="�ϴ�" class="b_text" name="uploadFile" onclick="uploadFiles();"/>
			</td>
		</tr>
	</table>
	-->
</form>