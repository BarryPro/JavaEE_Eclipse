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
			btnHover();//����ť��꾭����ʽ
			
			chgInputStyle();//�����ı����ɫ��ʽ
<%}%>

});
</script>