
<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming 2017.4.13------------------
 �����¹̻���Ʒ���ڵ���������ִ����ⱨ���ĺ�  �������ڱ��
 
 
 -------------------------��̨��Ա��gudd--------------------------------------------
 
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
	
	
<%	
     String sqlStrl ="select * from sgrpcreditctrl where ctrl_flag='1'";
  %> 	
    <wtc:service name="TlsPubSelCrm" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStrl%>" />
		</wtc:service>
		<wtc:array id="resultl" scope="end" />
<SCRIPT language=JavaScript>

$(function(){ 
����$("#myselect").change(function(){
		
    var i =  $('#myselect option:selected').val();
  	var a = $('#myselect option:selected').attr('v_oval');
  		 //alert("01234---"+a);
   		// alert("���="+i);
   		 
 		
   	switch (a) {
   		case '1':
   			 $("#other_value option[value=1]").attr("selected",true);
   		break;
   		case '2':
   			 $("#other_value option[value=2]").attr("selected",true);
   		break;
   		case '3':
   			 $("#other_value option[value=3]").attr("selected",true);
   		break;
   		default:
   			$("#other_value option[value=0]").attr("selected",true);
   	}
   
		});
}); 


function go_Cfm(){
		var other_value = $("#other_value option:selected").text();
 		//alert(other_value);
 		var external_code = $('#myselect option:selected').attr('v_code');
 		//alert("v_code---"+external_code);
    var packet = new AJAXPacket("fm469_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("other_value",other_value);// �����˻�
         packet.data.add("external_code",external_code);// Ʒ�Ʊ���
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
    
      reSetThis();//ǿ������
}

function do_Cfm(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ

	 if(code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(code+":"+msg);
	    return;
    }else{//�����ɹ�
	    rdShowMessageDialog("�����ɹ�",2);
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
	    <td class="blue" width="15%">Ʒ��</td>
			<td width="15%">
		  	<select id="myselect" name="myselect" style = "width:180px;" >
				   	<option >��ѡ��</option>
				   	<% 
				   	if(resultl.length>0){
				   		for(int i=0;i<resultl.length;i++){
				   	%>
				    <option v_oval='<%=resultl[i][7]%>' v_code='<%=resultl[i][0]%>'  value=<%=i+1%>><%=resultl[i][6]%></option>
				    <%
							}	
							}	    	
				    %>
				    
				</select>
		  </td>
		 	<td>
			    <select  id="other_value">
			    	<option value="0" selected>0</option>	
			    	<option value="1">1</option>	
			    	<option value="2">2</option>	
			    	<option value="3">3</option>	
			    
			    </select>
		  </td>
	</tr>
	<tr>
</table>

<table cellSpacing="0">
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