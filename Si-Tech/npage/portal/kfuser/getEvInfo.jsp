<%
   /*
   * ����: ��ѯ�ͻ�������Ϣ
�� * �汾: v1.0
�� * ����: 2008��4��22��
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
	String password = (String)session.getAttribute("password");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String phone_no = (String)session.getAttribute("activePhone");

%>

 <script>
 //$("#wait2").hide();		   
 </script>
 
