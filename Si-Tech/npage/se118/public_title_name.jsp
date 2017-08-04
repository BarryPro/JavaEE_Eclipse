<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%
    String cssPath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");  
%>
<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/jquery.dimensions.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.pack.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/csp/checkWork_dialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script type="text/javascript" src="/njs/si/rightKey.js" defer="true"></script>	
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<script language="JavaScript" src="/njs/si/prompt.js"></script>
<link href="/nresources/<%=cssPath%>/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/prompt.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/rightKey.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.js"></script>	
<link href="/njs/extend/jquery/tooltip/jquery.tooltip.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/ng35_kf.css" rel="stylesheet" type="text/css"></link><!--hejwa 增加 ng3.5样式-->