<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "171";
	String opName = "来话应答填写来电原因";
	String contactId =request.getParameter("contactId");
	 // String contactId="111120081100000000000630";
	 //String contactId="111120081100000000000781";
	String contactMonth =request.getParameter("contactMonth");
	String kfWorkNum=request.getParameter("kfWorkNum");
	 // String contactMonth = "200811";
	//System.out.println("contactId___1111111:\t"+contactId);

%>
<html>
<head>
<title>来话应答填写来电原因</title>

<script language=javascript>
var flag=window.opener.flag;
var initTag=0;
function win(){

//alert(document.form1.treeValue.value);
//window.opener.document.getElementById("call_cause_id").value=document.form1.node_Id.value;
window.close();
}
function unCheckBoxs(){
	myFrame2.window.unCheckBoxBySelect();
	myFrame3.window.unCheckBoxBySelect();
	//清空显示框
	//modify by fangyuan 20090228
	//document.form1.node_Id.value="";
	//document.form1.node_Name.value="";
	document.getElementById("node_Id").value="";
	document.getElementById("node_Name").value="";
	//end
	document.getElementById("show_Name").innerHTML=""; 
	}
function returnFlag(str){
	if(str=="000000"){
		//alert('更新成功');
		  flag=1;
		 window.opener.flag=flag;
		 var strFlag=document.frames["myFrame2"].form2.strFlag.value;
		 //modify by fangyuan 20090228
		 //var strNodeId=document.form1.node_Id.value;
		 var strNodeId=document.getElementById("node_Id").value;
		 //end
		 var remarkInfo= document.getElementById("remarkInfo").value;
		 if(strNodeId!=''||remarkInfo!=''){
		    rdShowMessageDialog('填写来电原因成功',2);
		  }   
		}else{
		rdShowMessageDialog('填写来电原因失败',0);
		}
		initTag=2;
		window.close();
	}
	//触发关闭窗口事建，保存数据
	window.onbeforeunload =   function()     
 { 
    if(initTag!=2){
         saveTreeData();
         }
 } 
function saveTreeData(){
  var remarkInfo;
  var Frame3bolen;
  var strFlag=document.frames["myFrame2"].form2.strFlag.value;
  //modify by fangyuan 20090228
  //var strNodeId=document.form1.node_Id.value;
   
  //var strNodeName=document.form1.node_Name.value;
  var strNodeId=document.getElementById("node_Id").value;
  var strNodeName=document.getElementById("node_Name").value;
  //end
  //alert("strNodeName"+strNodeName);
  remarkInfo= document.getElementById("remarkInfo").value; 
  
  if(remarkInfo=='' ||remarkInfo==undefined){
     remarkInfo="";
  } 
		 try
		{
			Frame3bolen=myFrame3.window.isCheckBoxsList();
		}
		catch(e){ 
			Frame3bolen=false;
		}
	if(Frame3bolen==true){
  var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_insertCause.jsp","aa");
	mypacket.data.add("strNodeId",strNodeId);
	mypacket.data.add("strNodeName",strNodeName);
	mypacket.data.add("remarkInfo",remarkInfo);
	if(strFlag==9){
	 var ContactId=document.frames["myFrame2"].form2.contactId.value;
	 var contactMonth=document.frames["myFrame2"].form2.contactMonth.value;
	 mypacket.data.add("strContactId",ContactId);
	 mypacket.data.add("contactMonth",contactMonth);
	}
	else{
	mypacket.data.add("strContactId","<%=contactId%>");
	mypacket.data.add("contactMonth","<%=contactMonth%>");
	}
  core.ajax.sendPacket(mypacket,doProcessGetFlag,false);
	mypacket=null;
		}else{
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_insertCause.jsp","aa");
	mypacket.data.add("strNodeId",strNodeId);
	mypacket.data.add("strNodeName",strNodeName);
	mypacket.data.add("remarkInfo",remarkInfo);
	if(strFlag==9){
	 var ContactId=document.frames["myFrame2"].form2.contactId.value;
	 var contactMonth=document.frames["myFrame2"].form2.contactMonth.value;
	 mypacket.data.add("strContactId",ContactId);
	 mypacket.data.add("contactMonth",contactMonth);
	}
	else{
	mypacket.data.add("strContactId","<%=contactId%>");
	mypacket.data.add("contactMonth","<%=contactMonth%>");
	}
  core.ajax.sendPacket(mypacket,doProcessGetFlag,false);
	mypacket=null;
			//rdShowMessageDialog('来电原因暂时为空',1);
			}
	}
	//saveTreeData的回调函数
	function doProcessGetFlag(packet){
   var str = packet.data.findValueByName("retCode");
   returnFlag(str);
} 
function selectNodeInfo()
{   var selectName = document.getElementById("selectName").value;
  if(document.getElementById("treeId").style.display=='none'){
     document.getElementById("treeId").style.display="";
     document.getElementById("causeId").style.display="none";
     if(selectName!=""){
      Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseNewTree.jsp?caption="+selectName,"myFrame2");
     }
   }
   else{
    if(selectName=="")
    {
    Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree.jsp?","myFrame2");
 	  document.frames["myFrame3"].src="";
     }
   else{
   Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseNewTree.jsp?caption="+selectName,"myFrame2");
   }
  }
}
function initJsp()
{
  if(document.getElementById("treeId").style.display=='none'){
  document.getElementById("treeId").style.display="";
  document.getElementById("causeId").style.display="none";
  }
  else{
  document.getElementById("selectName").value="";
  Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree.jsp?","myFrame2");
  }
}
function notCause(){
    document.getElementById("treeId").style.display="none";
    document.getElementById("causeId").style.display="";
    Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_notSaveCause.jsp?","myFrame4");
  
}
function otherInfo(){
   document.getElementById("callCauseShow").style.display="none";
   document.getElementById("writeInfoShow").style.display="";
   
}
function treeInfo(){
  document.getElementById("writeInfoShow").style.display="none";
  document.getElementById("callCauseShow").style.display=""; 
}
function showCheckBox(){
 alert("aa");
}

</script>
</head>
<body>
<div id="Operation_Table"> 
  <div class="title"  id="testName" >来话应答填写来电原因</div>
	  <table id="sQryCnttOnlyTable" >
	    <tr>
	        <input type="hidden" name="contactId" id="contactId" value="<%=contactId%>">
				  <input type="hidden" name="contactMonth" id="contactMonth" value="<%=contactMonth%>">
				  <input type="hidden" name="kfWorkNum" id="kfWorkNum" value="<%=kfWorkNum%>">
	       	<td  colspan="3" class="blue">查询条件
    			<input  id="selectName" name="selectName" type="text" value="" onkeydown="if(event.keyCode==13)selectNodeInfo()">
    			<input id="select" name="select" type="button" class="b_text" value="搜索" onClick="selectNodeInfo()">
    			<input id="init" name="init" type="button" class="b_text" value="还原" onClick="initJsp()">
    			<input id="initCause" name="initCause" type="button" class="b_text" value="未保存来话" onClick="notCause()"></td>
	    </tr>
	  	<tr id="treeId" >
	  		<td width="40%"> 
	  			<iframe  name="myFrame2" src="k172_callCauseBaseTree.jsp?" frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>	  			
	  		</td>
	  		 
         <td>
	  			<iframe  name="myFrame3"  frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>		  			
	  		</td>
	  	</tr>
	  	<tr id="causeId" style="display:none">
          <td>
	  			<iframe  name="myFrame4"  frameborder="0" width="110%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>		  			
	  		  </td>
	  	</tr>	
		</table>
	</div>
	<div id="Operation_Table">
<table id="sQryCnttOnlyTable">
			<tr>
				<td width="2%">				
					<input class="title"  id="sQryCnttInfoDiv" type="button" wrap="VIRTUAL" value="已选择项目(最多10个)" onClick="treeInfo()">
				</td>	
				<td align="left"><input name="search" type="button"   class="b_text"  id="search" value="备注" onClick="otherInfo();return false;"><input name="search" type="button"   class="b_text"  id="search" value="关闭" onClick="window.close();return false;"><input name="search" type="button"   class="b_text"  id="save" value="保存" onClick="saveTreeData();return false;"><input name="search" type="button"   class="b_text"  id="search" value="取消" onClick="unCheckBoxs();return false;">
				</td>
			</tr>	
			<tr id="callCauseShow">
				<td colspan="2" >
					<div  id="show_Name" align="left" onclick="showCheckBox()"></div>
					<!--<select id="show_Name" name="show_Name" style="width:500"  style="height:100"  multiple="true"  onDblClick ="right()">
          </select>-->
					<input type="hidden" name="node_Id" id="node_Id" value="">
				  <input type="hidden" name="node_Name" id="node_Name" value="">					  
				</td>	
			</tr>	
			<tr id="writeInfoShow" style="display:none">
			 <td colspan="2">
			 <textarea name="remarkInfo" cols="65%" rows="5" value=""></textarea> 
     </td>        
    </tr>
		</table>
</body>
</html>