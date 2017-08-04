<%@ page contentType= "text/html;charset=gb2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	  String [][]childTab=null;
    childTab=new String[1][2];
	  childTab[0][0]="一般通知" ;childTab[0][1]="/npage/callbosspage/K084/K084_commNoteSend.jsp";
	  childTab[1][0]="请求通知" ;childTab[1][1]="/npage/callbosspage/K084/K084_reqNoteSend.jsp";
 %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>通知</title>
	<link href="<%=request.getContextPath()%>/nresources/default/css/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/default/css/tabcss/tabStyle.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath()%>/njs/si/framework.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/njs/si/framework_extend.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/njs/si/tabScript_jsa.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript">
		function btnMoveShow()
		{
			var tabSet= g("tabset");
			var imgLeft= g("imgLeft");
			var imgRight=g("imgRight");
			var tabSetWidth=tabSet.clientWidth;
		
			var liTag=tabSet.getElementsByTagName("li");
			var liTagTotleWidth=0;
			var tabLeft=g("tab");
			for(var i=0;i<liTag.length;i++)
			{
				liTagTotleWidth=liTagTotleWidth+liTag[i].clientWidth+200;
			}
			if(liTagTotleWidth>tabSetWidth)
			{		
				tabLeft.style.paddingLeft=26+"px";
				imgLeft.style.display="block";
				imgRight.style.display="block";
				imgRight.src=g_imgTabWay+"btn_right_on.gif";
			}
		}

	</script>
<style>
	html,
	body,
	iframe
	{
		overflow:auto;
	}
</style>

</head>
<body>
	<div id="tabset">
		<div id="tab">
			<ul id="tabtag">
				<%
				  for(int i=0;i<childTab.length;i++){
				%>
				 <li onclick="click_link(this)" 
				 	<%
				 	 if(i==0){out.print("class=\"current\" ");}
				 	%>
				 	src="<%=request.getContextPath()%><%=childTab[i][1]%>">
				 	<span><%=childTab[i][0]%></span>
				 </li>
				<%
			  	}
				%>
			</ul>
			<div class="clr"></div>
		</div>
		<span class="first"><img src="<%=request.getContextPath()%>/nresources/default/images/tabimages/btn_left.gif" onclick="BtnMoveLeft(event)" id="imgLeft" /></span>
		<span class="next"><img src="<%=request.getContextPath()%>/nresources/default/images/tabimages/btn_right.gif" onclick="BtnMoveRight(event)"  id="imgRight" /></span>
		<div class="clr"></div>
		<dl id="contentArea">
			<dt class="on">
				<iframe align="top" name="false" id="user_index2" frameborder="yes" scrolling="auto" src="<%=request.getContextPath()%><%=childTab[0][1]%>" crolling="yes"  width="100%" height="480px">
				</iframe>
			</dt>
		</dl>
		<div class="clr"></div>
	</div>
</body>
</html>
<script>
 function click_link(ob){
 	 var els=document.getElementsByTagName("li");
 	 var frmSrc="";
 	 for(var i=0;i<els.length;i++){
 	 	if(els[i].className!=null&&els[i].className=="current"){
 	 		 els[i].className=null;
 	  }	
 	 }
 	 ob.className="current";
 	 document.getElementById("user_index2").src=ob.src;
 //	 alert(top.document.getElementById("K042"))
 }	
</script>

