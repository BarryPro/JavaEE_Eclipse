   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-12
********************/
%>
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String error_code="444444";
	String[][] errCodeMsg = null;
	String regionCode = (String)session.getAttribute("regCode");
	
	
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
  	String sDBChange = "sDBChange";
  	String procSql = request.getParameter("procSql");
  	System.out.println(procSql);
%>

    <wtc:service name="sPubProcCfm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=procSql%>" />
			<wtc:param value="<%=sDBChange%>" />	
		</wtc:service>
		<wtc:array id="result_t2" scope="end"/>

<% 
if(code.equals("000000"))
	valid=1;
else
	valid=2;
	
if( valid == 2){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<br>ҵ��������:"+"<%=error_code %></br>"+"������Ϣ:"+"<%=error_msg %>");
	window.location="f5004.jsp";
//-->
</script>

<%}else{%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("�����ɹ�!!");
	window.location="f5004.jsp";
//-->
</script>
<%}%>








