<%
	/*���� 2006��12��7�� ���� X_HLJMob_CRM_PD3_2006_370��������ҵ����������ʾ��Ϣ������.xls*/
	int flagwl = 0;
%>
<SCRIPT LANGUAGE="JavaScript">
	
var popupWindow  = null;
	
function popup_window(UserCheckCond)
{
	var i = 0;
	var	varString = "";

	popupWindow = window.open("", "12", "height=400, width=250, top=60,left=770, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
 	popupWindow.document.write("<TITLE>�������ƶ�ҵ������ҳ</TITLE>");
 	popupWindow.document.write("<BODY BGCOLOR=#ffffff>"); 
	popupWindow.document.write("<h3>�������ƶ�ҵ������ҳ!</h1>");
	popupWindow.document.write("<TABLE height=150 cellSpacing=0 cellPadding=0 width=300 border=0>");
	for(;UserCheckCond.indexOf("|") > 0;)
	{
		varString = UserCheckCond.substring(0,UserCheckCond.indexOf("|"));
		popupWindow.document.write("<TR>�� "+varString+"</TR>");
		UserCheckCond= UserCheckCond.substring(UserCheckCond.indexOf("|")+1,UserCheckCond.length);
	}
	popupWindow.document.write("</TABLE>");
	popupWindow.document.write("<CENTER><INPUT TYPE='BUTTON' VALUE='�ر�' onClick='window.close()'></CENTER>");
	popupWindow.document.write("</BODY>");
	popupWindow.document.write("</HTML>");
	popupWindow.document.close();
	
} 	

function popup_window_close()
{
	if (popupWindow != null)
	{
		popupWindow.close();
	}
}
</SCRIPT> 	
