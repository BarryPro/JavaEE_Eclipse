<%
/********************
 
 
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
  
       
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>



//��ѯ��̬չʾIMEI�����б�
function go_query(){
	if($("#sInLoginAccept").val().trim()==""){
		rdShowMessageDialog("��������ˮ");
		return;
	}
	
	var packet = new AJAXPacket("f1246_query_plresult.jsp","����ִ��,���Ժ�...");
			packet.data.add("sInLoginAccept",$("#sInLoginAccept").val().trim());//opcode
			core.ajax.sendPacket(packet,do_query);
			packet = null; 
}
//��ѯ��̬չʾIMEI�����б��ص�
function do_query(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			var phone_type = packet.data.findValueByName("phone_type");
		
			
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ // 
														 "<td>"+retArray[i][1]+"</td>"+ // 
												 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<div class="title"><div id="title_zi">��ѯ����</div></div>
<TABLE cellSpacing="0"  >
    <tr>
        <td class="blue" width="20%">��ˮ</td>
        <td  ><input type="input" id="sInLoginAccept"/>
        	<input type="button" class="b_foot" value="��ѯ" onclick="go_query()"  />
        	</td>
    </tr>
</table>

<div class="title"><div id="title_zi">����б�</div></div>
<TABLE cellSpacing="0"  id="upgMainTab">
    <tr>
        <th width="20%">�������</th>
        <th>������</th>
    </tr>
</table>
 

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="history.go(-1)"  /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>