<%
//在此处读取session信息
String hdword_no = (String)session.getAttribute("workNo");//工号
String hdorg_code = (String)session.getAttribute("orgCode");//org_code 操作权限归属
String hdwork_pwd = (String)session.getAttribute("password");//工号密码		
String hdthe_ip = (String)session.getAttribute("ipAddr");//登陆IP	
String[][] favInfo = (String[][])session.getAttribute("favInfo");	
%>