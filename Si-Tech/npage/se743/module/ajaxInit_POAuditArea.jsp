<%
  /*
   * ����: ҵ��������Ϣ�б�
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
	var POAuditJson = '{"ContainerPath": "POAudit","ElementType": 3,"ElementTypeName": "ҵ��������Ϣ�б�","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "����������","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "POAuditTime","ElementId": 1,"ElementName": "����ʱ��(��ʽ��YYYYMMDDhhmiss)","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "question","ElementId": 1,"ElementName": "�������","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0}]}';
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
	
	function getPOAuditObj() {
		rstJson.input.POAudit = [];
		var _POAudit = rstJson.input.POAudit;
		var $tbody = $('#tbody_<%=areaId%>');
		$tbody.find("tr").each(function(){
			var obj = {};
		    $(this).find("td").each(function(i){
		    	var value = getTdValByObj($(this));
		    	if(i==0) {
		    		obj.Auditor = value;
		    	}if(i==1) {
		    		obj.AuditTime = value;
		    	}if(i==2) {
		    		obj.AuditDesc = value;
		    	}if(i==3) {
		    		obj.AuditResult = value;
		    	}
			});
			_POAudit.push(obj);
		});
	}
</script>
<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>