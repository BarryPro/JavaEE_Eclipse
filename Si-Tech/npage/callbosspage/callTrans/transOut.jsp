



<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>ת���绰</title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<link href="<%=request.getContextPath() %>/nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
	
	<style type="text/css">
	#get_rest_title{
	text-align: left;
	height: 25px;
	width: 100%;
	float: left;
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #FFFFFF;
    }
	</style>	
  </head>
  
  <body>
	<div class="groupItem" id="div1_show">
		<!--<div class="itemHeader"><div id="get_rest_title">���β���</div>-->
	</div>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="blue">
							ת���绰���룺<input type="text" name="secondDial" value="" maxlength="15"/>
						</td>
					</tr>

				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="footer" align=center>
							<input class="b_foot" name="submit1" type="button" value="ȷ��"
								onclick="submitConfig()">
							&nbsp;&nbsp;&nbsp;<input class="b_foot" name="cancel" type="button"
								onclick="goaway();" value="ȡ��">
						</td>
					</tr>
				</table>
</body>
</html>
<script language="javascript">
document.getElementById("secondDial").focus();
function submitConfig(){
	var returnvalue="";
	var phoneNo = document.getElementById("secondDial").value;
	if(phoneNo=="")
	{
	   rdShowMessageDialog("������绰����!",1);
	   document.getElementById("secondDial").focus();
	   return;
	}
	/*else if(!(/[1]{1}\d{10}/.test(document.getElementById("secondDial").value))){	
			rdShowMessageDialog("�绰���벻��ȷ,����������!",1);
			document.getElementById("secondDial").value="";
			document.getElementById("secondDial").focus();
			return false;				
	}	*/
	
	else if(!(/^(\d)+$/.test(phoneNo))){
		rdShowMessageDialog("ֻ����������,����������!",1);
		document.getElementById("secondDial").value="";
		document.getElementById("secondDial").focus();
		return false;
	}else{
		var valid=false;
		var valid1 = /[1]{1}\d{10}/.test(phoneNo);
		var valid2 = /^(0[\d]{2,3})?\d{6,8}$/.test(phoneNo);
		    valid = valid1|valid2;
		if(!valid){
			rdShowMessageDialog("������벻��ȷ,����������!",1);
			document.getElementById("secondDial").value="";
			document.getElementById("secondDial").focus();
			return false;	
		}
	}
	var callerNum = window.opener.cCcommonTool.getCaller();
	var outNum= document.getElementById("secondDial").value;
	var ret= window.opener.cCcommonTool.TransOutEx(outNum,2);
	if(ret==0){
		//ת����Ϣ���
		callSwich(callerNum);
		window.opener.cCcommonTool.setOp_code("K102");
		window.close();
	}
	if(ret==1120){
		window.opener.similarMSNPop("��ǰ�����磬�޷�ת��!"); 
	}
}

function goaway(){
	window.returnValue="cancel";   
	window.close();
}

//ת����Ϣ���
function callSwich(callerNum){
	    var bossId = window.opener.document.getElementById("loginNo").value;
	    var packet = new AJAXPacket("../../../npage/callbosspage/K029/callSwichInsert.jsp","���ڴ���,���Ժ�...");
	    packet.data.add("contactId" ,window.opener.document.getElementById("contactId").value);
	    packet.data.add("retType" ,  "chkExample");
	    packet.data.add("caller" ,  callerNum);
	    packet.data.add("called" ,  document.getElementById("secondDial").value);
	    packet.data.add("transagent" ,bossId);
	    packet.data.add("skillName" ,window.opener.cCcommonTool.getSkillInfoExName());
	    packet.data.add("transType" ,"K102");
	    packet.data.add("is_success" ,"Y");
	    packet.data.add("op_code" ,"K102");
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
	    packet =null;
	}  
  //��������ص�
function doProcessNavcomring(packet)	 
	 {
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("����ɹ�!");
	    		//rdShowMessageDialog("����ɹ�!",1);
	    	}else{
	    		//alert("����ʧ��!");
	    		rdShowMessageDialog("����ʧ��!",0);
	    		return false;
	    	}
	    }
	 }



</script>