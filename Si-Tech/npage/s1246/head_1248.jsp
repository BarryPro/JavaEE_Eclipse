<%
//�ڴ˴���ȡsession��Ϣ
String hdword_no = (String)session.getAttribute("workNo");//����
String hdorg_code = (String)session.getAttribute("orgCode");//org_code ����Ȩ�޹���
String hdwork_pwd = (String)session.getAttribute("password");//��������		
String hdthe_ip = (String)session.getAttribute("ipAddr");//��½IP	
String[][] favInfo = (String[][])session.getAttribute("favInfo");	
%>