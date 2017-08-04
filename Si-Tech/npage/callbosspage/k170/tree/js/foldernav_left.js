
document.onmouseover = mOver ;
document.onmouseout = mOut ;

var gobal_check_str="";

function mOver() {
	var eSrc = window.event.srcElement ;
	if (eSrc.className == "item") {
		window.event.srcElement.className = "highlight";
	}
}

function mOut() {
	var eSrc = window.event.srcElement ;
	if (eSrc.className == "highlight") {
		window.event.srcElement.className = "item";
	}
}


var bV=parseInt(navigator.appVersion);
NS4=(document.layers) ? true : false;
IE4=((document.all)&&(bV>=4))?true:false;
ver4 = (NS4 || IE4) ? true : false;

isExpanded = false;

function getIndex($1) {
	ind = null;
	for (i=0; i<document.layers.length; i++) {
		whichEl = document.layers[i];
		if (whichEl.id == $1) {
			ind = i;
			break;
		}
	}
	return ind;
}

function arrange() {
	nextY = document.layers[firstInd].pageY + document.layers[firstInd].document.height;
	for (i=firstInd+1; i<document.layers.length; i++) {
		whichEl = document.layers[i];
		if (whichEl.visibility != "hide") {
			whichEl.pageY = nextY;
			nextY += whichEl.document.height;
		}
	}
}

function FolderInit(){
	//alert();
	if (NS4) {
	firstEl = "mParent";
	firstInd = getIndex(firstEl);
	//加载
	 curPardiv=document.getElementById("mainDiv");
	iniRootNodes()
	showAll();
	for (i=0; i<document.layers.length; i++) {
			whichEl = document.layers[i];
			if (whichEl.id.indexOf("Child") != -1) whichEl.visibility = "hide";
	}
		arrange();
	}
	else {
	    //加载
	 curPardiv=document.getElementById("mainDiv");
	iniRootNodes()
		tempColl = document.all.tags("DIV");
		for (i=0; i<tempColl.length; i++) {
			if (tempColl(i).className == "child") tempColl(i).style.display = "none";
		}
	}
}

function FolderExpand($1,$2,$3,$4) {

   
if (!ver4) return;
	if (IE4) { ExpandIE($1,$2,$3) } 
	else { ExpandNS($1,$2,$3) }

    getChildren($4);
}

function ExpandIE($1,$2,$3) {
  // alert("ExpandIE")
	Expanda = eval($1 + "a");
	
	Expanda.blur()
	ExpandChild = eval($1 + "Child");
	//alert(ExpandChild.style.display);
	
    if ($2 != "top") { 
		ExpandTree = eval($1 + "Tree");
		ExpandFolder = eval($1 + "Folder");
	}
	if (ExpandChild.style.display == "none"||ExpandChild.style.display == "") {
		ExpandChild.style.display = "block";
                if ($2 != "top") { 
                	if ($2 == "last") { ExpandTree.src = "/npage/callbosspage/k170/tree/images/Lminus.gif"; }
			else { ExpandTree.src = "/npage/callbosspage/k170/tree/images/Tminus.gif"; }
			ExpandFolder.src = "/npage/callbosspage/k170/tree/images/openfoldericon.gif";
			
		}
		else { mTree.src = "/npage/callbosspage/k170/tree/images/topopen.gif"; }
	}
	else {
		ExpandChild.style.display = "none";
                if ($2 != "top") { 
	                if ($2 == "last") { ExpandTree.src = "/npage/callbosspage/k170/tree/images/Lplus.gif"; }
			else { ExpandTree.src = "/npage/callbosspage/k170/tree/images/Tplus.gif"; }
			ExpandFolder.src = "/npage/callbosspage/k170/tree/images/foldericon.gif";
		
		}
		else { mTree.src = "/npage/callbosspage/k170/tree/images/topopen.gif"; }
	}
	
}
function ExpandNS($1,$2,$3) {
   //alert("ExpandNS");
	ExpandChild = eval("document." + $1 + "Child")
	//alert(ExpandChild.visibility);
    if ($2 != "top") { 
		ExpandTree = eval("document." + $1 + "Parent.document." + $1 + "Tree")
		ExpandFolder = eval("document." + $1 + "Parent.document." + $1 + "Folder")
	}	
	if (ExpandChild.visibility == "hide") {
		ExpandChild.visibility = "show";
                if ($2 != "top") { 
               		if ($2 == "last") { ExpandTree.src = "/npage/callbosspage/k170/tree/images/Lminus.gif"; }
			else { ExpandTree.src = "/npage/callbosspage/k170/tree/images/Tminus.gif"; }
			ExpandFolder.src = "/npage/callbosspage/k170/tree/images/openfoldericon.gif";	
		}
		else { mTree.src = "/npage/callbosspage/k170/tree/images/topopen.gif"; }
	}
	else {
		ExpandChild.visibility = "hide";
                if ($2 != "top") { 
               		if ($2 == "last") { ExpandTree.src = "/npage/callbosspage/k170/tree/images/Lplus.gif"; }
			else { ExpandTree.src = "/npage/callbosspage/k170/tree/images/Tplus.gif"; }
			ExpandFolder.src = "/npage/callbosspage/k170/tree/images/foldericon.gif";	
		}
		else { mTree.src = "/npage/callbosspage/k170/tree/images/top.gif"; }
	}
	arrange();
	
}

function showAll() {
	for (i=firstInd; i<document.layers.length; i++) {
		whichEl = document.layers[i];
		whichEl.visibility = "show";
	}
}


with (document) {
	write("<STYLE TYPE='text/css'>");
	if (NS4) {
		write(".parent { color: black; font-size:9pt; line-height:0pt; color:black; text-decoration:none; margin-top: 0px; margin-bottom: 0px; position:absolute; visibility:hidden }");
		write(".child { text-decoration:none; font-size:9pt; line-height:15pt; position:absolute }");
	        write(".item { color: black; text-decoration:none }");
	        write(".highlight { color: blue; text-decoration:none }");
	}
	else {
		write(".parent { font: 12px/13px; Times; text-decoration: none; color: black;}");
		write(".child { font:12px/13px Times; display:none;color:black;}");
	        write(".item { color: black; text-decoration:none; cursor: hand }");
	        write(".highlight { color: blue; text-decoration:none }");
	        write(".icon { margin-right: 5 }")
		
	}
	write("</STYLE>");
}

function linew(){
with(document){
  write("<img src=/npage/callbosspage/k170/tree/images/I.gif align=absmiddle border='0'><img src=/npage/callbosspage/k170/tree/images/T.gif align=absmiddle border='0'>");	
}
}

function elinew(){
with(document){
  write("<img src=/npage/callbosspage/k170/tree/images/white.gif align=absmiddle border='0'><img src=/npage/callbosspage/k170/tree/images/L.gif align=absmiddle border='0'>");	
}
}

/*
  初始化树节点
*/
function iniRootNodes(){
  //alert("iniRootNodes");
  var par_node= {};
  par_node.par_id='0'; 
  //alert("packet");
  var packet = new AJAXPacket("/npage/callbosspage/k170/k170_test_rpc.jsp","");
  //alert("iniRootNodes2");
  packet.data.add("nodeId",'0');
  core.ajax.sendPacket(packet,iniCallBack,true);
	packet=null;
  //tree.getChildNodes(par_node,iniCallBack);
}


function iniCallBack(packet){
  //alert(curPardiv.id);
  var rootNodes = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");

  if(rootNodes!=null){
   var parnodeHTML='';
   var count=0;
   for(var i=0;i<rootNodes.length;i++){
     var img_plus_src=''
     
     if(rootNodes[i].is_Leaf==0){
        img_plus_src='/npage/callbosspage/k170/tree/images/Tplus.gif';
       }else{
       	img_plus_src='/npage/callbosspage/k170/tree/images/T.gif';
       }	
     if(count==rootNodes.length-1){
        img_plus_src='/npage/callbosspage/k170/tree/images/Lplus.gif';
     }
     //判断是否为叶结点，如果是叶子节点，变成叶节点的图标，onclick事件没有
     var is_leaf_img='';
     var is_leaf_onclick='';
     var is_checkbox='';
     var is_checked='';
     var is_leaf_check_onclick="";
     //如果在全局里面有ID则要选中
     if(gobal_check_str.indexOf(rootNodes[i].node_id)!=-1){
         	is_checked=" checked ";
     }
     if(rootNodes[i].is_Leaf==0){//不是叶子
       	is_leaf_img='<IMG src="/npage/callbosspage/k170/tree/images/foldericon.gif" align=\'absMiddle\' border=0 name=\'m'
        +rootNodes[i].node_id+'Folder\'>';
       	is_leaf_onclick='onclick="createRightWindow(\''+rootNodes[i].node_id+'\',\''+rootNodes[i].node_name+'\');return false;"';
        
     }else{
     	  is_leaf_img='<IMG src="/npage/callbosspage/k170/tree/images/icon-page.gif" align=\'absMiddle\' border=0 name=\'m'
        +rootNodes[i].node_id+'Folder\'>';
     	  is_checkbox='<input type=\'checkbox\' '+is_checked+' value=\''+rootNodes[i].node_id+'\' name =\'chk'+rootNodes[i].node_id+'\'>';
     	  is_leaf_check_onclick='onclick="createRightWindow(\''+rootNodes[i].node_id+'\',\''+rootNodes[i].node_name+'\');return false;"';
     } 
     parnodeHTML=parnodeHTML+'<A style=\'cursor:hand\' '+is_leaf_onclick+' name=\'m'
     +rootNodes[i].node_id+'a\'><IMG src="'+img_plus_src+'" align=\'absMiddle\' border=0 name=\'m'
     +rootNodes[i].node_id+'Tree\'>'+is_leaf_img
     //+is_checkbox
     +'<span  '+is_leaf_check_onclick+'>'+rootNodes[i].node_name+'['+rootNodes[i].node_id+']'+'</span>'
    +'</A><BR>' 
    +'<DIV traceName=\''+rootNodes[i].node_name+'->\' class=child id=\'m'+rootNodes[i].node_id+'Child\'   layer=\'0\'>'+'</DIV>'
     count++;
    }
    
    //alert(parnodeHTML)
    curPardiv.innerHTML=parnodeHTML
  }   
}

/**
*添加子节点
*/
var curPardiv;
function getChildren(par_id){
  //alert("childCallBack");
  var par_node= {};
  par_node.par_id=par_id; 
  curPardiv=document.getElementById('m'+par_id+'Child');
  
  var packet = new AJAXPacket("/npage/callbosspage/k170/k170_test_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  packet.data.add("nodeId",par_id);
  core.ajax.sendPacket(packet,getChildCallBack,true);
	packet=null;
 // tree.getChildNodes(par_node,getChildCallBack);

}

//增加子节点

function getChildCallBack(packet){
 // alert(curPardiv.id);
 // alert(curPardiv.layer);
  var rootNodes = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
    
  var curlayer=parseInt(curPardiv.layer)+1
  //alert(curlayer);
  var layerHTML="<img src=/npage/callbosspage/k170/tree/images/I.gif align=absmiddle border='0'>";
  var temlayerHTML="";
  for(var i=0;i<curlayer;i++){
    temlayerHTML=temlayerHTML+layerHTML;
   // alert("i:"+i)
  }
 // alert(temlayerHTML);
  layerHTML=temlayerHTML
  if(rootNodes!=null){
    var parnodeHTML='';
     var count=0;
   for(var i=0;i<rootNodes.length;i++){
     var img_folder_plus_src='/npage/callbosspage/k170/tree/images/Tplus.gif';
     if(count==rootNodes.length-1){
       img_folder_plus_src='/npage/callbosspage/k170/tree/images/Lplus.gif';
     }
     var img_file_plus_src='/npage/callbosspage/k170/tree/images/T.gif';
     if(count==rootNodes.length-1){
       img_file_plus_src='/npage/callbosspage/k170/tree/images/L.gif';
     }
     var img_folder="";
     var is_checkbox='';
     var is_checked='';
     //如果在全局里面有ID则要选中
     if(gobal_check_str.indexOf(rootNodes[i].node_id)!=-1){
         	is_checked=" checked ";
     }
     if(rootNodes[i].is_Leaf==0){
       img_folder =  '<IMG src="'+img_folder_plus_src+'" align=\'absMiddle\' border=0 name=\'m'+rootNodes[i].node_id+'Tree\'>'
       +'<IMG src="/npage/callbosspage/k170/tree/images/foldericon.gif" align=\'absMiddle\' border=0 name=\'m' +rootNodes[i].node_id+'Folder\'>'
     }else {
        img_folder = '<img src=\''+img_file_plus_src+'\' align=absmiddle border=\'0\'><IMG src="/npage/callbosspage/k170/tree/images/icon-page.gif" align=\'absMiddle\' border=0 name=\'m' +rootNodes[i].node_id+'Folder\'>'
       is_checkbox='<input type=\'checkbox\' '+is_checked+' value=\''+rootNodes[i].node_id+'\' name =\'chk'+rootNodes[i].node_id+'\'>';
       
     }
     
     if(rootNodes[i].is_Leaf==0){
      parnodeHTML=parnodeHTML+'<A style=\'cursor:hand\' onclick="FolderExpand(\'m'
	     +rootNodes[i].node_id+'\',\'\',\'1\',\''+rootNodes[i].node_id+'\');return false;"  name=\'m'
	     +rootNodes[i].node_id+'a\'>'
	     +layerHTML
	     +img_folder
	     +rootNodes[i].node_name+'['+rootNodes[i].node_id+']'
	     +'</A><BR>' 
	     +'<DIV traceName=\''+curPardiv.traceName+rootNodes[i].node_name+'->\'  layer=\''+curlayer+'\' class=child id=\'m'+rootNodes[i].node_id+'Child\'>'+'</DIV>'
     }else {//叶子节点
	        parnodeHTML=parnodeHTML+'<A style=\'cursor:hand\' onclick="judgeChecked(\'chk'+rootNodes[i].node_id+'\')" node_id=\''+rootNodes[i].node_id+'\' traceName=\''+curPardiv.traceName+rootNodes[i].node_name+'\' onclick=" retValue(this.traceName+\'|\'+this.node_id)" href="#"  name=\'m'+rootNodes[i].node_id+'a\'>'
	          +layerHTML
	          +img_folder
	          +is_checkbox
	         +rootNodes[i].node_name+'['+rootNodes[i].node_id+']'
	         +'</A><BR>' 
     
     }
      count++;
    }
   // alert(parnodeHTML)
    curPardiv.innerHTML=parnodeHTML
   // alert(curPardiv.id)
   // alert(curPardiv.innerHTML);
  }   
}
//Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseLeaveTree.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId,"myFrame3");
//打开一个窗体。
function  createRightWindow(node_id,node_name){
	//alert(node_id);
	Window.open("/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+node_id+"&node_name="+node_name,"myFrame3");
}	
//选中文字进行选中和取消
function judgeChecked(checkName){
	/*
	var chkbox=document.all(checkName);
	if(chkbox.checked){
		chkbox.checked=false;
	}else{
		chkbox.checked=true;
	}		
	*/
}	
window.onload = function(){
 FolderInit();
}