<%@ page contentType="text/html; charset=GBK" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
%>
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>
<script language="javascript">
$(document).ready(function(){
	showLightBox();
	var h=400;
	var w=600;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "/npage/client4A/getTreasuryStatus1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	//var ret;
	var ret=window.showModalDialog(path,"",prop);
	if(typeof(ret) != "undefined"){
		if(ret == "Y"){
			/* ���Լ��������� */
		}else{
			/* 4A ������*/
			removeCurrentTab()
		}
	}else{
		/*���������رյģ��������������*/
		removeCurrentTab()
	}
	hideLightBox();

});
</script>