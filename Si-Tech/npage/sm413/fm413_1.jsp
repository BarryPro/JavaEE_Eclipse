<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-10-8 17:04:40------------------
 ���ڶ�ʵ���ƹ��������ԭ�����ϵͳ�����ͱ������ĺ����޸�������ɾ��������
 
 
 -------------------------��̨��Ա��xiahk/chenlina--------------------------------------------
 
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
	
	//out.print( new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
%> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
 




//��ѯ�ͻ�������Ϣ
function go_queryCustName(){
    var packet = new AJAXPacket("fm413_ajax_queryCustName.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo",$("#phoneNo").val());//
    core.ajax.sendPacket(packet,do_queryCustName);
    packet =null;
}
//��ѯ�ͻ�������Ϣ�ص�
function do_queryCustName(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
    	var old_custName = packet.data.findValueByName("custName");
	    var old_custaddr = packet.data.findValueByName("custAddr");
	    	
    	if(old_custName!=""){
	    	set_opr_tr();
	    	$("#phoneNo").attr("disabled","disabled");
	    	$("#btn_qry_phoneNo").attr("disabled","disabled");
	    	$("#upd_opType").attr("disabled","disabled");

	    	$("#old_custName").text(old_custName);
	    	$("#old_custaddr").text(old_custaddr);
    	}else{
    		rdShowMessageDialog("��������ȷ���ֻ�����");
    	}
    	
    }
}


function go_Cfm(){
		
		var new_custName = "";
		
		var iOpType  = "";/*��������0������;1�ĵ�ַ*/
		var iOpValue = "";
		var iOpmemo  = "";
		
		if("upd_name"==$("#upd_opType").val()){
			if(checkElement(document.msgFORM.new_custName)){
				if(!checkCustNameFunc16New(document.msgFORM.new_custName,0,0)){
					return;
				}
			}else{
				return;
			}    
		
		
			iOpType  = "0";
			iOpValue = $("#new_custName").val().trim();
			iOpmemo  = "��ע���޸Ŀͻ�����";
			new_custName = $("#new_custName").val().trim(); 

		}
		if("upd_ad"==$("#upd_opType").val()){
			if($("#new_addr").val().trim()==""){
				rdShowMessageDialog("�������¿ͻ���ַ");
				return;
			}  
			
			var m = /^[\u0391-\uFFE5]*$/;
			var chinaLength = 0;
			for (var i = 0; i <$("#new_addr").val().trim().length; i ++){
		        var code = $("#new_addr").val().trim().charAt(i);//�ֱ��ȡ��������
		        var flag = m.test(code);
		        if(flag){
		        	chinaLength ++;
		        }
		  }
    	if(chinaLength < 8){
				rdShowMessageDialog("�¿ͻ���ַ���뺬������8�����ĺ��֣�");
				$("#new_addr").val("");
				return;
			}
    
			iOpType = "1";
			iOpValue = $("#new_addr").val().trim();
			iOpmemo  = "��ע���޸Ŀͻ���ַ";
		}		
		
		
    var packet = new AJAXPacket("fm413_updCfm.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo",$("#phoneNo").val());//
        packet.data.add("iOpType",iOpType);//
        packet.data.add("iOpValue",iOpValue);//
        packet.data.add("iOpmemo",iOpmemo);//
        packet.data.add("new_custName",new_custName);//
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


//��������
function set_opr_tr() {
	var opType = $("#upd_opType").val();
	if("upd_name"==opType){
		$("#tr_old_custname").show();
		$("#tr_new_custname").show();
		
		$("#tr_old_custaddr").hide();
		$("#tr_new_custaddr").hide();
		
	}
	if("upd_ad"==opType){
		$("#tr_old_custname").hide();
		$("#tr_new_custname").hide();
		
		$("#tr_old_custaddr").show();
		$("#tr_new_custaddr").show();
		
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
	    <td class="blue"  width="15%">��������</td>
		  <td colspan="3">
		  	<select id="upd_opType"   >
				    <option value="upd_name">�ͻ�����</option>
				    <option value="upd_ad">�ͻ���ַ</option>
				</select>
		  </td> 
	</tr>	
		
		<tr>
			  <td class="blue" width="15%">�ֻ�����</td>
		  <td width="35%">
			    <input type="text"  name="phoneNo" id="phoneNo"  maxlength="11" value="" />
			    <input type="button" class="b_text" value="��ѯ" id="btn_qry_phoneNo" onclick="go_queryCustName()" />
		  </td>	
		</tr>
	
		<tr id="tr_old_custname"    style="display:none">
	  
		  <td class="blue"  width="15%">�ͻ�����</td>
		  <td>
			    <span id="old_custName"></span>
		  </td>
	</tr>
	<tr id="tr_new_custname"  style="display:none">
	    <td class="blue">�¿ͻ�����</td>
		  <td colspan="3">
			    <input name=new_custName id="new_custName" value="" v_must="1"  maxlength="30" v_type="string"    onblur="if(checkElement(this)){checkCustNameFunc16New(this,0,0)}">
		  </td>
	</tr>

	

	<tr id="tr_old_custaddr" style="display:none;">
		  <td class="blue"  width="15%">�ͻ���ַ</td>
		  <td>
			    <span id="old_custaddr"></span>
		  </td>
	</tr>
	<tr id="tr_new_custaddr" style="display:none;">
	    <td class="blue">�¿ͻ���ַ</td>
		  <td colspan="3">
			    <input  name="new_addr" id="new_addr" value="" size="100"   v_must="1"   v_type="string"   maxlength="30"   />
		  </td>
	</tr>

</table>


<table cellSpacing="0" style="display:">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="�޸�" onclick="go_Cfm()"            />
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