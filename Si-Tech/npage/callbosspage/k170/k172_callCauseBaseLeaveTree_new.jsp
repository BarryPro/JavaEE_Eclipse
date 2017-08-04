<%@page contentType="text/html;charset=GBK"%>
<HTML>    
    <HEAD> 
    	  <META http-equiv=Content-Type content="text/html; charset=gbk">  
    	  <link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link> 
        <SCRIPT language=javascript src="/npage/callbosspage/k170/tree/js/foldernav_main.js"></SCRIPT>
        <script type="text/javascript" src="/njs/extend/prototype/prototype.js"></script>	
<!--modify wangyong 20090817 修改引入js，替换成吉林本地使用-->
<script src="/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>  
<script src="/njs/si/core_sitech_pack.js" type="text/javascript"></script>
<!--script type="text/javascript" src="/njs/si/core_sitech_pack_new.js"></script-->	
				<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
				<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
      </HEAD> 
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
      <%
         String nodeId=request.getParameter("nodeId");
         String fullname=request.getParameter("fullname");
         String isleaf=request.getParameter("isleaf");
         String caption= request.getParameter("caption");
         String selectPara=request.getParameter("selectPara");
         String strId =request.getParameter("strId");
         if(selectPara==null){
         		selectPara = "";
         }
         if(selectPara.equals("")){
         		if("1".equals(isleaf)){
         				selectPara = "4";
         		}
         }
         String mynodeId=request.getParameter("mynodeId");
         String myid = request.getParameter("myid");
         String iniNum = request.getParameter("iniNum");
      %>
      <SCRIPT type=text/javascript> 
      	if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** k172_callCauseBaseLeaveTree_new.jsp begin");
        var Id='<%=nodeId%>'; 
        var fullname='<%=fullname%>';
        var isleaf='<%=isleaf%>';
        var caption='<%=caption%>'; 
        var selectPara='<%=selectPara%>';
        var mynodeId = parent.document.getElementById("node_Id").value;
        gobal_check_str = mynodeId;
        var myid = '<%=myid%>';
        var iniNum = '<%=iniNum%>';
        var strFlag=parent.document.frames["myFrame2"].form2.strFlag.value;
				var contactId ='';
				if(strFlag==9){
   				contactId=parent.document.frames["myFrame2"].form2.contactId.value;
  			}
  			else{
  				contactId=parent.document.getElementById("contactId").value;
  			}
      </SCRIPT>
     
<BODY oncontextmenu="popMenu('itemMenu','80','11');event.returnValue=false;event.cancelBubble=true;return false;">           
<TABLE><TR>
<input type="hidden" name="isTag" id="isTag" value="">
<input type="hidden" name="isTagFull" id="isTagFull" value="">
<TD vAlign=top width="70%">
<DIV id="mainDiv" ></DIV>
</TD>
<TD vAlign=top width="70%">
<DIV id="childTree">
	</DIV>
</TD>
  <select id="myselect" style="display:none"></select>  	
        </TR>
        
        </TABLE>
        
<div id='itemMenu' style='display:none;'>

<table border='1' width='100%' height='100%' bgcolor='#dfe8f6' style='border:thin;font-size: 12px;border-right:1px solid #8eb2e2;	border-bottom:1px solid #8eb2e2;	border-top:1px solid #b4d4fe;	border-left:1px solid #b4d4fe;' cellspacing='0'>
	<tr>
		<td style='cursor:default;border:outset 1;' align='center'
			onclick='parent.formsub(0)'>收起</td>
	</tr>
	<tr>
		<td style='cursor:default;border:outset 1;' align='center'
			onclick='parent.formsub(1);'>展开</td>
	</tr>
	

</table>
</div>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 
    
  function setOpenPreFolder(node_id){
 			parent.temp_callCauseNode_=node_id;
 	
 	}
	
	//取消
	function deleteBoxList(node_id)
	{
	   var par_object=parent.document.getElementById("show_Name");
	   var par_del_child=parent.document.getElementById("node_id");
	   var children = par_object.childNodes;
	  // var a=parent.document.getElementsByTagName("br");
	     deleteShowName(node_id);   
	   for(var i=0;i<children.length;i++){	
	     if(children[i].id==node_id){	
	       par_object.removeChild(children[i]);	
	       var showname=parent.show_Name.value;
	       parent.document.getElementById("node_Name").value=showname;
	  
	     }
	   }
	   //alert(node_id);
	   var myselect=parent.select_Name.options;
	   //alert(myselect);
	   for(var i=0;i<myselect.length;i++){
	   		
	   		if(myselect[i].value==node_id){
	   				
	   				myselect.remove(i);
	   				break;
	   		}
	   }
	   
	}
//判断是checkbox是否有值 
function isCheckBoxsList(){
	var res = false;
	var checkBoxItems = document.getElementsByTagName("input");  	
		for(var i=0;i<checkBoxItems.length;i++){
				if(checkBoxItems[i].type=='checkbox'&&checkBoxItems[i].checked==true){
						res=true;
						break;
				}
		}
		return res;
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


//显示选中节点在的全称(不查数据库判断，数据可能不准确)
function showNodeIdList(arr,id){
		var j=0;		
		var isflag=0;
	  for(var i=0;i<arr.length;i++,j++){
	  	var pardiv2=document.getElementById('m'+arr[i]+'span');
						 	if(pardiv2.is_Leaf==1){
								 	 if(!isInShowName(arr[i])){
								 	 	     
									      var mytext = arr[i]+'→'+pardiv2.fullName;
									      var myvalue = arr[i];
									      var mylen = parent.select_Name.options.length;
												if(mylen<10){
														var myOption = new Option(mytext,myvalue);
											
									      		parent.select_Name.options.add(myOption); 
									      }else{  
									      		var checkBoxItem = document.getElementById("chk"+id);		
														if(checkBoxItem.checked==true)
   													{ 
      												checkBoxItem.checked = false;
      												isflag=1;   
      												rdShowMessageDialog('来电原因项目添加已经满10个',2);
												 		  break; 
   													}
											 		      
											 	}
									    
									      parent.document.getElementById("node_Id").value=parent.document.getElementById("node_Id").value+','+arr[i];
									      parent.show_Name.value=parent.show_Name.value+","+arr[i]+'→'+pardiv2.fullName;
									      parent.document.getElementById("node_Name").value=parent.show_Name.value;
									      //parent.document.getElementById("funllName").value=parent.document.getElementById("funllName").value+","+tree.getUserData(arr[i],"fullname");
							     	}
					    }
	
				 		

		 	}	
		 

			//显示提出弹出框
			if(isflag==1){
					//rdShowMessageDialog('来电原因项目添加已经满10个',2);
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
	 var els =parent.select_Name.options;
	 if(els.length<0)return false;
	   for(var i=0;i<els.length;i++){
	   if(els[i].value==node_id){
	     return true;
	   }
	 }
	 return false;
	}  
  /*
  * 从数组中删除选中相同的数据
  */
  function deleteShowName(node_id){
  
  var elsId =parent.document.getElementById("node_Id").value;
  var elsName = parent.document.getElementById("node_Name").value;
  var pardiv2=document.getElementById('m'+node_id+'span');
  var node_name="";
  if(selectPara==1){
    node_name=fullname;
  }
  else{
     node_name = pardiv2.fullName;
  }
    node_name = node_id+"→"+node_name;
  var elsArray=elsId.split(",");
  var elsNameArray = elsName.split(",");
  if(elsId==null||elsId==undefined)return false;
  for(var i=1;i<elsArray.length;i++){
      if(elsArray[i]==node_id){
	       elsArray.splice(i,1);
	       parent.document.getElementById("node_Id").value=elsArray.toString();
   }
  }
  for(var i=1;i<elsNameArray.length;i++){
      if(elsNameArray[i]==node_name){
	       //elsArray.splice(i,1);
	       elsNameArray.splice(i,1);
	       parent.document.getElementById("node_Name").value=elsNameArray.toString();
	       parent.document.getElementById("show_Name").value=elsNameArray.toString();
   }
  }
  
  }
	//initBaseLeaveTree(Id);
	
	
	function firstUnCheckItem(reId){ 
	 // document.getElementById(reId).click(); 
	  var strlist ='';	
	  //var els =parent.document.getElementsByTagName("span"); 
	    var els=mynodeId.split(",");
	  if(els==null||els==undefined)return false;
	  for(var i=0;i<els.length;i++){
	       if(reId==els[i])
	       {
	         return true;
	       }   
		}
		return false;
		}


function img1Click(par_id){
	  changeColor(par_id);
		var pardiv=document.getElementById('m'+par_id+'span');
		//针对非叶子节点，打开加载数据
		if(pardiv.is_Leaf=='0'){
			  setOpenPreFolder(par_id);
				if(pardiv.isOpen=='0'){
					if(pardiv.hasLoad=='0'){
						getChildren(par_id);
						pardiv.isOpen='1';
						//pardiv.hasLoad='1';
						hideOrShow_(par_id);
			  	}else{
			  		pardiv.isOpen='1';
			  		hideOrShow_(par_id);	  	  	
			  	}
		 	 	}else{		  		
		  		pardiv.isOpen='0';
		  		hideOrShow_(par_id);
		  	}			
		}else{
				var checkBoxItem = document.getElementById("chk"+par_id);
				if(checkBoxItem.checked==false){
					checkBoxItem.checked=true;
			  }else{
			    checkBoxItem.checked=false;
			  }
				checkBoxClick(par_id);
		}
	}
	function img2Click(par_id){
		img1Click(par_id);
	}
	function spanClick(par_id){
		changeColor(par_id);
		var pardiv=document.getElementById('m'+par_id+'span');
		//针对非叶子节点，打开加载数据
		if(pardiv.is_Leaf=='0'){
			//节点层数的限制
        setOpenPreFolder(par_id);
				if(pardiv.isOpen=='0'){
					if(pardiv.hasLoad=='0'){
						
						getChildren(par_id);
						pardiv.isOpen='1';
						//pardiv.hasLoad='1';
						hideOrShow_(par_id);
			  	}else{
			  		pardiv.isOpen='1';
			  		hideOrShow_(par_id);	  	  	
			  	}
		 	 	}else{		  		
		  		pardiv.isOpen='0';
		  		hideOrShow_(par_id);
		  	}
			
		}
		else{
				var checkBoxItem = document.getElementById("chk"+par_id);
				if(checkBoxItem.checked==false){
					checkBoxItem.checked=true;
			  }else{
			    checkBoxItem.checked=false;
			  }
				checkBoxClick(par_id);
		}
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
	function checkBoxClick(id){
		changeColor(id);
		var checkBoxItem = document.getElementById("chk"+id);
		
		if(checkBoxItem.checked==false)
   	{ 
      	deleteBoxList(id);      
   	}
   	var checkBoxItems = document.getElementsByTagName("input");
		var arr = new Array();
   	var m = 0;
		for(var i=0;i<checkBoxItems.length;i++){
				if(checkBoxItems[i].type=='checkbox'&&checkBoxItems[i].checked==true){
					arr[m] = checkBoxItems[i].value;
					m++;
				}
		}
	 	if(m>0){
			showNodeIdList(arr,id);//性能优化操作 不用再去查询数据库
		}  
		
		if(parent&&parent.opener){
			//alert(parent.opener.document.getElementById("contactId").value);
			var nowId=parent.document.getElementById("contactId").value;
			 if(nowId==contactId){
				var selectnodeId_ = parent.document.getElementById("node_Id").value;
				if(selectnodeId_!=null){
		  		var selectNodes = selectnodeId_.split(',');
		  		if(selectNodes.length>1){
		  			parent.opener.flag='1';
		  		}else{
		  			parent.opener.flag='0';
		  		}
				}
		  }
		}
	}
	function doOpen(){
		    var strId = '<%=strId%>';
				openLeftTree('<%=nodeId%>','2','',strId,'1','1');
		}
	function doOpen2(){
				openLeftTree('<%=nodeId%>','1',autoOpenMaxLevel,'','1','1');
		}
	window.onload = function(){
		<%
 				if(nodeId==null){
 						nodeId = "";
 				}
 			  if(!nodeId.equals("")){
 			      
        	  if(strId==null){
        			strId = "";
        		}
 			  		if(strId.equals("")){
 		%>        
 		          if('<%=isleaf%>'=='1'){
		      			iniRootNodes('mainDiv','<%=nodeId%>','0','1','<%=selectPara%>');
		      	  }else{
		      	  	iniRootNodes('mainDiv','<%=nodeId%>','0','1','<%=selectPara%>');
		      	  }
		<%  
		    		}else{
		%>
							iniRootNodes('mainDiv','<%=nodeId%>','0','1','5');
							
		<%    	
		    		}
		    }
		%>
	}
	if(parent.opener.cCcommonTool!=undefined)
 	      parent.opener.cCcommonTool.DebugLog("javascript *** k172_callCauseBaseLeaveTree_new.jsp end");

//F8挂机
    function keydown_release(){
			  if (window.event.keyCode==119){
			     //使用F8键挂机
			     if(parent.opener.document.getElementById('K013') != undefined){
			      
			      parent.opener.document.getElementById('K013').click();//子窗体
			     
			     } 
			     event.returnValue=false;
			  }
			}

    var obj = document.getElementsByTagName("body");

		if(window.addEventListenner){
		  obj[0].addEventListenner("keydown",keydown_release,false);
		}
		else
		 obj[0].attachEvent("onkeydown",keydown_release);
		 
//右键菜单
function popMenu(menuDiv,width,rowControlString)

{
    //创建弹出菜单
    var pop=window.createPopup();
    //设置弹出菜单的内容
    pop.document.body.innerHTML=document.getElementById(menuDiv).innerHTML;   
    var rowObjs=pop.document.body.all[0].rows;
    //获得弹出菜单的行数
    var rowCount=rowObjs.length;
    //循环设置每行的属性
    for(var i=0;i<rowObjs.length;i++)

    {
        //如果设置该行不显示，则行数减一
        var hide=rowControlString.charAt(i)!='1';
        if(hide){
            rowCount--;
        }
        //设置是否显示该行
        rowObjs[i].style.display=(hide)?'none':'';
        //设置鼠标滑入该行时的效果
        rowObjs[i].cells[0].onmouseover=function()
        {
            this.style.background='#0066CC';
            this.style.color='black';
        }
        //设置鼠标滑出该行时的效果
        rowObjs[i].cells[0].onmouseout=function(){
            this.style.background='#dfe8f6';
            this.style.color='black';
        }
    }
    //屏蔽菜单的菜单
    pop.document.oncontextmenu=function()
    {
            return false;
    }
    //选择右键菜单的一项后，菜单隐藏
    pop.document.onclick=function()
    {
            pop.hide();
    }
    //显示菜单
    pop.show(event.clientX-1,event.clientY,width,rowCount*25,document.body);
    return true;
}
function formsub(flag){
	var nodeId =  '<%=nodeId%>';
	var parSpandiv=document.getElementById('m'+nodeId+'span');
	if(parSpandiv==null||parSpandiv.is_Leaf=='1'){
		 	return;
	}
	if(flag=='0'){
		 var spandivs = document.getElementsByTagName('span');
		 for(i=0;i<spandivs.length;i++){
		 		var sid = spandivs[i].id;
		 		if(sid.indexOf('span')!=-1&&sid!='m'+nodeId+'span'){ 
		 			 if(spandivs[i].isOpen=='1'&&spandivs[i].is_Leaf=='0'){
		 			 	  spanClick(sid.substring(1,sid.length-4));
		 			 }
		 		}	
		 }
	}
	if(flag=='1'){
		 if(parSpandiv.isOpen=='0'){
		 		spanClick(nodeId);
		 	}
		 gobal_check_str = parent.document.getElementById("node_Id").value;
		 doOpen2();
	}
} 

</SCRIPT>        

   
      
