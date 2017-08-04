/*
 ______________________________________________________
/\
|           Folder Navigation 2.0 by EAE               |
|                                                      |
|   Based on a cross browser outline sample found      |
|   at 'www.webreference.com/dhtml'                    |
|                                                      |
|   Feel free to copy, use and change this script as   |
|   long as this part remains unchanged.               |
|                                                      |
|   If you have any questions and or comments please   |
|   E-mail me 'eae@eae.net'. If you're looking for     |
|   more JavaScripts etc, please check out my webpage  |
|                 'www.eae.net/weebfx'                 |
|                                                      |
|              Last Updated: 17 July 1998              |
\______________________________________________________/
 
*/



document.onmouseover = mOver ;
document.onmouseout = mOut ;

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

function FolderInit(iniParid){
	if (NS4) {
	firstEl = "mParent";
	firstInd = getIndex(firstEl);
	//加载
	 curPardiv=document.getElementById("mainDiv");
	iniRootNodes(iniParid);
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
	iniRootNodes(iniParid)
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
                	if ($2 == "last") { ExpandTree.src = "/workflow/include/tree/images/Lminus.gif"; }
			else { ExpandTree.src = "/workflow/include/tree/images/Tminus.gif"; }
			ExpandFolder.src = "/workflow/include/tree/images/openfoldericon.gif";
			
		}
		else { mTree.src = "/workflow/include/tree/images/topopen.gif"; }
	}
	else {
		ExpandChild.style.display = "none";
                if ($2 != "top") { 
	                if ($2 == "last") { ExpandTree.src = "/workflow/include/tree/images/Lplus.gif"; }
			else { ExpandTree.src = "/workflow/include/tree/images/Tplus.gif"; }
			ExpandFolder.src = "/workflow/include/tree/images/foldericon.gif";
		
		}
		else { mTree.src = "/workflow/include/tree/images/topopen.gif"; }
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
               		if ($2 == "last") { ExpandTree.src = "/workflow/include/tree/images/Lminus.gif"; }
			else { ExpandTree.src = "/workflow/include/tree/images/Tminus.gif"; }
			ExpandFolder.src = "/workflow/include/tree/images/openfoldericon.gif";	
		}
		else { mTree.src = "/workflow/include/tree/images/topopen.gif"; }
	}
	else {
		ExpandChild.visibility = "hide";
                if ($2 != "top") { 
               		if ($2 == "last") { ExpandTree.src = "/workflow/include/tree/images/Lplus.gif"; }
			else { ExpandTree.src = "/workflow/include/tree/images/Tplus.gif"; }
			ExpandFolder.src = "/workflow/include/tree/images/foldericon.gif";	
		}
		else { mTree.src = "/workflow/include/tree/images/top.gif"; }
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
  write("<img src=/workflow/include/tree/images/I.gif align=absmiddle border='0'><img src=/workflow/include/tree/images/T.gif align=absmiddle border='0'>");	
}
}

function elinew(){
with(document){
  write("<img src=/workflow/include/tree/images/white.gif align=absmiddle border='0'><img src=/workflow/include/tree/images/L.gif align=absmiddle border='0'>");	
}
}

/*
  初始化树节点
*/
function iniRootNodes(iniParid){
  //alert("iniRootNodes"+iniParid);
  var par_node= {};
  par_node.layer='org';
  par_node.par_id=iniParid; 
  tree.getTreeChildNodes(par_node,iniCallBack);
}


function iniCallBack(rootNodes){
  //alert(curPardiv.id);

  if(rootNodes!=null){
    var parnodeHTML='';
   var count=0;
   for(var i=0;i<rootNodes.length;i++){
   
     var img_plus_src='/workflow/include/tree/images/Tplus.gif';
     
     if(count==rootNodes.length-1){
       img_plus_src='/workflow/include/tree/images/Lplus.gif';
     }
     if(rootNodes[i].is_Leaf==0){
       parnodeHTML=parnodeHTML+'<A  node_name=\''+rootNodes[i].node_name+'\' node_id=\''+rootNodes[i].node_id+'\' par_id=\''+rootNodes[i].par_id+'\' is_leaf=\''+rootNodes[i].is_Leaf+'\' onclick="FolderExpand(\'m'
       +rootNodes[i].node_id+'\',\'\',\'1\',\''+rootNodes[i].node_id+'\');return false;" ondblclick="retValue(this)"  name=\'m'
       +rootNodes[i].node_id+'a\'>'
       +'<IMG src="'+img_plus_src+'" align=\'absMiddle\' border=0 name=\'m'
       +rootNodes[i].node_id+'Tree\'>'
       +'<IMG src="/workflow/include/tree/images/foldericon.gif" align=\'absMiddle\' border=0 name=\'m'
       +rootNodes[i].node_id+'Folder\'>'
       +rootNodes[i].node_name
       +'</A><BR>' 
       +'<DIV traceName=\''+rootNodes[i].node_name+'->\' class=child id=\'m'+rootNodes[i].node_id+'Child\'   layer=\'0\'>'+'</DIV>'
     }else{
          parnodeHTML=parnodeHTML+'<A  node_name=\''+rootNodes[i].node_name+'\' node_id=\''+rootNodes[i].node_id+'\' par_id=\''+rootNodes[i].par_id+'\' is_leaf=\''+rootNodes[i].is_Leaf+'\' onclick="retValue(this);return false;" href=\'#\'  name=\'c'+rootNodes[i].node_id+'a\'>'
	          +'<IMG src="/workflow/include/tree/images/T.gif" align=\'absMiddle\' border=0 >'
	          +'<IMG src="/workflow/include/tree/images/icon-page.gif" align=\'absMiddle\' border=0>'
	         +rootNodes[i].node_name
	         +'</A><BR>' 
		      
     }
     count++;
    }
    if(count==0){
    curPardiv.style.display='none';
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
  par_node.layer='org';
  par_node.par_id=par_id; 
  curPardiv=document.getElementById('m'+par_id+'Child');
  tree.getTreeChildNodes(par_node,getChildCallBack);

}

//增加子节点

function getChildCallBack(rootNodes){
  //alert(curPardiv.id);
  //alert(curPardiv.layer);
  var curlayer=parseInt(curPardiv.layer)+1
  var layerHTML="<img src=/workflow/include/tree/images/I.gif align=absmiddle border='0'>";
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
     //alert('sss:'+rootNodes[i].is_Leaf);
     
     var img_folder_plus_src='/workflow/include/tree/images/Tplus.gif';
     if(count==rootNodes.length-1){
       img_folder_plus_src='/workflow/include/tree/images/Lplus.gif';
     }
     
     var img_file_plus_src='/workflow/include/tree/images/T.gif';
     if(count==rootNodes.length-1){
       img_file_plus_src='/workflow/include/tree/images/L.gif';
     }
     var img_folder="";
     if(rootNodes[i].is_Leaf==0){
       img_folder =  '<IMG src="'+img_folder_plus_src+'" align=\'absMiddle\' border=0 name=\'m'+rootNodes[i].node_id+'Tree\'>'
       +'<IMG src="/workflow/include/tree/images/foldericon.gif" align=\'absMiddle\' border=0 name=\'m' +rootNodes[i].node_id+'Folder\'>'
     }else {
        img_folder = '<img src=\''+img_file_plus_src+'\' align=absmiddle border=\'0\'><IMG src="/workflow/include/tree/images/icon-page.gif" align=\'absMiddle\' border=0 >'
       
     }
     if(rootNodes[i].is_Leaf==0){
      parnodeHTML=parnodeHTML+'<A  node_name=\''+rootNodes[i].node_name+'\' node_id=\''+rootNodes[i].node_id+'\' par_id=\''+rootNodes[i].par_id+'\' is_leaf=\''+rootNodes[i].is_Leaf+'\' onclick="FolderExpand(\'m'
	     +rootNodes[i].node_id+'\',\'\',\'1\',\''+rootNodes[i].node_id+'\');return false;" ondblclick="retValue(this)" name=\'m'
	     +rootNodes[i].node_id+'a\'>'
	     +layerHTML
	     +img_folder
	     +rootNodes[i].node_name
	     +'</A><BR>' 
	     +'<DIV traceName=\''+curPardiv.traceName+rootNodes[i].node_name+'->\'  layer=\''+curlayer+'\' class=child id=\'m'+rootNodes[i].node_id+'Child\'>'+'</DIV>'
     }else {
	        parnodeHTML=parnodeHTML+'<A node_name=\''+rootNodes[i].node_name+'\' node_id=\''+rootNodes[i].node_id+'\' par_id=\''+rootNodes[i].par_id+'\' is_leaf=\''+rootNodes[i].is_Leaf+'\'  onclick=" retValue(this);return false;" href="#"  name=\'c'+rootNodes[i].node_id+'a\'>'
	          +layerHTML
	          +img_folder
	         +rootNodes[i].node_name
	         +'</A><BR>' 
     
     }
      count++;
    }
    //alert(count);
    if(count==0){
     curPardiv.style.display='none';
    }
    //alert(parnodeHTML)
    curPardiv.innerHTML=parnodeHTML
   // alert(curPardiv.id)
   //alert(curPardiv.innerHTML);
  }   
}
/*
 返回 代码类型和代码名称。
*/
function retValue(ob){
  //alert(ob.node_id+','+ob.par_id+','+ob.is_leaf+','+ob.node_name)
  var ret=ob.node_id+"|"+ob.node_name;
 // alert(ret);
  window.returnValue=ret;
  window.close();
}

