<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: 098Ȩ�޽�ɫ����->ά��Ȩ�޹���->����(ҵ���߼�)
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:  yinzx 2009/07/17  �ͷ����ܵ���  1.�޸Ļ�ȡ���еķ����� ʹ��sPubSelect 2 �޸��˻�ȥ���е���� ȥ�������� valid_flag = 'Y' 3.ȥ����е��¼�  onchange="region.value=this.options[this.selectedIndex].tex" �����Ϊ��Ҫ�����
   * modify by 20091009  �޸�regioncode�� 
*/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*,com.sitech.crmpd.core.wtc.util.*,com.sitech.crmpd.kf.ejb.client.KFEjbClient" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String sel_id = request.getParameter("sel_id");
		String sel_text = request.getParameter("sel_text");		
		String region_code = request.getParameter("city_no");
		String region_name = "";
		String city_code = "";
		List list = new ArrayList();
		HashMap pMap = new HashMap();
		if(sel_id != null && !"".equals(sel_id.trim())){
			pMap.put("callcause_id",sel_id);
			try{
				list = KFEjbClient.queryForList("query_k171_ivr",pMap);
			}catch(Exception e){
				e.printStackTrace();
			}
		}

		pMap.clear();
		if( region_code != null && !"".equals(region_code.trim())){
			try{
				Object obj = KFEjbClient.queryForObject("query_k171_ivr_region",(Object)region_code);
				if (obj != null) {
					pMap = (HashMap)obj;
					region_name = pMap.get("REGION_NAME")==null?"":(String)pMap.get("REGION_NAME");
					city_code = pMap.get("CITY_CODE")==null?"":(String)pMap.get("CITY_CODE");
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
%>
<html>
<head>
<title>ά����λһ��</title>
<style>
	img {
		cursor:hand;
		vertical-align:middle;
	}	
</style>

<script language=javascript>
var array = new Array();	
window.onload = function(){
	var flag = false;
	var item;
	<%if(list != null && list.size() != 0){
		String id,servicename;
		Map map = new HashMap();
		for(int i=0 ;i< list.size();i++){
			map = (Map)list.get(i);
			id = (String)map.get("IVR_ID");
			servicename = (String)map.get("SERVICENAME");%>
			item = {"id":"<%=id%>","servicename":"<%=servicename%>"};
			array.push(item);
		<%}
	}%>
	if(array && array.length != 0){
		generateCheckBox(array,2);
	}
}

//�������¼
function cleanValue(){
	$("#ivr input:checkbox[flag!=2]").attr("checked",false);
	$("#ivr input:checkbox[flag=2]").attr("checked",true);
	
	$("#knowledgeDiv input:checkbox[exist='Y']").attr("checked",true);
	$("#knowledgeDiv input:checkbox[exist='N']").attr("checked",false);
}

function closeWin(){
	window.close();
}

function getKnowledgeData() {
	//ҳ������ʾ��֪ʶ
	var p_knowledgeId = ",";
	var knowledgeObj = document.getElementsByName("knowledge");
	for (var i=0;i<knowledgeObj.length;i++) {
		p_knowledgeId += knowledgeObj[i].value + ",";
	}
	var knowledgeDiv = document.getElementById("knowledgeDiv");
	var iHeight = 535;
	var iWidth = 850;
	var iLeft = window.screen.availWidth/2 + 100;
	var path = "../k171/k171_getKnowledgeData.jsp?p_knowledgeId="+p_knowledgeId;
	var features = "dialogLeft:"+iLeft+"px;dialogHeight:"+iHeight+"px;dialogWidth:"+iWidth+"px;";
	window.showModalDialog(path,knowledgeDiv,features);
	//window.open(path,null,"width=850px,height=535px");
}

function getIVRData()
{
	var checkboxs = $("#ivr input:checkbox[flag!=2]");
	var iheight = 700;
	var iwidth = 400;
	var itop = (screen.availHeight - iheight)/2;
	var ileft = screen.availWidth/2 + 100;
	var sel_ids = "";
	var sFeatures = "dialogHeight:"+iheight+"px;dialogLeft:"+ileft+"px;dialogWidth:"+iwidth+"px;dialogTop:"+itop+"px;";
	if(array.length != 0){
		for(var i=0;i<array.length;i++){
			sel_ids += array[i].id + ",";
		}
	}
	if(checkboxs.length != 0){
		for(var i=0 ;i <checkboxs.length;i++){
			sel_ids += checkboxs.eq(i).val() + ",";
		}
	}
	if(sel_ids.length != 0)
		sel_ids = sel_ids.substring(0,sel_ids.length-1);
	window.showModalDialog("k171_callIvrTree.jsp?flag=0&CityCode="+"<%=city_code%>"+"&region_name="+"<%=region_name%>"+"&sel_ids="+sel_ids,window,sFeatures);
}

//array��һ������,��������{"id":value,"servicename":value}��json��ʽ����
//flag=0��ʾҵ�����,flag=1��ʾ��ѯ����,flag=2��ʾ��ʶ�ڵ��Ǵ����ݿ��в�ѯ������
function generateCheckBox(array,flag){
	var ivr = $("#ivr");
	var checkedHtml = "";
	for(var i = 0; i < array.length; i++){
		checkedHtml += "<input type='checkbox' name='ivr_node' checked='true' flag='" + flag + "' value='"+array[i].id + "'>" + array[i].servicename + "</input><br>";
	}
	ivr.append(checkedHtml);
}

//����/ɾ�����ݵ�ivr����
function submit_ivr_knowledge(){
	var callcause_id = $("#callcause_id").val();
	var caption = $("#caption").val();
	var checked_service = $("#ivr input:checked[flag='0']");
	var checked_voice = $("#ivr input:checked[flag='1']");
	var checked_remove = $("#ivr input:not(:checked)[flag='2']");
	//��ʶ,0����û��ivr��������,1������ivr��������
	var ivr_count = 1;
	if(checked_service.length ==0 && checked_voice.length ==0 && checked_remove.length==0){
		ivr_count = 0;
		relation_knowledage(ivr_count);
		return;
	}

	var service_ids = new Array();
	var voice_ids = new Array();
	var remove_ids = new Array();
	if(checked_service && checked_service.length != 0){
		for(var i=0 ;i < checked_service.length;i++)
			service_ids.push(checked_service.eq(i).val());
	}
	
	if(checked_voice || checked_voice.length != 0){
		for(var i=0 ;i < checked_voice.length;i++)
			voice_ids.push(checked_voice.eq(i).val());
	}
	
	if(checked_remove || checked_remove.length != 0){
		for(var i=0 ;i< checked_remove.length;i++){
			remove_ids.push(checked_remove.eq(i).val());
		}
	}

	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k171/k171_relation_ivr.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("callcause_id",callcause_id);
	packet.data.add("caption",caption);
	packet.data.add("service_ids",service_ids.toString());
	packet.data.add("voice_ids",voice_ids.toString());
	packet.data.add("remove_ids",remove_ids.toString());

	core.ajax.sendPacket(packet,doknowledge,true);
	packet=null;
}

function doknowledge(packet){
	var ret = packet.data.findValueByName("ret");
	if(ret == "000000"){
		relation_knowledage(1);
	} else {
		rdShowMessageDialog("�Բ��𣬱�������ʧ�ܣ�",1);
	}
}

//����֪ʶ����ivr�Ĺ�������
function relation_knowledage(ivr_count) {
	var add_knowledgeId = "";
	var del_knowledgeId = "";
	var count = 0; //ѡ�е�֪ʶ��
	var knowledgeObj = document.getElementsByName("knowledge");
	for (var i=0;i<knowledgeObj.length;i++) {
		if (knowledgeObj[i].checked) {
			//���ݿⲻ���ڸü�¼�����ұ���ѡʱ�����뵽���ݿ�
			if (knowledgeObj[i].exist == 'N') {
				count++;
				add_knowledgeId += "'" + knowledgeObj[i].value + "',";
			} 
		} else {
			//���ݿ���ڸü�¼ʱ������ȡ����ѡʱ�������ݿ���ɾ��
			if (knowledgeObj[i].exist == 'Y') {
				count++;
				del_knowledgeId += "'" + knowledgeObj[i].value + "',";
			}
		}
	}
	if (count == 0 && ivr_count == 0) {
		rdShowMessageDialog("δ���κι�������",1);
		return;
	}
	if (add_knowledgeId != "") {
		add_knowledgeId = add_knowledgeId.substring(0,add_knowledgeId.length-1);
	}
	if (del_knowledgeId != "") {
		del_knowledgeId = del_knowledgeId.substring(0,del_knowledgeId.length-1);
	}
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k171/k171_relation_knowledge.jsp","���ڱ�������...");
	mypacket.data.add("causeId",$("#callcause_id").val());
	mypacket.data.add("causeCaption",$("#caption").val());
	mypacket.data.add("add_knowledgeId",add_knowledgeId);
	mypacket.data.add("del_knowledgeId",del_knowledgeId);
  core.ajax.sendPacket(mypacket,doprocess,false);
	mypacket=null;
}


function doprocess(packet) {
	var retCode = packet.data.findValueByName("retCode");
	if (retCode == "000000") {
		rdShowMessageDialog("����ɹ���",2);
		window.close();
	} else {
		rdShowMessageDialog("�Բ��𣬱�������ʧ�ܣ�",1);
	}
}
</script>
</head>
<body >
<%
 /*midify by yinzx 20091113 ������ѯ�����滻*/ 
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
%>
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
			<tr>
  				<td class="blue">����ԭ������</td>
  				<td width="75%">
						<input id="caption" name="caption" type="text" readOnly=true class="InputGrey" value="<%=sel_text%>"/>
						<input id="callcause_id" name="callcause_id" type="hidden" class="InputGrey" value="<%=sel_id%>"/>
	  			</td>
			</tr>
			<%
				Object noteObj = KFEjbClient.queryForObject("query_k171_cause",sel_id);
				String note = noteObj==null?"":noteObj.toString();
			%>
			<tr>
  				<td class="blue">����</td>
  				<td width="75%">
  					<textarea name="note" cols="30" rows="4" readonly="readonly"><%=note%></textarea>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">����IVR�ڵ�<font color="orange">*</font>
  					<span style="padding-top:20px;">
							<img onclick="getIVRData()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" />
	  				</div>
	  			</td>
  				<td width="75%">
  					<div id="ivr" style="width:98%;height:130px;overflow-y:scroll;text-indent:0;float:left;border:1px #BFCFE6 solid;"></div>
	  			</td>
			</tr>
			<tr>
				<td class="blue">����֪ʶ��<font color="orange">*</font>
					<img onclick="getKnowledgeData()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" />
				</td>
				<td>
					<div id="knowledgeDiv" style="width:98%;height:130px;overflow-y:scroll;text-indent:0;border:1px #BFCFE6 solid;">
					<%
						Map pMap2 = new HashMap();
						pMap2.put("causeId",sel_id);
						List list2 = (List)KFEjbClient.queryForList("query_k171_knowledge",pMap2);
						for (int i = 0; i < list2.size(); i++) {
							Map map = (Map)list2.get(i);
							String knowledgeId = (String)map.get("KNOWLEDGE_ID");
							String knowledgeCaption = (String)map.get("KNOWLEDGE_CAPTION");
							out.println("<input type='checkbox' name='knowledge' checked='checked' value='"+knowledgeId+"' exist='Y' />"+knowledgeCaption+"<br />");
						}
  				%>
					</div>
  			</td>
			</tr>			
			<tr >
  				<td colspan="2" align="center">
   					<input name="add" type="button" class="b_text" id="add" value="ȷ��" onClick="submit_ivr_knowledge();">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="ȡ��" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>