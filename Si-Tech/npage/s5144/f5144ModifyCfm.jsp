<%
/********************
 version v2.0
开发商: si-tech
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
    String nopass  = (String)session.getAttribute("password");                      //登陆密码 
    String regionCode = org_code.substring(0,2);
        
    String faq_id = request.getParameter("faq_id");
    String mode_name = request.getParameter("mode_name");
    String mode_code = request.getParameter("mode_code");
    String show_type = request.getParameter("show_type");
    String request_privs = request.getParameter("request_privs");
    String show_index = request.getParameter("show_index");
    String begin_time = request.getParameter("begin_time");
    String end_time = request.getParameter("end_time");
    String faq_bit_region = request.getParameter("faq_bit_region");
   
    String paraArray[] = new String[11];
    paraArray[0] = faq_id;
    paraArray[1] = mode_name;
    paraArray[2] = mode_code;
    paraArray[3] = show_type;
    paraArray[4] = request_privs;
    paraArray[5] = show_index;
    paraArray[6] = begin_time;
    paraArray[7] = end_time;
    paraArray[8] = faq_bit_region;
    paraArray[9] = regionCode;
    paraArray[10] = workNo;
  
    //SPubCallSvrImpl impl = new SPubCallSvrImpl();
   
    //impl.callService("s5144ModifyCfm",paraArray,"2","region",org_code.substring(0,2));
  
%>
	<wtc:service name="s5144ModifyCfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:params value="<%=paraArray%>"/>
		</wtc:service>
	<wtc:array id="result" scope="end" />
<%
	if (!"000000".equals(errCode)) {
		%>
			<script language="javascript">
				rdShowMessageDialog("s5144ModifyCfm：<%=errCode%>，<%=errMsg%>。", 0);
				window.location = "f5144.jsp";
			</script>
		<%
	} else {
		%>
			<script language="javascript">
				rdShowMessageDialog("申请成功！", 2);
				window.location = "f5144.jsp";
			</script>
		<%
	}
%>