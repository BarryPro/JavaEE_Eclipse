<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.25
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%

	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);

%>

<%
    String workNo   = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
    String regCode = (String)session.getAttribute("regCode");
    
    String mode_id = request.getParameter("mode_id");
    
    String paraArray[] = new String[2];
    paraArray[0] = mode_id;
    paraArray[1] = workNo;

    
    //impl.callService("s6208Del",paraArray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s6208Del" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:params value="<%=paraArray%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
    
    String errCode = retCode1;
    String errMsg = retMsg1;
    System.out.println("errCode===="+errCode);
    System.out.println("errMsg===="+errMsg);
    
    if (errCode.equals("000000"))
    {

       response.sendRedirect("f6208.jsp?retCode=3&opCode=6208&opName=资费导购套餐配置");
    }
    else
    {
        response.sendRedirect("../common/errorpage.jsp");
    }
    
%>