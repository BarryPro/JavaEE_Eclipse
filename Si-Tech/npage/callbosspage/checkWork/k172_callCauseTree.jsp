<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "171";
	String opName = "����Ӧ����д����ԭ��";
	String contactId =request.getParameter("contactId");
	String contactMonth =request.getParameter("contactMonth");
	System.out.println("contactId___1111111:\t"+contactId);
%>
<html>
<head>
<title>����Ӧ����д����ԭ��</title>

<script language=javascript>

function win(){

//alert(document.form1.treeValue.value);
//window.opener.document.getElementById("call_cause_id").value=document.form1.node_Id.value;
window.close();
}

function unCheckBoxs(){
myFrame2.window.unCheckBoxBySelect();
	//�����ʾ��
	document.form1.node_Id.value="";
	document.form1.node_Name.value="";
	document.getElementById("show_Name").innerHTML=""; 
}
	
function returnFlag(str){
	if(str=="000000"){
		//alert('���³ɹ�');
		rdShowMessageDialog('��д����ԭ��ɹ�',2);
		}else{
	//	alert('����ʧ��');	
		rdShowMessageDialog('��д����ԭ��ʧ��',0);
		}
}
	
function saveTreeData(){
	var strNodeId=document.form1.node_Id.value;
	var strNodeName=document.form1.node_Name.value;
//	var strContactId='';
//	var strTableName ='';
	var isbolen=myFrame2.window.isCheckBoxsList();
	if(isbolen==true){
  var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_insertCause.jsp","aa");
	mypacket.data.add("strNodeId",strNodeId);
	mypacket.data.add("strNodeName",strNodeName);
	mypacket.data.add("strContactId","<%=contactId%>");
	mypacket.data.add("contactMonth","<%=contactMonth%>");
	///alert(<%=contactId%>);
  core.ajax.sendPacket(mypacket,doProcessGetFlag,true);
	mypacket=null;
		}else{
			 rdShowMessageDialog('����ѡ������ԭ��',1);
			}

	}
	//saveTreeData�Ļص�����
	function doProcessGetFlag(packet){
   var str = packet.data.findValueByName("retCode");
   returnFlag(str);
} 


</script>
</head>
<body>
<form name="form1" method="POST" action="">	
<div id="Operation_Table"> 
  <div class="title"  id="testName" >����Ӧ����д����ԭ��</div>
	  <table id="sQryCnttOnlyTable" >
	  	<tr>
	  		<td>
	  			<iframe  name="myFrame2" src="k172_callCauseBaseTree.jsp" frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>	
	  		</td>
	  	</tr>
		</table>
	</div>
	<div id="Operation_Table">
<table id="sQryCnttOnlyTable">
			<tr>
				<td >				
					<div class="title"  id="sQryCnttInfoDiv" align="top">��ѡ����Ŀ(���10��)</div>
				</td>	
				<td  align="left"  width="70%" ><input name="search" type="button"  id="search" value="�ر�" onClick="window.close();return false;"><input name="search" type="button"  id="search" value="����" onClick="saveTreeData();return false;"><input name="search" type="button"  id="search" value="ȡ��" onClick="unCheckBoxs();return false;">
				</td>
			</tr>	
			<tr>
				<td colspan="2">
					<div  id="show_Name" align="left"></div>
				  <input type="hidden" name="node_Id" id="node_Id" value="">
				  <input type="hidden" name="node_Name" id="node_Name" value="">
				</td>	
			</tr>	
			<tr>
      <td  align="left" colspan="2">&nbsp;           
      </td>
    </tr>
		</table>

  </form>
</body>
</html>