<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-9-21 13:41:06------------------
 �������롰 �ƶ�����ͨ����Ʒ����ר���Ŀ����մ�������ĺ���9��19-9��30��
 
 
 -------------------------��̨��Ա��xiahk--------------------------------------------
 
********************/
%>
              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>



<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
    
  String regionCode = (String)session.getAttribute("regCode"); 
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
	
<script language=javascript>


function go_check_simType10073(){
	    var packet = new AJAXPacket("/npage/s1170/ajax_check_simType10073.jsp","���Ժ�...");
        	packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
        	packet.data.add("opCode","<%=opCode%>");//
    core.ajax.sendPacket(packet,do_check_simType10073);
    packet =null;
}
function do_check_simType10073(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
    }else{//�����ɹ�
	    var offer_flag = packet.data.findValueByName("offer_flag");	
	    if(offer_flag=="1"){
	    	rdShowMessageDialog("�Ѿ��γɶ�����ϵ�����ܳ���");
	    	removeCurrentTab();
	    }
    }
}


 
 function go_Qry_CustInfo(){

    if($("#loginAccept").val().trim()==""){
        rdShowMessageDialog("��������ˮ�ţ�");
        return;
    }
    if($("#billDate").val().trim()=="") {
        rdShowMessageDialog("���������ڣ�");
        return;
    }
    
			var packet = new AJAXPacket("fm405_Qry_CustInfo.jsp","���Ժ�...");
	        packet.data.add("opCode","<%=opCode%>");//
	        packet.data.add("phoneNo","<%=activePhone%>");//
	        packet.data.add("loginAccept",$("#loginAccept").val().trim());//
	        packet.data.add("billDate",$("#billDate").val().trim());//
			    core.ajax.sendPacket(packet,do_Qry_CustInfo);
			    packet =null;
}
 
 
function do_Qry_CustInfo(packet) {
  	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
    	 var sPubGetOprMsgArr =  packet.data.findValueByName("retArray");
    	 
    		var userId          = sPubGetOprMsgArr[0][0];
				var custName        = sPubGetOprMsgArr[0][1];
				var passWord        = sPubGetOprMsgArr[0][2];
				var asIdtape        = sPubGetOprMsgArr[0][3];
				var asIdname        = sPubGetOprMsgArr[0][4];
				var asIdiccid       = sPubGetOprMsgArr[0][5];
				var smTape          = sPubGetOprMsgArr[0][6];
				var smName          = sPubGetOprMsgArr[0][7];
				var runCode         = sPubGetOprMsgArr[0][8];
				var runName         = sPubGetOprMsgArr[0][9];
				var cardName        = sPubGetOprMsgArr[0][10];
				var blocName        = sPubGetOprMsgArr[0][11];
				var base_No         = sPubGetOprMsgArr[0][12];
				var base_Name       = sPubGetOprMsgArr[0][13];
				var base_Date       = sPubGetOprMsgArr[0][14];
				var oldFee          = sPubGetOprMsgArr[0][15];
				var back_flag       = sPubGetOprMsgArr[0][17];
				var test            = sPubGetOprMsgArr[0][18];
				var test1           = sPubGetOprMsgArr[0][19];
				var test2           = sPubGetOprMsgArr[0][20];
				var test3           = sPubGetOprMsgArr[0][21];
				var VloginAccept    = sPubGetOprMsgArr[0][22];
				var oldsim          = sPubGetOprMsgArr[0][23];
				var newsim          = sPubGetOprMsgArr[0][24];
				
						document.sm450Form.custName.value = custName;
						document.sm450Form.asIdname.value = asIdname;	
						document.sm450Form.asIdiccid.value = asIdiccid;
						document.sm450Form.smName.value = smName;
						document.sm450Form.runName.value = runName;
						document.sm450Form.cardName.value = cardName;
						document.sm450Form.base_No.value = base_No;	
						document.sm450Form.base_Date.value = base_Date;
						document.sm450Form.oldFee.value = oldFee;
						document.all.confirm.disabled=false;
    }
  
}

 
//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


function go_cfm(){
	
 	if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
 	
 	    var packet = new AJAXPacket("fm405_Cfm.jsp","���Ժ�...");
	        packet.data.add("opCode","<%=opCode%>");//
	        packet.data.add("opName","<%=opName%>");//
	        packet.data.add("phoneNo","<%=activePhone%>");//
	        packet.data.add("loginAccept",$("#loginAccept").val().trim());//
	        packet.data.add("billDate",$("#billDate").val().trim());//
	    core.ajax.sendPacket(packet,do_cfm);
	    packet =null;
}

function do_cfm(packet){
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


$(document).ready(function(){
	
	go_check_simType10073();
}); 
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<title><%=opName%></title>
</head>

<body>

<form   name="sm450Form" method="POST"   ">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">ҵ�����</div>
</div>


<table cellspacing="0">

    <tr> 
        <td class=blue nowrap>�û�����</td>
        <td nowrap> 
            <input class=InputGrey readOnly type="text" size="16" name="phoneno" id="phoneno" value="<%=activePhone%>" maxlength=11  index="6"> 
        </td>
        <td class=blue>��ˮ��</td>
        <td>
            <input type="text" size="16" v_type="loginAccept" v_must=1 name="loginAccept" id="loginAccept" index="3">
            <font class="orange">*</font>
        </td>
        <td class=blue>����</td>
        <td>
            <input type="text" size="16" v_type="billDate" v_must=1 name="billDate" id="billDate" maxlength=8 index="3">
            <font class="orange">yyyyMMdd *</font>
            <input class="b_text" type="button"  value="��ѯ" onClick="go_Qry_CustInfo()">
        </td>
    </tr>
    
    
    <tr> 
        <td nowrap class="blue">�û�����</td>
        <td nowrap colspan="5">
            <input class="InputGrey"  type="text" size="16" name="custName" id="custName"  index="6" readonly >
        </td>
        
    </tr>
    <tr> 
        <td nowrap class=blue>֤������</td>
        <td nowrap> 
            <input class="InputGrey"  type="text" size="16" name="asIdname" id="asIdname"  index="8" readonly>
        </td>
        <td nowrap class=blue>֤������</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="asIdiccid" id="asIdiccid" size="16" readonly >
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>����״̬</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="runName" id="runName" size="16" readonly tabindex="0">
        </td>
        <td nowrap class=blue>��ͻ���־</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text" name="cardName" id="cardName" size="16" readonly >
        </td>
    </tr>
    <tr> 
        <td nowrap class="blue">��������</td>
        <td nowrap>  
            <input class="InputGrey" type="text"  name="base_No" id="base_No" size="16" readonly tabindex="0">
        </td>
        <td nowrap class="blue">����ʱ��</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="base_Date" id="base_Date" size="16" readonly tabindex="0">
        </td>
    </tr>
    <tr> 
        <td nowrap class="blue">���úϼ�</td>
        <td nowrap> 
            <input class="InputGrey" type="text"  name="oldFee" id="oldFee" size="16" readonly tabindex="0">
        </td>
        <td nowrap class="blue">�ͻ�Ʒ��</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="smName" id="smName" size="16" readonly tabindex="0">
        </td>
    </tr>
    
    <tr> 
        <td class="blue">��ע</td>
        <td colspan="5"> 
            <input type="text" class="InputGrey" name="remark" id="remark" size="60" readonly maxlength=30>
        </td>
    </tr>
    <tr style="display:none"> 
        <td class="blue">�û���ע</td>
        <td colspan="5"> 
            <input type="text" name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  index="28" maxlength=60> 
        </td>
    </tr>
  </table>
  <table>
    <tr id="footer"> 
        <td colspan="6"> 
            <input class="b_foot" type="button" name="confirm" value="ȷ��"  onClick="go_cfm()" index="26" disabled >
            <input class="b_foot" type="button" name="b_back" value="�ر�"  onClick="removeCurrentTab()" index="28">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 

</html>
