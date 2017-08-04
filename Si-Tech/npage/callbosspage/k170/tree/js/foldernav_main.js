
//document.onmouseover = mOver ;
//document.onmouseout = mOut ;
var gobal_check_str="";
var hasSelectOption = "0";
var operateDiv = null;
var leftTreeMaxLevel = '2';
var autoOpenMaxLevel = '2';


function mOver() {
	var eSrc = window.event.srcElement ;
	if (eSrc.className == "item") {
		window.event.srcElement.className = "highlight";
	}
	eSrc = null;
}

function mOut() {
	var eSrc = window.event.srcElement ;
	if (eSrc.className == "highlight") {
		window.event.srcElement.className = "item";
	}
	eSrc = null;
}



function showAll() {
	for (i=firstInd; i<document.layers.length; i++) {
		whichEl = document.layers[i];
		whichEl.visibility = "show";
	}
}


with (document) {
	write("<STYLE TYPE='text/css'>");
	write(".parent { font: 12px/13px; Times; text-decoration: none; color: black;}");
	write(".child { font:12px/13px Times; display:none;color:black;}");
	write(".child_show { font:12px/13px Times; display:block;color:black;}");
	write(".item { color: black; text-decoration:none; cursor: hand;display: inline  }");
	write(".highlight { color: blue; text-decoration:none }");
	write(".icon { margin-right: 5 }")		
	write("</STYLE>");
}





/**
*添加子节点
*/

function getChildren(par_id){
  if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** getChildren begin");
  var pardiv=document.getElementById('m'+par_id+'span');

  
  var packet = new AJAXPacket("/npage/callbosspage/k170/k170_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  packet.data.add("nodeId",par_id);
  packet.data.add("nodeLevel",pardiv.nodeLevel);
  packet.data.add("lastChildRoute",pardiv.lastChildRoute);
  if(gobal_check_str==null){
  		gobal_check_str = '';
  	}
  packet.data.add("hasSelectOption",hasSelectOption);
  packet.data.add("gobal_check_str",gobal_check_str);
  core.ajax.sendPacket(packet,getChildCallBack,true);
	packet=null;
	pardiv = null;
 // tree.getChildNodes(par_node,getChildCallBack);
 if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** getChildren end");

}
var parentNodeId ;
var isFirstSelect_ ;
function iniRootNodes(divId,par_id,isVisual,hasSelect,isFirstSelect){
  if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** iniRootNodes begin");
  hasSelectOption = hasSelect;

  parentNodeId = divId;
  if(isFirstSelect!=null&&isFirstSelect!=''){
  		isFirstSelect_ = isFirstSelect;
  }
  
  if(isFirstSelect=='1'&&par_id=='0'){
  	 var curPardiv=document.getElementById(divId);
     curPardiv.innerHTML = "<span><nobr>"
		 +"<IMG style='cursor:hand'  onclick=\"img1Click('0');return false;\"  src='/npage/callbosspage/k170/tree/images/Lplus.gif'  align='absMiddle' border=0 name='m0Tree'>"
		 +"<IMG style='cursor:hand'  onclick=\"img2Click('0');return false;\"  src='/npage/callbosspage/k170/tree/images/foldericon.gif' align='absMiddle' border=0 name='m0Folder'>"
     +"<span  class='item' style='cursor:hand'  onclick=\"spanClick('0');return false;\"  ondblclick=\"spandblClick('0');return false;\"  id='m0span'  nodeLevel='1' lastChildRoute='1' is_Leaf='0' isLast='1' isOpen='0' hasLoad='0' fullName='来电原因' >来电原因</span>"
     +"</nobr></span><BR>"
     +"<DIV traceName='来电原因->' class=child  id='m0Child' ></DIV>";
     spanClick('0');
     curPardiv = null;
     return;
  }
  
  var packet = new AJAXPacket("/npage/callbosspage/k170/k170_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  packet.data.add("nodeId",par_id);
  packet.data.add("nodeLevel","1");
  packet.data.add("isRoot","1");
  packet.data.add("isVisual",isVisual);
  packet.data.add("hasSelectOption",hasSelectOption);
  if(isFirstSelect_!=null){
     packet.data.add("isFirstSelect",isFirstSelect_);
  }
  packet.data.add("gobal_check_str",gobal_check_str);
  core.ajax.sendPacket(packet,getIniCallBack,true);
	packet=null;
 // tree.getChildNodes(par_node,getChildCallBack);
	if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** iniRootNodes begin");
}



function getChildCallBack(packet){
	if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** getChildCallBack begin");
  var nodesHtml = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
  var curPardiv=document.getElementById("m"+nodeId+"Child");  
  curPardiv.innerHTML = nodesHtml;
  var pardiv=document.getElementById('m'+nodeId+'span');
  pardiv.hasLoad='1';
  if(nodeId=='0'&&parent.opener.cCcommonTool!=undefined){
		if(parent.opener.cCcommonTool.getIsAnswerCause1258()==1){
				spanClick('07');
		}
	}
  //jiangbing 20090605
  if(nodeId=='07'){
  	 var spandiv_ = document.getElementById('img'+nodeId+'f');
  	 spandiv_.scrollIntoView();
  	 spandiv_ = null;
  }
  //打开第一层目录，只执行一次
  if(isFirstSelect_=='2'){
  	  childLoad(nodeId);
  	isFirstSelect_='';
  }
  nodesHtml = null;
  nodeId = null;
  curPardiv = null;
  pardiv = null;
  packet = null;
  if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** getChildCallBack end");
}
function childLoad(par_id){
	 var parDiv = document.getElementById('m'+par_id+'Child');
	 var childSpans = parDiv.getElementsByTagName('span');
	 for(var i=0;i<childSpans.length;i++){
	 	  if(childSpans[i].is_Leaf=='0')
	 			childSpans[i].click();
	 }
	 parDiv = null;
	 childSpans = null;
}
function clickspan(nodeId){
	var pardiv2=document.getElementById('m'+nodeId+'span');
	pardiv2.click();	
	pardiv2 = null;
}
function getIniCallBack(packet){
	if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** getIniCallBack begin");
  var nodesHtml = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
  var curPardiv=document.getElementById(parentNodeId);
  curPardiv.innerHTML = nodesHtml;
  var pardiv2=document.getElementById('m'+nodeId+'span'); 
  if(isFirstSelect_=='1'){
  	//自动点击第一个节点
  	//setTimeout(pardiv2.click(),100);
  	pardiv2.click();
  }else if(isFirstSelect_=='5'){
  	//document.getElementById('m'+nodeId+'Child').style.display='block';
  	pardiv2.isOpen='1';
  	//pardiv2.hasLoad='1';
  	hideOrShow_(nodeId);
  	doOpen();
  }else if(isFirstSelect_=='6'){
  	//document.getElementById('m'+nodeId+'Child').style.display='block';
  	pardiv2.isOpen='1';
  	//pardiv2.hasLoad='1';
  	hideOrShow_(nodeId);
  	doOpen2();
  }else if(isFirstSelect_=='0'){
  	pardiv2.click();
  }else if(isFirstSelect_=='2'){
  	
  }else if(isFirstSelect_=='7'){
  	 if(pardiv2.is_Leaf=='1'){
  	 	   changeColor(nodeId);
  	 		 var node_checkbox = document.getElementById('chk'+nodeId);
  	 		 if(node_checkbox!=null){
  	 		 	   if(node_checkbox.checked==false){
  	 		 	   	 pardiv2.click();
  	 		 	   	}  	 		 	
  	 		  }
  	 		 node_checkbox = null;
  	 	}
  }
  nodesHtml="";
	nodesHtml = null;
	nodeId = null;
	curPardiv = null;
	pardiv2 = null;
	packet =  null;
	if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** getIniCallBack end");
}


//图形转换，需要在逻辑转换后执行
function hideOrShow_(par_id){
	var img1div=document.getElementById('m'+par_id+'Tree');
	var img2div=document.getElementById('m'+par_id+'Folder');
	var pardiv=document.getElementById('m'+par_id+'Child');
	var pardiv2=document.getElementById('m'+par_id+'span');
	if(pardiv){
		if(pardiv2.isOpen=='0'){
			if(pardiv2.isLast=='0'){
				img1div.src="/npage/callbosspage/k170/tree/images/Tplus.gif";				
			}else{
				img1div.src="/npage/callbosspage/k170/tree/images/Lplus.gif";
			}
			img2div.src="/npage/callbosspage/k170/tree/images/foldericon.gif";
			pardiv.style.display='none';
		}
		else{
			if(pardiv2.isLast=='0'){
				img1div.src="/npage/callbosspage/k170/tree/images/Tminus.gif";				
			}else{
				img1div.src="/npage/callbosspage/k170/tree/images/Lminus.gif";
			}
			img2div.src="/npage/callbosspage/k170/tree/images/openfoldericon.gif";
			pardiv.style.display='block';
		}
	}
	img1div = null;
	img2div = null;
	pardiv = null;
	pardiv2 = null;
}

function openLeftTree(nodeId,preopen,param1,param2,nodeLevel,lastChildRoute){
	if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** openLeftTree begin");
	//alert("nodeId="+nodeId);
	//alert("preopen="+preopen);
	//alert("param1="+param1+"<->param2="+param2);
	//alert("nodeLevel="+nodeLevel+"<->lastChildRoute="+lastChildRoute);
  var packet = new AJAXPacket("/npage/callbosspage/k170/k170_rpc_preopen.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  packet.data.add("nodeId",nodeId);
  packet.data.add("preopen",preopen);
  packet.data.add("param1",param1);
  packet.data.add("param2",param2);
  packet.data.add("nodeLevel",nodeLevel);
  packet.data.add("hasSelectOption",hasSelectOption);
  packet.data.add("lastChildRoute",lastChildRoute);
  packet.data.add("gobal_check_str",gobal_check_str);
  core.ajax.sendPacket(packet,getOpenLeftCallBack,true);
	packet=null;
 // tree.getChildNodes(par_node,getChildCallBack);
 if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** openLeftTree end");

}

function getOpenLeftCallBack(packet){
	if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** getOpenLeftCallBack begin");
  var nodesHtml = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
  var param2= packet.data.findValueByName("param2");
  var preopen= packet.data.findValueByName("preopen");
  var curPardiv=document.getElementById("m"+nodeId+"Child");
  var parSpandiv=document.getElementById('m'+nodeId+'span');
  curPardiv.innerHTML = nodesHtml;
  parSpandiv.hasLoad='1';
  if(preopen=='2'){  	
  	var spandiv=document.getElementById('m'+param2+'span');
  	if(nodeId=='0'){
  		if(spandiv!=null){
  			if(spandiv.is_Leaf=='0'){
  		  	 spandiv.click();	 
  		  	 var spandiv_ = document.getElementById('img'+param2+'f');
  	 		 	 spandiv_.scrollIntoView();
  	 		 	 spandiv_ = null;
  	  	}else if(spandiv.is_Leaf=='1'){
  	  		changeColor(param2);
  	  		var spandiv_ = document.getElementById('img'+param2+'f');
  	 		 	spandiv_.scrollIntoView();
  	 		 	spandiv_ = null;
  	  	 	window.open("/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+param2+"&fullname="+spandiv.fullName+"&isleaf="+spandiv.is_Leaf+"&selectPara=7","myFrame3");
  	  	}
  		}else{
  			var subParam2 = param2.substring(0,2*leftTreeMaxLevel);
  			var spandiv_ = document.getElementById('img'+subParam2+'f');
  			spandiv_.scrollIntoView();
  			changeColor(subParam2);
  			subParam2 = null;
  			spandiv_ = null;
  		}
    }else{
    	if(spandiv!=null){
    		 
    		 if(spandiv.is_Leaf=='1'){
    		 	  var node_checkbox = document.getElementById('chk'+param2);
  	 		    if(node_checkbox!=null){
  	 		 	     if(node_checkbox.checked==false){
  	 		 	   	    spandiv.click();
  	 		 	   	    var spandiv_ = document.getElementById('img'+param2+'f');
  	 		 	   	    spandiv_.scrollIntoView();
  	 		 	   	    spandiv_ = null;
  	 		 	   	  }else{
  	 		 	   	  	changeColor(param2);
  	 		 	   	  	var spandiv_ = document.getElementById('img'+param2+'f');
  	 		 	   	  	spandiv_.scrollIntoView();
  	 		 	   	  	spandiv_ = null;
  	 		 	   	  }  	 		 	
  	 		    }
  	 		    node_checkbox = null;
  	  	 }else if(spandiv.is_Leaf=='0'){
  	  	 			spandiv.click();
  	  	 			var spandiv_ = document.getElementById('img'+param2+'f');
  	 		 	   	spandiv_.scrollIntoView();
  	 		 	   	spandiv_ = null;
  	  	 	}
    	}
    }
    spandiv = null;
  }
  packet = null;
  nodesHtml = null;
  nodeId = null;
  param2 = null;
  preopen = null;
  curPardiv = null;
  parSpandiv = null;
  if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** getOpenLeftCallBack end");
}

function changeColor(node_id){
	if(operateDiv!=null&&operateDiv!=''){
		   var spandiv=document.getElementById(operateDiv);
		   if(spandiv!=null){
		   			spandiv.style.color = '#000000';
		   			spandiv.style.backgroundColor = '';
		   	}
		   	spandiv = null;
		}
		operateDiv = 'm'+node_id+'span';
		var spandiv2=document.getElementById(operateDiv);
		if(spandiv2!=null){
		   			spandiv2.style.color = '#FFFFFF';
		   			spandiv2.style.backgroundColor = '#000BB0';
		}
		spandiv2 = null;
	}

