<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016/11/3 16:12:49------------------
 ����ר�߶˵���ϵͳ�������͹��������Ż�����
 
 -------------------------��̨��Ա��zhangzhea--------------------------------------------
 
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


//��ѯ�ͻ�������Ϣ
function go_Cfm(){
		if(!check(msgFORM)) return false;
		
    var packet = new AJAXPacket("fm421_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("business_code",$("#business_code").val());//
        packet.data.add("old_workNo",$("#old_workNo").val());//
        packet.data.add("new_workNo",$("#new_workNo").val());//
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
}

//��ѯ�ͻ�������Ϣ�ص�
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

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">�̻����� </td>
		  <td width="35%">
		  	<input type="text" id="business_code" name="business_code"   v_must="1" v_type="string"  onblur = "checkElement(this)"  />
		  </td>
		  <td class="blue" width="15%">��ǰ��������</td>
		  <td>
			    <input type="text" id="old_workNo" name="old_workNo"    v_must="1" v_type="string"  onblur = "checkElement(this)"  />
		  </td>
	</tr>
	<tr>
	    <td class="blue">�����������</td>
		  <td>
			    <input type="text" id="new_workNo" name="new_workNo"  v_must="1" v_type="string"  onblur = "checkElement(this)"  />
		  </td>
		  <td class="blue" >&nbsp;</td>
		  <td>
		  	&nbsp;
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
</FORM>
</BODY>
</HTML>