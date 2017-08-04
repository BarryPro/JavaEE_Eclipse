<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%
ArrayList arr = (ArrayList)session.getAttribute("allArr");
String sqlStr = "";
    String passflag = "0";
    
    //优惠信息                                                                             
    String[][] favInfo = (String[][])arr.get(3);   
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
//String passflag = request.getParameter("passflag");
if(width1==null)  width1="";
if(width2==null)  width2="";


%>
 			
			
<input name="<%=pname%>" type="password" v_name="客户密码" maxlength="6" onKeyPress="return isKeyNumberdot(0)" prefield="<%=pname%>" filedtype="pwd" functype="0">
<input onclick="showNumberDialog(document.all.<%=pname%>)" type=button class="b_text" value="输入">

