
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
  String opCode ="";
  
  String opName ="";

%>
<html>
<head>
<title>��Ajaxʾ��</title>

 
<script language="javaScript">
	 
	 function doProcess(packet)	 
	 {
	 	
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		alert("���������֤�ɹ�!");
	    	}else{
	    		alert("���������֤ʧ��!");
	    		return false;
	    	}
	    }
	 }
	 
   function doCheck()
	 {     
        var phone_no = document.form1.phone_no.value;
        var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/chkExample.jsp","����У��������,���Ժ�...");
        chkPacket.data.add("retType" ,  "chkExample");
        chkPacket.data.add("phone_no" ,   phone_no );
        core.ajax.sendPacket(chkPacket);
		chkPacket =null;
	}
	
		function getQuickNavData()
	{
	    var packet = new AJAXPacket("getQuickNavData.jsp","���Ժ�...");
	    core.ajax.sendPacket(packet,doProcessNav,true);
			packet =null;
	}
	
</script>
</head>
<body>
<form name="form1">
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">��Ajaxʾ��</div>

   <table>
   	<tr>	
				<td class="blue"������룺</td>
				<td class="blue">			
						<input type="text" name="phone_no" v_type="mobphone" id="phone_no" v_must="1"  maxlength="11" > 	
					 	<input name="ChkPwdBtn" type="button" class="b_text" onClick="doCheck()"  value="��֤">
           	<font class="orange">*</font>
				</td>
			</tr>
   </table>
   <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
