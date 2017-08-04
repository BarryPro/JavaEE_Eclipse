<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page contentType="text/html; charset=gb2312" %>
<%request.setCharacterEncoding("GB2312");%>
<%@ page import="java.io.*"%>

<%
String opCode = "1450";
String opName = "积分兑换冲正"; 
String phone_no =request.getParameter("phoneNo");
String loginAccept =request.getParameter("loginAccept");
String vOpNote =request.getParameter("vOpNote");
String newLoginAccept =request.getParameter("newLoginAccept");

String work_no = (String)session.getAttribute("workNo");
String org_code = (String)session.getAttribute("orgCode");
String ip_Addr = (String)session.getAttribute("ipAddr");
String region_code = (String)session.getAttribute("regCode");
//add by diling for 安全加固修改服务列表
String password = (String)session.getAttribute("password");
%>

<%      
	String System_Note = region_code + ":" + phone_no + ":" +  loginAccept+"积分冲正" ;   
	String []l_in=new String[12];
	l_in[0]= newLoginAccept;
	l_in[1]=phone_no;
	l_in[2]=loginAccept;
	l_in[3]= "1450";
	l_in[4]= work_no;
	l_in[5]=org_code;
	l_in[6]= ip_Addr;
	l_in[7]=System_Note;
	l_in[8]=vOpNote;
	l_in[9]="01";
	l_in[10]=password;
	l_in[11]="";

 	String ret_code="";
 	String retMessage="";
try{
    //result = callView.srvCall("s1250Back",l_in,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s1250Back" routerKey="region" routerValue="<%=region_code%>" retcode="retCode2" retmsg="retMsg2" outnum="3" >
		<wtc:param value="<%=l_in[0]%>"/>
		<wtc:param value="<%=l_in[9]%>"/>
		<wtc:param value="<%=l_in[3]%>"/>
		<wtc:param value="<%=l_in[4]%>"/>
		<wtc:param value="<%=l_in[10]%>"/>
		<wtc:param value="<%=l_in[1]%>"/>
		<wtc:param value="<%=l_in[11]%>"/>
	  <wtc:param value="<%=l_in[2]%>"/>
	  <wtc:param value="<%=l_in[5]%>"/>
	  <wtc:param value="<%=l_in[6]%>"/>
    <wtc:param value="<%=l_in[7]%>"/>
		<wtc:param value="<%=l_in[8]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	ret_code = retCode2;
    retMessage = retMsg2;
   }
	catch(Exception e){
	}        
	System.out.println("ret_code==========" + ret_code);
	System.out.println("retMessage==========" + retMessage);
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+ret_code+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+newLoginAccept+"&pageActivePhone="+phone_no+"&retMsgForCntt="+retMessage+"&opBeginTime="+opBeginTime; 
%>
	<jsp:include page="<%=url%>" flush="true" />   
<%  
   if(!ret_code.equals("000000"))
    {
%>
            <script language='jscript'>
                rdShowMessageDialog('<%=retMessage%>' + '[' + '<%=ret_code%>' + ']',0);
                window.location="f1450.jsp?op_code=1450&activePhone=<%=phone_no%>";
            </script>
<%  }
    else
    {
%>        
        <script language='jscript'>
            rdShowMessageDialog('积分兑换冲正操作成功!');
            window.location="f1450.jsp?op_code=1450&activePhone=<%=phone_no%>";
        </script>
<%            
    }
%>






