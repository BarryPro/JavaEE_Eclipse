<%
/********************
 
 -------------------------����-----------�ξ�ΰ(hejwa) 2015/3/19 9:10-------------------
 �в⹦��
 -------------------------��̨��Ա��liyang--------------------------------------------
 
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
	String opName    = WtcUtil.repNull(request.getParameter("opName"));
	  
	String workNo    = (String)session.getAttribute("workNo");
	String password  = (String)session.getAttribute("password");
	String workName  = (String)session.getAttribute("workName");
	String orgCode   = (String)session.getAttribute("orgCode");
	String ipAddrss  = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	
	String phoneNo = request.getParameter("activePhone");
  
%> 
		<wtc:service name="sUserInfoQry" outnum="30" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="" />						
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	if(!"000000".equals(code)){
	%>
	<script>
		rdShowMessageDialog("��ѯ�û���Ϣʧ�ܣ�<%=code%>,<%=msg%>");
		parent.removeTab("<%=opCode%>");
	</script>
	<%
	}
%>

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

$(document).ready(function(){
	query();
});

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}
 
//��ѯ������Ϣ��ѯ
function query(){
	var packet = new AJAXPacket("fm247_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());
			core.ajax.sendPacket(packet,doQuery);
			packet = null; 
}
//��ѯ������Ϣ��ѯ���ص�
function doQuery(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#mainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
			
			 var td0 = "<select value='"+retArray[i][7]+"' disabled='disabled' ><option>"+retArray[i][7]+"</option></select>";
			 var td1 = "<select value='"+retArray[i][8]+"' disabled='disabled' ><option>"+retArray[i][8]+"</option></select>";
			 
			 var op_sel_1 = "";
			 var op_sel_2 = "";
			 var op_sel_3 = "";
			 var op_sel_4 = "";
			 var op_sel_5 = "";
			 var op_sel_6 = "";
			 var op_sel_7 = "";
			 var op_sel_8 = "";
			 var op_sel_9 = "";
			 
			 if(retArray[i][10]==1){
			 	op_sel_1 = "selected";
			 }
			 if(retArray[i][10]==2){
			 	op_sel_2 = "selected";
			 }
			 if(retArray[i][10]==3){
			 	op_sel_3 = "selected";
			 }
			 if(retArray[i][10]==4){
			 	op_sel_4 = "selected";
			 }
			 if(retArray[i][10]==5){
			 	op_sel_5 = "selected";
			 }
			 if(retArray[i][10]==6){
			 	op_sel_6 = "selected";
			 }
			 if(retArray[i][10]==7){
			 	op_sel_7 = "selected";
			 }
			 if(retArray[i][10]==8){
			 	op_sel_8 = "selected";
			 }
			 if(retArray[i][10]==9){
			 	op_sel_9 = "selected";
			 }
			 
			 var td3 = "<select disabled='disabled' >"+
			 		"<option value='1' "+op_sel_1+">1</option>"+
			 		"<option value='2' "+op_sel_2+">2</option>"+
			 		"<option value='3' "+op_sel_3+">3</option>"+
			 		"<option value='4' "+op_sel_4+">4</option>"+
			 		"<option value='5' "+op_sel_5+">5</option>"+
			 		"<option value='6' "+op_sel_6+">6</option>"+
			 		"<option value='7' "+op_sel_7+">7</option>"+
			 		"<option value='8' "+op_sel_8+">8</option>"+
			 		"<option value='9' "+op_sel_9+">9</option>"+
			 	  "</select>";
			
			 var op_sel_10A = "";
			 var op_sel_10E = "";
			 if("10A"==retArray[i][14]){
			 	op_sel_10A = "selected";
			 }else if("10E"==retArray[i][14]){
			 	op_sel_10E = "selected";
			 }
			 
			 			 	  
			var td4 = "<select disabled='disabled' >"+
			 		"<option value='10A' "+op_sel_10A+">����</option>"+
			 		"<option value='10E' "+op_sel_10E+">����</option>"+
			 	  "</select>";			 	  
			 	  
			var td5="<input size='20' disabled='disabled'  value='"+retArray[i][11]+"'>";
			var td6="<input size='20' disabled='disabled'  value='"+retArray[i][12]+"'>";
			
			trObjdStr += "<tr>"+
					 "<td>"+td0+"</td>"+ 
					 "<td>"+td1+"</td>"+ 
					 "<td>"+td3+"</td>"+ 
					 "<td>"+td4+"</td>"+ 
					 "<td>"+td5+"</td>"+ 
					 "<td>"+td6+"</td>"+ 
					 "<td><input type=\"button\" value=\"�޸�\" class=\"b_text\" onclick=\"update(this)\"> <input type=\"button\" value=\"����\" class=\"b_text\" onclick=\"upd_save(this)\" style='display:none'></td>"+
					 "<td style='display:none'>"+retArray[i][7]+"</td>"+ 
				 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#mainTab tr:eq(0)").after(trObjdStr);
			$("#phoneNo").attr("readOnly","readOnly");//�ɹ����ֻ��Ų����޸ģ���Ϊ�޸ļ�¼ʱ���õ�
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}



//���Ļ��ּƻ�����̬���һ��
function update(bt){
	var trObj         = $(bt).parent().parent();
	
	trObj.find("td:eq(2)").find("select").removeAttr("disabled");
	trObj.find("td:eq(3)").find("select").removeAttr("disabled");
	trObj.find("td:eq(4)").find("input").removeAttr("disabled");
	trObj.find("td:eq(5)").find("input").removeAttr("disabled");
	
	//ȥ���޸İ�ť����ӱ��水ť
	trObj.find("td:eq(6)").find("input:eq(0)").hide();
	trObj.find("td:eq(6)").find("input:eq(1)").show();
	
} 
//�޸ı���
function upd_save(bt){
	var trObj         = $(bt).parent().parent();
	var iScoreRule    = trObj.find("td:eq(0)").find("select").val();
	var iScoreName    = trObj.find("td:eq(1)").find("select").val();
	var iPriority     = trObj.find("td:eq(2)").find("select").val();
	var iStatus       = trObj.find("td:eq(3)").find("select").val();
	var iScoreRuleOld = trObj.find("td:eq(7)").text();
	var iEffDate      = trObj.find("td:eq(4)").find("input").val();
	var iExpDate      = trObj.find("td:eq(5)").find("input").val();
	
	if(iScoreRule==""){
		rdShowMessageDialog("��������ּƻ�����");
		return;
	}

	var reg1 = /^[a-zA-Z0-9]+$/;
	if(!reg1.test(iScoreRule)){
		rdShowMessageDialog("���ּƻ�����ֻ������������ĸ�����");
		return;
	}
	
		
	if(iScoreName==""){
		rdShowMessageDialog("��������ּƻ�����");
		return;
	}
	
	var reg31 = /^((((1[6-9]|[2-9]\d)\d{2})(0?[13578]|1[02])(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})(0?[13456789]|1[012])(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})0?2(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))0?229)) (([1-2][0-4]:[0-5][0-9]:[0-5][0-9])|0[1-9]:[0-5][0-9]:[0-5][0-9])$/;
	
	if(!reg31.test(iEffDate)){	
		rdShowMessageDialog("��ʼʱ���ʽΪ yyyyMMdd HH:mm:ss");
		return;
	}
	if(!reg31.test(iExpDate)){	
		rdShowMessageDialog("��ʼʱ���ʽΪ yyyyMMdd HH:mm:ss");
		return;
	}
		
	if(iEffDate>iExpDate){
		rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
		return;
	}
	
	var packet = new AJAXPacket("fm247_3.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//�ֻ���
			packet.data.add("iOpType","U");//�޸ĵ�����ΪU
			packet.data.add("iScoreRule",iScoreRule);//
			packet.data.add("iScoreName",iScoreName);//
			packet.data.add("iPriority",iPriority);//
			packet.data.add("iStatus",iStatus);//
			packet.data.add("iScoreRuleOld",iScoreRuleOld);//
			packet.data.add("iEffDate",iEffDate);//
			packet.data.add("iExpDate",iExpDate);//
			core.ajax.sendPacket(packet,doUpd_save);
			packet = null; 
}
function doUpd_save(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){
		rdShowMessageDialog("�޸ĳɹ�",2);
		query();
	}else{
		rdShowMessageDialog("�޸�ʧ�ܣ�"+code+msg,0);
	}
}

//�������ּƻ�����̬���һ��
function add(){

	 var td0 = "<select  >"+
					 		"<option value='JFJS000' >JFJS000</option>"+
					 	  "</select>";
	 var td1 = "<select  >"+
					 		"<option value='�������ּ���' >�������ּ���</option>"+
					 	  "</select>";
	 var td3 = "<select  >"+
	 		"<option value='1' >1</option>"+
	 		"<option value='2' >2</option>"+
	 		"<option value='3' >3</option>"+
	 		"<option value='4' >4</option>"+
	 		"<option value='5' >5</option>"+
	 		"<option value='6' >6</option>"+
	 		"<option value='7' >7</option>"+
	 		"<option value='8' >8</option>"+
	 		"<option value='9' >9</option>"+
	 	  "</select>";
	
	 			 	  
	var td4 = "<select >"+
	 		"<option value='10A' >����</option>"+
	 		"<option value='10E' >����</option>"+
	 	  "</select>";	
			 	  
			 	  
	var inHtml_j = "<tr>"+
		       		"<td>"+td0+"</td>"+ 
				"<td>"+td1+"</td>"+ 
				"<td>"+td3+"</td>"+ 
				"<td>"+td4+"</td>"+ 
				"<td>&nbsp;</td>"+ 
				"<td>&nbsp;</td>"+ 
				"<td><input type=\"button\" value=\"����\" class=\"b_text\" onclick=\"add_save(this)\"></td>"+
		       "</tr>";
	$("#mainTab tr:eq(0)").after(inHtml_j);
} 

//��������
function add_save(bt){
	var trObj         = $(bt).parent().parent();
	var iScoreRule    = trObj.find("td:eq(0)").find("select").val();
	var iScoreName    = trObj.find("td:eq(1)").find("select").val();
	var iPriority     = trObj.find("td:eq(2)").find("select").val();
	var iStatus       = trObj.find("td:eq(3)").find("select").val();
	
	if(iScoreRule==""){
		rdShowMessageDialog("��������ּƻ�����");
		return;
	}
	
	var reg1 = /^[a-zA-Z0-9]+$/;
	if(!reg1.test(iScoreRule)){
		rdShowMessageDialog("���ּƻ�����ֻ������������ĸ�����");
		return;
	}
	
	
	if(iScoreName==""){
		rdShowMessageDialog("��������ּƻ�����");
		return;
	}
	
	var packet = new AJAXPacket("fm247_4.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//�ֻ���
			packet.data.add("iOpType","I");//�޸ĵ�����ΪU
			packet.data.add("iScoreRule",iScoreRule);//
			packet.data.add("iScoreName",iScoreName);//
			packet.data.add("iPriority",iPriority);//
			packet.data.add("iStatus",iStatus);//
			packet.data.add("iScoreRuleOld","");//
			core.ajax.sendPacket(packet,doAdd_save);
			packet = null; 
}
function doAdd_save(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){
		rdShowMessageDialog("��ӳɹ�",2);
		query();
	}else{
		rdShowMessageDialog("���ʧ�ܣ�"+code+msg,0);
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="11%">�ֻ�����</td>
		  <td width="22%">
			    <input type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" maxlength="11" class="InputGrey" readonly/> 
		  </td>
	</tr>
</table>



<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="add()"               /> 
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<div class="title"><div id="title_zi">������Ϣ</div></div>
<TABLE cellSpacing="0" >
    <tr>
    	<td class="blue">�û�ID</td>
    	<td><%=serverResult[0][0]%></td>
    	<td class="blue">�ͻ�ID</td>
    	<td><%=serverResult[0][1]%></td>
    	<td class="blue">�ʻ�ID</td>
    	<td><%=serverResult[0][2]%></td>
    </tr>
    <tr>
    	<td class="blue">ҵ��Ʒ������</td>
    	<td><%=serverResult[0][6]%></td>
    	<td class="blue">����ʱ��</td>
    	<td colspan="3"><%=serverResult[0][17]%></td>
    </tr>
    <tr>
    	<td class="blue">��������</td>
    	<td><%=serverResult[0][20]%></td>
    	<td class="blue">��������</td>
    	<td colspan="3"><%=serverResult[0][22]%></td>
    </tr>
</table>

<div class="title"><div id="title_zi">���ּƻ���ѯ���</div></div>
<TABLE cellSpacing="0" id="mainTab">
    <tr>
    	<th width="16%">���ּƻ�����</th>
        <th width="16%">���ּƻ�����</th>
        <th width="16%">���ּƻ����ȼ�</th>
        <th width="16%">���ּƻ�״̬</th>
        <th width="15%">�ƻ���Чʱ��</th>
        <th width="15%">�ƻ�ʧЧʱ��</th>
        <th>����</th>
    </tr>
</table>


<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>