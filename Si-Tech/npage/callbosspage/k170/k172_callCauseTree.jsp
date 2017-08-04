<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "171";
	String opName = "来话应答填写来电原因";
	String contactId =request.getParameter("contactId");
	String kfWorkNum=request.getParameter("kfWorkNum");
	String contactMonth =request.getParameter("contactMonth");

%>
<html>
<head>
<title>来话应答填写来电原因</title>

<script language=javascript>
var flag=window.opener.flag;
var initTag=0;
function unCheckBoxs(){
	//alert("1");
	myFrame2.window.unCheckBoxBySelect();
	//alert("2");
	try{
	myFrame3.window.unCheckBoxBySelect();
	}catch(e){
	document.getElementById("node_Id").value="";
	document.getElementById("node_Name").value="";
	document.getElementById("show_Name").value=""; 
	document.getElementById("select_Name").options.length=0;	
	}
	
	//alert("3");
	//清空显示框
	//modify by fangyuan 20090228
	//document.form1.node_Id.value="";
	//document.form1.node_Name.value="";
	document.getElementById("node_Id").value="";
	document.getElementById("node_Name").value="";
	document.getElementById("show_Name").value=""; 
	document.getElementById("select_Name").options.length=0;
	//alert(document.getElementById("select_Name"));
	}
function returnFlag(str){
	if(str=="000000"){
		 /*add by fangyuan 090318 如果还在整理态中，保存成功后退出整理态--开始*/		
		 exitWorkState();
		 /*add by fangyuan 090318 如果还在整理态中，保存成功后退出整理态--结束*/
		 var strFlag=document.frames["myFrame2"].form2.strFlag.value;
		 //alert("cc"); 		
		 var nowId=window.opener.document.getElementById("contactId").value;
		 if(nowId=='<%=contactId%>')
		 {
		  flag=1;	
		}
		else
		{
				flag=0;
		}	  
		 window.opener.flag=flag;
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

//by fangyuan 20090318 在整理态中，保存来电原因后，直接退出整理态

function exitWorkState(){
  var workNo=window.opener.cCcommonTool.getWorkNo();
  var current_CurState;
  if(window.opener.parPhone.QueryAgentStatusEx(workNo)==0){
    current_CurState=window.opener.parPhone.AgentInfoEx_CurState;
  }
if(current_CurState==6)
  {
  	 var el = window.opener.document.getElementById("bn_status_first");
      el.src="/nresources/default/images/ico_16/status_01.gif";
	 var ret = window.opener.cCcommonTool.ExtenseAdjustment();
	 if(ret == 0){
	 		//恢复到空闲时的状态
	 		
			window.opener.buttonType("K003");
			//lijin 090407 写整理态结束时间	
				var arr=new Array("'27'");
 				var oprTypeAll=arr.join(",");
 				var oprType="";
 				var sign=0;
 				window.opener.recodeTime(oprTypeAll,oprType,sign,"");
		     //恢复状态栏中的座席状态,ref footpanel	
		     window.opener.resetStatusTimer();	  	
			  window.opener.clearAllAdjustTimer();
			  window.opener.document.getElementById("extendTime").value="";
	    	window.opener.document.getElementById("beforeTime").value="";
	 }
  }
}

 

function saveTreeData(){
  var remarkInfo='';
  var Frame3bolen;
  var strFlag;
  var strNodeId='';
  var contactId='';
  var contactMonth='';
  strFlag=document.frames["myFrame2"].form2.strFlag.value;
  strNodeId=document.getElementById("node_Id").value;
  var strNodeName=document.getElementById("node_Name").value;
  strNodeName = makeNodeName(strNodeId,strNodeName);
  remarkInfo= document.getElementById("remarkInfo").value; 
  //alert("strNodeId"+strNodeId);
  //alert("strNodeName"+strNodeName);
  if(strFlag==9){
   contactId=document.frames["myFrame2"].form2.contactId.value;
   contactMonth=document.frames["myFrame2"].form2.contactMonth.value;
  }
  else{
  	contactId=document.getElementById("contactId").value;
  	contactMonth=document.getElementById("contactMonth").value;
  }
  if((remarkInfo!=''||strNodeId!='')&&contactId!=''){
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
	  		mypacket.data.add("strContactId",contactId);
	  		mypacket.data.add("contactMonth",contactMonth);
  			core.ajax.sendPacket(mypacket,doProcessGetFlag,false);
				mypacket=null;
			}
			else{
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_insertCause.jsp","aa");
				mypacket.data.add("strNodeId",strNodeId);
				mypacket.data.add("strNodeName",strNodeName);
				mypacket.data.add("remarkInfo",remarkInfo);
				mypacket.data.add("strContactId",contactId);
				mypacket.data.add("contactMonth",contactMonth);
  			core.ajax.sendPacket(mypacket,doProcessGetFlag,false);
				mypacket=null;
				}
		}
		else{
			initTag=2;
			window.close();
		}
}
	//saveTreeData的回调函数
	function doProcessGetFlag(packet){
   var str = packet.data.findValueByName("retCode");
   returnFlag(str);
} 

function selectNodeInfo()
{   
	strFlag=document.frames["myFrame2"].form2.strFlag.value;
  var selectName = document.getElementById("selectName").value;
  var contactId=document.getElementById("contactId").value;
  var contactMonth=document.getElementById("contactMonth").value;
  document.getElementById("treeId").style.display="none";
  document.getElementById("causeId").style.display="";
  if(selectName!=''){
     Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_SearchTreeNode.jsp?caption="+selectName+"&strFlag="+strFlag+"&contactId="+contactId+"&contactMonth="+contactMonth,"myFrame4");
   }
   else{
    Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree.jsp?","myFrame2");
 	  document.frames["myFrame3"].src="";
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
  //document.frames["myFrame3"].src="";
  //document.frames["myFrame3"].location.reload();
  unCheckBoxs();
 
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
    			<input id="select" name="select" type="button" class="b_text" value="搜索"  onClick="selectNodeInfo()">
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
	  	</iframe>
		</table>
		</div>
	<div id="Operation_Table">
<table id="sQryCnttOnlyTable">
			<tr>
				<td width="2%">				
					<input class="title"  id="sQryCnttInfoDiv" type="button" wrap="VIRTUAL" value="已选择项目(最多10个)" onClick="treeInfo()">
				</td>	
				<td align="left"><input name="search" type="button"   class="b_text"  id="search" value="备注" onClick="otherInfo();return false;"><input name="search" type="button"   class="b_text"  id="search" value="关闭" onClick="window.close();return false;"><input name="search" type="button"   class="b_text"  id="save" value="保存" onClick="saveTreeData();return false;"><input name="search" type="button"   class="b_text"  id="search" value="取消" onClick="unCheckBoxs();">
				</td>
			</tr>	
			<tr id="callCauseShow">
				<td colspan="2" >
					<div id="my_div" style="display:none" ></div>
					<input type="hidden" id="show_Name" align="left">
					<select id="select_Name" name="select_Name" style="width:100%"  size="6"  onDblClick ="right(this)" onclick="goFindTree(this);">
          </select>
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
		</div>
</body>
</html>
<script>
var sign=false;
//lijin 090316 修改 
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
				Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseLeaveTree.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId+"&iniNum="+iniNum,"myFrame3");
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
 Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseLeaveTree.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId+"&iniNum="+iniNum,"myFrame3");
}
</script>	
	