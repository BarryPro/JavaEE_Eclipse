<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2017/2/28 20:21:43]------------------
 ���ڵ����ں��ʷѿ��˿ھ�����ʾ
 
 -------------------------��̨��Ա��[chenlina]--------------------------------------------
 
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

function go_query_unitProId(){
    var packet = new AJAXPacket("fm459_Qry.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("ipt_unitId",$("#ipt_unitId").val());//
        packet.data.add("sel_opType",$("#sel_opType").val());//
    core.ajax.sendPacket(packet,do_query_unitProId);
    packet =null;
}

function do_query_unitProId(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ


    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
      
      $("#div_iVpmnIdNo").hide();
	    $("#upgMainTab tr").remove();
	    
	    return;
	   
    }else{//�����ɹ�
    	
    	$("#div_iVpmnIdNo").show();
    	$("#upgMainTab tr").remove();
    	
    	var iVpmnIdNoVal =  packet.data.findValueByName("iVpmnIdNoVal");//������Ϣ
    	$("#span_iVpmnIdNo").text(iVpmnIdNoVal);
    	var retArray =  packet.data.findValueByName("retArray");
    	
    	
    	
    	var trObjdStr = "";
    	for(var i=0;i<retArray.length;i++){
    		trObjdStr += "<tr>"+
									 		"	<td>"+
									 		"		<input type=\"radio\" name=\"idradio\" value=\""+retArray[i][0]+"\" />"+retArray[i][0]+
									 		"	</td>"+
											"</tr>";
    	}
    	if(trObjdStr!=""){
				$("#upgMainTab").append(trObjdStr);
			}
    }
}


function go_Cfm(){
		
		var iRHIdNoVal = $("#upgMainTab").find("input[type='radio']:checked").val();
		
		if(iRHIdNoVal=="undefined"||typeof(iRHIdNoVal)=="undefined"){
			rdShowMessageDialog("��ѡ��Ҫ����������V����Ʒ");
			return;
		}
    var packet = new AJAXPacket("fm459_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("iVpmnIdNoVal",$("#span_iVpmnIdNo").text().trim());//
        packet.data.add("iRHIdNoVal",iRHIdNoVal);//
        packet.data.add("sel_opType",$("#sel_opType").val());//
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
	    <td class="blue" width="15%">���ű���</td>
		  <td width="35%">
		  	<input type="text" id="ipt_unitId" name="ipt_unitId" v_must="0" v_type="string" value=""   />
		  	<input type="button" class="b_text" value="��ѯ"   onclick="go_query_unitProId()" />
		  </td>
		  
		  <td class="blue" width="15%">��������</td>
		  <td width="35%">
		  	<select id="sel_opType" name="sel_opType" onchange="">
				    <option value="0">��</option>
				    <option value="1">���</option>
				</select>
		  </td>
	</tr>
</table>
<div class="title" id="div_iVpmnIdNo" style="display:none"><div id="title_zi">��������Ʒ��<span id="span_iVpmnIdNo"></span>����Ӧ���ں�ͨ�Ų�ƷID�б�</div></div>
<table cellSpacing="0" id="upgMainTab">
	 	
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