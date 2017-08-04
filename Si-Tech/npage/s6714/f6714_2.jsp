<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-2-5
********************/
%>

<%
  String opCode = "6714";
  String opName = "彩铃功能暂停/恢复";
%>        

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>   
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>


<%
    String error_code = "0";
    String error_msg = "";
    Logger logger = Logger.getLogger("f6714_2.jsp");
    String workNo   = (String)session.getAttribute("workNo");
	  String workName = (String)session.getAttribute("workName");

    String[] retStr = null;
    String sOutCRRunCode      = request.getParameter("CRRunCode");
    String sInLoginNo         = request.getParameter("loginNo");					//操作工号        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");         //工号密码             
    String sInOpCode          = request.getParameter("opCode");           //功能代码          
    String sInOpNote          = request.getParameter("opNote");           //用户备注         
    String sInOrgCode         = request.getParameter("orgCode");          //操作工号归属       
    String sInSystemNote      = request.getParameter("sysNote");          //系统备注           
    String sInIpAddr          = request.getParameter("ip_Addr");          //操作IP地址          
    String sInLoginAccept     = request.getParameter("loginAccept");      //流水                  
    String sInPhoneNo         = request.getParameter("phone_no");         //用户手机号         
    String sInOnOff           = request.getParameter("OnOff");			      //暂停恢复标志        				  
    String sInCreateType      = "9";	                                    //业务受理渠道:00:BOSS
    
    String regionCode         = (String)session.getAttribute("regCode");                                             
		  
	  String[] paramsIn = new String[11];
	
    paramsIn[0]=sInLoginNo;
    paramsIn[1]=sInLoginPasswd;
    paramsIn[2]=sInOpCode ;
    paramsIn[3]=sInOpNote ;
    paramsIn[4]=sInOrgCode  ;
    paramsIn[5]=sInSystemNote ;
    paramsIn[6]=sInIpAddr;
    paramsIn[7]=sInLoginAccept;
    paramsIn[8]=sInPhoneNo ;
    paramsIn[9]=sInOnOff  ;
    paramsIn[10]=sInCreateType ;
    
		//retStr = callView.callService("s6714Cfm", paramsIn, "1", "region", regionCode);
%>

    <wtc:service name="s6714Cfm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />	
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />	
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:param value="<%=paramsIn[8]%>" />
			<wtc:param value="<%=paramsIn[9]%>" />
			<wtc:param value="<%=paramsIn[10]%>" />
		</wtc:service>
<%		
    error_code = code1;
    error_msg  = msg1;
		if(!error_code.equals("000000")){
		%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=error_msg%>");
			history.go(-1);
		</script>
		<%}else{%>
		  <script language="JavaScript">
			rdShowMessageDialog("彩铃功能<% if(sOutCRRunCode.equals("A")){%>暂停<%}else{%>恢复<%}%>成功",2);
			window.location = "f6714_1.jsp?ph_no=<%=sInPhoneNo%>";
		</script>
		<%	}	%>
		
		<%String url =
"/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
