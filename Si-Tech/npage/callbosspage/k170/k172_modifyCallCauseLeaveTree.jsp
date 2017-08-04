<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>    
    <HEAD>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css" type=text/css rel=STYLESHEET>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>
      </HEAD> 
      <%
         String nodeId=request.getParameter("nodeId");
         String fullname=request.getParameter("fullname");
         String isleaf=request.getParameter("isleaf");
         String caption= request.getParameter("caption");
         String selectPara=request.getParameter("selectPara");
         String mynodeId=request.getParameter("mynodeId");
         String myid = request.getParameter("myid");
         String iniNum = request.getParameter("iniNum");
      %>
      <SCRIPT type=text/javascript> 
        var Id='<%=nodeId%>'; 
        var fullname='<%=fullname%>';
        var isleaf='<%=isleaf%>';
        var caption='<%=caption%>'; 
        var selectPara='<%=selectPara%>';
        var mynodeId = '<%=mynodeId%>';
        var myid = '<%=myid%>';
        var iniNum = '<%=iniNum%>';
      </SCRIPT>
     
<BODY>           
<TABLE><TR>
<input type="hidden" name="isTag" id="isTag" value="">
<input type="hidden" name="isTagFull" id="isTagFull" value="">
<TD vAlign=top width="500">
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top width="50%">
<DIV id="childTree">
	</DIV>
</TD>
        	
        </TR>
        
        </TABLE>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 
    
		function fixImage(id){
			switch(tree.getLevel(id)){
			case -1:	
			tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
				break;
			case 0:	
			tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
				break;
			case 1:
			tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
				break;
			case 2:
			tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');			
				break;
			case 3:
			tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');			
				break;			
			default:
			tree.setItemImage2(id,'leaf.gif','folderClosed.gif','folderOpen.gif');			
				break;
			}
		}	
//响应鼠标单击事件，查询数据库得到下一节点
function onNodeSelect(id){   
//alert(id);
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")==0){
  	//alert("1");
  	if(tree.getOpenState(id)==1){
         tree.closeAllItems(id);
        }
    else if(tree.getOpenState(id)==-1){
    	   tree.openItem(id);
       } 
    else{
	tree.showItemCheckbox(tree.getSelectedItemId(),0);
	tree.showItemSign(tree.getSelectedItemId(),1);
	 getTreeListByNodeId(tree.getSelectedItemId()); //用ajax动态查询数据
	 }	
  }   
 else
   {
    if(iniNum!=2 && tree.isItemChecked(id)!=0){
     var myarr = mynodeId.split(",");
     for(var i=0;i<myarr.length;i++){
     		if(id==myarr[i]){
     				 if(tree.getUserData(id,"isleaf")==1){ 
				        tree.setCheck(tree.getSelectedItemId(),true)
				        tree.showItemCheckbox(id,1);
				        tree.showItemSign(id,0);
				        tree.setItemImage2(id,'leaf.gif','folderClosed.gif','folderOpen.gif');
				     }      				
     		}
     }
     }
     if(tree.isItemChecked(id)==0){
         tree.setCheck(id,true);
         var allCheckItem=tree.getAllCheckedBranches();
         if(allCheckItem!=null){
         showNodeIdList(allCheckItem,id);
         }
     }
     else{
         tree.setCheck(id,false);
         deleteBoxList(id);
     }
     }
}
 //响应checkbox选中事件，把提示信息显示到另外一个页面
function onCheckBoxsBySelect(id){
	//alert("1");
  var allCheckItem=tree.getAllCheckedBranches();
   if(tree.isItemChecked(id)==0)
   {	
   		//alert("1");
      deleteBoxList(id);
   }
    // alert(allCheckItem);
	if(allCheckItem!=null){
		showNodeIdList(allCheckItem,id);//性能优化操作 不用再去查询数据库
//	getIeafList(allCheckItem);  老方法(需要查询数据库) 不推荐
		}  
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
	   var myselect=parent.document.getElementById("select_Name").options;
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
	var allCheckItem=tree.getAllCheckedBranches();
	//alert(allCheckItem);
	if(allCheckItem!=null&&allCheckItem!=''){
		return true;
		}else{
		return false;	
		} 
	}	 
// 取消所有的checkbox选中
function unCheckBoxBySelect(){
var allCheckItem=tree.getAllCheckedBranches();
if(allCheckItem!=null&&allCheckItem!=''){
var str = new Array();
str=allCheckItem.split(",");
for(var i=0;i<str.length;i++){
//	alert("str"+str[i]);
	tree.setCheck(str[i],false);
	}
		}  
	}    
	//构建一个动态树
function initBaseLeaveTree(Id){	
          tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);  
          tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");   
        //tree.enableCheckBoxes(1);
        //tree.enableSmartCheckboxes(1);
        //tree.enableThreeStateCheckboxes(true);    
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseLeaveXml.jsp?id="+Id+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara);      
          tree.setOnClickHandler(onNodeSelect);
          tree.setOnCheckHandler(onCheckBoxsBySelect);
        //tree.enableHighlighting(0);
        //tree.disableCheckbox("0",0);
        //tree.showItemCheckbox(Id,0);
        //tree.setOnOpenStartHandler(onNodeSelect);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseLeaveXml.jsp?id="+Id+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara); 
          if(isleaf==0){  
	        document.getElementById(Id).click();  
	        }
	        //单击选中项
	        if(isleaf==1&&iniNum==1){
	               if(Id!=undefined){
	                tree.setCheck(Id,true);
	                tree.showItemCheckbox(Id,1);
				          tree.showItemSign(Id,0);
				          tree.setItemImage2(Id,'leaf.gif','folderClosed.gif','folderOpen.gif');
	                var allCheckItem=tree.getAllCheckedBranches();
	                if(allCheckItem!=null){
	                showNodeIdList(allCheckItem,Id);
	                }
	              }
	              else{
	                tree.setCheck(Id,true);
	             }
	        }
	      if(isleaf==1&&iniNum==2){
	        tree.setCheck(Id,false);
	        tree.showItemCheckbox(Id,1);
				  tree.showItemSign(Id,0);
				  tree.setItemImage2(Id,'leaf.gif','folderClosed.gif','folderOpen.gif');
	        deleteBoxList(Id);
	      }
	}     
        </SCRIPT> 

<SCRIPT type=text/javascript> 

// 根据选中的节点id 返回该节点下子节点
function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getChildTreeList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("nodeId",strSelectedNodeid);
	core.ajax.sendPacket(packet,doProcessGetList,false);
	packet=null;
}
//getTreeListByNodeId的回调函数
	function doProcessGetList(packet){
   var childNodeList = packet.data.findValueByName("worknos");
   var nodeId= packet.data.findValueByName("nodeId");   
     insertChildNodeList(childNodeList);
} 
//做插入操作的函数  
function insertChildNodeList(retData){
    
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
   	var str = new Array();
   	if(varSubItems!=null&&varSubItems!=''){
   		 str=varSubItems.split(",");
   		 for(var i=0;i<retData.length;i++){
   		 //alert("getSubItems is not null:\t"+retData[i][3]);
       if(!isStr(retData[i][0],str)){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	     
       }
        // alert("isleaf0:\t"+retData[i][3]);
       
       if(retData[i][3]==0){
        	 tree.showItemCheckbox(retData[i][0],0);
        	 tree.showItemSign(retData[i][0],1);
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]==1){
            if(firstUnCheckItem(tree.getSelectedItemId())){
             tree.setCheck(tree.getSelectedItemId(),true);
             }
           // firstUnCheckItem(retData[i][0]);
        		tree.showItemCheckbox(retData[i][0],1);
        	  tree.showItemSign(retData[i][0],0);
        	   tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          } 
     
     }
   }else{
        
     	for(var i=0;i<retData.length;i++){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	
       //  alert("getSubItems is null:\t"+retData[i][3]);
         if(retData[i][3]==0){
        	 tree.showItemCheckbox(retData[i][0],0);
        	 tree.showItemSign(retData[i][0],1);
        	  tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]==1){ 
          if(firstUnCheckItem(tree.getSelectedItemId())){
              tree.setCheck(tree.getSelectedItemId(),true);
             }
        		 tree.showItemCheckbox(retData[i][0],1);
        	   tree.showItemSign(retData[i][0],0);
        	   tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');
        	  		
          }     	
     	}
}
}
//显示选中节点在的全称(不查数据库判断，数据可能不准确)
function showNodeIdList(retData,id){
    
		var arr =retData.split(",");
		var j=0;		
		var isflag=0;
		//alert(arr);
	  for(var i=0;i<arr.length;i++,j++){
		// alert("1");
				  if(tree.getUserData(arr[i],"isleaf")!=null){
				  	//alert("1");
						 	if(tree.getUserData(arr[i],"isleaf")==1){
						 		//alert(arr[i]);
								 	 if(!isInShowName(arr[i])){
								 	 	 //alert("3");
									      var mytext = arr[i]+'→'+tree.getUserData(arr[i],"fullname");
									      var myvalue = arr[i];
									      var mylen = parent.document.getElementById("select_Name").options.length;
												if(mylen<10){
														var myOption = new Option(mytext,myvalue);
											
									      		parent.document.getElementById("select_Name").options.add(myOption); 
									      }else{  
											         if(tree.isItemChecked(id)==1){     
												           tree.setCheck(id,false);
												 		       isflag=1;
												 		       rdShowMessageDialog('来电原因项目添加已经满10个',2);
												 		       break;
												       }
											 		      
											 	}
									    
									      parent.document.getElementById("node_Id").value=parent.document.getElementById("node_Id").value+','+arr[i];
									      parent.document.getElementById("show_Name").value=parent.document.getElementById("show_Name").value+","+arr[i]+'→'+tree.getUserData(arr[i],"fullname");
									      parent.document.getElementById("node_Name").value=parent.document.getElementById("show_Name").value;
									      //parent.document.getElementById("funllName").value=parent.document.getElementById("funllName").value+","+tree.getUserData(arr[i],"fullname");
							     	}
					    }
						  if(tree.getUserData(arr[i],"isleaf")==0){	
							 
							  	tree.setCheck(arr[i],0);
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
	 var els =parent.document.getElementById("select_Name").options;
	 if(els.length<0)return false;
	   for(var i=0;i<els.length;i++){
	   if(els[i].value==node_id){
	     return true;
	   }
	 }
	 return false;
	} 
	
	function deleteShowName(node_id){
  var elsId =parent.document.getElementById("node_Id").value;
  var elsName = parent.document.getElementById("node_Name").value;
  var isTag=document.getElementById("isTag").value;
  var node_name="";
  if(isTag==1){
  node_name=document.getElementById("isTagFull").value;
  }
  else{
   node_name = tree.getUserData(node_id,"fullname");
   }
  node_name = node_id+"→"+node_name;
  //alert(node_name);
  var elsArray=elsId.split(",");
  var elsNameArray = elsName.split(",");
  //alert(elsNameArray);
  if(elsId==null||elsId==undefined)return false;
  for(var i=1;i<elsArray.length;i++){
      if(elsArray[i]==node_id){
	       elsArray.splice(i,1);
	       //elsNameArray.splice(i,1);
	       parent.document.getElementById("node_Id").value=elsArray.toString();
	       //parent.document.getElementById("node_Name").value=elsNameArray.toString();
   }
  }
  
  for(var i=1;i<elsNameArray.length;i++){
  	 // alert(elsNameArray[i]+"Y"+node_name);
  	// alert("2");
      if(elsNameArray[i]==node_name){
	       //elsArray.splice(i,1);
	       elsNameArray.splice(i,1);
	     //  alert(elsNameArray[i]+"N");
	      // parent.document.getElementById("node_Id").value=elsArray.toString();
	       parent.document.getElementById("node_Name").value=elsNameArray.toString();
	       parent.document.getElementById("show_Name").value=elsNameArray.toString();
   }
  }
  
  }
	
	initBaseLeaveTree(Id,fullname,isleaf,caption);
	
	
	function firstUnCheckItem(reId){ 
	  //document.getElementById(reId).click(); 
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

		/*
	*模拟onclick事件，展开节点
	*/
	function unFoldNode(node_id){
		var i_length=node_id.length/2;
		var j=0;
   if(i_length==1){
	tree.setCheck(node_id,true);	
	}else{
		for(var i=0;i<=i_length;i++){
			 	j+=2;
	 // alert("node_id.substring:\t"+node_id.substring(0,j));
	  if(tree.getUserData(node_id.substring(0,j),"isleaf")=='N'){
	  	document.getElementById(node_id.substring(0,j)).click();
	  	}	
		tree.setCheck(node_id,true);	
    }
	}	
}
function dotShowBoxList(nodeId){
   tree.setCheck(nodeId,false);
}
</SCRIPT>        

   
      
