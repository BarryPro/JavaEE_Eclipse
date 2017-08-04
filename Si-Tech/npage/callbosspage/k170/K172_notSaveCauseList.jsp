<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
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
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
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
  var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/k170/k170_currentData.jsp","正在查询,请稍后...");
  packet.data.add("contactId", contactId);
	packet.data.add("contactMonth",contactMonth);
	core.ajax.sendPacket(packet,doShowCurrent,true);
  packet =null;
  }
 }
 function doShowCurrent(packet){
  
  var contact=packet.data.findValueByName("contact"); 
  var tempid="";
  for(var i=0;i<contact.length;i++){
   var tableid= document.getElementById("dataTable");
   var tr=tableid.insertRow();
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
Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree.jsp?strFlag=9"+"&contactId="+contactId+"&contactMonth="+contactMonth,"myFrame2");
parent.parent.unCheckBoxs();
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
