<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="/npage/common/errorpage.jsp" %><%/*update by diling for Ӫҵ��������weblogic�����Բ�����@2011/10/27 */%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 

<%
	//String activePhone  = (String)session.getAttribute("activePhone");//��ǰ�����û�����
	String activePhone = (String)request.getParameter("activePhone");
	String appCnttFlag = (String) application.getAttribute("appCnttFlag");//�Ӵ�ƽ̨״̬
%>

<%
	String opBeginTime  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//ҵ��ʼʱ��
	//System.out.println("opBeginTime=="+opBeginTime);
%>
