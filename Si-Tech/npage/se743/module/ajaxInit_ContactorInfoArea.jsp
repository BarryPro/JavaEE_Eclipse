<%
  /*
   * ����: e743 ȫ������ҵ�񶩵�����
   * �汾: 1.0
   * ����: 2012-03-31
   * ����: wanghfa
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
	//var ContactorInfoJson = eval("(" + $("#json1").val() + ")");
	//var ContactorInfoJson = '{"ContainerPath": "ContactorInfo","ElementType": 3,"ElementTypeName": "��Ʒ��������ϵ����Ϣ","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "POAuditType","ElementId": 1,"ElementName": "��ϵ������","FormType": "select","SelShow": "�����ύ��~","SelValue": "audit~","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "����","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "��ϵ������","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "13904516789","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "��ϵ�˵绰","FormType": "text","SelShow": "","SelValue": "","ElementGroup":0},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "POAuditType","ElementId": 1,"ElementName": "��ϵ������","FormType": "select","SelShow": "����������~","SelValue": "read~","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "����","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "��ϵ������","FormType": "text","SelShow": "","SelValue": "","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "13904511111","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "��ϵ�˵绰","FormType": "text","SelShow": "","SelValue": "","ElementGroup":1},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "","ElementAlter": "","ElementCode": "POAuditType","ElementId": 1,"ElementName": "��ϵ������","FormType": "select","SelShow": "����������~","SelValue": "send~","ElementGroup":2},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "0","EValue": "����","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "��ϵ������","FormType": "text","SelShow": "","SelValue": "","ElementGroup":2},{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 2,"EType": "","EUpdate": "0","EValue": "13904512222","ElementAlter": "","ElementCode": "ContName","ElementId": 1,"ElementName": "��ϵ�˵绰","FormType": "text","SelShow": "","SelValue": "","ElementGroup":2}]}';
	//var _json = eval("(" + ContactorInfoJson + ")");
	
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	
	var $opt = {
		json : _json, //json����
		tableId : '<%=areaId%>_table', //����ӵ�bodyid
		showAddBtn : true,//�Ƿ���ʾ����ӡ�������ť
		showDelBtn : true,//�Ƿ���ʾ��ɾ����������ť
		showTitleOnly : false//�Ƿ�ֻ��ʾthead
	}
	setListHtml($opt);
	function getContactorInfoObj() {
		rstJson.input.ContactorInfo = [];
		$('#tbody_<%=areaId%>').find('tr').each(function() {
			var obj = {};
		    var $tr = $(this);
		    obj.ContactorType = getTdValByObj($tr.find('td:eq(0)'));
		    obj.ContactorName = getTdValByObj($tr.find('td:eq(1)'));
		    obj.ContactorPhone = getTdValByObj($tr.find('td:eq(2)'));
		    //liujian 2013-3-26 15:52:08 wangleic���һ��
		    if($tr.find('td:eq(3)').find(":text").length > 0) {
				obj.StaffNumber = getTdValByObj($tr.find('td:eq(3)'));
			}
			rstJson.input.ContactorInfo.push(obj);
		});
	}
</script>
<form>
	<table id="<%=areaId%>_table">
	</table>
</form>