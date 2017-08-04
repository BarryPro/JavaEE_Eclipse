<%
  /*
   * 功能: 商品订购对应的附件信息
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
	var POAuditJson = '{"ContainerPath": "POAttachment","ElementType": 3,"ElementTypeName": "商品订购对应的附件信息","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "附件类型1","ElementAlter": "","ElementCode": "POAttType","ElementId": 1,"ElementName": "附件类型","FormType": "select","SelShow": "合同附件~","SelValue": "撒旦法是撒旦法撒旦法~","ElementGroup":0},{"EFormat": "1","EMaxVal": "2","EMinVal": "2","EMust": "1","EOrder": 1,"EType": "3","EUpdate": "1","EValue": "合同编码1","ElementAlter": "","ElementCode": "POAttCode","ElementId": 1,"ElementName": "合同编码","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "合同名称1","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "合同名称","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 3,"EType": "","EUpdate": "0","EValue": "商品级相关附件名称1","ElementAlter": "","ElementCode": "POAttName","ElementId": 1,"ElementName": "商品级相关附件名称","FormType": "file","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "1","EMaxVal": "2","EMinVal": "2","EMust": "1","EOrder": 1,"EType": "3","EUpdate": "1","EValue": "合同编码2","ElementAlter": "","ElementCode": "POAttCode","ElementId": 1,"ElementName": "合同编码","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "附件类型2","ElementAlter": "","ElementCode": "POAttType","ElementId": 1,"ElementName": "附件类型","FormType": "select","SelShow": "普通附件~","SelValue": "2~","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "合同名称2","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "合同名称","FormType": "text","SelShow": "","SelValue": "","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 3,"EType": "","EUpdate": "0","EValue": "商品级相关附件名称2","ElementAlter": "","ElementCode": "POAttName","ElementId": 1,"ElementName": "商品级相关附件名称","FormType": "file","SelShow": "","SelValue": "","ElementGroup":1}]}';
	var _json = eval("(" + POAuditJson + ")");
	*/
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	var $opt = {
		json : _json, //json对象
		tableId : '<%=areaId%>_table', //待添加的bodyid
		showAddBtn : false,//是否显示“添加”操作按钮
		showDelBtn : false,//是否显示“删除”操作按钮
		showTitleOnly : false//是否只显示thead
	}
	setListHtml($opt);
	
	//2012-6-1 16:49:07 新添加获取json串的方法
	/*
	{
		"POAttType":"",//附件类型
		"POAttCode":"",//合同编码
		"ContName":"",//合同名称
		"POAttName":""//商品级相关附件名称
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
			    		//确认后，和ContName一致
			    		POAtt.POAttName = value;
		    		}else {
		    			POAtt.ContName = $(this).find('input').val();
			    		//确认后，和ContName一致
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
			rdShowMessageDialog("请上传所有附件文件！");
		}
	}
	
	//设置合同名称
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
				<input type="button" value="上传" class="b_text" name="uploadFile" onclick="uploadFiles();"/>
			</td>
		</tr>
	</table>
	-->
</form>