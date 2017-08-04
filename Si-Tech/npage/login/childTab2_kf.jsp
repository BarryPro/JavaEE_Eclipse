<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
 response.setHeader("Pragma","No-Cache"); 
 response.setHeader("Cache-Control","No-Cache");
 response.setDateHeader("Expires", 0); 
	String gCustId = request.getParameter("gCustId");
	String loginType = request.getParameter("loginType");
	String phone_no = request.getParameter("phone_no");
	String custOrderId = request.getParameter("custOrderId");
	if(gCustId==null||gCustId.equals(""))
	{
		out.println("号码信息不正确,请重新输入");
		return;
	}
	String cssPath = (String)session.getAttribute("cssPath");
	ContactInfo contactInfo = new ContactInfo();
  contactInfo.setPhoneno(gCustId);
  Map map = (Map)session.getAttribute("contactInfo");
  map.put(gCustId, contactInfo);	

	String url="/npage/contact/InitCntt.jsp?phone_no="+phone_no+"&loginType="+loginType+"&gCustId="+gCustId;
%>
  <jsp:include page="/npage/contact/GetCnttStatus.jsp" flush="true" />
  <jsp:include page="<%=url%>" flush="true" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<title>客户首页</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/tabcss/tabStyle.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath()%>/njs/si/tabScript_jsa.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/validate_class.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/framework_kf.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/njs/si/framework2.js" type="text/javascript"></script>	
	<%@ include file="/npage/include/public_hotkey.jsp" %>
	<script language="javascript" type="text/javascript">
		window.onresize=function()
		{
	 		setChildIframe();  
	  }
		window.onload=function()
		{
			setChildIframe();
			//rightDel('child_index',false);//激活综合信息右键菜单
			//rightDel('child_index');//激活综合信息右键菜单
		}
			var _exttabref=function(){};
	 		_exttabref.removeTab=function(opcode){
	 		removeTab(opcode);
	 	};
function addNewTab(I,K,G,E){
	initTab();
	var D=g("tabtag"),J=document.createElement("li");
	J.className="current";
	J.setAttribute("id",K);
	J.setAttribute("name",I);
	if(I) activateTab(J.id);
	/*J.oncontextmenu=function(){//右键事件,创建div,关闭当前标签,关闭其他标签,加入常用功能,查询当天费用
		var A=document.createElement("div");
		A.setAttribute("id","ball");
		
		var $=document.createElement("div");
		$.setAttribute("id","colseMe");
		
		var D=document.createElement("div");
		D.setAttribute("id","colseOther");
		
		colseMeTxt=document.createTextNode("\u5173\u95ed\u5f53\u524d\u6807\u7b7e");//关闭当前标签
		colseOtherTxt=document.createTextNode("\u5173\u95ed\u5176\u4ed6\u6807\u7b7e");//关闭其他标签
		
		var _=document.createElement("div");
		_.setAttribute("id","commonUse");
		
		commonUseTxt=document.createTextNode("\u52a0\u5165\u5e38\u7528\u529f\u80fd");//加入常用功能
		var B=document.createElement("div");
		B.setAttribute("id","inquireCost"); 
		var C=document.createTextNode("\u67e5\u8be2\u5f53\u5929\u8d39\u7528");//查询当天费用
		
		$.onmouseover=function(){$.className="curmouse"};
		$.onmouseout=function(){$.className=""};
		$.onclick=function(A){
			var _=arguments[0]||window.event,B=_.srcElement||_.target,C=B.parentNode.parentNode,$=C.id;
			removeTab($);
		};
		
		D.onmouseover=function(){D.className="curmouse"};
		D.onmouseout=function(){D.className=""};
		D.onclick=function(){
			var _=arguments[0]||window.event,A=_.srcElement||_.target,B=A.parentNode.parentNode,$=B.id;
			delOtherTab($)};
			_.onmouseover=function(){_.className="curmouse"};
			_.onmouseout=function(){_.className=""};
			_.onclick=function(){
				var _=arguments[0]||window.event,A=_.srcElement||_.target,B=A.parentNode.parentNode,$=B.id;
				if(I)addFavfunc($);
				else parent.addFavfunc($)};
				B.onmouseover=function(){B.className="curmouse"};
				B.onmouseout=function(){B.className=""};
				B.onclick=function(){
					if(I)inqurCost();
					else parent.inqurCost()};
					$.appendChild(colseMeTxt);
					D.appendChild(colseOtherTxt);
					_.appendChild(commonUseTxt);
					B.appendChild(C);
					A.appendChild($);
					A.appendChild(D);
					A.appendChild(_);
					A.appendChild(B);
					J.appendChild(A);
					A.onmouseleave=function(){
						if(document.getElementById("ball")){
							$.removeChild(colseMeTxt);
							D.removeChild(colseOtherTxt);
							_.removeChild(commonUseTxt);
							B.removeChild(C);
							A.removeChild($);
							A.removeChild(D);
							A.removeChild(_);
							A.removeChild(B);
							J.removeChild(A)}};
							J.onmouseleave=function(){
								if(document.getElementById("ball")){
									$.removeChild(colseMeTxt);
									D.removeChild(colseOtherTxt);
									_.removeChild(commonUseTxt);
									B.removeChild(C);
									A.removeChild($);
									A.removeChild(D);
									A.removeChild(_);
									A.removeChild(B);
									J.removeChild(A)
								}
							};
							return false
						};*/
						var A=document.createElement("span");
						titleTxt=document.createTextNode(G);
						var C=document.createElement("img");
						C.className="";
						C.setAttribute("src",g_imgTabWay+"icon_close_off.gif");
						C.onmouseover=function(){
							C.setAttribute("src",g_imgTabWay+"icon_close02_on.gif")
						};
						C.onmouseout=function(){
							C.setAttribute("src",g_imgTabWay+"icon_close_off.gif")
						};
						C.onclick=function(B){
							var A=arguments[0]||window.event,
							$=A.srcElement||A.target,
							C=$.parentNode.parentNode,
							_=C.id;
							removeTab(_)
						};
						A.appendChild(titleTxt);
						if(E.indexOf("fq025") == -1 && E.indexOf("fq046") == -1){
							A.appendChild(C);	
						}
						J.appendChild(A);
						 
						D.appendChild(J);
						var F=g("contentArea"),B=document.createElement("dt");
						B.className="on";
						var H=document.createElement("iframe");
						if(I){
							g_parentRig=g("workPanel");
							g_parentRigHeight=g_parentRig.clientHeight;
							var _="iframe"+K;
							H.setAttribute("id",_);
							//updated by tangsong 20100825
							//var $=(g_parentRigHeight-28)+"px"
							var $=(g_parentRigHeight-parent.g("callSearch").clientHeight-32)+"px";
						}else{
							g_parentRig=parent.g("workPanel");
							g_parentRigHeight=g_parentRig.clientHeight;
							_="iframe"+K;
							H.setAttribute("id",_);
							//updated by tangsong 20100825
							//$=(g_parentRigHeight-70)+"px"
							$=(g_parentRigHeight-parent.g("callSearch").clientHeight-74)+"px";
						}
						H.setAttribute("align","top");
						H.setAttribute("frameBorder","no");
						H.setAttribute("id","iframe"+K);
						H.setAttribute("crolling","yes");
						H.setAttribute("width","100%");
						H.setAttribute("height",$);
						H.setAttribute("scrolling","auto");
						B.appendChild(H);
						F.appendChild(B);
						setTimeout(function(){H.src=E},0);
						HoverTab();
						isOverstep()
					}
		
	</script>
    <style>
    	html,
    	body
    	{
    		overflow:hidden;
    	}
	</style>
</head>
<body>
	<div id="tabset">
		<div id="tab" >
			<ul id="tabtag">
				<li id="child_index" class="current"><span class="fristab"><img src="../../nresources/<%=cssPath%>/images/tab_user.gif" id="tab_user" />客户首页</span></li>
			</ul>
			<div class="clr"></div>
		</div>
		<span class="first"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/tabimages/btn_left.gif"  onclick="BtnMoveLeft(event)" id="imgLeft" /></span>
		<span class="next"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/tabimages/btn_right.gif" onclick="BtnMoveRight(event)"  id="imgRight" /></span>
		<div class="clr"></div>
		<dl id="contentArea">
			<dt class="on">
				<iframe align="top" name="false" id="user_index" frameborder="0" scrolling="auto" src="../portal/shoppingCar/custMain.jsp?gCustId=<%=gCustId%>&loginType=<%=loginType%>&phone_no=<%=phone_no%>&activePhone=<%=phone_no%>&custOrderId=<%=custOrderId%>" width="100%" height="100%">
				</iframe>
			</dt>
		</dl>
		<div class="clr"></div>
	
	</div>
</body>
</html>