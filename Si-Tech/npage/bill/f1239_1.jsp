<%
/********************
 version v2.0
������: si-tech
update:yanpx@2008-9-16
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
	String opCode = "1239";//ģ�����
  String opName = "���������";//ģ������
%>

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
	<title><%=opName%></title>
	<%@ include file="/npage/include/public_title_name.jsp" %>
 </head>

<SCRIPT type=text/javascript>
onload = function(){
  document.all.mphone_no.focus();
}
//----------------��֤���ύ����-----------------
var subButt2;
function controlButt(subButton){
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}
function query(subButton)
{
  	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	if($("input[@name='opFlag'][@checked]").val() == "��ѯ"){
		return false;
	}else if(check(frm1239))
	{
		frm1239.action="f1239_query.jsp";
		frm1239.submit();	
	}
}
function opChange(){
	var opValue = $("input[@name='opFlag'][@checked]").val();
	if(opValue == "��ѯ"){
		getQueryDate();
	}else{
		$("#queryMsg").hide("fast");
		$("#btnSpan").show();
	}
}
function getQueryDate(){
	var getdataPacket = new AJAXPacket("f1239_getDate.jsp","���ڻ�����ݣ����Ժ�......");
	getdataPacket.data.add("phoneNo","<%=activePhone%>");
	core.ajax.sendPacket(getdataPacket,setQueryDate);
	getdataPacket = null;
}
function setQueryDate(packet){
	var retCode = "";
	var retMsg = "";
	//��f1239_getDate.jsp ��ȡ����
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	if("000000" == retCode){
		var offerMsg = packet.data.findValueByName("offerMsg");
		var arrMsg 		= packet.data.findValueByName("arrMsg");
		var hisArrMsg 	= packet.data.findValueByName("hisArrMsg");
		var timeArrMsg = packet.data.findValueByName("timeArrMsg");
		var rowStr = "";
		
		rowStr = "<tr><th>����Ʒ����</th><th>�ְ󶨵绰��</th><th>���󶨵绰��</th><th>������</th></tr>";
		for(var i = 0; i < offerMsg.length; i++){
			rowStr += "<tr>";
			for(var j = 0; j < offerMsg[i].length; j++){
				rowStr += "<td>" + offerMsg[i][j] + "</td>";
			}
			rowStr += "</tr>";
		}
		$("#offerDetail").empty();
		$("#offerDetail").append(rowStr);
		
		rowStr = "<tr><th>�󶨵绰����</th><th>��Чʱ��</th><th>ʧЧʱ��</th><th>��������</th><th>����ʱ��</th><th>����Ʒ����</th></tr>";
		for(var i = 0; i < arrMsg.length; i++){
			rowStr += "<tr>";
			for(var j = 0; j < arrMsg[i].length+2; j++){
				//alert(j);
				if(j==1)
				{
					rowStr += "<td>" + timeArrMsg[i][0] + "</td>";
					//alert(timeArrMsg[i][0]+"---��Чʱ��");
				}
				if(j==2)
				{
					rowStr += "<td>" + timeArrMsg[i][1] + "</td>";
					//alert(timeArrMsg[i][1]+"---ʧЧʱ��");
				}
				else if(j!=1 && j!=2 && j<2 ){
				rowStr += "<td>" + arrMsg[i][j] + "</td>";
				//alert(arrMsg[i][j]+"---����");
				}
				else if (j>2)
					{
						rowStr += "<td>" + arrMsg[i][j-2] + "</td>";
					}
			}
			rowStr += "</tr>";
		}
		$("#nowDetail").empty();
		$("#nowDetail").append(rowStr);
		
		rowStr = "<tr><th>�󶨵绰����</th><th>��������</th><th>����ʱ��</th><th>��ʷ״̬</th><th>����Ʒ����</th></tr>";
		for(var i = 0; i < hisArrMsg.length; i++){
			rowStr += "<tr>";
			for(var j = 0; j < hisArrMsg[i].length; j++){
				rowStr += "<td>" + hisArrMsg[i][j] + "</td>";
			}
			rowStr += "</tr>";
		}
		//$("#hisDetail tr:gt(0)").empty();
		$("#hisDetail").empty();
		$("#hisDetail").append(rowStr);
		
		//��ֵ�������޸���ʽ
		$("#queryMsg").show("fast");
		$("#btnSpan").hide();
	}else{
		rdShowMessageDialog("��ѯ�û����鳩���ײ�ʧ�ܣ�"+ retMsg + "[" + retCode + "]");
		frm1239.reset();
	}
}
$(document).ready(function(){
	$("#queryMsg").hide();
});
</SCRIPT>

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form method="post" name="frm1239"  onKeyUp="chgFocus(frm1239)">
	<%@ include file="/npage/include/header.jsp" %>
	    <div class="title">
			<div id="title_zi">���������</div>
		</div>
		<table cellspacing="0">
			<tr> 
				<td class="blue"> �������� </td>
				<td>
					<input type="radio" name="opFlag" value="����" checked class="radio" onclick="opChange()"/> ����
					<input type="radio" name="opFlag" value="�޸�" class="radio" onclick="opChange()"/> �޸�
					<input type="radio" name="opFlag" value="ɾ��" class="radio" onclick="opChange()"/>ɾ��
					<input type="radio" name="opFlag" value="��ѯ" class="radio" onclick="opChange()"/> ��ѯ
				</td>
			</tr>	
			<tr> 		 
				<td class="blue"> �������� </td>
				<td> 
					<input name="mphone_no" id="mphone_no" v_type="mobphone" v_must=1 v_minlength=11 v_maxlength=11  v_name="�ֻ�����"  maxlength=11  value="<%=activePhone%>" readonly Class="InputGrey"/>   
				</td>
			</tr>
		</table>
		<div id="queryMsg" style="display:none;">
			<div class="title">
				<div id="title_zi">��������ѯ</div>
			</div>
			<table cellspacing="0" id="offerDetail">
			</table>
			<div class="title">
				<div id="title_zi">��ǰ���������ϸ</div>
			</div>
			<table cellspacing="0" id="nowDetail">
			</table>
			<div class="title">
				<div id="title_zi">���6���°����¼</div>
			</div>
			<table cellspacing="0" id="hisDetail">
			</table>
		</div>
		<table cellspacing="0" id="btnSpan">
			<tr> 
				<td align="center" id="footer">
				<input class="b_foot" name="queryAll" type="button" value="ȷ��" onclick="query(this)"/>
				<input class="b_foot" name="reset1"   type="button" onClick="frm1239.reset();" value="���"/>
				<input class="b_foot" name="back"   onclick="parent.removeTab(<%=opCode%>);" type="button" value="�ر�"/>
				</td>
			</tr>
		</table>

<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
