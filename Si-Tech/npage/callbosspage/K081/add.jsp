<%
   /*
   * ����: ������������
   * �汾: 1.0.0
   * ����: 20090825
   * ����: yinzx
   * ��Ȩ: sitech
   *
   */	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<html>
<head>
<title>������������</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>



</head>
<body>


<form name="formbar" method="post" action="insertList.jsp" target="frameright">
<div id="Operation_Table">
		<div class="title"><div id="title_zi">������������</div></div>
		<table>
		  <tr>
  		    <td class="blue">IP��ַ��</td>
  		    <td  >
  		      <input id="agent_ip" name="agent_ip" size="15" maxlength="15" type="text" value="">
                       
	  	      </td>
		    </tr>
		  <tr>
  				<td class="blue">����CCS��IP��ַ</td>
  				<td  >
             <input id="mainccsip" name="mainccsip" size="15" maxlength="15" type="text" value="">
	  			  </td>
			        </tr>
		  
		  <tr >
	 
  				<td class="blue">����CCS��IP��ַ</td>
  				<td  >
             <input id="mainccsip2" name="mainccsip2" size="15" maxlength="15" type="text" value="">
	  			  </td>
			        </tr>
		  
 
 
		  	<tr>
  				<td class="blue">����������ID</td>
  				<td  >
             <input id="ccsid" name="ccsid" size="15" maxlength="15" type="text" value="22">
	  			  </td>
			        </tr>
		  	<tr>
		  		<td class="blue">��������ַ</td>
		  		<td>
		  			<select id="serv_addr" name="serv_addr">
		  				<option value="1" selected="true">����</option>
		  				<option value="2">����</option>
		  			</select>
		  		</td>
		  	</tr>
 
		  	<tr>
  				<td class="blue">��ϯ����</td>
  				<td  >
             <select id='agenttype'>
         	 <option value="2">��ͨ��ϯ</option>
         	 <option value="4">PC+Phone</option>
        </select>
	  			  </td>
			        </tr>
		  
		  <tr >
  		    <td colspan="2" align="center" id="footer">
   		      <input name="btn_internalcall" type="button" class="b_text" id="btn_internalcall" value="�ύ" onClick="submitInputCheck()"  >
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

  
  //��������ص�
function doProcess(packet)	 
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


	 
function submitInputCheck(){
 
	 var agentIp = document.getElementById("agent_ip").value;
	 var mainCCSIp = document.getElementById("mainccsip").value;
	 var mainCCSIp2 = document.getElementById("mainccsip2").value;
	 var CCSId = document.getElementById("ccsid").value;
	 var agentType = document.getElementById("agentType").value;
	 
	if(agentIp=='')
	{ 
			rdShowMessageDialog("IP��ַ�β���Ϊ��!",1);
		  document.getElementById("agent_ip").focus();
   	  return;
	}
	if(mainCCSIp=='')
	{
	 
		rdShowMessageDialog("����CCS��IP��ַ����Ϊ��!",1);
		document.getElementById("mainccsip").focus();
		return;
	}
	var patrnx =/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\*$/;
	if(!patrnx.exec(agentIp))
	{
   	rdShowMessageDialog("IP��ַ�θ�ʽ����ȷ! <b> ��ʽΪ��192.168.0.*",1);
   	document.getElementById("agent_ip").focus();
	 	return;
   }   
	
	var patrn =/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
	if(!patrn.exec(mainCCSIp))
	{
   	rdShowMessageDialog("����CCS��IP��ַ��ʽ����ȷ!",1);
   	document.getElementById("mainccsip").focus();
	 	return;
   }    
   if(mainCCSIp2=='')
   {
     
    	rdShowMessageDialog("����CCS��IP��ַ����Ϊ��!",1);
	  	document.getElementById("mainCCSIp2").focus();
	 		return;
   }
   if(!patrn.exec(mainCCSIp2))
	{
   
   	rdShowMessageDialog("����CCS��IP��ַ��ʽ����ȷ!",1);
   	document.getElementById("mainCCSIp2").focus();
	 	return;
   }   
	if(CCSId=='')
	{
	 
		rdShowMessageDialog("����������ID����Ϊ��!",1);
		document.getElementById("ccsid").focus();
		return;
	}	
		
	if(rdShowConfirmDialog("���Ҫ������?")==1){
		updateLocalCfg();
	}
    	
}


 
function closeWin()
{
  window.close();
}

// �������¼
function cleanValue(){
document.getElementById("agent_ip").value="";	
document.getElementById("mainccsip").value="";	
document.getElementById("mainccsip2").value="";	

}


/*��ӻ����޸ı���������Ϣ*/	
function updateLocalCfg()
{   
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K081/update.jsp","���ڻ�ȡ����������Ϣ,���Ժ�...");
    var sql="insert into dcrmcallcfg(mainccsip,mainccsip2,ccsid,agenttype,agent_ip,bak2) values (:v1,:v2,:v3,:v4,:v5,:v6)";
    chkPacket.data.add("sql", sql);
    
    chkPacket.data.add("retType", "chkExample");
    chkPacket.data.add("agent_ip", document.getElementById("agent_ip").value);
    chkPacket.data.add("mainccsip", document.getElementById("mainccsip").value);
    chkPacket.data.add("ccsid", document.getElementById("ccsid").value);
    chkPacket.data.add("mainccsip2", document.getElementById("mainccsip2").value);
    chkPacket.data.add("agenttype", document.getElementById("agentType").value);
    chkPacket.data.add("serv_addr", document.getElementById("serv_addr").value);
    chkPacket.data.add("callerno", '');
    core.ajax.sendPacket(chkPacket,doProcess,true);
	  chkPacket =null;
}
</script>






