<%@ page contentType="text/html; charset=GBK" %>
<%
	String openType = request.getParameter("openType")==null ? "":request.getParameter("openType");
%>

<script language="JavaScript">	
var global4AFlag = "noCheck";
/*�жϹ��ܿ����Ƿ����������Ƿ���main�е�NORMAL���У��*/
function checkBoss4A(opCode){
	var getdataPacket = new AJAXPacket("/npage/public/intf4A/common/checkBoss4A.jsp","����У�����ݣ����Ժ�......");
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
				rdShowMessageDialog("��ѯ4A���ܿ���ʧ�ܣ�",0);
				global4AFlag = "checkError";
				return false;
			}
}

/*����У�鷽��*/
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
			/* ���Լ��������� */
			opFlag = true;
			
		}else{
			/* 4A ������*/
			rdShowMessageDialog("4A��֤ʧ��!");
			opFlag = false;
		}
	}else{
		/*���������رյģ��������������*/
		rdShowMessageDialog("4A��֤ʧ��!");
		opFlag = false;
	}
	return opFlag;
}


</script>