<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-10-13 17:01:48------------------
�����·������̳ǽ���ͳһ�Ż���֤ƽ̨ʡ��֧��ϵͳ��ϸ����֪ͨ 
 
 -------------------------��̨��Ա��jianglei--------------------------------------------
 
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

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


function go_Query(){
	if(!check(document.msgFORM)) return false;
	
	var packet = new AJAXPacket("fm418_ajax_Query.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			
			packet.data.add("login_accept",$("#login_accept").val().trim());//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//opcode
			core.ajax.sendPacket(packet,do_Query);
			packet = null; 
}
//��ѯ��̬չʾIMEI�����б��ص�
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ // 
														 "<td>"+retArray[i][1]+"</td>"+ // 
														 "<td>"+retArray[i][2]+"</td>"+ // 
														 "<td>"+retArray[i][3]+"</td>"+// 
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


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">�ֻ�����</td>
		  <td width="35%">
		  	<input type="text" name="phoneNo" id="phoneNo" value="" v_must="1" maxlength="11" v_type="mobphone" onblur="checkElement(this)"/> 
		  	<input type="button" class="b_foot" value="��ѯ" onclick="go_Query()"          />
		  </td>
		  
		  <td class="blue" width="15%">��ѯ��ˮ</td>
		  <td width="35%">
		  	<input type="text" name="login_accept" id="login_accept" value=""  v_must="1"  maxlength="20"  /> 
		  </td>
	</tr>
</table>

<div class="title"><div id="title_zi"><%=opName%>-��ѯ����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="25%">�󶩵����</th>
        <th width="25%">�����ۼ��ܻ���</th>
        <th width="25%">�ۼ����ѻ���</th>
        <th width="25%">�ۼ���������</th>	
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