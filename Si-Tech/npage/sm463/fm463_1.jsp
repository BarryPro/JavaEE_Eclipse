
<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming 2017.4.5------------------
 ���ڶ���Ƨ������������ǩ������һ֤������ʾ�ĺ�
 
 
 -------------------------��̨��Ա��xiahk--------------------------------------------
 
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


%> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
 



function go_Cfm(){
	
    var packet = new AJAXPacket("fm463_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo",$("#phoneNo").val());//
        packet.data.add("phone_type",$("#phone_type").val());//
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
	
}

function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//�����ɹ�
    	rdShowMessageDialog("�����ɹ�",2);
    	reSetThis();
    }
}


function reSetThis(){
	location = location;
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">��������</td>
		  <td width="35%" colspan="3">
		  	<select id="phone_type" name="phone_type" >
				    <option value="1">�ֻ�����</option>
				    <option value="2">����˺�</option>
				</select>
		  </td>
	</tr>
		
	<tr>
	    <td class="blue" width="15%">�û�����</td>
		  <td width="35%">
			    <input type="text"  name="phoneNo" id="phoneNo"   value="" />
		  </td>
		  
		  
	</tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/include/public_smz_check.jsp" %>
</FORM>
</BODY>
</HTML>