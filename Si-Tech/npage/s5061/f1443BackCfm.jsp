   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-10
********************/
%>

<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
              
<%
  String opCode = "1443";
  String opName = "�ļ�����";
%>              

<%	
	String tranType = request.getParameter("tranType");
	String loginAccept = request.getParameter("loginAccept");
	String phoneno = request.getParameter("phoneno");
	String mode_type = request.getParameter("mode_type");
	String t_sys_remark = request.getParameter("t_sys_remark");
	
	
	String[][] result = new String[][]{};
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
  
	String paraAray[] = new String[6];   
	paraAray[0] = tranType; //����
	paraAray[1] = phoneno;	//�û�����
	paraAray[2] = work_no; //work_no	
	paraAray[3] = loginAccept; //loginAccept
	paraAray[4] = mode_type; //mode_type
	paraAray[5] = t_sys_remark; //E_Mail
	
	System.out.println("-------------mode_type-----------"+mode_type);
	//String[] ret = impl.callService("sPubGift",paraAray,"1","phone",phoneno);
%>

    <wtc:service name="sPubGift" outnum="3" retmsg="msg1" retcode="code1" routerKey="phone" routerValue="<%=phoneno%>">
			<wtc:params value="<%=paraAray%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%	
	String errMsg = msg1;
	if (code1.equals("000000"))
	{
	
	System.out.println("-------------loginAccept-----------"+loginAccept);
	

%>

<script language="JavaScript">
	rdShowMessageDialog("ҵ������ɹ���");
	window.location="f1443.jsp?op_code=1443&activePhone=<%=phoneno%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("ҵ������ʧ��: <%=errMsg%>");
	window.location="f1443.jsp?op_code=1443&activePhone=<%=phoneno%>";
</script>
<%}
%>

<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1
		+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept
		+"&pageActivePhone="+phoneno+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime; 
	System.out.println("url========================"+url);
%>
<jsp:include page="<%=url%>" flush="true" />
