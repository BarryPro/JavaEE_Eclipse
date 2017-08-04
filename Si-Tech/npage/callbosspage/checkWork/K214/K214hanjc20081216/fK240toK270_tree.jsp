<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
   response.setHeader("Pragma", "No-cache");   
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Expires", "0"); 
   String vop_code = request.getParameter("op_code");
   System.out.print("\n\n[" + vop_code + "]\n\n");
   String service_name = new String();
   int int_op_code = Integer.parseInt(vop_code.substring(1,4));
   switch(int_op_code){
   		case 240:service_name = "sK240Qry";break;
   		case 250:service_name = "sK250Qry";break;
   		case 260:service_name = "sK260Qry";break;
   		case 270:service_name = "sK270Qry";break;
   }
	String op_code = request.getParameter("op_code");
%>
 	<wtc:service name="<%=service_name%>" outnum="5">
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<html>
	<head>
	<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
	<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
	<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
		<style>
			li{
					list-style-type:none;
					vertical-align:middle;
					font-size:15px;
					border:1pxsolid;
					white-space:nowrap;					
			}
			ul{
					border:0px solid;
					margin-left:0px;
			}
			span{
					width:300px;
					cursor:hand;
					font-size:13px;
					white-space:nowrap;
					border:0px solid;
					margin:0px;
					float:none;
					text-overflow:ellipsis;
			}
			img{
					cursor:hand;
					float:left;
			}
		</style>
		<script language="javascript">
			function treeview(rela,img){
				var treecontent = document.getElementById("demon");
				var root = document.createElement("ul");
				root.style.marginLeft = "10px";
				root.style.marginTop = "10px";
				treecontent.appendChild(root);
				root.setAttribute("id", "treemenu");
				root.style.textAlign = "left";
				
				for(var i=0;i<rela.length;i++){
					var childList = document.createElement("li");
					var linkclick = document.createElement("span");
					linkclick.id = "" + rela[i][0];
					linkclick.vorder = "tdata" + i;
					if(rela[i][1]=="0000"){
						childList.style.marginLeft = "13px";
						root.appendChild(childList);
					}else{
						var parentnode = document.getElementById(rela[i][1]).parentNode;
						if(parentnode.childNodes.length == 1){
							var ulroot = document.createElement("ul");
							parentnode.appendChild(ulroot);
							if(rela[i][1] == 0)
								ulroot.style.display = "block";
							else
								ulroot.style.display = "none";
							ulroot.appendChild(childList);
						}else{
							parentnode.lastChild.appendChild(childList);
						}
					}
					childList.appendChild(linkclick);
					linkclick.innerHTML = "<img src=\"" + img[0] + "\" height=\"18\" width=\"18\" border=\"0\"> " + rela[i][2];
					linkclick.attachEvent("onclick", function(){ treeOp(event.srcElement, img) });
				}
				
				
				
				for(var i=0;i<rela.length;i++){
					var child_flag = 0;
					var node = document.getElementById(rela[i][0]);
					if(node.parentNode.childNodes.length > 1){
						child_flag = 1;
						node.img0 = "/images/dtmltree_imgs/csh_books/plus3.gif";
						node.img1 = "/images/dtmltree_imgs/csh_books/minus3.gif";
					}else{
						child_flag = 0;
						node.img0 = "/images/dtmltree_imgs/csh_books/line3.gif";
						node.img1 = "/images/dtmltree_imgs/csh_books/line3.gif";
					}
					/**/
					if(rela[i][1] != "0000" && document.getElementById(rela[i][1]).nextSibling.lastChild.firstChild.vorder == document.getElementById(rela[i][0]).vorder){
						if(child_flag == 0){
							node.img0 = "/images/dtmltree_imgs/csh_books/line2.gif";
							node.img1 = "/images/dtmltree_imgs/csh_books/line2.gif";
						}else{
							node.img0 = "/images/dtmltree_imgs/csh_books/plus2.gif";
							node.img1 = "/images/dtmltree_imgs/csh_books/minus3.gif";
						}
					}
					
					if(rela[i][1] == "0000"){
						node.img0 = "/images/dtmltree_imgs/csh_books/minus5.gif";
						node.img1 = "/images/dtmltree_imgs/csh_books/plus5.gif";
					}
					
					
					//alert(document.getElementById(rela[i][1]));
					//alert(document.getElementById(rela[i][0]).vorder);
					//node.parentNode.style.listStyleImage = "url(" + node.img0 + ")";
					var doubleimg = document.createElement("img");
					doubleimg.height = "18";
					doubleimg.width = "18";
					doubleimg.border = "0";
					doubleimg.src = "" + node.img0;
					node.insertBefore(doubleimg,node.firstChild);
					
				}				

				document.getElementById("treemenu").firstChild.lastChild.style.marginLeft = "18px";
				for(var i=0;i<rela.length;i++){
					var node = document.getElementById(rela[i][0]);
					if(node.parentNode.childNodes.length > 1){
						if(rela[i][1] != "0000"){
							insertLine(rela[i][0],rela[i][1],0);
						}
					}
				}						
				
				//alert(document.getElementById("treemenu").firstChild.lastChild.style.marginLeft);
				//alert(treecontent.innerHTML);
			}
			
			function insertLine(vchild,vparent,aa){
				//alert(vchild + " " + vparent + " " +aa);
				var node = document.getElementById(vchild);
				for(var i=0;i<node.nextSibling.childNodes.length;i++){
					//alert(node.nextSibling.nodeName);
					var vline = document.createElement("img");
					vline.height = "18";
					vline.width = "18"; 
					vline.border = "0";
					vline.src = "/images/dtmltree_imgs/csh_books/line.gif";
					try{
						node.nextSibling.childNodes[i].firstChild.insertBefore(vline,node.nextSibling.childNodes[i].firstChild.firstChild);
					}catch(e){
						alert("err:" +  e.message);
					}
					
					if(node.nextSibling.childNodes[i].childNodes.length > 1){
						//alert(node.nextSibling.childNodes[i].firstChild.id);
						insertLine(node.nextSibling.childNodes[i].firstChild.id,node.id,1);
					}
				}			
			}
			
			
			function treeOp(py,img){
				alert(py.nodeName);
				try{
					if(py.nodeName == "SPAN"){
						//window.parent.frames.rightFrame.document.all["" + py.vorder].click();
						alert(py.innerText);
						alert(py.id);
						<%if(int_op_code==240){%>
						addSelectedItemToRight(py.id, py.innerText);
						<%}%>
						<%if(int_op_code==250){%>
						getErrorLevel(py.id, py.innerText);
						<%}%>		
						<%if(int_op_code==270){%>
						addSelectedServiceToRight(py.id, py.innerText);
						<%}%>										
						if(py.nextSibling.style.display=='block'){
							py.lastChild.previousSibling.src = img[0];
							py.nextSibling.style.display='none';
							py.lastChild.previousSibling.previousSibling.src = py.img0;
						}else{
							py.lastChild.previousSibling.src = img[1];
							py.nextSibling.style.display='block';
							py.lastChild.previousSibling.previousSibling.src = py.img1;
						}
					}else if(py.nodeName == "IMG"){
						//window.parent.frames.rightFrame.document.all["" + py.parentNode.vorder].click();
						if(py.parentNode.nextSibling.style.display=='block'){
							py.parentNode.lastChild.previousSibling.src = img[0];
							py.parentNode.nextSibling.style.display='none';
							py.parentNode.lastChild.previousSibling.previousSibling.src = py.parentNode.img0;
						}else{
							py.parentNode.lastChild.previousSibling.src = img[1];
							py.parentNode.nextSibling.style.display='block';
							py.parentNode.lastChild.previousSibling.previousSibling.src = py.parentNode.img1;
						}					
					}
				}catch(e){
					if(py.nodeName == "SPAN"){
						var path = py.lastChild.previousSibling.src.split("/");
						var img_name = path[path.length-1];
						if(img_name == img[0]){
							py.lastChild.previousSibling.src = img[1];
						}else{
							py.lastChild.previousSibling.src = img[0];
						}
					}else if(py.nodeName == "IMG"){
						var path = py.parentNode.lastChild.previousSibling.src.split("/");
						var img_name = path[path.length-1];
						if(img_name == img[0]){
							py.parentNode.lastChild.previousSibling.src = img[1];
						}else{
							py.parentNode.lastChild.previousSibling.src = img[0];										
						}
					}					
				}
			}			
			
			
			
			function test(){
				var treelist = new Array();
<%
			for(int i=0;i<result.length;i++){
%>
				treelist[<%=i%>] = new Array();
				treelist[<%=i%>][0] = "<%=result[i][2]%>";
				treelist[<%=i%>][1] = "<%=result[i][3]%>";
				treelist[<%=i%>][2] = "<%=result[i][0]%>";
				treelist[<%=i%>][3] = "#";				
<%			
			}
%>
				
				var img = new Array();
				img[0] = "/images/dtmltree_imgs/csh_books/folderClosed.gif";
				img[1] = "/images/dtmltree_imgs/csh_books/folderOpen.gif";
				
				treeview(treelist, img);
			}
			<%if(int_op_code==240){%>
			//²î´íÀà±ð
			function addSelectedItemToRight(optionValue, optionText){
				var error_levels = document.getElementById("error_levels");
				for(var i = 0; i < error_levels.length; i++){
					if(optionValue == error_levels.options[i].value){
						return false;
					}
				}
					
				var option = document.createElement("OPTION");
				option.text = optionText;
				option.value = optionValue;
				error_levels.add(option);	
			
			}
		    <%}%>
			<%if(int_op_code==250){%>
			function getErrorLevel(optionValue, optionText){
				window.returnValue = optionValue + '_' + optionText;
				window.close();	
			}
		    <%}%>
			<%if(int_op_code==270){%>
			function addSelectedServiceToRight(optionValue, optionText){

				var error_levels = document.getElementById("service_class");	
				for(var i = 0; i < error_levels.length; i++){
					if(optionValue == error_levels.options[i].value){
						return false;
					}
				}					
				var option = document.createElement("OPTION");
				option.text = optionText;
				option.value = optionValue;
				error_levels.add(option);	
			
			}
		    <%}%>		    		    			
		</script>
	</head>
	<body onload="test();">
		<div id="demon" style="width=350px;height:200px;overflow:auto"></div>
	</body>
</html>