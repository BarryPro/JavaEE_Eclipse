<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>

<%@ include file = "/npage/include/public_title_name_p.jsp" %>
<%@ page contentType = "text/html;charset=GBK" %>
<%
/*��׼���*/
String logAcc = request.getParameter( "logAcc" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = request.getParameter( "workNo" );
String passwd = request.getParameter( "passwd" );

String phoNo = request.getParameter( "phoNo" );   
String usrPwd = request.getParameter( "usrPwd" );

/*��������*/
String odrId = request.getParameter( "odr_id");
String compId = "";
String compOdrId = request.getParameter( "comp_odr_id");
String regCode = request.getParameter( "regCode");
String opName = request.getParameter( "opName" );
String ps_rst = request.getParameter( "ps_rst" );
String fail_rsn = request.getParameter( "fail_rsn" );
if ( "0".equals(ps_rst) )
{
	fail_rsn = "���ͳɹ�";
}

String sl_rst = "3";
%>
<wtc:service name = "sA381Cfm" outnum = "30"
	routerKey = "region" routerValue = "<%=regCode%>" 
	retcode = "rc_cfm" retmsg = "rm_cfm" >
	<wtc:param value="<%=logAcc%>"/>
	<wtc:param value="<%=chnSrc%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=passwd%>"/>
		
	<wtc:param value="<%=phoNo%>"/>
	<wtc:param value="<%=usrPwd%>"/>
		
	<wtc:param value="<%=odrId%>"/>
	<wtc:param value=""/> <%//����%>
	<wtc:param value="<%=ps_rst%>"/> <%//д��3  0�����ʧ�� 1������ɹ� 2������ 3���ص��ɹ� 4 �ص�ʧ�� %>
	<wtc:param value=""/>  <%//����  ���͵�ַ������޸ĵ�ַʱ��ֵ��%>
	<wtc:param value=""/> <%//���� �Ƿ�֪ͨ�����µ�0����  1���� %>
	<wtc:param value="<%=compId%>"/> <%//������˾����%>
	<wtc:param value="<%=compOdrId%>"/> <%//��������%>
	<wtc:param value="<%=ps_rst%>"/> 
	<wtc:param value="<%=fail_rsn%>"/> 

</wtc:service>
<wtc:array id="rst" scope="end" />
<%

if( !"000000".equals(rc_cfm))
{
%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>" + ":" + "<%=rm_cfm%>" , 0 );
		window.location = 'f<%=opCode%>_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>    
<%
}
else
{%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 2 );
		window.location = 'f<%=opCode%>_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>
<%
}
%>