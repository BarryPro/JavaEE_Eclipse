<%@page contentType="text/html;charset=GBK"%>
<HTML>  
	<!--左边的树 -->  
	<head>
		 <META content="MSHTML 6.00.2800.1400" name=GENERATOR></HEAD>
	</head>	
     <%
        String strFlag =request.getParameter("strFlag");
        String contactId =request.getParameter("contactId");
        String contactMonth =request.getParameter("contactMonth");
        String strId =request.getParameter("strId");
        
        if(strId==null){
        	strId = "";
        }
        String isLeaf =request.getParameter("isLeaf");
        if(isLeaf==null){
        	isLeaf = "";
        }
        String firstInitree =request.getParameter("firstInitree");
        if(firstInitree==null){
        	firstInitree = "";
        }
        
     %>  
<STYLE type=text/css>TD {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
BODY {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
SELECT {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
A {
	FONT-SIZE: 9pt; COLOR: #000000; FONT-FAMILY: "宋体"; TEXT-DECORATION: none
}
A:hover {
	FONT-SIZE: 9pt; COLOR: #ff0000; FONT-FAMILY: "宋体"; TEXT-DECORATION: underline
}
</STYLE>  
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<SCRIPT language=javascript src="/npage/callbosspage/k170/tree/js/foldernav_main.js"></SCRIPT>
<script type="text/javascript" src="/njs/extend/prototype/prototype.js"></script>	
<!--modify wangyong 20090817 修改引入js，替换成吉林本地使用-->
<script src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>  
<script src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js" type="text/javascript"></script>
<!--script type="text/javascript" src="/njs/si/core_sitech_pack_new.js"></script-->

<script type="text/javascript" language="javascript" src="/njs/si/base.js"></script>
<SCRIPT type="text/javascript" language=javascript src="/njs/si/ajax.js"></SCRIPT>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<BODY>   
 <form name="form2" method="POST" action="">	        


<DIV id='mainDiv'>
  <%       
 			  /*if(strId.equals("")){
 		%>
<span><nobr>
<IMG style='cursor:hand'  onclick="img1Click('0');return false;"  src='/npage/callbosspage/k170/tree/images/Lminus.gif'  align='absMiddle' border=0 name='m0Tree'><IMG style='cursor:hand'  onclick="img2Click('0');return false;"  src='/npage/callbosspage/k170/tree/images/openfoldericon.gif' align='absMiddle' border=0 name='m0Folder'><span  class='item' style='cursor:hand'  onclick="spanClick('0');return false;"  ondblclick="spandblClick('0');return false;"  id='m0span'  nodeLevel='1' lastChildRoute='1' is_Leaf='0' isLast='1' isOpen='1' hasLoad='1' fullName='来电原因' >来电原因</span></nobr></span>
<BR>
<DIV traceName='来电原因->' class='child_show'  id='m0Child' >
<span><nobr><img src='/npage/callbosspage/k170/tree/images/white.gif' id= 'img00f'  align=absmiddle border='0'><IMG style='cursor:hand'  onclick="img1Click('00');return false;"  src='/npage/callbosspage/k170/tree/images/T.gif'  align='absMiddle' border=0 name='m00Tree'><IMG style='cursor:hand'  onclick="img2Click('00');return false;"  src='/npage/callbosspage/k170/tree/images/icon-page.gif' align='absMiddle' border=0 name='m00Folder'><span  class='item' style='cursor:hand'  onclick="spanClick('00');return false;"  id='m00span'  nodeLevel='2' lastChildRoute='1,0' is_Leaf='1' isLast='0' isOpen='0' hasLoad='0' fullName='未保存呼叫类型' >未保存呼叫类型</span></nobr></span>
<BR>
<span><nobr><img src='/npage/callbosspage/k170/tree/images/white.gif' id= 'img01f'  align=absmiddle border='0'><IMG style='cursor:hand'  onclick="img1Click('01');return false;"  src='/npage/callbosspage/k170/tree/images/T.gif'  align='absMiddle' border=0 name='m01Tree'><IMG style='cursor:hand'  onclick="img2Click('01');return false;"  src='/npage/callbosspage/k170/tree/images/icon-page.gif' align='absMiddle' border=0 name='m01Folder'><span  class='item' style='cursor:hand'  onclick="spanClick('01');return false;"  id='m01span'  nodeLevel='2' lastChildRoute='1,0' is_Leaf='1' isLast='0' isOpen='0' hasLoad='0' fullName='投诉申告' >投诉申告</span></nobr></span>
<BR>
<span><nobr><img src='/npage/callbosspage/k170/tree/images/white.gif' id= 'img02f'  align=absmiddle border='0'><IMG style='cursor:hand'  onclick="img1Click('02');return false;"  src='/npage/callbosspage/k170/tree/images/Tplus.gif'  align='absMiddle' border=0 name='m02Tree'><IMG style='cursor:hand'  onclick="img2Click('02');return false;"  src='/npage/callbosspage/k170/tree/images/foldericon.gif' align='absMiddle' border=0 name='m02Folder'><span  class='item' style='cursor:hand'  onclick="spanClick('02');return false;"  ondblclick="spandblClick('02');return false;"  id='m02span'  nodeLevel='2' lastChildRoute='1,0' is_Leaf='0' isLast='0' isOpen='0' hasLoad='0' fullName='业务咨询' >业务咨询</span></nobr></span>
<BR>
<DIV traceName='业务咨询->' class='child'  id='m02Child' ></DIV>
<span><nobr><img src='/npage/callbosspage/k170/tree/images/white.gif' id= 'img04f'  align=absmiddle border='0'><IMG style='cursor:hand'  onclick="img1Click('04');return false;"  src='/npage/callbosspage/k170/tree/images/Tplus.gif'  align='absMiddle' border=0 name='m04Tree'><IMG style='cursor:hand'  onclick="img2Click('04');return false;"  src='/npage/callbosspage/k170/tree/images/foldericon.gif' align='absMiddle' border=0 name='m04Folder'><span  class='item' style='cursor:hand'  onclick="spanClick('04');return false;"  ondblclick="spandblClick('04');return false;"  id='m04span'  nodeLevel='2' lastChildRoute='1,0' is_Leaf='0' isLast='0' isOpen='0' hasLoad='0' fullName='业务办理' >业务办理</span></nobr></span>
<BR>
<DIV traceName='业务办理->' class='child'  id='m04Child' ></DIV>
<span><nobr><img src='/npage/callbosspage/k170/tree/images/white.gif' id= 'img06f'  align=absmiddle border='0'><IMG style='cursor:hand'  onclick="img1Click('06');return false;"  src='/npage/callbosspage/k170/tree/images/Tplus.gif'  align='absMiddle' border=0 name='m06Tree'><IMG style='cursor:hand'  onclick="img2Click('06');return false;"  src='/npage/callbosspage/k170/tree/images/foldericon.gif' align='absMiddle' border=0 name='m06Folder'><span  class='item' style='cursor:hand'  onclick="spanClick('06');return false;"  ondblclick="spandblClick('06');return false;"  id='m06span'  nodeLevel='2' lastChildRoute='1,0' is_Leaf='0' isLast='0' isOpen='0' hasLoad='0' fullName='外呼' >外呼</span></nobr></span>
<BR>
<DIV traceName='外呼->' class='child'  id='m06Child' ></DIV>
<span><nobr><img src='/npage/callbosspage/k170/tree/images/white.gif' id= 'img07f'  align=absmiddle border='0'><IMG style='cursor:hand'  onclick="img1Click('07');return false;"  src='/npage/callbosspage/k170/tree/images/Tplus.gif'  align='absMiddle' border=0 name='m07Tree'><IMG style='cursor:hand'  onclick="img2Click('07');return false;"  src='/npage/callbosspage/k170/tree/images/foldericon.gif' align='absMiddle' border=0 name='m07Folder'><span  class='item' style='cursor:hand'  onclick="spanClick('07');return false;"  ondblclick="spandblClick('07');return false;"  id='m07span'  nodeLevel='2' lastChildRoute='1,0' is_Leaf='0' isLast='0' isOpen='0' hasLoad='0' fullName='12580信息咨询' >12580信息咨询</span></nobr></span>
<BR>
<DIV traceName='12580信息咨询->' class='child'  id='m07Child' ></DIV>
<span><nobr><img src='/npage/callbosspage/k170/tree/images/white.gif' id= 'img08f'  align=absmiddle border='0'><IMG style='cursor:hand'  onclick="img1Click('08');return false;"  src='/npage/callbosspage/k170/tree/images/Lplus.gif'  align='absMiddle' border=0 name='m08Tree'><IMG style='cursor:hand'  onclick="img2Click('08');return false;"  src='/npage/callbosspage/k170/tree/images/foldericon.gif' align='absMiddle' border=0 name='m08Folder'><span  class='item' style='cursor:hand'  onclick="spanClick('08');return false;"  ondblclick="spandblClick('08');return false;"  id='m08span'  nodeLevel='2' lastChildRoute='1,1' is_Leaf='0' isLast='1' isOpen='0' hasLoad='0' fullName='→外包咨询' >外包咨询</span></nobr></span>
<BR>
<DIV traceName='外包咨询->' class='child'  id='m08Child' ></DIV>
</DIV>
 <%  
		    }*/
		%> 
  
</DIV>
      <input type="hidden" name="strFlag" id="strFlag" value="<%=strFlag%>">
      <input type="hidden" name="contactId" id="contactId" value="<%=contactId%>">
      <input type="hidden" name="contactMonth" id="contactMonth" value="<%=contactMonth%>">  
      <input type="hidden" name="strId" id="strId" value="<%=strId%>"> 		
        
 </form>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 
 	if(parent.opener.cCcommonTool!=undefined)
 	parent.opener.cCcommonTool.DebugLog("javascript *** k172_callCauseBaseTree_new.jsp begin");
 function setOpenPreFolder(node_id){
 	  	if(node_id!='0'){
 				parent.temp_callCauseNode_=node_id;
 	  	}else{
 	  		parent.temp_callCauseNode_='';
 	  	}	
 	}

//座席单击来电原因，取得对应流水数据
 function findContactInfo()
 { 
 	   if(parent.opener.cCcommonTool!=undefined)
 	   parent.opener.cCcommonTool.DebugLog("javascript *** findContactInfo begin");
 	   parent.unCheckBoxs();
     var contactId="";
     var contactMonth="";
     var strFlag='<%=strFlag%>';
    
     if(strFlag==9){//9表示未保存来电原因的流水。
     contactId='<%=contactId%>';
     contactMonth='<%=contactMonth%>';
     }
     else{
      contactId=parent.document.getElementById("contactId").value; 
      contactMonth = parent.document.getElementById("contactMonth").value;
     }
    
    var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_selectCause.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
    mypacket.data.add("strContactId",contactId);
    mypacket.data.add("strContactMonth",contactMonth);
	  core.ajax.sendPacket(mypacket,doFindContactInfo,true);
	  mypacket=null; 
	  if(parent.opener.cCcommonTool!=undefined)
 	   parent.opener.cCcommonTool.DebugLog("javascript *** findContactInfo end");
 }
 //findContactInfo回掉函数
 function doFindContactInfo(packet)
 {
 	   if(parent.opener.cCcommonTool!=undefined)
 	   parent.opener.cCcommonTool.DebugLog("javascript  doFindContactInfo begin");

     var call_cause_id= packet.data.findValueByName("call_cause_id");
     var callcausedescs =packet.data.findValueByName("callcausedescs"); 
     var remarkInfo =   packet.data.findValueByName("remarkInfo"); 
   // alert(call_cause_id);
    //alert(callcausedescs);
    // alert(remarkInfo);
     if(call_cause_id!=null ||call_cause_id!=''||callcausedescs!=null ||call_cause_id!='')
     { 
        insertShowName(call_cause_id,callcausedescs,remarkInfo);
     }
     
     iniNode_import();
     if(parent.opener.cCcommonTool!=undefined)
 	   parent.opener.cCcommonTool.DebugLog("javascript  doFindContactInfo end");
     
 }	
 
// 取消所有的checkbox选中
function unCheckBoxBySelect(){
		var checkBoxItems = document.getElementsByTagName("input");

   	
		for(var i=0;i<checkBoxItems.length;i++){
				if(checkBoxItems[i].type=='checkbox'&&checkBoxItems[i].checked==true){
						checkBoxItems[i].checked=false;
				}
		}
	
		 
	}
     


function insertShowName(call_cause_id,callcausedescs,remarkInfo)
{
	if(parent.document.getElementById("pre_node_Id")!=null){
	   parent.document.getElementById("pre_node_Id").value=call_cause_id;
  }
  if(parent.document.getElementById("pre_node_Name")!=null){
		parent.document.getElementById("pre_node_Name").value=callcausedescs;
  }


  parent.document.getElementById("node_Id").value=call_cause_id;
  parent.document.getElementById("my_div").innerHTML=callcausedescs;
  var arr = parent.document.getElementsByTagName("span");
  //alert(arr.length);
  //alert("1");
  var mynodename = "";
  for(var i=0;i<arr.length;i++){
  		var name = arr[i].innerHTML;
 			name = name.replace("&lt;","");
 			name = name.replace("&gt;","");
 			name = name.replace("<BR>","");
 			mynodename = mynodename+","+name;
  }
  parent.show_Name.value=mynodename;
  //parent.document.getElementById("show_Name").value=callcausedescs;
  var strFlag='<%=strFlag%>';
  if(strFlag==9){
		   parent.document.getElementById("node_Name").value="";
		   parent.document.getElementById("remarkInfo").value="";
		   if(parent.document.frames["myFrame3"].window){
		   		parent.document.frames["myFrame3"].window.unCheckBoxBySelect();
		   }
   
   }
   else{
   
		   parent.document.getElementById("remarkInfo").value=remarkInfo;
		   
		   //alert(mynodename);
		   var arrid =call_cause_id.split(",");
		   var arrname = mynodename.split(",");
		   for(var i=0;i<arrid.length;i++){
		   		
		   		var myid = arrid[i];
		   		var myname =arrname[i];
		   		//alert(myid);
		   		if(myid!=""){
		   				parent.document.getElementById("select_Name").options.add(new Option(myname,myid));
		   		}
		   }
		   //alert(mynodename);
		   parent.document.getElementById("node_Name").value=mynodename;
   }
}


//判断一个字符串是否在数组中出现
function isStr(strtreeData,str){
	if(str!=null){
			  for(var j=0;j<str.length;j++){
     	if(strtreeData==str[j]){
     		return true;
     		}
		}
}  
   	return false;
	}   
	
	/*
	*判断节点ID是否在选中的集合中
	*/
	function isInShowName(node_id){
	
	 var els =parent.document.getElementsByTagName("span");
	 if(els==null||els==undefined)return false;
	 for(var i=0;i<els.length;i++){
	   if(els[i].id==node_id){
	     return true;
	   }
	 }
	 return false;
	}
	//满足查询条件的树
	function selectInfo(selectName)
	{      
          Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseNewTree.jsp?caption="+selectName,"myFrame2");
	  
	}
	function img1Click(par_id){
		changeColor(par_id);
		var pardiv=document.getElementById('m'+par_id+'span');
		//针对非叶子节点，打开加载数据
		if(pardiv.is_Leaf=='0'){
			setOpenPreFolder(par_id);
			//节点层数的限制
			if(pardiv.nodeLevel<=leftTreeMaxLevel){
				if(pardiv.isOpen=='0'){
					if(pardiv.hasLoad=='0'){
						getChildren(par_id);
						pardiv.isOpen='1';
						//pardiv.hasLoad='1';
						hideOrShow_(par_id);
			  	}else{
			  		pardiv.isOpen='1';
			  		hideOrShow_(par_id);	
			  		if(par_id=='07'){
  	 					var spandiv_ = document.getElementById('img'+par_id+'f');
  	 					spandiv_.scrollIntoView();
  					}  	   	  	
			  	}
		 	 	}else{		  		
		  		pardiv.isOpen='0';
		  		hideOrShow_(par_id);
		  	}
			}else{
				window.open("/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+par_id+"&fullname="+pardiv.fullName+"&isleaf="+pardiv.is_Leaf+"&selectPara=6","myFrame3");	
			}
		}else{
				window.open("/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+par_id+"&fullname="+pardiv.fullName+"&isleaf="+pardiv.is_Leaf+"&selectPara=2","myFrame3");
			}	
	}
	function img2Click(par_id){
		img1Click(par_id);
	}
	function spanClick(par_id){
		if(parent.opener.cCcommonTool!=undefined)
 	   parent.opener.cCcommonTool.DebugLog("javascript *** spanClick begin");
		changeColor(par_id);
		var pardiv=document.getElementById('m'+par_id+'span');
		//针对非叶子节点，打开加载数据
		if(pardiv.is_Leaf=='0'){
			setOpenPreFolder(par_id);
			//节点层数的限制
			if(pardiv.nodeLevel<=leftTreeMaxLevel){
				if(pardiv.isOpen=='0'){
					if(pardiv.hasLoad=='0'){
						
						getChildren(par_id);
						pardiv.isOpen='1';
						//pardiv.hasLoad='1';
						hideOrShow_(par_id);
			  	}else{
			  		pardiv.isOpen='1';
			  		hideOrShow_(par_id);
			  		//20090605 jiangbing	
			  		if(par_id=='07'){
  	 					var spandiv_ = document.getElementById('img'+par_id+'f');
  	 					spandiv_.scrollIntoView();
  					}  	  	
			  	}
			  	
		 	 	}else{		  		
		  		pardiv.isOpen='0';
		  		hideOrShow_(par_id);
		  	}
			}else{
				window.open("/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+par_id+"&fullname="+pardiv.fullName+"&isleaf="+pardiv.is_Leaf+"&selectPara=6","myFrame3");	
			}
		}else{
				window.open("/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+par_id+"&fullname="+pardiv.fullName+"&isleaf="+pardiv.is_Leaf+"&selectPara=2","myFrame3");
			}	
			if(parent.opener.cCcommonTool!=undefined)
 	   parent.opener.cCcommonTool.DebugLog("javascript *** spanClick end");
	}
	
	function spandblClick(par_id){
		changeColor(par_id);
		var pardiv=document.getElementById('m'+par_id+'span');
		if(pardiv.is_Leaf=='0'){
				if(pardiv.isOpen=='1'){
						pardiv.isOpen='0';
		  		  hideOrShow_(par_id);
		 	 	}			
		}
	}
  function doOpen(){
  	    var strId = '<%=strId%>';
		    openLeftTree('0','2',leftTreeMaxLevel,strId,'1','1');
		}
	function iniNode_import(){
		if(parent.opener.cCcommonTool!=undefined)
 	   parent.opener.cCcommonTool.DebugLog("javascript *** iniNode_import begin");
  	<%       
 			  if(strId.equals("")){
		%>
		setTimeout("iniRootNodes('mainDiv','0','1','0','1')",100);
		
		<% 
		    }else{
		%>
		if(parent.document.frames['myFrame3'].document){
			var rightHtmlDiv = parent.document.frames['myFrame3'].document.getElementById('mainDiv');
			if(rightHtmlDiv!=null){
		   	rightHtmlDiv.innerHTML='';
	  	}
	  }
		iniRootNodes('mainDiv','0','1','0','5');
		var strId = '<%=strId%>';
		<!--modify wangyongjl 20090818 将原有2长度修改为3-->
		if(strId.length>(3*leftTreeMaxLevel)){
			 var subtree = strId.substring(0,3*leftTreeMaxLevel);
			 window.open("/npage/callbosspage/k170/k172_callCauseBaseLeaveTree_new.jsp?nodeId="+subtree+"&strId="+strId+"&isleaf=0","myFrame3")
		}
		<%    	
		    	}
		%>
		if(parent.opener.cCcommonTool!=undefined)
 	   parent.opener.cCcommonTool.DebugLog("javascript *** iniNode_import end");
	}
	window.onload = function(){
		var firstInitree = '<%=firstInitree%>';
		if(firstInitree=='1'){
		   setTimeout('findContactInfo()',100);
		 }else{
		 		iniNode_import();
		 }
	}
	if(parent.opener.cCcommonTool!=undefined)
 	parent.opener.cCcommonTool.DebugLog("javascript *** k172_callCauseBaseTree_new.jsp end");

</SCRIPT>        
