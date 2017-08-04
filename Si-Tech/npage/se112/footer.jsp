<%
rightkey="Y";
hotkey="N";
chgcolor="Y";
if("Y".equals(rightkey))
	{%>
<script type="text/javascript" src="/npage/se112/js/rightKey.js" defer="true" ></script>
<%}%>

<%
if("Y".equals(hotkey))
	{%>
<%@ include file="/npage/se112/public_hotkey.jsp" %>
<%}%>

<script language="javascript">
$(document).ready(function(){
<%
if("Y".equals(chgcolor))
	{%>
			btnHover();//主按钮鼠标经过样式
			
			chgInputStyle();//控制文本框变色样式
<%}%>

});
</script>