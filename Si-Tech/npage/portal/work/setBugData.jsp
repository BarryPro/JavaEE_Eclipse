<%
   /*
   * ����: �������ⷴ��
�� * �汾: v1.0
�� * ����: 2008��4��18��
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
     String workNo = (String)session.getAttribute("workNo");
	   String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
     String ret_code="999999";
                          
     String subject     =request.getParameter("bugsubject");  //����                         
     String content     =request.getParameter("bugContent");  //����                         
     String buglevel    =request.getParameter("buglevel");    //���ϼ���                     
     String parrent_id  =request.getParameter("pater_id");    //�ظ���ʱ���¼�ظ������bugid
     
%>

<wtc:service name="sBugIns" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=subject%>"/>
	<wtc:param value="<%=content%>"/>
	<wtc:param value="<%=buglevel%>"/>
	<wtc:param value="<%=parrent_id%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />


<%
if(retCode.equals("000000"))
{
    ret_code="000000";
}
else
{
    ret_code="999999";
}
  out.println(ret_code);
%>	