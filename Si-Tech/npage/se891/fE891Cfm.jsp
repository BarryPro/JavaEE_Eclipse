<%
/*
 * ����: ��ͯ�ײ�
 * �汾: 1.0
 * ����: 2012-07-12 14:20:33
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/

%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String opName=request.getParameter("opName");
String regCode		=	(String)session.getAttribute("regCode");
String iLoginAccept=request.getParameter("loginAccept"); 	/*������ˮ*/
String iChnSource="01"; 		/*������ʾ*/
String iOpCode=request.getParameter("opCode"); 		/*��������*/
String iLoginNo=(String)session.getAttribute("workNo"); 		/*��������*/
String iLoginPwd=(String)session.getAttribute("password"); 		/*��������*/
String iPhoneNo=request.getParameter("cldPhone"); 		/*��Ա����*/
String iUserPwd=""; 		/*��������*/
String iNextMode=request.getParameter("offerId"); 		/*��ͯ�ʷѴ���*/
String iParentNo=request.getParameter("pPhoneNo");		/*�ҳ�����*/
String iProductStr=""; 	/*�˶��ط���*/
String iPayAmount="";  		/*�������*/
String iBusiTypeStr="";  	/*SPҵ�����ʹ�*/
String iSpIdStr= ""; 		/*SP��ҵ���봮*/
String iSpBizCodeStr="";  	/*SPҵ����봮*/
String iIpAddr=(String)session.getAttribute("ipAddr");  //IP��ַ   
String iOpNote=iOpCode+opName;  /*������־ */
%>
	<wtc:service name="sChildOfferCfm"  outnum="2"
		routerKey="region" routerValue="<%=regCode%>"  
		retcode="cldRc" retmsg="cldRm"  >
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iNextMode%>"/>
	<wtc:param value="<%=iParentNo%>"/>
	<wtc:param value="<%=iProductStr%>"/>
	<wtc:param value="<%=iPayAmount%>"/>
		
	<wtc:param value="<%=iBusiTypeStr%>"/>
	<wtc:param value="<%=iSpIdStr%>"/>
	<wtc:param value="<%=iSpBizCodeStr%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
	<wtc:param value="<%=iOpNote%>"/>
	</wtc:service>
	<wtc:array id="spRst" scope="end" />
<%
if( "000000".equals(cldRc))
{
%>
	<script>
		rdShowMessageDialog("<%=opName%>�ύ�ɹ�!");
		removeCurrentTab();
	</script>
<%
}
else
{%>
	<script>
		rdShowMessageDialog("<%=cldRc%>"+":"+"<%=cldRm%>" , 0);
		removeCurrentTab();	
	</script>
<%
}%>