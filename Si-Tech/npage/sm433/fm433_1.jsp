<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2016/11/16 16:52:04]------------------
 
 
 -------------------------��̨��Ա��[xiahk]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  
  
  String currentDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

%> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


//
function go_Query(){
	if($("#qry_val").val().trim()==""){
		rdShowMessageDialog("�������ѯֵ");
		return;
	}
	if($("#sel_type").val()=="3"){
		//���֤��ѯ
		go_Query_ICCID();
	}else if($("#sel_type").val()=="4"){
		go_Query_IMEI();
	}else{
		go_Query_OT();
	}
}

/**
 * �Ƚ�2��������������
 * ���strDateStart ��ʼʱ�䣬����С�ڽ���ʱ��
 * ���strDateEnd   ����ʱ��  ������ڿ�ʼʱ��
 * ʱ���ʽ��Ϊ YYYYmmdd
 * �� 20161101 �� 20161110 ���ؽ��Ϊ9
 */
function getDays(strDateStart,strDateEnd){
	
   var strDateS = new Date(
   													parseInt(strDateStart.substring(0,4)), 
   													parseInt(strDateStart.substring(4,6))-1, 
   													parseInt(strDateStart.substring(6,8))
   												);
   												
   var strDateE = new Date(  
   													parseInt(strDateEnd.substring(0,4)),   
   													parseInt(strDateEnd.substring(4,6))-1,   
   													parseInt(strDateEnd.substring(6,8))
   											  );
   
   var iDays = parseInt(Math.abs(strDateE - strDateS ) / 1000 / 60 / 60 /24)//�����ĺ�����ת��Ϊ����
   
   return iDays ;
}
//����IMEI��ѯ
function go_Query_IMEI(){
	if($("#beginDate").val().trim()==""){
		rdShowMessageDialog("�����뿪ʼʱ��");
		return;
	}
	if($("#endDate").val().trim()==""){
		rdShowMessageDialog("�����뿪ʼʱ��");
		return;
	}
	
	if(parseInt($("#beginDate").val().trim())>parseInt($("#endDate").val().trim())){
		rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
		return;
	}
	
	if(parseInt($("#endDate").val().trim())>parseInt("<%=currentDate%>")){
		rdShowMessageDialog("����ʱ�䲻�ܴ��ڵ�ǰʱ��");
		return;
	}
	
	if(getDays($("#beginDate").val().trim(),$("#endDate").val().trim())>9){
		rdShowMessageDialog("��ʼʱ�����ʱ�䲻�����10��");
		return;
	}

 	var pactket = new AJAXPacket("fm433_Query_ByIMEI.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("iIMEINo",$("#qry_val").val().trim());
			pactket.data.add("beginDate",$("#beginDate").val().trim());
			pactket.data.add("endDate",$("#endDate").val().trim());
			core.ajax.sendPacket(pactket,do_dQuery_IMEI);
			pactket=null;
	
}
function do_dQuery_IMEI(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td><input type='button' class='b_text' value='��ѯ������Ϣ'   onclick='go_Query_PHONENO(this)' /></td>"+ //
												 "</tr>";
			}
			$("#div_phoneList").hide();
			$("#div_result").hide();
			$("#div_IMEI_resList").hide();
			
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#div_IMEI_resList").show();
			$("#tab_IMEI_resList tr:gt(0)").remove();
			$("#tab_IMEI_resList tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}


//��ѯ���б�󣬵����ѯ�����ֻ������ͽ��в�ѯ
function go_Query_PHONENO(bt){
	$("#qry_val").val($(bt).parent().parent().find("td:eq(0)").text().trim());
	$("#sel_type").val("0");
	go_Query_OT();
}


//��ѯ֤������
function go_Query_OT(){	
			
			var iQryPhoneNo = "";
			var iIMSINo     = "";
			var iCfmLogin   = "";
			var iIdIccid    = "";
			var iIMEINo     = "";
			
			var sel_type = $("#sel_type").val();
			if("0"==sel_type){
				iQryPhoneNo = $("#qry_val").val();
			}
			
			if("1"==sel_type){
				iIMSINo = $("#qry_val").val();
			}
			
			if("2"==sel_type){
				iCfmLogin = $("#qry_val").val();
			}
			
			if("3"==sel_type){
				iIdIccid = $("#qry_val").val();
			}
			
			if("4"==sel_type){
				iIMEINo = $("#qry_val").val();
			}
			

			
 	var pactket = new AJAXPacket("fm433_Query_ByOt.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("opCode","<%=opCode%>");
			
			
			pactket.data.add("iOpType",$("#sel_type").val());
			pactket.data.add("iQryPhoneNo",iQryPhoneNo);
			pactket.data.add("iIMSINo",iIMSINo);
			pactket.data.add("iCfmLogin",iCfmLogin);
			pactket.data.add("iIdIccid",iIdIccid);
			pactket.data.add("iIMEINo",iIMEINo);
			core.ajax.sendPacket(pactket,do_Query_OT);
			pactket=null;
}
function do_Query_OT(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
														 "<td>"+retArray[i][4]+"</td>"+ //
														 "<td>"+retArray[i][6]+"</td>"+ //
														 "<td>"+retArray[i][7]+"</td>"+ //
														 "<td>"+retArray[i][8]+"</td>"+ //
														 "<td>"+retArray[i][10]+"</td>"+ //
														 "<td>"+retArray[i][11]+"</td>"+ //
														 "<td>"+retArray[i][13]+"</td>"+ //
												 "</tr>";
			}
			$("#div_phoneList").hide();
			$("#div_result").hide();
			$("#div_IMEI_resList").hide();
			$("#tr_IMEI").hide();
			
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#div_result").show();
			$("#tab_result tr:gt(0)").remove();
			$("#tab_result tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}


//��ѯ֤������
function go_Query_ICCID(){	
	
 	var pactket = new AJAXPacket("fm433_Query_ByIccid.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("iccid_no",$("#qry_val").val().trim());
			core.ajax.sendPacket(pactket,do_Query_ICCID);
			pactket=null;
}
// �ص�
function do_Query_ICCID(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td><input type='button' class='b_text' value='��ѯ������Ϣ'   onclick='go_Query_PHONENO(this,\"0\")' /></td>"+ //
												 "</tr>";
			}
			$("#div_phoneList").hide();
			$("#div_result").hide();
			$("#div_IMEI_resList").hide();
			
			
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#div_phoneList").show();
			$("#tab_phoneList tr:gt(0)").remove();
			$("#tab_phoneList tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}


//������ѯ���ͣ�����б������
function set_div_show(){
	$("#div_phoneList").hide();
	$("#tab_phoneList tr:gt(0)").remove();
	
	$("#div_result").hide();
	$("#tab_result tr:gt(0)").remove();
	
	$("#div_IMEI_resList").hide();
	$("#tab_IMEI_resList tr:gt(0)").remove();
	$("#tr_IMEI").hide();
	
	$("#qry_val").val("");
	
	if($("#sel_type").val()=="4"){
		$("#tr_IMEI").show();
	}else{
		$("#tr_IMEI").hide();
	}
}


</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">��ѯ����</td>
		  <td width="35%">
		  	<select id="sel_type" name="sel_type"  onchange="set_div_show()">
				    <option value="0">�ֻ�����</option>
				    <option value="1">IMSI</option>
				    <option value="2">����˺�</option>
				    <option value="3">֤������</option>
				    <option value="4">IMEI</option>
				</select>
		  </td>
		  <td class="blue" width="15%">��ѯֵ</td>
		  <td>
		  	<input type="text" id="qry_val" name="qry_val" v_must="0" v_type="string"  onblur = "checkElement(this)"  />
		  	&nbsp;
		  	<input type="button" class="b_text" value="��ѯ" onclick="go_Query()" />
		  </td>
	</tr>
	
	<tr id="tr_IMEI" style="display:none">
	    <td class="blue">��ʼ����</td>
		  <td>
			    <input type="text" name="beginDate" id="beginDate"   onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
			    <font class="orange">*</font>
		  </td>
		  <td class="blue" >��������</td>
		  <td>
			    <input type="text" name="endDate" id="endDate"    onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
			    <font class="orange">*</font>
		  </td>
	</tr>	
	
</table>


<div id="div_IMEI_resList" style="display:none">
<div class="title"><div id="title_zi">�����б�</div></div>
<TABLE cellSpacing="0" id="tab_IMEI_resList">
    <tr>
        <th width="25%">�ֻ�����</th>
        <th width="25%">IMEI</th>
        <th width="25%">ͨ������</th>
        <th width="25%">����</th>
    </tr>
</table>
</div>


<div id="div_phoneList" style="display:none">
<div class="title"><div id="title_zi">�����б�</div></div>
<TABLE cellSpacing="0" id="tab_phoneList">
    <tr>
        <th width="25%">�ֻ�����</th>
        <th width="25%">�ͻ�����</th>
        <th width="25%">����ʱ��</th>
        <th width="25%">����</th>
    </tr>
</table>
</div>

<div id="div_result"  style="display:none">
<div class="title"><div id="title_zi">������Ϣ�б�</div></div>
<TABLE cellSpacing="0" id="tab_result">
    <tr>
        <th>�ֻ�����</th>
        <th>IMSI</th>
        <th>����˺�</th>
        <th>�ͻ�����</th>	
        <th>�ͻ���ַ</th>
        <th>֤������</th>	
        <th>֤������</th>	
        <th>֤����ַ</th>	
        <th>�����ص�</th>	
        <th>����ʱ��</th>	
        <th>����״̬</th>	
    </tr>
</table>
</div>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>