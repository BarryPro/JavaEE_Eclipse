<%
  /*
   * 功能: 差错等级、差错类别、业务类别选择页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
   response.setHeader("Pragma", "No-cache");   
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Expires", "0"); 
   String vop_code = request.getParameter("op_code");
   String service_name = new String();
   int int_op_code = Integer.parseInt(vop_code.substring(1,4));
   
   switch(int_op_code){
   		case 240:service_name = "sK240_1Qry";break;
   		case 250:service_name = "sK250_1Qry";break;
   		case 260:service_name = "sK260_1Qry";break;
   		case 270:service_name = "sK270Qry";break;
   		case 271:service_name = "sK271Qry";break;
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
					text-overflow:ellipsis;
			}
			img{
					cursor:hand;
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
						node.img0 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/plus3.gif";
						node.img1 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/minus3.gif";
					}else{
						child_flag = 0;
						node.img0 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/line3.gif";
						node.img1 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/line3.gif";
					}
					if(rela[i][1] != "0000" && document.getElementById(rela[i][1]).nextSibling.lastChild.firstChild.vorder == document.getElementById(rela[i][0]).vorder){
						if(child_flag == 0){
							node.img0 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/line2.gif";
							node.img1 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/line2.gif";
						}else{
							node.img0 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/plus2.gif";
							node.img1 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/minus3.gif";
						}
					}
					
					if(rela[i][1] == "0000"){
						node.img0 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/plus5.gif";
						node.img1 = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/minus5.gif";
					}
					
					var doubleimg = document.createElement("img");
					doubleimg.height = "18";
					doubleimg.width = "18";
					doubleimg.border = "0";
					doubleimg.src = "" + node.img1;
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
				/*2、添加内容.*/
				for(var i=0;i<rela.length;i++){
					document.getElementById('m_content_').innerHTML+="<input type='hidden' id='m_content_"+rela[i][0]+"' value='"+rela[i][4]+"'>";
				}	
			}
			
			function insertLine(vchild,vparent,aa){
				var node = document.getElementById(vchild);
				for(var i=0;i<node.nextSibling.childNodes.length;i++){
					var vline = document.createElement("img");
					vline.height = "18";
					vline.width = "18"; 
					vline.border = "0";
					vline.src = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/line.gif";
					try{
						node.nextSibling.childNodes[i].firstChild.insertBefore(vline,node.nextSibling.childNodes[i].firstChild.firstChild);
					}catch(e){
						alert("err:" +  e.message);
					}
					
					if(node.nextSibling.childNodes[i].childNodes.length > 1){
						insertLine(node.nextSibling.childNodes[i].firstChild.id,node.id,1);
					}
				}			
			}
			
			
			function treeOp(py,img){
				try{
					if(py.nodeName == "SPAN"){
						<%if(int_op_code==240){%>
						if(py.parentNode.childNodes.length==1)	
						addSelectedItemToRight(py.id, py.innerText);
						<%}%>
						<%if(int_op_code==250){%>
							if(py.parentNode.childNodes.length==1)	
						getErrorLevel(py.id, py.innerText);
						<%}%>	
						<%if(int_op_code==260){%>
							if(py.parentNode.childNodes.length==1)	
						addSelectedResonToRight(py.id, py.innerText);
						<%}%>							
						<%if(int_op_code==270){%>
							if(py.parentNode.childNodes.length==1)	
						addSelectedServiceToRight(py.id, py.innerText);
						<%}%>	
						<%if(int_op_code==271){%>
							if(py.parentNode.childNodes.length==1)	
						addSelectedRemarkToRight(py.id, py.innerText);
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
				System.out.println(result[i][0]+"]"+result[i][1]+"]"+result[i][2]+"]"+result[i][3]);
%>
				treelist[<%=i%>] = new Array();
				treelist[<%=i%>][0] = "<%=result[i][2]%>";
				treelist[<%=i%>][1] = "<%=result[i][3]%>";
				treelist[<%=i%>][2] = "<%=result[i][0]%>";
				treelist[<%=i%>][3] = "#";				
				treelist[<%=i%>][4] = "<%=result[i][1]%>";		//1、java、js 数组转化->内容		
<%			
			}
%>
				
				var img = new Array();
				img[0] = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/folderClosed.gif";
				img[1] = "<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/folderOpen.gif";
				
				treeview(treelist, img);
			}
			<%if(int_op_code==240){%>
			//差错类别
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
				var error_levels = document.getElementById("error_levels");
				for(var i = 0; i < error_levels.length; i++){
					if(optionValue == error_levels.options[i].value){
						return false;
					}
				}
			//	alert(document.getElementById('m_content_'+optionValue).value);
				var option = document.createElement("OPTION");
				option.text = optionText;
				option.value = optionValue;
				error_levels.add(option);	
				//updated by tangsong 20100629
				if (error_levels.length == 0) {
					document.getElementById("error_levels_desc").value = "";
					return false;
				}
				var error_ids = "";
				for(var i = 0; i < error_levels.length; i++){
					error_ids += "'" + error_levels.options[i].value + "',";
				}
				error_ids = error_ids.substr(0, error_ids.length-1);
				var myPacket = new AJAXPacket("K250_get_error_desc.jsp","正在提交，请稍候......");
				myPacket.data.add("error_ids",error_ids);
				core.ajax.sendPacket(myPacket,setLevelDesc,true);
				myPacket = null;
			}
		    <%}%>
			<%if(int_op_code==260){%>
			function addSelectedResonToRight(optionValue, optionText){
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
			<%if(int_op_code==270){%>
			function addSelectedServiceToRight(optionValue, optionText){
				var checkReason_levels = document.getElementById("checkReason_levels");	
				for(var i = 0; i < checkReason_levels.length; i++){
					if(optionValue == checkReason_levels.options[i].value){
						return false;
					}
				}					
				var option = document.createElement("OPTION");
				option.text = optionText;
				option.value = optionValue;
				checkReason_levels.add(option);	
			}
		    <%}%>
		    
		  <%if(int_op_code==271){%>
			function addSelectedRemarkToRight(optionValue, optionText){

				var remark_levels = document.getElementById("remark_levels");
				
				for(var i = 0; i < remark_levels.length; i++){
					if(optionValue == remark_levels.options[i].value){
						return false;
					}
				}		
				var option = document.createElement("OPTION");
				option.text = optionText;
				option.value = optionValue;
				remark_levels.add(option);
			}
		    <%}%> 	

			//added by tangsong 20100629
			function setLevelDesc(myPacket) {
				var descriptions = myPacket.data.findValueByName("descriptions");
				var re = /@#/g;
				descriptions = descriptions.replace(re,"\n");
				document.getElementById("error_levels_desc").value = descriptions;
			}
		</script>
	</head>
	<body onload="test();">
		<div id="demon" style="width=100%;height:180px;overflow:auto"></div>
		<div id="m_content_" style="visibility: hidden;">123</div>
	</body>
</html>