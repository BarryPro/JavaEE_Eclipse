<%
   /*
   * ����: ����ʧ��ԭ��
   * �汾: 1.0.0
   * ����: 
   * ����: 
   * ��Ȩ: sitech
   * update: liujied 0716 �ͷ�����  
   * 1.��ҳ������Ϊ����ʧ��ԭ��
   * 2.����ʽ�淶
   * 3.�����֤�������͹���
   * 4.��û����֤ʱ,�޷��ύ����(�û�),ֻ��ͨ����֤
   *   �ſ����ύ����
   * 5.ÿ���������������������һһ��Ӧ�Ĺ�ϵ���û��޷��������ݿ������еĴ�������
   */	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<html>
<head>
<title>����ʧ��ԭ��</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

</head>
<body>


<form name="formbar" method="post" action="insertList.jsp" target="frameright">
<div id="Operation_Table">
		<div class="title"><div id="title_zi">����ʧ��ԭ��</div></div>
		<table>
		  <tr>
  		    <td class="blue">��������</td>
  		    <td width="70%">
  		      <input id="code" name="code" size="20" maxlength="6" type="text" value="">
                        <input class = "b_text" name ="check" type="button" id="check" onclick="submitErrorKindCheck()" size='5' maxlength='5' value="��֤">
	  	      </td>
		    </tr>
		  <tr>
  				<td class="blue">��������</td>
  				<td width="70%">
                                  <input id="name" name="name" size="20" type="text" maxlength="40"  value="">
	  			  </td>
			        </tr>
		  
		  <tr >
  		    <td colspan="2" align="center" id="footer">
   		      <input name="btn_internalcall" type="button" class="b_text" id="btn_internalcall" value="�ύ" onClick="submitInputCheck()" disabled=true>
   			<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   			  <input name="close" type="button" class="b_text" id="close" value="ȡ��" onClick="closeWin()">
  			  </td>
			</tr>
		      </table>
	            </div>
                  </form>
                  </body>
                    </html>

<script>

//���ݲ���
function callSwich()
{
  var packet = new AJAXPacket("../../../npage/callbosspage/failReason/insert.jsp",
                              "���ڴ���,���Ժ�...");
  packet.data.add("code",window.formbar.code.value);
  packet.data.add("name",window.formbar.name.value);
  core.ajax.sendPacket(packet,doProcessNavcomring,false);
  packet =null;
}  
  //��������ص�
function doProcessNavcomring(packet)	 
	 {
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    	if(retCode=="000000"){
	    		rdShowMessageDialog("����ɹ�!",'2');
          window.opener.location.href=window.opener.location.href;
          window.close();
	    	}else{
	    		rdShowMessageDialog("����ʧ��!");
	    		return false;
	    	}
	 }

function doProcessChecking(packet)	 
	 {
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    	if(retCode=="000000"){
                     rdShowMessageDialog("��֤�ɹ�!",'2');
                     //ʹ�ύ��ť����
                     document.getElementById("btn_internalcall").disabled=false;
                     
	    	}else{
                     rdShowMessageDialog("��֤ʧ��!");
                     return false;
	    	}
	 }
	 
function submitInputCheck(){
   if( document.formbar.code.value == ""){
    	   showTip(document.formbar.code,"�������Ͳ���Ϊ��"); 
    	   formbar.code.focus(); 	
    	 return false;
    }
    if(isNaN(document.formbar.code.value)){
    		showTip(document.formbar.code,"��������ֻ��������"); 
    	   formbar.code.focus(); 	
    	   return false;
    	}
     if(document.formbar.name.value == ""){
		     showTip(document.formbar.name,"�������Ʋ���Ϊ��"); 
    	   formbar.name.focus(); 	
    	   return false;
    }


callSwich();
    	
}

function submitErrorKindCheck(){
   if( document.formbar.code.value == ""){
    	   showTip(document.formbar.code,"�������Ͳ���Ϊ��"); 
    	   formbar.code.focus(); 	
    	 return false;
    }
    if(isNaN(document.formbar.code.value)){
    		showTip(document.formbar.code,"��������ֻ��������"); 
    	   formbar.code.focus(); 	
    	   return false;
    	}
ErrorKindSend();
}

function ErrorKindSend()
{
  
  var packet = new AJAXPacket("check.jsp", "������֤,���Ժ�...");
  packet.data.add("check",window.formbar.code.value);
 
  core.ajax.sendPacket(packet,doProcessChecking,false);
 
  packet =null;
}
function closeWin()
{
  window.close();
}

// �������¼
function cleanValue(){
document.getElementById("code").value="";	
document.getElementById("name").value="";	

}

</script>






