<%
/* �������
 * ajaxType : ��������
 * svcName : ������,�ַ���
 * inPrs : �������,����
 * �������
 * oRetCode : ���ش���
 * oRetMsg : ������Ϣ
 */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*��ҳ�洫�ݵĲ���*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("getIfo") ) //�����ַ���
{			
	System.out.println("ajaxType=="+s_ajaxType);
}
else if ( s_ajaxType.equals("getCfmIfo") ) 
{
	String svcName = request.getParameter( "svcName" );
	String inPrs[] = request.getParameterValues("inPrs");
	%>
	<wtc:service name = "<%=svcName%>" outnum = "30" routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "rc_cfm" retmsg = "rm_cfm" >
		<%
		for ( int i=0 ; i < inPrs.length ; i ++  )
		{
		%>
			<wtc:param value = "<%=inPrs[i]%>"/>
		<%
		}
		%>
	</wtc:service>
	<wtc:array id="rst" scope="end" />
		
	var response = new AJAXPacket();
	response.data.add("oRetCode" ,"<%=rc_cfm%>");
	response.data.add("oRetMsg"  ,"<%=rm_cfm%>");
	core.ajax.receivePacket(response);   
<%
}
%>
