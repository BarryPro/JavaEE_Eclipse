<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
String opCode = request.getParameter("opCode");
String sqlStr = "";
    String passflag = "0";
    
//begin add by diling for 对密码权限整改 @2011/11/1 
    boolean pwrf = false;
	String pubOpCode = opCode;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==第三批======/common/pwd_one1.jsp==== pwrf = " + pwrf);
if(pwrf){               
   passflag = "1"; 
}
//end add by diling for 对密码权限整改 @2011/11/1  
String pname = request.getParameter("pname");
String width1 = request.getParameter("width1");
String width2 = request.getParameter("width2");
String pwd = request.getParameter("pwd");
//String passflag = request.getParameter("passflag");
if(width1==null)  width1="";
if(width2==null)  width2="";


%>
 			
			
<% 
     if (passflag.equals ("1"))
     {
%>

	<input name="<%=pname%>" type=password size="17" v_type="0_9" v_name="用户密码" maxlength=8 disabled class="button" value="111111" onKeyPress="return isKeyNumberdot(0)"   prefield="<%=pname%>"     filedtype="pwd" functype="0">
	<input  onclick="showNumberDialog(document.all.<%=pname%>)" type=button value="输入" disabled>
<%
    }
    else if (passflag.equals ("0"))
    {
%>
<input name="<%=pname%>" type="password"   class="button"  onKeyPress="return isKeyNumberdot(0)" prefield="<%=pname%>" filedtype="pwd" functype="0">
<input onclick="showNumberDialog(document.all.<%=pname%>)" type=button value="输入">
<%
    }
%>
			
			
			
			
