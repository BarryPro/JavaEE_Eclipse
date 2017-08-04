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
		<link href="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_css/style.css" type=text/css rel=stylesheet>    
		<link href="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_css/dhtmlxtree.css" type=text/css rel=stylesheet>    
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
					margin-left:18px;
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
							node.img1 = "/images/dtmltree_imgs/csh_books/minus2.gif";
						}
					}
					
					if(rela[i][1] == "0000"){
						node.img0 = "/images/dtmltree_imgs/csh_books/minus5.gif";
						node.img1 = "/images/dtmltree_imgs/csh_books/plus5.gif";
					}
					
					
					//alert(document.getElementById(rela[i][1]));
					//alert(document.getElementById(rela[i][0]).vorder);
					node.parentNode.style.listStyleImage = "url(" + node.img0 + ")";
				}				
				alert(treecontent.innerHTML);
			}
			
			
			
			function treeOp(py,img){
				//alert(py.nodeName);
				try{
					if(py.nodeName == "SPAN"){
						window.parent.frames.rightFrame.document.all["" + py.vorder].click();
						if(py.nextSibling.style.display=='block'){
							py.firstChild.src = img[0];
							py.nextSibling.style.display='none';
						}else{
							py.firstChild.src = img[1];
							py.nextSibling.style.display='block';
						}
					}else if(py.nodeName == "IMG"){
						window.parent.frames.rightFrame.document.all["" + py.parentNode.vorder].click();
						if(py.parentNode.nextSibling.style.display=='block'){
							py.src = img[0];
							py.parentNode.nextSibling.style.display='none';
						}else{
							py.src = img[1];
							py.parentNode.nextSibling.style.display='block';
						}					
					}
				}catch(e){
					//alert(111);
					if(py.nodeName == "SPAN"){
						var path = py.firstChild.src.split("/");
						var img_name = path[path.length-1];
						if(img_name == img[0]){
							py.firstChild.src = img[1];
						}else{
							py.firstChild.src = img[0];
						}
					}else if(py.nodeName == "IMG"){
						var path = py.src.split("/");
						var img_name = path[path.length-1];
						if(img_name == img[0]){
							py.src = img[1];
						}else{
							py.src = img[0];										
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
		</script>
	</head>
	<body onload="test();">
		<div id="demon" align="center">
		</div>
	</body>
</html>