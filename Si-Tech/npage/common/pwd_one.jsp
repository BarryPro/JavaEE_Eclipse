<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-09-16 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String sqlStr = "";
    String passflag = "0";
    
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   
    String tempStr = ""; 
    for(int i=0;i<favInfo.length;i++) {
        tempStr = (favInfo[i][0]).trim();
        if(tempStr.compareTo("a272") == 0) {     
					passflag = "1";         
				}
    }     

		String pname = request.getParameter("pname");
		String width1 = request.getParameter("width1");
		String width2 = request.getParameter("width2");
		String pwd = request.getParameter("pwd");
		if(width1==null)  width1="";
		if(width2==null)  width2="";
%>
 			
			
<% 
     if (passflag.equals ("1")){
%>
			<input name="<%=pname%>" type=password maxlength=8   prefield="<%=pname%>" filedtype="pwd" functype="0" value="">
			<input onclick="showNumberDialog(document.all.<%=pname%>)" class="b_text" type=button value="输入"  >
<%
     }else if (passflag.equals ("0")){
%>
			<input name="<%=pname%>" type="password" maxlength="6"  onKeyPress="return isKeyNumberdot(0)" prefield="<%=pname%>" filedtype="pwd" functype="0" value="">
			<input onclick="showNumberDialog(document.all.<%=pname%>)" class="b_text" type=button value="输入">
<%
    }
%>
			
			
			
			
