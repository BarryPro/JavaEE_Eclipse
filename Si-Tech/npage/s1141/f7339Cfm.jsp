<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-23 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	String opCode = (String)request.getParameter("opCode");
   	String opName = (String)request.getParameter("opName");	
   	String regionCode = (String)session.getAttribute("regCode");  
   	
	String work_no =(String)session.getAttribute("workNo");	
	String org_code = (String)session.getAttribute("orgCode");	
	String ip_Addr = (String)session.getAttribute("ipAddr");
	
	String paraAray[] = new String[12];
	String paraArayJk[] = new String[13];
	String paraArayTd[] = new String[13];	

	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("opcode");
	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("paper_code");
	paraAray[5] = request.getParameter("paper_money");
	paraAray[6] = request.getParameter("sp_code");
	paraAray[7] = request.getParameter("server_code");
	paraAray[8] = request.getParameter("oper_code");
	paraAray[9] = request.getParameter("opNote");
	paraAray[10] = request.getParameter("ip_Addr");
	paraAray[11] = request.getParameter("consume_term");

  	//String[] ret = impl.callService("s7188Cfm",paraAray,"2","region",org_code.substring(0,2));
 %>
 	<wtc:service name="s7188Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>		
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>		
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>		
	</wtc:service>
	
 <%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if(errCode.equals("000000")){
%>
		<script language="JavaScript">
			rdShowMessageDialog("ȷ�ϳɹ���",2);
			history.go(-2);
		</script>
	
<%
	}else{%>
		<script language="JavaScript">
			rdShowMessageDialog("ȷ��ʧ��!<%=errMsg%>",0);
			history.go(-2);
		</script>
<%	
	}
%>
<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />