<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
 response.setHeader("Pragma","No-Cache"); 
 response.setHeader("Cache-Control","No-Cache");
 response.setDateHeader("Expires", 0); 
	String gCustId = request.getParameter("gCustId");
	String loginType = request.getParameter("loginType");
	String phone_no = request.getParameter("phone_no");
	
	System.out.println("----------hejwa-----44------phone_no----------------------"+phone_no);
	/* ningtn 铁通宽带 */
	String broadPhone = request.getParameter("broadPhone");
	String custOrderId = request.getParameter("custOrderId");
	if(gCustId==null||gCustId.equals(""))
	{
		out.println("号码信息不正确,请重新输入");
		return;
	}
	String cssPath =session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
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
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightmenu.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/framework.css" rel="stylesheet" type="text/css" />
	<link href="/nresources/<%=cssPath%>/css/ng35.css" rel="stylesheet" type="text/css"></link><!--hejwa 增加 ng3.5样式-->
	<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa.js" type="text/javascript"></script>
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
				<iframe align="top" name="false" id="user_index" frameborder="0" scrolling="auto" src="../portal/shoppingCar/custMain.jsp?gCustId=<%=gCustId%>&loginType=<%=loginType%>&phone_no=<%=phone_no%>&activePhone=<%=phone_no%>&custOrderId=<%=custOrderId%>&broadPhone=<%=broadPhone%>" width="100%" height="100%">
				</iframe>
			</dt>
		</dl>
		<div class="clr"></div>
	
	</div>
</body>
</html>