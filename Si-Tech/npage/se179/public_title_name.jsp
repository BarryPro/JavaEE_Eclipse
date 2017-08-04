<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%
    String cssPath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");  
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/system.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/npage/se112/js/validate_class.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/npage/se112/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/npage/se112/js/util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/autocomplete.js"></script>
<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/block.css" rel="stylesheet" type="text/css" />
<%
String hotkey = (String)session.getAttribute("hotkey");
String rightkey = (String)session.getAttribute("rightkey");
String chgcolor = (String)session.getAttribute("chgcolor");
%>
