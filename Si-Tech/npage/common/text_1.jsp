<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%
String pname = request.getParameter("pname");
String width1 = request.getParameter("width1");
String width2 = request.getParameter("width2");
String size1 = request.getParameter("size1");
String btnName = request.getParameter("btnName");

if(width1==null)  width1="130px";
if(width2==null)  width2="";
if(btnName==null || "".equals(btnName))  width2="输入";
System.out.println(":::::::::::::::::::: " + btnName);
%>
<SCRIPT LANGUAGE="JAVASCRIPT">
	function showTextDialog(obj) {
		var path = "<%=request.getContextPath()%>/npage/common/TextDialog.jsp";
		var h=170;
		var w=470;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";
		returnValue = window.showModalDialog(path,"",prop);
		var tempStr = "";
		if (returnValue != '') {
			if(obj.value.trim() == ''){
				tempStr = obj.value + returnValue;
			}else{
				tempStr = obj.value + "~" + returnValue;
			}
		}else{
			tempStr = obj.value;
		}
		obj.value = tempStr;
	}
</SCRIPT>
<input name="<%=pname%>" id="<%=pname%>" type="text" style="width:<%=width1%>;" size="<%=size1%>" onkeyup="autoSize('<%=pname%>','<%=size1%>');" >
<input class="b_text" onclick="showTextDialog(document.all.<%=pname%>);" type=button  value="<%=btnName%>">
