<%
/********************
 
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-5-28 14:22:50-------------------
 ���������Ż��ƶ������ն�CRMϵͳ����ʾ@�������۸�
 -------------------------��̨��Ա������--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}
 
//ɾ������
function delAndroidFile(){
    if(rdShowConfirmDialog('ȷ��ɾ����¼��')!=1) return;
    
}
$(document).ready(function(){
});


//���һ��
function add(){
	var addTr_html = "<tr>"+
									 "<td align='center'><input type='text' maxlength='11' v_type='mobphone' onblur='checkElement(this)'></td>"+
									 "<td align='center'><input type='text' maxlength='6'  ></td>"+
									 "<td align='center'><input type='button' class='b_text' onclick='add_cfm(this)' value='����'><input type='button' class='b_text' onclick='del(this)' value='ɾ��'></td>"+
									 "</tr>";
	$("#upgMainTab tr:eq(0)").after(addTr_html);
}
//����ύ
function add_cfm(bt){
	var phone_no_i = $(bt).parent().prev().prev().find("input").val();
	var login_no_i = $(bt).parent().prev().find("input").val();
	
	if(phone_no_i.trim()==""){
		rdShowMessageDialog("�������ֻ�����");
		return;
	}
	
	if(login_no_i.trim()==""){
		rdShowMessageDialog("�������������");
		return;
	}
	
	var packet = new AJAXPacket("fm271_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phone_no_i",phone_no_i); 
			packet.data.add("login_no_i",login_no_i); 
			packet.data.add("iFlag","1"); /*0��ѯ 1���� 2ɾ��*/
			core.ajax.sendPacket(packet,do_add_cfm);
			packet = null; 
}
function do_add_cfm(packet){
		var code = packet.data.findValueByName("code"); //���ش���
		var msg  = packet.data.findValueByName("msg"); //������Ϣ
		if(code=="000000"){//�ɹ�ȥ��ѯ��ˢ���б�
			rdShowMessageDialog("��ӳɹ�",2);
			reSetThis();
		}else{
			rdShowMessageDialog("���ʧ�ܣ�"+code+"��"+msg,0);
		}
}

//ɾ����̬��ӵ���
function del(bt){
	$(bt).parent().parent().remove();
}


//��ѯ����
function query(){
	var phone_no_i = $("#phoneNo").val();
	var login_no_i = $("#oprLoginNo").val();
	
	if(phone_no_i.trim()==""&&login_no_i.trim()==""){
		rdShowMessageDialog("��������һ����ѯ����");
		return;
	}
	
		var packet = new AJAXPacket("fm271_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phone_no_i",phone_no_i); 
			packet.data.add("login_no_i",login_no_i); 
			packet.data.add("iFlag","0"); /*0��ѯ 1���� 2ɾ��*/
			core.ajax.sendPacket(packet,do_query);
			packet = null; 
}

function do_query(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg  = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td align='center'>"+retArray[i][1]+"</td>"+ //�ֻ���
														 "<td align='center'>"+retArray[i][0]+"</td>"+ //��������
														 "<td align='center'><input type=\"button\" value=\"ɾ��\" class=\"b_text\" onclick=\"del_cfm('"+retArray[i][1]+"','"+retArray[i][0]+"')\"></td>"+//ɾ����ť
												 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}


function del_cfm(phone_no_i,login_no_i){
	if(rdShowConfirmDialog('ȷ��ɾ����¼��')!=1) return;
	var packet = new AJAXPacket("fm271_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phone_no_i",phone_no_i); 
			packet.data.add("login_no_i",login_no_i); 
			packet.data.add("iFlag","2"); /*0��ѯ 1���� 2ɾ��*/
			core.ajax.sendPacket(packet,do_del_cfm);
			packet = null; 
}
function do_del_cfm(packet){
		var code = packet.data.findValueByName("code"); //���ش���
		var msg  = packet.data.findValueByName("msg"); //������Ϣ
		if(code=="000000"){//�ɹ�ȥ��ѯ��ˢ���б�
			rdShowMessageDialog("ɾ���ɹ�",2);
			reSetThis();
		}else{
			rdShowMessageDialog("ɾ��ʧ�ܣ�"+code+"��"+msg,0);
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
	    <td class="blue" width="20%">������ֻ�����</td>
		  <td width="30%">
			    <input type="text" name="phoneNo" id="phoneNo" value="" /> 
		  </td>
		  <td class="blue" width="20%">��������</td>
		  <td width="30%">
			    <input type="text" name="oprLoginNo" id="oprLoginNo" value=""   />  
		  </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="query()"           />
	 		<input type="button" class="b_foot" value="���" onclick="add()"           />
	 	</td>
	</tr>
</table>

<div class="title"><div id="title_zi">����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="35%">������ֻ�����</th>
        <th width="35%">��������</th>
        <th >����</th>	
    </tr>
</table>

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