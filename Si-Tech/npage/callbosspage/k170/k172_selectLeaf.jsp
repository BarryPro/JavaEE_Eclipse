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
         %>
          <SCRIPT type=text/javascript> 
           var nodeId='<%=nodeId%>'; 
         </SCRIPT>
      <BODY>           
<TABLE><TR>
<input type="hidden" name="isTag" id="isTag" value="">
<input type="hidden" name="isTagFull" id="isTagFull" value="">
<TD vAlign=top width="70%">
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top width="70%">
<DIV id="childTree">
	</DIV>
</TD>
  <select id="myselect" style="display:none"></select>  	
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
		
		function onNodeSelect(id){
		}
		 //��Ӧcheckboxѡ���¼�������ʾ��Ϣ��ʾ������һ��ҳ��
        function onCheckBoxsBySelect(id){
	//alert(id);
  var allCheckItem=tree.getAllCheckedBranches();
   if(tree.isItemChecked(id)==0)
   {
      if(selectPara==1){
      deleteBoxList(myid);
      }
      else{
      deleteBoxList(id);
      }
   }
   //alert(allCheckItem);
	 if(allCheckItem!=null){
		showNodeIdList(allCheckItem,id);//�����Ż����� ������ȥ��ѯ���ݿ�
		}  
		
	} 
	//ȡ��
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
		
		//����һ����̬��
function initBaseLeaveTree(nodeId){	
          tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);  
          tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");      
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_selectLeafXml.jsp?nodeId="+nodeId); 
          tree.enableCheckBoxes(1);   
          tree.setOnClickHandler(onNodeSelect);
          tree.setOnCheckHandler(onCheckBoxsBySelect);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_selectLeafXml.jsp?nodeId="+nodeId); 
          }
   initBaseLeaveTree(nodeId); 
    </SCRIPT>
    
  <SCRIPT type=text/javascript>   
     /*
  * ��������ɾ��ѡ����ͬ������
  */
  function deleteShowName(node_id){
  
  var elsId =parent.document.getElementById("node_Id").value;
  var elsName = parent.document.getElementById("node_Name").value;
  var isTag=document.getElementById("isTag").value;
  var node_name="";
  if(isTag==1){
  node_name=document.getElementById("isTagFull").value;
  }
  else{
  if(selectPara==1){
    node_name=fullname;
  }
  else{
     node_name = tree.getUserData(node_id,"fullname");
  }
  }
    node_name = node_id+"��"+node_name;
  var elsArray=elsId.split(",");
  var elsNameArray = elsName.split(",");
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
      if(elsNameArray[i]==node_name){
	       //elsArray.splice(i,1);
	       elsNameArray.splice(i,1);
	       parent.document.getElementById("node_Name").value=elsNameArray.toString();
	       parent.document.getElementById("show_Name").value=elsNameArray.toString();
   }
  }
  
  }
  
  //��ʾѡ�нڵ��ڵ�ȫ��(�������ݿ��жϣ����ݿ��ܲ�׼ȷ)
function showNodeIdList(retData,id){
		var arr =retData.split(",");
		var j=0;		
		var isflag=0;
	  for(var i=0;i<arr.length;i++,j++){
				  if(tree.getUserData(arr[i],"isleaf")!=null){
						 	if(tree.getUserData(arr[i],"isleaf")==1){
								 	 if(!isInShowName(arr[i])){
								 	 	     
									      var mytext = arr[i]+'��'+tree.getUserData(arr[i],"fullname");
									      var myvalue = arr[i];
									      var mylen = parent.select_Name.options.length;
												if(mylen<10){
														var myOption = new Option(mytext,myvalue);
											
									      		parent.select_Name.options.add(myOption); 
									      }else{  
											         if(tree.isItemChecked(id)==1){     
												           tree.setCheck(id,false);
												 		       isflag=1;
												 		       rdShowMessageDialog('����ԭ����Ŀ����Ѿ���10��',2);
												 		       break;
												       }
											 		      
											 	}
									    
									      parent.document.getElementById("node_Id").value=parent.document.getElementById("node_Id").value+','+arr[i];
									      parent.show_Name.value=parent.show_Name.value+","+arr[i]+'��'+tree.getUserData(arr[i],"fullname");
									      parent.document.getElementById("node_Name").value=parent.show_Name.value;
									      //parent.document.getElementById("funllName").value=parent.document.getElementById("funllName").value+","+tree.getUserData(arr[i],"fullname");
							     	}
					    }
						  if(tree.getUserData(arr[i],"isleaf")==0){	
							 
							  	tree.setCheck(arr[i],0);
						  } 
				 			
				 		
				 	}
		 	}	
		 

			//��ʾ���������
			if(isflag==1){
					//rdShowMessageDialog('����ԭ����Ŀ����Ѿ���10��',2);
			}
}
//�ж�һ���ַ����Ƿ��������г���
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
	*�жϽڵ�ID�Ƿ���ѡ�еļ�����
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
	function dotShowBoxList(nodeId){
   tree.setCheck(nodeId,false);
} 
	</SCRIPT>  