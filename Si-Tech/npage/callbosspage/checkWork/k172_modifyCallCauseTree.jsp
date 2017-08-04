<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "171";
	String opName = "来电原因异动修改主页面";
	String contactId =request.getParameter("contact_id");
	String contactMonth =request.getParameter("contactMonth");
  String nodeIdList=request.getParameter("strnodeid");		
   if(contactMonth!=null){
			contactMonth=contactMonth.substring(0,6);
 		}
  System.out.println("contactId:\t"+contactId);
  System.out.println("nodeIdList:\t"+nodeIdList);
  System.out.println("contactMonth:\t"+contactMonth);
%>
<html>
<head>
<title>来电原因异动修改主页面</title>

<script language=javascript>

function unCheckBoxs(){
	myFrame2.window.unCheckBoxBySelect();
	//清空显示框
	document.form1.node_Id.value="";
	document.form1.node_Name.value="";
	document.getElementById("show_Name").innerHTML=""; 
	}
function returnFlag(str){
	if(str=="000000"){
		//alert('更新成功');
		rdShowMessageDialog('修改来电原因成功',2);
		window.close();
		}else{
	//	alert('更新失败');	
		rdShowMessageDialog('修改来电原因失败',0);
		}
	}
function saveTreeData(){
	var strNodeId=document.form1.node_Id.value;
	var strNodeName=document.form1.node_Name.value;
	var strPreNodeId=document.form1.pre_node_Id.value;
	var strPreNodeName=document.form1.pre_node_Name.value;
	var isbolen=myFrame2.window.isCheckBoxsList();
	if(isbolen==true){
  var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_modifyCallCause.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	mypacket.data.add("strPreNodeId",strPreNodeId);
	mypacket.data.add("strPreNodeName",strPreNodeName);
  mypacket.data.add("strNodeId",strNodeId);
	mypacket.data.add("strNodeName",strNodeName);
	mypacket.data.add("strContactId","<%=contactId%>");
	mypacket.data.add("contactMonth","<%=contactMonth%>");
	///alert(<%=contactId%>);
  core.ajax.sendPacket(mypacket,doProcessGetFlag,true);
	mypacket=null;
		}else{
			 rdShowMessageDialog('请您选择来电原因',1);
			}

	}
	//saveTreeData的回调函数
	function doProcessGetFlag(packet){
   var str = packet.data.findValueByName("retCode");
   returnFlag(str);
} 


</script>
</head>
<body>
<form name="form1" method="POST" action="">	
<div id="Operation_Table"> 
  <div class="title"  id="testName" >来电原因异动修改主页面</div>
	  <table id="sQryCnttOnlyTable" >
	  	<tr>
	  		<td>
	  			<iframe  name="myFrame2" src="k172_modifyCallCauseBaseTree.jsp" frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>	
	  		</td>
	  	</tr>
		</table>
	</div>
	<div id="Operation_Table">
<table id="sQryCnttOnlyTable">
			<tr>
				<td >				
					<div class="title"  id="sQryCnttInfoDiv" align="top">已选择项目(最多10个)</div>
				</td>	
				<td  align="left"  width="70%" ><input name="search" type="button"  id="search" value="关闭" onClick="window.close();return false;"><input name="search" type="button"  id="search" value="保存" onClick="saveTreeData();return false;"><input name="search" type="button"  id="search" value="取消" onClick="unCheckBoxs();return false;">
				</td>
			</tr>	
			<tr>
				<td colspan="2">
					<div  id="show_Name" align="left"></div>
				  <input type="hidden" name="node_Id" id="node_Id" value="<%=nodeIdList%>">
				  <input type="hidden" name="node_Name" id="node_Name" value="">
				  <input type="hidden" name="pre_node_Id" id="pre_node_Id" value="">
				  <input type="hidden" name="pre_node_Name" id="pre_node_Name" value="">
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