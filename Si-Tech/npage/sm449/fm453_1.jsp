<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2017/2/8 13:25:25-----------------
 �����·����ӻ��мۿ�ҵ��ȫ�����췽�������߼ƻ���֪ͨ
 
 
 -------------------------��̨��Ա��liyang--------------------------------------------
 
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



//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

var COM_OPCODE = "";


$(document).ready(function(){
	$("#radio_<%=opCode%>").click();
	
});

function pub_set_radio(bt){
	$(bt).prev().click();
	
}
function show_p_div(bt,check_opcode){
	COM_OPCODE = check_opcode;
}

function go_Cfm(){
		if(!check(msgFORM)) return false;
    var packet = new AJAXPacket("ajaxGetServRe.jsp","���Ժ�...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("ipt_BeginCardNo",$("#ipt_BeginCardNo").val());//
        packet.data.add("ipt_EndCardNo",$("#ipt_EndCardNo").val());//
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
}
function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
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

<!----------------------------------------------��������-----------------��ʼ----------------------------->
<table cellSpacing="0">
	<tr>
		<td class="blue" align="center">
			<input type="radio" id="radio_m453"  value="m453" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m453')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m453�����ӿ�����</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_m454"  value="m454" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m454'),sm454_go_getImeiList()" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m454�����ӿ�����</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_m455"  value="m455" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m455'),sm455_go_getImeiList()" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m455�����ӿ�����</span>
		
		</td>
	</tr>
</table>


<table cellSpacing="0">
	<tr>
		<td width="25%" class="blue">��ʼ���ţ�</td>
		<td><input type="text" id="ipt_BeginCardNo" name="ipt_BeginCardNo" v_must="1" v_type="string"  onblur = "checkElement(this)"  size="50"   /></td>
	</tr>
	<tr>
		<td width="25%" class="blue">�������ţ�</td>
		<td><input type="text" id="ipt_EndCardNo" name="ipt_EndCardNo" v_must="1" v_type="string"  onblur = "checkElement(this)"  size="50" /></td>
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