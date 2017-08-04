<%@ page contentType= "text/html;charset=GBK" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
       //added by liujied 090814 
       System.out.println("got the page childTab_allList!");
	String [][]childTab=null;
	childTab = new String[3][2];
			childTab[0][0] = "转业务办理";childTab[0][1]="/npage/callbosspage/callTrans/k029_ivrCallTreeMain.jsp?flag=0";
			childTab[1][0]="转咨询语音" ;childTab[1][1]="/npage/callbosspage/callTrans/k029_ivrCallTreeMain.jsp?flag=1";
			childTab[2][0]="搜索结果" ;childTab[2][1]="/npage/callbosspage/callTrans/k029_ivrCallSearch.jsp";

 %>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<title></title>
	<link href="<%=request.getContextPath()%>/nresources/default/css/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/default/css/tabcss/tabStyle.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath()%>/njs/si/framework.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/njs/si/framework_extend.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/njs/si/tabScript_jsa.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript">
		
		function setChildIframe()
		{
			var workPanel=parent.g("workPanel");
			var workPanelHeight=workPanel.clientHeight;
			var workPanelWidth=workPanel.clientWidth;
			var callSearchHeight=0;
			var callSearch=parent.g("callSearch");
			if(callSearch) callSearchHeight=callSearch.clientHeight;
				
			var callSearchHeight=callSearch.clientHeight;
			if(typeof(callSearchHeight)=="undefined")
			{
				 callSearchHeight = 0;
			}
			//var ua = navigator.userAgent;
			//if(/msie 6/i.test(ua)) 
			//workPanelHeight=workPanelHeight-30;
			var subIframe=g("contentArea").getElementsByTagName("iframe");
			for(var i=0;i<subIframe.length;i++)
			{
				//subIframe[i].style.height=(workPanelHeight-g_posHeight-callSearchHeight)+"px";
				subIframe[i].style.height=(800-g_posHeight-callSearchHeight)+"px";
				//alert("subIframe[i].style.height"+subIframe[i].style.height);
			}
		}

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
				liTagTotleWidth=liTagTotleWidth+liTag[i].clientWidth+2;
			}
			//alert("tabSetWidth="+tabSetWidth);
			//alert("liTagTotleWidth="+liTagTotleWidth);
			if(liTagTotleWidth>tabSetWidth)
			{		
				tabLeft.style.paddingLeft=26+"px";
				imgLeft.style.display="block";
				imgRight.style.display="block";
				imgRight.src=g_imgTabWay+"btn_right_on.gif";
			}
		}
		window.onresize=function()
		{
			setChildIframe();
		}
		window.onload=function()
		{
			setChildIframe();
			btnMoveShow();
		}
	</script>
<style>
	html,
	body,
	iframe
	{
		overflow:hidden;
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
		<span class="first">
		<img src="<%=request.getContextPath()%>/nresources/default/images/tabimages/btn_left.gif" onclick="BtnMoveLeft(event)" id="imgLeft" /></span>
		<span class="next">
		<img src="<%=request.getContextPath()%>/nresources/default/images/tabimages/btn_right.gif" onclick="BtnMoveRight(event)"  id="imgRight" /></span>
		<div class="clr"></div>
		<dl id="contentArea">
			<dt class="on" >
				<iframe align="top" name="false" id="user_index" frameborder="0" scrolling="auto" src="<%=request.getContextPath()%><%=childTab[0][1]%>" crolling="yes"  width="100%" height="100%">
				</iframe>
			</dt>
		</dl>
		<div class="clr"></div>
	</div>
</body>
</html>
<script>
	 function click_link(ob){
	 	 var els = document.getElementsByTagName("li");
	 	 var frmSrc = "",changeNo = 0;
	 	 for(var i=0;i<els.length;i++){
	 	 	if(els[i].className != null && els[i].className=="current"){
	 	 		 els[i].className = null;
	 	  	}
	 	 }
	 	 ob.className = "current";
	 	 for(var i=0;i<els.length;i++){
		 	if(els[i].className != null && els[i].className=="current"){
		 	 		changeNo = i;/**在这个地方记录样式改变的id*/
		 	}
		 }
	 	 try{/**页面未加载错误.*/
	 		user_index.doChangeTabBar(changeNo);
	 	 }catch(Ex){}
	 	 /**document.getElementById("user_index").src=ob.src;*/
	 	 /**在这里使用ajax函数进行调用.*/
	 //	 alert(top.document.getElementById("K042"))
	 }
	 /*yanghy添加链接样式改变函数,在其他页面调用.20091029*/
	 function change_link3_style(){
	 	 var els = document.getElementsByTagName("li");
	 	 for(var i = 0 ; i < els.length; i++){
	 	 	if(els[i].className != null && els[i].className=="current"){
	 	 		 els[i].className = null;
	 	  }
	 	 }
	 	els[2].className = "current";/*将最后一个链接的样式修改*/
	 }
</script>
