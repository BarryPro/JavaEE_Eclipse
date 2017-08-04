<%@ page contentType="text/html; charset=GBK" %>
<%
	String openType = request.getParameter("openType")==null ? "":request.getParameter("openType");
%>

<script language="JavaScript">	
var global4AFlag = "noCheck";
/*判断功能开关是否开启，或者是否是main中的NORMAL金库校验*/
function checkBoss4A(opCode){
	var getdataPacket = new AJAXPacket("/npage/public/intf4A/common/checkBoss4A.jsp","正在校验数据，请稍候......");
	getdataPacket.data.add("opCode4A",opCode);
	getdataPacket.data.add("openType","<%=openType%>");
	core.ajax.sendPacket(getdataPacket,doRetBoss4A);
	getdataPacket = null;
	
}	

function doRetBoss4A(packet){
			var checkFlag = packet.data.findValueByName("checkFlag");
			var opCode = packet.data.findValueByName("opCode");
			if(checkFlag == "true"){
				global4AFlag = "needCheck";
			}else if(checkFlag == "false"){
				global4AFlag = "noCheck";
			}else{
				rdShowMessageDialog("查询4A功能开关失败！",0);
				global4AFlag = "checkError";
				return false;
			}
}

/*整合校验方法*/
function allCheck4A(opCode){
	var retFlag = false;
	checkBoss4A(opCode);
	if(global4AFlag == "needCheck"){
		if(openBoss4A(opCode)){
			retFlag = true;
		}else{
			retFlag = false;
		}
	}else if(global4AFlag == "noCheck"){
		retFlag = true;
	}
	global4AFlag = "noCheck";
	return retFlag;
}
	
function openBoss4A(opCode)
{
	var opFlag = false;
	var h=600;
	var w=800;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;"
		+"toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var ret=window.showModalDialog("/npage/public/intf4A/client4A/showCheck4AInfo.jsp"
	+"?rnd=<%=java.lang.Math.random()%>"
	+"&opCode="+opCode
	,"",prop);
	if(typeof(ret) != "undefined"){
		if(ret == "Y"){
			/* 可以继续操作了 */
			opFlag = true;
			
		}else{
			/* 4A 不允许*/
			rdShowMessageDialog("4A认证失败!");
			opFlag = false;
		}
	}else{
		/*不是正常关闭的，不允许继续操作*/
		rdShowMessageDialog("4A认证失败!");
		opFlag = false;
	}
	return opFlag;
}


</script>