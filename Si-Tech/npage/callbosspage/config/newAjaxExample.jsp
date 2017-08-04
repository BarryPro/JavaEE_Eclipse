
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
  String opCode ="";
  
  String opName ="";

%>
<html>
<head>
<title>新Ajax示例</title>

 
<script language="javaScript">
	 
	 function doProcess(packet)	 
	 {
	 	
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		alert("服务号码验证成功!");
	    	}else{
	    		alert("服务号码验证失败!");
	    		return false;
	    	}
	    }
	 }
	 
   function doCheck()
	 {     
        var phone_no = document.form1.phone_no.value;
        var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/chkExample.jsp","正在校验服务号码,请稍后...");
        chkPacket.data.add("retType" ,  "chkExample");
        chkPacket.data.add("phone_no" ,   phone_no );
        core.ajax.sendPacket(chkPacket);
		chkPacket =null;
	}
	
		function getQuickNavData()
	{
	    var packet = new AJAXPacket("getQuickNavData.jsp","请稍后...");
	    core.ajax.sendPacket(packet,doProcessNav,true);
			packet =null;
	}
	
</script>
</head>
<body>
<form name="form1">
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">新Ajax示例</div>

   <table>
   	<tr>	
				<td class="blue"服务号码：</td>
				<td class="blue">			
						<input type="text" name="phone_no" v_type="mobphone" id="phone_no" v_must="1"  maxlength="11" > 	
					 	<input name="ChkPwdBtn" type="button" class="b_text" onClick="doCheck()"  value="验证">
           	<font class="orange">*</font>
				</td>
			</tr>
   </table>
   <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
