<%@ page contentType="text/html;charset=gbk"%>
<%
	String opCode = "171";
	String opName = "来话应答填写来电原因";
	String contactId =request.getParameter("contactId");
	String kfWorkNum=request.getParameter("kfWorkNum");
	String contactMonth =request.getParameter("contactMonth");
	String temp_caption =request.getParameter("temp_caption");
	if(temp_caption==null){
			temp_caption = "";
	}
	String temp_callCauseNode =request.getParameter("temp_callCauseNode");
	if(temp_callCauseNode==null){
			temp_callCauseNode = "";
	}
	

%>
<html>
<head>
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<title>来话应答填写来电原因</title>
<script type="text/javascript" src="/njs/extend/prototype/prototype.js"></script>	
<!--modify wangyong 20090817 修改引入js，替换成吉林本地使用-->
<script src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>  
<script src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js" type="text/javascript"></script>
<!--script type="text/javascript" src="/njs/si/core_sitech_pack_new.js"></script-->	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<style>
.b_text1{
height:25px;
        border:1px solid #417db3;
        font-size:12px;
        font-weight:bold;
        color:#1E245E;
        background-image: url(../images/button_1.jpg);
        background-repeat: repeat-x;
        background-position: left bottom;
        text-align: center;
        background-color: #fcfdff;
        padding-top: 1px;
        cursor: hand;
}
</style>
<script language=javascript>

opener.cCcommonTool.DebugLog("javascript *** k172_callCauseTree_new.jsp begin");
var temp_callCauseNode = '<%=temp_callCauseNode%>';	
//是否点击保存按钮保存
var is_click_save = '0';
//清除选择目录
if(window.opener){
     window.opener.temp_callCauseNode=''; 
}
var flag=window.opener.flag;
var initTag=0;
//保存选择的目录ID
var temp_callCauseNode_ = '';

//window.onload = function(){
//	setTimeout("openFrame()",200);
//}

function openFrame(){
<%
  if(!temp_callCauseNode.equals("")){
%>
  window.open("<%=request.getContextPath()%>/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?firstInitree=1&strId="+temp_callCauseNode,"myFrame2");
<%  	 
}else{
%>
  window.open("<%=request.getContextPath()%>/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?firstInitree=1","myFrame2");
<%  	
	}
%>	
}

function unCheckBoxs(){

	myFrame2.window.unCheckBoxBySelect();
	try{
	myFrame3.window.unCheckBoxBySelect();
	}catch(e){

	}
	

	document.getElementById("node_Id").value="";
	document.getElementById("node_Name").value="";
	document.getElementById("show_Name").value=""; 
	document.getElementById("select_Name").options.length=0;

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
		 opener.cCcommonTool.DebugLog("javascript *** insertCause end");
		initTag=2;
		releaseEle();
		window.close();
	}
	//触发关闭窗口事建，保存数据
	window.onbeforeunload =   function()     
 {  
 		if(opener.isLoadCallCauseWindow!=undefined){
				opener.isLoadCallCauseWindow = 0;
			}
    if(initTag!=2){
         saveTreeData();
         }else{
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
	opener.cCcommonTool.DebugLog("javascript *** saveTreeData begin");
	window.opener.windowHandle ='';
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
  //alert(1);
  if(strFlag==9){
   contactId=document.frames["myFrame2"].form2.contactId.value;
   contactMonth=document.frames["myFrame2"].form2.contactMonth.value;
  }
  else{
  	contactId=document.getElementById("contactId").value;
  	contactMonth=document.getElementById("contactMonth").value;
  }
  //保存最后点击的目录
  if(contactId!=''){
				 if(window.opener){
				 	 if(is_click_save=='0')
            	window.opener.temp_callCauseNode=temp_callCauseNode_; 
           else{
           	  window.opener.temp_callCauseNode=''; 
           }
         }				 
	}
  //alert(2);
  if((remarkInfo!=''||strNodeId!='')&&contactId!=''){
  	/*
		 	try
			{
				Frame3bolen=myFrame3.window.isCheckBoxsList();
			}
			catch(e){ 
				Frame3bolen=false;
			}
			*/
			Frame3bolen=true;
			opener.cCcommonTool.DebugLog("javascript  insertCause begin");
  		if(Frame3bolen==true){
  			var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_insertCause.jsp","aa");
				mypacket.data.add("strNodeId",strNodeId);
				mypacket.data.add("strNodeName",strNodeName);
				mypacket.data.add("remarkInfo",remarkInfo);
	  		mypacket.data.add("strContactId",contactId);
	  		mypacket.data.add("contactMonth",contactMonth);
	  		//by zwy 20090509,同步变成异步
  			//core.ajax.sendPacket(mypacket,doProcessGetFlag,false);
  			core.ajax.sendPacket(mypacket,doProcessGetFlag,true);
				mypacket=null;
			}
			else{
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_insertCause.jsp","aa");
				mypacket.data.add("strNodeId",strNodeId);
				mypacket.data.add("strNodeName",strNodeName);
				mypacket.data.add("remarkInfo",remarkInfo);
				mypacket.data.add("strContactId",contactId);
				mypacket.data.add("contactMonth",contactMonth);
				//by zwy 20090509,同步变成异步
  			//core.ajax.sendPacket(mypacket,doProcessGetFlag,false);
  			core.ajax.sendPacket(mypacket,doProcessGetFlag,true);
				mypacket=null;
				}
		}
		else{
			initTag=2;
			//保存打开节点信息
			releaseEle();
			window.close();
		}
		opener.cCcommonTool.DebugLog("javascript *** saveTreeData end");
}
	//saveTreeData的回调函数
	function doProcessGetFlag(packet){
   var str = packet.data.findValueByName("retCode");
   returnFlag(str);
} 

function selectNodeInfo2()
{   
  var selectName = document.getElementById("selectName").value;
  if(selectName!=''){
  if(document.getElementById("treeId").style.display=='none'){
     document.getElementById("treeId").style.display="";
     document.getElementById("causeId").style.display="none";
     if(selectName!=""){
      window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?caption="+selectName,"myFrame2");
     }
   }
   else{
    if(selectName=="")
    {
    window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?","myFrame2");
 	  document.frames["myFrame3"].src="";
     }
   else{
   window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?isRoot=1&caption="+selectName,"myFrame2");
   }
  }
}
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
   	//document.getElementById("causeId").style.display="none";
    //document.getElementById("treeId").style.display="";
    //Window.open("/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp","myFrame2");
 	  //document.frames["myFrame3"].src="";
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
  window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?","myFrame2");
 
  }
}
function notCause(){
    document.getElementById("treeId").style.display="none";
    document.getElementById("causeId").style.display="";
    window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_notSaveCause_new.jsp?","myFrame4");
  
}
function otherInfo(){
   document.getElementById("callCauseShow").style.display="none";
   document.getElementById("writeInfoShow").style.display="";
   
}
function treeInfo(){
  document.getElementById("writeInfoShow").style.display="none";
  document.getElementById("callCauseShow").style.display=""; 
}

//控制table拖拉
var isDraging=false;
var ox,oy;
function  getPosition(e) {
       var  left  =   0 ;
       var  top   =   0 ;
       while  (e.offsetParent){
            left  +=  e.offsetLeft;
            top  +=  e.offsetTop;
            e  =  e.offsetParent;
       } 
       left  +=  e.offsetLeft;
       top  +=  e.offsetTop;
       return {x:left, y:top} ;
   } 
function fnDown()
{    isDraging=true;   
     ox=event.offsetX;
     oy=event.offsetY;
     mid.setCapture();
}
function fnMove()
{
if(event.button!=1)
 fnRelease();
if(isDraging){ 
   var th=event.x+ document.body.scrollLeft - document.body.clientLeft - getPosition(oTable).x-ox-oTable.border;
    if (th<1) th=1;
    if(th+parseInt(mid.width)>parseInt(oTable.width))
    th=parseInt(oTable.width)-parseInt(mid.width);   
    up.width=th;    
}
}
function fnUp()
{
		fnRelease();
}
function fnRelease(){
    isDraging=false;
    mid.releaseCapture();
}
function releaseEle(){

	  var iframeTags = document.getElementsByTagName("iframe");
    for(var i = iframeTags.length-1;i>=0;i--){
    	iframeTags[i].src = "_blank";
    	iframeTags[i].parentNode.removeChild(iframeTags[i]);
    	//alert(i);
    	//gbg(iframeTags[i]);
    }
    iframeTags = null;
    
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
    			<input  id="selectName" name="selectName" type="text" value="<%=temp_caption%>" onkeydown="if(event.keyCode==13)selectNodeInfo()">
    			<input id="select" name="select" type="button" class="b_text" value="搜索"  onClick="selectNodeInfo()">
    			<input id="init" name="init" type="button" class="b_text" value="还原" onClick="initJsp()">
    			<input id="initCause" name="initCause" type="button" class="b_text" value="未保存来话" onClick="notCause()"></td>
	    </tr>
	  </table>
	  <table id=oTable>
	  	 <tr id="treeId">
	  		 <td width="40%" id=up style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"> 
          <%
  						if(!temp_callCauseNode.equals("")){
					%>
	  			<iframe  name="myFrame2" frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src="<%=request.getContextPath()%>/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?firstInitree=1&strId=<%=temp_callCauseNode%>"></iframe>	  
		      <%
		      	}else{
		      %>
		      <iframe  name="myFrame2" frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src="<%=request.getContextPath()%>/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?firstInitree=1"></iframe>	 
		      <%
		      	}
		      %>
	  		 </td>
	  		 <TD id=mid width=3  onmousedown="fnDown()" onmousemove="fnMove()" onmouseup="fnUp" style="cursor:e-resize;padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;background:#D0E9FF"></TD>  
         <td id=down style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;">
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
				<td align="left"><input name="search" type="button"   class="b_text1"  id="search" value="备注" onClick="otherInfo();return false;">&nbsp;<input name="search" type="button"   class="b_text1"  id="search" value="关闭" onClick="window.close();return false;">&nbsp;<input name="search" type="button"   class="b_text1"  id="save" value="保存" onClick="is_click_save='1';saveTreeData();return false;">&nbsp;<input name="search" type="button"   class="b_text1"  id="search" value="取消" onClick="unCheckBoxs();">
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
		if(value.selectedIndex!=-1){
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
  		  var selectPara=2;
  		  var iniNum=1;
  		  window.open("<%=request.getContextPath()%>/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?strId="+nodeId,"myFrame2");
				//Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara,"myFrame3");
			}
},300);
}

function right(value){
 sign=true;
 var optionarr = value.options;
 
 if(value.selectedIndex!=-1){
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
 Window.open("<%=request.getContextPath()%>/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara,"myFrame3");
}
}
if(opener.isLoadCallCauseWindow!=undefined){
				opener.isLoadCallCauseWindow = 1;
			}
opener.cCcommonTool.DebugLog("javascript *** k172_callCauseTree_new.jsp end");
</script>	
	
