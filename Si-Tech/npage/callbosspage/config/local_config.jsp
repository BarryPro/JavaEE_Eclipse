<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ����ϵͳ����
�� * �汾: 1.0.0
�� * ����: 2008/10/16
�� * ����: tancf
�� * ��Ȩ: sitech
	 *update:  yinzx 0715 �ͷ����� 1.���ӹ淶���޸���ʽ
	 *														 2.����ͷ����icdCfgObject ��Ҫ���أ��ͷų�����ʾһ��Ȧ ��֪��Ϊʲô
��*/
%>
<%
	String opCode = "K081";
	String opName = "����ϵͳ����";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
<div style="display:none"> 
<OBJECT id='icdCfgObject' classid="CLSID:7F3929A0-C455-43EC-ACF0-8B1AD46873DC"
 codebase="/ocx/localId.cab#version=1,0,0,0"
	  width=20
	  height=20
	  align=center
	  hspace=0
	  vspace=0>
</OBJECT>
</div>  
<html>
<head>
<title>����ϵͳ����</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/CCcommonTool.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/sitechcallcenter.js"></script>
<script>

/*�ύ������Ϣ*/
function submitConfig(){
  var macAdds="";
	var agentIp = document.getElementById("agent_ip").value;
	var mainCCSIp = document.getElementById("mainccsip").value;
	var mainCCSIp2 = document.getElementById("mainccsip2").value;
	var CCSId = document.getElementById("ccsid").value;
	var agentType = document.getElementById("agentType").value;
	//var callinnerflag = document.getElementById("callinnerflag").value;
	//var callerNo =document.getElementById("callerno").value;
	if(agentIp=='')
	{
	//alert("IP��ַ����Ϊ��");
	rdShowMessageDialog("IP��ַ����Ϊ��!",1);
	document.getElementById("agent_ip").focus();
   return;
	}
	if(mainCCSIp=='')
	{
	//alert("����CCS��IP��ַ����Ϊ��");
	rdShowMessageDialog("����CCS��IP��ַ����Ϊ��!",1);
	document.getElementById("mainccsip").focus();
	return;
	}
	var patrn =/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
	if(!patrn.exec(mainCCSIp))
	{
   //alert("������Ҫ���ҵ�IP��ʽ����ȷ");
   rdShowMessageDialog("�������IP��ʽ����ȷ!",1);
   document.getElementById("mainccsip").focus();
	 return;
   }    
   if(mainCCSIp2=='')
   {
    //alert("����CCS��IP��ַ����Ϊ��");
    rdShowMessageDialog("����CCS��IP��ַ����Ϊ��!",1);
	  document.getElementById("mainCCSIp2").focus();
	  return;
   }
   if(!patrn.exec(mainCCSIp2))
	{
   //alert("������Ҫ���ҵ�IP��ʽ����ȷ");
   rdShowMessageDialog("�������IP��ʽ����ȷ!",1);
   document.getElementById("mainCCSIp2").focus();
	 return;
   }   
	if(CCSId=='')
	{
	//alert("����������ID����Ϊ��");
	rdShowMessageDialog("����������ID����Ϊ��!",1);
	document.getElementById("ccsid").focus();
	return;
	}		
	if(rdShowConfirmDialog("���Ҫ������?")==1){
	updateLocalCfg(macAdds);
	}
}

function deleteClose(){
document.getElementById("mainccsip").value='';
document.getElementById("mainccsip2").value='';  
}

/*�Է���ֵ���д���*/
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var agentIp = packet.data.findValueByName("agentIp");
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="chkExample"){
		if(retCode=="000000"){
		  icdCfgObject.writeLocalIp(agentIp);
			rdShowMessageDialog("�ɹ����±���������Ϣ!",1);
		}else{
			rdShowMessageDialog("�޷����±���������Ϣ!",1);
			return false;
		}
	}
}


/*�Է���ֵ���д���*/
function doProcessSelect(packet)
{
	//var retType = packet.data.findValueByName("retType");
	//var retCode = packet.data.findValueByName("retCode"); 
	//var retMsg = packet.data.findValueByName("retMsg");
	var agent_ip = document.getElementById("agent_ip").value;
	var mainccsip = packet.data.findValueByName("mainccsip");
	document.getElementById("mainccsip").value=mainccsip;
	var ccsid =packet.data.findValueByName("ccsid");
	if(ccsid=='' ||ccsid==null){
	   ccsid='22';
	}
	document.getElementById("ccsid").value=ccsid;
	var mainccsip2 = packet.data.findValueByName("mainccsip2");
	document.getElementById("mainccsip2").value=mainccsip2;
	//var create_time = packet.data.findValueByName("create_time");
	var agenttype = packet.data.findValueByName("agenttype");
	var typeone=document.getElementById("agentType");
	if(agenttype!=""){
		
	 for(var j=0;j<typeone.length;j++)
	 {
	 if (agenttype == typeone[j].value) { 
		typeone[j].selected = true; 
		break; 
		} 	
	 }
	}
	else
		{
		typeone[0].selected = true; 	
		}
	//var callerno = packet.data.findValueByName("callerno");
	// document.getElementById("callerno").value=callerno;
	
		if(mainccsip!=''){ 
			rdShowMessageDialog("�ɹ���ȡ����������Ϣ!",1);
		}else{
			rdShowMessageDialog("û��������Ϣ!",1);
			return false;
		}
}

/*��ӻ����޸ı���������Ϣ*/	
function updateLocalCfg(macAdds)
{   
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/local_config_update.jsp","���ڻ�ȡ����������Ϣ,���Ժ�...");
    chkPacket.data.add("retType", "chkExample");
    chkPacket.data.add("agent_ip", document.getElementById("agent_ip").value);
    chkPacket.data.add("mainccsip", document.getElementById("mainccsip").value);
    chkPacket.data.add("ccsid", document.getElementById("ccsid").value);
    chkPacket.data.add("mainccsip2", document.getElementById("mainccsip2").value);
    chkPacket.data.add("agenttype", document.getElementById("agentType").value);
    chkPacket.data.add("callerno", '');
    core.ajax.sendPacket(chkPacket,doProcess,true);
	  chkPacket =null;
}		
function getLocale()
{
		var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/public/selectCCSInfo.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
    chkPacket.data.add("localIp", document.getElementById("agent_ip").value);
    core.ajax.sendPacket(chkPacket,doProcessSelect,true);
	  chkPacket =null;
}
</script>
</head>
<body>
<form  name=formbar>
<%@ include file="/npage/include/header.jsp" %>

    <div class="title"><div id="title_zi">����ϵͳ��������</div></div>
    <%--����ϵͳ���ñ��Begin{--%>
    <table cellpadding="0">
      <tr>
         <td  class="Blue">IP��ַ</td>
         <td>
         	<select id="agent_ip" onchange="getLocale();"></select>
         </td>
        <td  class="Blue">����CCS��IP��ַ</td>
        <td> 
        <input id="mainccsip"  maxlength="15" index="27"  v_must=1 v_maxlength=15 v_type="text" size="15"><font class="orange">&nbsp;&nbsp;*</font>
        </td>
        <td class="Blue">����CCS��IP��ַ</td>
        <td> 
          <input id="mainccsip2" maxlength="15" index="27"  v_must=1 v_maxlength=8 v_type="date" size="15"><font class="orange">&nbsp;&nbsp;*</font>
        </td>        
      </tr>
       <tr>
         <td class="Blue">����������ID</td>
         <td> 
         <input id="ccsid" value="22"><font class="orange">&nbsp;&nbsp;*</font>
         </td>       	
         <td class="Blue">��ϯ����</td>
         <td colspan="3" > 
          <select id='agenttype'>
         	 <option value="2">��ͨ��ϯ</option>
         	 <option value="4">PC+Phone</option>
          </select>
          
         </td>
          
         <!-- 20090310 fangyuan ȡ���ڲ����� option
         <td class="blue"><!--�ֻ���->�Ƿ�����ڲ�����</td>
         <td> -->
         	<!-- 
         <input id="callerno" maxlength=13 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
         -->
         <!-- 20090310 fangyuan ȡ���ڲ����� option
         <select id='callinnerflag'>
         	 <option value="1">��</option>
         	 <option value="0">��</option>
        </select>
         
         </td>     20090310 fangyuan ȡ���ڲ����� option  end -->           
       </tr>
       
    </table>
       
    <%--����ϵͳ���ñ��End}--%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td id="footer"  align=center> 
        <input class="b_foot" name="submit" type="button" value="ȷ��" onclick="submitConfig()">
        <input type="reset" name="Reset" value="Reset" style="display:none">
    </td>
   </tr>  

    </table>
    
    <!--���±��滻-->
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
  <SCRIPT >
 var locator = document.getElementById("locator");
 var varMacObject = document.getElementById("varMacObject");
 //var service = locator.ConnectServer();
 //service.Security_.ImpersonationLevel=3;
 //service.InstancesOfAsync(varMacObject, 'Win32_NetworkAdapterConfiguration');
 var flag=0;
 
//��ȡip
 onInit();
 function onInit(){
 var selectMac = document.getElementById("agent_ip");
 var localIp=icdCfgObject.ownerIp();
 var arr =localIp.split("|");
 for(var i=0;i<arr.length-1;i++){
 selectMac.options.add(new Option(arr[i],arr[i]));
 if(i==0){
   getLocale();
 }
 }
 }
</script>



