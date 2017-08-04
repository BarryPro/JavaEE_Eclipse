<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=gbk"%>
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
  
%>
<html>
<head>
<title>来电原因异动修改主页面</title>
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" language="javascript" src="/njs/si/base.js"></script>
<SCRIPT type="text/javascript" language=javascript src="/njs/si/ajax.js"></SCRIPT>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<style>
.b_text1{
height:25px;
        border:1px solid #417db3;
        font-size:12px;
        font-weight:bold;
        color:#1E245E;
        background-repeat: repeat-x;
        background-position: left bottom;
        text-align: center;
        background-color: #fcfdff;
        padding-top: 1px;
        cursor: hand;
}
</style>
<script language=javascript>

function unCheckBoxs(){
	myFrame2.window.unCheckBoxBySelect();
	try{
	myFrame3.window.unCheckBoxBySelect();
	}catch(e){
	document.getElementById("node_Id").value="";
	document.getElementById("node_Name").value="";
	document.getElementById("show_Name").value=""; 
	document.getElementById("select_Name").options.length=0;	
	document.getElementById("my_div").innerHTML = "";
	document.getElementById("remarkInfo").innerHTML = "";
	
	}
	//清空显示框

	document.getElementById("node_Id").value="";
	document.getElementById("node_Name").value="";
	document.getElementById("show_Name").value=""; 
	document.getElementById("select_Name").options.length=0;
	document.getElementById("my_div").innerHTML = "";
	document.getElementById("remarkInfo").innerHTML = "";

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
//by xingzhan 20090309 对node_Name进行处理；
function makeNodeName(node_Id,node_Name){
		var strNodeName="";
		try{
				var idarr = node_Id.split(",");
				var namearr = node_Name.split(",");
				for(var i=0;i<idarr.length;i++){
						
						if(idarr[i]!=null&&idarr[i]!=""&&idarr[i]!=undefined){
								
								strNodeName = strNodeName+"<span id="+idarr[i]+" ><"+namearr[i]+"><br></span>";
						}
						
				}
				//alert(strNodeName);
		}catch(e){
		
		}
		return strNodeName;
}
function saveTreeData(){

	var Frame3bolen=true;

	var strNodeId=document.getElementById("node_Id").value;

	//alert("strNodeId"+strNodeId);
  var strNodeName=document.getElementById("node_Name").value;

  //alert("strNodeName"+strNodeName);
  strNodeName = makeNodeName(strNodeId,strNodeName);

	var strPreNodeId=document.getElementById("pre_node_Id").value;

	//alert("strPreNodeId"+strPreNodeId);
	var strPreNodeName=document.getElementById("pre_node_Name").value;

	//alert("strPreNodeName"+strPreNodeName);
	var remarkInfo= document.getElementById("remarkInfo").value;

	//alert("remarkInfo"+remarkInfo);
	 if(remarkInfo=='' ||remarkInfo==undefined){

     remarkInfo="";
   } 
	
	 if(strNodeId=='' ||strNodeId==undefined||strNodeName=='' ||strNodeName==undefined){	
	 		Frame3bolen =false;
	 } 	
	
	
	//var isbolen=myFrame2.window.isCheckBoxsList();
	//if(Frame3bolen==true){
	var url_saveTreeData="/npage/callbosspage/k170/k172_modifyCallCause.jsp";
	var postData = "strPreNodeId="+strPreNodeId+"&strPreNodeName="+strPreNodeName+"&strNodeId="+strNodeId+"&strNodeName="+strNodeName+"&remarkInfo="+remarkInfo+"&strContactId=<%=contactId%>&contactMonth=<%=contactMonth%>";
	postData = postData.replace(/%20/g, "+");	
  asyncGetText(url_saveTreeData+"?"+postData,doProcessGetFlag); 
	//	}else{
	//		 rdShowMessageDialog('请您选择来电原因',1);
		//	}

	}
	//saveTreeData的回调函数
	function doProcessGetFlag(txt){
   returnFlag(txt);
} 

function selectNodeInfo()
{ 
	 
	strFlag=document.frames["myFrame2"].form2.strFlag.value;
  var selectName = document.getElementById("selectName").value;
  //保存查询条件
  if(window.opener){
     window.opener.temp_caption=selectName; 
  }
  var contactId=document.getElementById("contactId").value;
  var contactMonth=document.getElementById("contactMonth").value;
  
  if(selectName!=''){
  	 document.getElementById("treeId").style.display="none";
     document.getElementById("causeId").style.display="";
     window.open("/npage/callbosspage/k170/k172_SearchTreeNode_new.jsp?caption="+selectName+"&strFlag="+strFlag+"&contactId="+contactId+"&contactMonth="+contactMonth,"myFrame4");
   }
   else{
     }
  }
function initJsp()
{
  document.getElementById("selectName").value="";
  window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?","myFrame2");
  unCheckBoxs();
}

function otherInfo(){
   var callCauseShowDisplay =  document.getElementById("callCauseShow").style.display;
   //alert(callCauseShowDisplay);
   if(callCauseShowDisplay=="none"){
       document.getElementById("callCauseShow").style.display="";
       document.getElementById("writeInfoShow").style.display="none";
   }else{
       document.getElementById("callCauseShow").style.display="none";
       document.getElementById("writeInfoShow").style.display="";
   }
}
function treeInfo(){
  document.getElementById("writeInfoShow").style.display="none";
  document.getElementById("callCauseShow").style.display=""; 
}
</script>
</head>
<body>
<div id="Operation_Table"> 
  <div class="title"  id="testName" >来电原因异动修改主页面</div>
	  <table id="sQryCnttOnlyTable" >
	    <tr>
	        <input type="hidden" name="isSelectData" id="isSelectData" value="">
	       	<td  colspan="3" class="blue">查询条件
    			<input  id="selectName" name="selectName" type="text" value="" onkeydown="if(event.keyCode==13)selectNodeInfo()">
    			<input id="select" name="select" type="button" class="b_text" value="搜索" onClick="selectNodeInfo()">
    			<input id="init" name="init" type="button" class="b_text" value="还原" onClick="initJsp()">
	    </tr>	  	
	  	<tr id='treeId'>
	  		<td>
	  		  <input type="hidden" name="contactId" id="contactId" value="<%=contactId%>">
				  <input type="hidden" name="contactMonth" id="contactMonth" value="<%=contactMonth%>">
	  			<iframe  name="myFrame2" src="k172_callCauseBaseTree_new.jsp?firstInitree=1" frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>
	  		</td>
	  		<td>
	  			<iframe  name="myFrame3"  frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>		  			
	  		</td>
	  	</tr>
		</table>
		<table>
	  	<tr id="causeId" style="display:none">
          <td>
	  			<iframe  name="myFrame4"  frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>		  			
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
				<td  align="left">
					<input name="search" type="button"   class="b_text1"  id="search" value="备注" onClick="otherInfo();return false;">
					<input name="search" type="button"  class="b_text1"  id="search" value="关闭" onClick="window.close();return false;">
					<input name="search" type="button"  class="b_text1"  id="search" value="保存" onClick="saveTreeData();return false;">
					<input name="search" type="button"  class="b_text1"  id="search" value="取消" onClick="unCheckBoxs();return false;">
					
				</td>
			</tr>	
        <tr id="callCauseShow">
				<td colspan="2" >
					<div id="my_div" style="display:none" ></div>
					<input type="hidden" id="show_Name" align="left">
					<select id="select_Name" name="select_Name" style="width:100%;height:100px;"  size="6"  onDblClick ="right(this)" onclick="goFindTree(this);">
          </select>
				  <input type="hidden" name="node_Id" id="node_Id" value="">
				  <input type="hidden" name="node_Name" id="node_Name" value="">
				  <input type="hidden name="pre_node_Id" id="pre_node_Id" value="">
				  <input type="hidden" name="pre_node_Name" id="pre_node_Name" value=""> 
				</td>	
			</tr>	
			<tr id="writeInfoShow" style="display:none">
			 <td colspan="2">
			 <textarea name="remarkInfo" id="remarkInfo" cols="65%" rows="5" value=""></textarea> 
     </td>        
    </tr>
		</table>
</body>
</html>
<script>
 var sign=false;
function goFindTree(value){
	
		setTimeout(function(){
		if(sign){sign=false;return;}
		var optionarr = value.options;
		var myid = optionarr[value.selectedIndex].value;
		var mytext=optionarr[value.selectedIndex].text;
    var indexId="";
    var nodeName="";
    var textAry=mytext.split('→');
    nodeName=textAry[textAry.length-1];
    for(var i=0;i<textAry.length;i++){
       if(textAry[i]==myid){
      		indexId= mytext.substr(mytext.indexOf('→')+1);
    		 }
 			}
		var myidlen =(myid.length)-2;
				var nodeId = myid;
				var fullname=indexId;
				var isleaf=1;
				var mynodeId = document.getElementById("node_Id").value;
				var caption=nodeName;
  		  var selectPara=0;
  		  var iniNum=1;
  		  window.open("<%=request.getContextPath()%>/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?strId="+nodeId,"myFrame2");
				//Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_modifyCallCauseLeaveTree_new.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId+"&myid="+myid+"&iniNum="+iniNum,"myFrame3");
},300);
}

function right(value){
 sign=true;
 var optionarr = value.options;
 var myid = optionarr[value.selectedIndex].value;
 var mytext=optionarr[value.selectedIndex].text;
 var indexId="";
 var nodeId = myid;
 var textAry=mytext.split('→');
 nodeName=textAry[textAry.length-1];
 for(var i=0;i<textAry.length;i++){
     if(textAry[i]==myid){
      indexId= mytext.substr(mytext.indexOf('→')+1);
     }
 }
 var myidlen =(myid.length)-2;
 var fullname=indexId;
 var isleaf=1;
 var mynodeId = document.getElementById("node_Id").value;
 var caption=nodeName;
 var selectPara=0;
 var iniNum=2;
 window.open("<%=request.getContextPath()%>/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId+"&myid="+myid+"&iniNum="+iniNum,"myFrame3");
 }
</script>	
