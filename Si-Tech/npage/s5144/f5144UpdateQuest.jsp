<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String group_id = (String)session.getAttribute("groupId");   
	String ip_Addr  = request.getRemoteAddr();  
    String nopass  = (String)session.getAttribute("password");                      //µÇÂ½ÃÜÂë 
    String regionCode = org_code.substring(0,2);
    
    String quest_id = request.getParameter("quest_id");
    String faq_id = request.getParameter("faq_id");
    String quest = request.getParameter("quest");
    String answer = request.getParameter("answer");
    String privs = request.getParameter("request_privs");
    
    
    String paraArray[] = new String[5];
    paraArray[0] = workNo;
    paraArray[1] = quest_id;
    paraArray[2] = quest;
    paraArray[3] = answer;
    paraArray[4] = privs;
  
    //SPubCallSvrImpl impl = new SPubCallSvrImpl();
   
    //impl.callService("s5144Update",paraArray,"2","region",org_code.substring(0,2));
  
%>
           <wtc:service name="s5144Update" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			       <wtc:params value="<%=paraArray%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%  
  
    response.sendRedirect("f5144Main.jsp?faq_id="+faq_id);
%>
