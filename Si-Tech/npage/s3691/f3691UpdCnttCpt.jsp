<%
/*
 * ����: ��Ŀ��ͬ��ƷЭ��
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

String regCode		=	(String)session.getAttribute("regCode");
String iLoginAccept=request.getParameter("login_accept"); 	/*������ˮ*/
String iChnSource="01"; 		/*������ʾ*/
String iOpCode="3690"; 		/*��������*/
String iLoginNo=(String)session.getAttribute("workNo"); 		/*��������*/
String iLoginPwd=(String)session.getAttribute("password"); 		/*��������*/
String iPhoneNo=""; 		/*��Ա����*/
String iUserPwd=""; 		/*��������*/
String iIdNo=request.getParameter("grpIdNo"); 		/*�����û�ID*/
String iCompactNo=request.getParameter("cptNo"); 		/*Э����*/
String iContractNo=request.getParameter("cntNo"); 		/*��ͬ���*/
String iOpenDate=request.getParameter("prodOpenTime"); 		/*��Ʒ����ʱ��*/
String iCnttCode=request.getParameter("oCnttCode"); 		/*��ͬ����ű��*/
String iCptCode=request.getParameter("oCptCode"); 		/*Э�鸸���*/
String iUnitId=request.getParameter("oUnitId"); 		/*���ű��*/

%>
	<wtc:service name="sContractUpdate"  outnum="2"
		routerKey="region" routerValue="<%=regCode%>"  
		retcode="cldRc" retmsg="cldRm"  >
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>	
	<wtc:param value="<%=iIdNo%>"/>
	<wtc:param value="<%=iCompactNo%>"/>
	<wtc:param value="<%=iContractNo%>"/>
	<wtc:param value="<%=iOpenDate%>"/>
	<wtc:param value="<%=iCnttCode%>"/>
	<wtc:param value="<%=iCptCode%>"/>
	<wtc:param value="<%=iUnitId%>"/>
	</wtc:service>
	<wtc:array id="spRst" scope="end" />
<%
if( "000000".equals(cldRc))
{
%>
	<script>
		rdShowMessageDialog("�ύ�ɹ�!");
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