
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
 String flag="";
 String contactId=request.getParameter("contactId");
 String contactMonth=request.getParameter("contactMonth");
 if(contactMonth.equals("")||contactMonth==null){
		//取得系统当前的年月
		  String date[]=new String[6];    
      Calendar calendar = Calendar.getInstance();
      int year = calendar.get(Calendar.YEAR);
      int month = calendar.get((Calendar.MONTH))+1; 
      String _month = month<=9 ? "0"+month : ""+month;
      contactMonth=year+_month;
		}
	String kfWorkNum=request.getParameter("kfWorkNum");
 flag =request.getParameter("flag");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<title>无标题文档</title>
<script type="text/javascript" src="/njs/extend/prototype/prototype.js"></script>	
<script type="text/javascript" src="/njs/si/core_sitech_pack_new.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script language=javascript>
 var contactId='<%=contactId%>';
 var contactMonth ='<%=contactMonth%>';
 var kfWorkNum ='<%=kfWorkNum%>';
 var flag='<%=flag%>';
 showCurrent();
 function showCurrent(){
  if(flag==1){
   
   	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/k170/k170_historyData.jsp","正在查询,请稍后...");
   	packet.data.add("contactId", contactId);
	 	packet.data.add("contactMonth",contactMonth);
	 	packet.data.add("kfWorkNum",kfWorkNum);
	 	core.ajax.sendPacket(packet,doShowCurrent,true);
   	packet =null;
  	
  }
  else{
  	if(contactId!=null&&contactId!=''){
  		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/k170/k170_currentData.jsp","正在查询,请稍后...");
  		packet.data.add("contactId", contactId);
			packet.data.add("contactMonth",contactMonth);
			core.ajax.sendPacket(packet,doShowCurrent,true);
  		packet =null;
  	}
  }
  
 }
 function doShowCurrent(packet){
  
  var contact=packet.data.findValueByName("contact"); 
  var tempid="";
  for(var i=0;i<contact.length;i++){
   var tableid= document.getElementById("dataTable");
   var tr=tableid.insertRow();
   tr.insertCell().innerHTML= "<img style='cursor:hand' onclick=checkCallListen('"+contact[i][0]+"');return false; alt='听取语音' src='<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif' width='16' height='16' align='absmiddle'>";
   tr.insertCell().innerHTML="<a href='#' value='"+contact[i][0]+"' onclick='saveCause(this.value);'>"+contact[i][0]+"</a>";	
   for(var j=1;j<4;j++){
      //增加表格
      tr.insertCell().innerHTML="<a href='#' value='"+contact[i][j]+"' id='"+contact[i][0]+"' onclick='saveCause(this.id);'>"+contact[i][j]+"&nbsp;</a>";	
      //tr.insertCell().innerHTML=contact[i][j];
    }
    }
 }
 function saveCause(contactId){   
 //alert("contactId"+contactId)
parent.parent.document.getElementById("treeId").style.display="";
parent.parent.document.getElementById("causeId").style.display="none"; 
parent.parent.document.getElementById("contactId").value= contactId;
parent.parent.document.getElementById("contactMonth").value=contactMonth;
Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?strFlag=9"+"&contactId="+contactId+"&contactMonth="+contactMonth,"myFrame2");
parent.parent.unCheckBoxs();
 }
 
 //听取录音 by libin 2009-05-14
 function checkCallListen(id){
	if(id==''){
		return;
	}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("contact_id",id);
	core.ajax.sendPacket(packet,doProcessGetPath,true);
	packet=null;
}
function doProcessGetPath(packet){
   var file_path = packet.data.findValueByName("file_path");
   var flag = packet.data.findValueByName("flag");
   var contact_id = packet.data.findValueByName("contact_id");
   if(flag=='Y'){
   	doLisenRecord(file_path,contact_id);
   }else{
   	getCallListen(contact_id)	;
   }
}
 function doLisenRecord(filepath,contact_id)
{
	parent.parent.window.opener.top.document.getElementById("recordfile").value=filepath;
  parent.parent.window.opener.top.document.getElementById("lisenContactId").value=contact_id;
  parent.parent.window.opener.top.document.getElementById("K042").click();
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K042/lisenRecord.jsp","正在处理,请稍后...");
	packet.data.add("retType" , "chkExample");
	packet.data.add("filepath" , filepath);
	packet.data.add("liscontactId" ,contact_id);
	core.ajax.sendPacket(packet,doProcessNavcomring,true);
  packet =null;
}

function doProcessNavcomring(packet)
{
	 var retType = packet.data.findValueByName("retType");
	 var retCode = packet.data.findValueByName("retCode");
	 var retMsg = packet.data.findValueByName("retMsg");
	 if(retType=="chkExample"){
	 	if(retCode=="000000"){
	 		//alert("处理成功!");
	 	}else{
	 		//alert("处理失败!");
	 		return false;
	 	}
	 }
}

function getCallListen(id){
	if(id==''){
		return;
	}
 openWinMid("k170_getCallListen.jsp?flag_id="+id,'录音听取',650,850);
}

function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2;
  var iLeft = (window.screen.availWidth-10-iWidth)/2;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
</script>
</head>
 
<body>
<div id="Operation_Table">
	<table  width="100%" height="200px" border="0" cellpadding="0" cellspacing="0">
		<tr>
	  	<td valign="top">
  			<table id="dataTable" cellspacing="0">
 	 				<tr>
 	 					<td align="center">录音</td>
    				<td align="center">流水号</td>
    				<td align="center">受理号码</td>
    				<td align="center">主叫号码</td>
    				<td align="center">受理方式</td>
  				</tr>
  			</table>
  		</td>
	   </tr>
	</table>	
</div>
</body>
</html>
