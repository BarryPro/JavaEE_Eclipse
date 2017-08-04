<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ include file = "/npage/include/public_title_name.jsp" %>
<%@ page contentType = "text/html;charset=GBK" %>
<%
    String iWorkNo = ( String )session.getAttribute( "workNo" );
    String iLogin_Pass = ( String )session.getAttribute( "password" );
    String iIpAddr = ( String )session.getAttribute( "ipAddr" );
    String iOrgCode = ( String )session.getAttribute( "orgCode" );
    String iBelong_Code = ( String )session.getAttribute( "belongCode" );
    
    String iOpCode = request.getParameter( "opCode" );
    String iOpType = request.getParameter( "op_type" );
    String iUnit_Id = request.getParameter( "unit_id" );
    String iBoss_Vpmn_code = request.getParameter( "boss_vpmn_code" );
    String iOrg_Id = ( String )session.getAttribute( "orgId" );
    String iSm_Code = request.getParameter( "sm_code" );
    String regCode = ( String )session.getAttribute( "regCode" );
    String opName = request.getParameter( "opName" );
    %>
	<wtc:service name="s3673Cfm" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regCode%>">
		<wtc:param value="<%=iWorkNo%>" />
		<wtc:param value="<%=iLogin_Pass%>" />
		<wtc:param value="<%=iIpAddr%>" />
		<wtc:param value="<%=iOrgCode%>" />
		<wtc:param value="<%=iBelong_Code%>" />
		
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iOpType%>" />
		<wtc:param value="<%=iUnit_Id%>" />
		<wtc:param value="<%=iBoss_Vpmn_code%>" />
		<wtc:param value="<%=iOrg_Id%>" />
		
		<wtc:param value="<%=iSm_Code%>" />
	</wtc:service>
	<wtc:array id="rst" scope="end"   />	  
    <%

    if(code.equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("业务受理成功！");
            window.location = "s3673_1.jsp?opCode=<%=iOpCode%>&opName=<%=opName%>";
        </script>
<%  } else {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=code%>" + "[" + "<%=msg%>" + "]" ,0);
              window.location = "s3673_1.jsp?opCode=<%=iOpCode%>&opName=<%=opName%>";
        </script>
<%
    }
%>
