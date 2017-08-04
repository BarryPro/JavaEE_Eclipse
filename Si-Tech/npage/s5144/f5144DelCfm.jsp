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
    
    String paraArray[] = new String[2];
    paraArray[0] = faq_id ;
    paraArray[1] = workNo ;
  
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  
  //impl.callService("s5144Del",paraArray,"2","region",org_code.substring(0,2));
%>
           <wtc:service name="s5144Del" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			       <wtc:params value="<%=paraArray%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%   
  response.sendRedirect("f5144.jsp");
%>
