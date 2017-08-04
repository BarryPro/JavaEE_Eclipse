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
    String workNo   = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String ip_Addr  = request.getRemoteAddr();  
    String nopass  = (String)session.getAttribute("password");       //µÇÂ½ÃÜÂë 
    String regionCode = org_code.substring(0,2);
    
    String faq_id = request.getParameter("faq_id");
    String quest = request.getParameter("quest");
    String answer = request.getParameter("answer");
    String privs = request.getParameter("privs");
   
    String paraArray[] = new String[5];
    paraArray[0] = workNo;
    paraArray[1] = faq_id;
    paraArray[2] = quest;
    paraArray[3] = answer;
    paraArray[4] = privs;
  
   //SPubCallSvrImpl impl = new SPubCallSvrImpl();
   
    //impl.callService("s5144AddOne",paraArray,"5","region",org_code.substring(0,2));
  
%>
           <wtc:service name="s5144AddOne" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="5" >
			       <wtc:params value="<%=paraArray%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%  
    response.sendRedirect("f5144Main.jsp?faq_id="+faq_id);
%>

