<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-8-31 10:19:13------------------
������CRM��������400���̻�����������Բ�ѯ���ܵ�����
 
 
 -------------------------��̨��Ա��xiahk--------------------------------------------
 
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


//��ѯ�ͻ�������Ϣ
function getAjaxInfo(){
    var packet = new AJAXPacket("ajaxGetServRe.jsp","���Ժ�...");
        packet.data.add("servName","sWIflowQry");//��������
        packet.data.add("phone_no",PHONE_NO);//�ֻ���
        packet.data.add("cust_name",$("#cust_name").val());//�ͻ�����
    core.ajax.sendPacket(packet,doGetAjaxInfo);
    packet =null;
}
//��ѯ�ͻ�������Ϣ�ص�
function doGetAjaxInfo(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//���÷���ʧ��
	    var resultArray = packet.data.findValueByName("resultArray");	
    }
}

function show_tab_optype(optype){
	if(0==optype){
		$("#tab_optype_1").show();
		$("#tab_optype_2").hide();
		$("#tab_optype_3").hide();
	}
	if(1==optype){
		$("#tab_optype_1").hide();
		$("#tab_optype_2").show();
		$("#tab_optype_3").hide();
	}
	if(2==optype){
		$("#tab_optype_1").hide();
		$("#tab_optype_2").hide();
		$("#tab_optype_3").show();
	}
}

$(document).ready(function(){
	show_tab_optype(0);
});



function go_cfm(){
	var optype = $("input[name='optype']:checked").val();
	if(optype=="0"){
		if($("#phoneIn").val().trim()==""){
			rdShowMessageDialog("������̻�����");
			return;
		}
	} 
	
	if(optype=="1"){
		if($("#feefile").val().trim()==""){
			rdShowMessageDialog("��ѡ���ļ�");
			return;
		}
	} 
	
	if(optype=="2"){
		if($("#phoneNo_b").val().trim()==""||$("#phoneNo_e").val().trim()==""){
			rdShowMessageDialog("��ʼ���롢���������������");
			return;
		}
		
		if(parseInt($("#phoneNo_b").val().trim())>parseInt($("#phoneNo_e").val().trim())){
			rdShowMessageDialog("��ʼ���벻���ڽ�������");
			return;
		}
		
		if(parseInt($("#phoneNo_e").val().trim())-parseInt($("#phoneNo_b").val().trim())>10000){
			rdShowMessageDialog("���������뿪ʼ�����ֵ���ܳ���10000");
			return;
		}
		
	} 
	
	
	if($("#unit_name").val().trim()==""){
			rdShowMessageDialog("����������ļ�������");
			return;
	}
	
	if(optype=="0"){//����

			document.msgFORM.action  = "fm398_Cfm.jsp?opCode=<%=opCode%>"+
																"&opName=<%=opName%>"+
																"&optype="+optype+
																"&unit_name="+$("#unit_name").val().trim()+
																"&phoneNo_b="+$("#phoneIn").val().trim()+
																"&phoneNo_e="+$("#phoneIn").val().trim()
																;

		
	}	
	if(optype=="1"){//�ļ�
		
				document.msgFORM.action  = "fm398_file_Cfm.jsp?opCode=<%=opCode%>"+
																	"&opName=<%=opName%>"+
																	"&optype="+optype+
																	"&unit_name="+$("#unit_name").val().trim()+
																	"&phoneNo_b="+
																	"&phoneNo_e=";

	}
	if(optype=="2"){//�Ŷ�
		
			document.msgFORM.action  = "fm398_Cfm.jsp?opCode=<%=opCode%>"+
																"&opName=<%=opName%>"+
																"&optype="+optype+
																"&unit_name="+$("#unit_name").val().trim()+
																"&phoneNo_b="+$("#phoneNo_b").val().trim()+
																"&phoneNo_e="+$("#phoneNo_e").val().trim()
																;

	}
	
	//alert(document.msgFORM.action);
	document.msgFORM.submit();
	
	
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM"     method="POST" ENCTYPE = "multipart/form-data"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>


<table cellSpacing="0" >
	<tr>
	    <td class="blue" width="15%">��������</td>
		  <td >
			    <input type="radio" name="optype" id="optype_1" value="0" onclick="show_tab_optype(0)" checked/> ��������¼��
			    <input type="radio" name="optype" id="optype_1" value="1" onclick="show_tab_optype(1)" /> ��������¼��
			    <input type="radio" name="optype" id="optype_1" value="2" onclick="show_tab_optype(2)" /> ���պ����¼��
		  </td>
	</tr>
</table>

<!--��������¼��-->
<table cellSpacing="0" id="tab_optype_1" style="display:none">
	<tr>
	    <td class="blue" width="15%">�̻�����</td>
		  <td  >
			    <input type="text" name="phoneIn" id="phoneIn" value="" maxlength="11"/> 
		  </td>
		 
	</tr>
</table>

<!--��������¼��-->
<table cellSpacing="0" id="tab_optype_2" style="display:none">
	<tr>
		<td colspan="4">
			<font class="orange">
				�ļ�Ϊtxt��ʽ��ÿ��һ�����ݣ����ܳ���500�У������пո�Ϳ��С�<br>
				�̻�����|<br>
				����ʾ�����£�<br>
				4001590459|<br>
				4001057157|<br>
			</font>
		</td>
	</tr>
	<tr>
	    <td class="blue" width="15%">�����ļ�</td>
		  <td  >
			    <input type="file" name="feefile" id="feefile" value="" /> 
		  </td>
	</tr>
		  
</table>

<!--���պ����¼��-->
<table cellSpacing="0" id="tab_optype_3" style="display:none">
	<tr>
	    <td class="blue" width="15%"  >��ʼ����</td>
		  <td width="35%">
			    <input type="text" v_type="int"  onblur = "checkElement(this)" name="phoneNo_b" id="phoneNo_b" value=""   /> 
		  </td>
		  <td class="blue" width="15%"  >��������</td>
		  <td width="35%">
			    <input type="text" v_type="int"  onblur = "checkElement(this)" name="phoneNo_e" id="phoneNo_e" value=""      /> 
		  </td>
	</tr>
	<tr>
		  
 
</table>


<table cellSpacing="0" >
	<tr>
		  <td class="blue" width="15%">�����ļ���</td>
		  <td  >
		  	<input type="text" name="unit_name" id="unit_name"  v_type="string"  onblur = "checkElement(this)"  value="" /> 
		  </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_cfm()"            /> 
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>