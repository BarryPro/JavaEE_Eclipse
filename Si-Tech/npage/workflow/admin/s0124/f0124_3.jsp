<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.s1100.viewBean.S1100View" %>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<link rel="stylesheet" href="/css/style.css" type="text/css">

<%
	Logger logger = Logger.getLogger("f1024_3.jsp");
	S1100View callView = new S1100View();
	ArrayList retArray = new ArrayList();
  String[][] result = new String[][]{};
  String department = Pub_lxd.repStr(request.getParameter("department"),""); 
  String team_flag = Pub_lxd.repStr(request.getParameter("team_flag"),""); 
  int flagcount=0;
  String sqlStr="";
try{
  sqlStr ="delete from dwsrolememb where role_code in (select distinct role_code from sdeptrole )";
  retArray = callView.view_spubqry32("2",sqlStr);
	 }catch(Exception e){
			logger.error("Call sunView is Failed!");
			flagcount++;
	 } 
try{
  sqlStr ="insert into dwsrolememb (role_code,login_no) select a.role_code, b.login_no from sdeptrole a,dloginmsg b where b.expire_time > sysdate and a.dept_id = b.dept_code";
  retArray = callView.view_spubqry32("2",sqlStr);
	 }catch(Exception e){
			logger.error("Call sunView is Failed!");
			flagcount++;
	 }	 

  	if(flagcount>0){
%>
      <script language='jscript'>
				rdShowMessageDialog("操作失败,请核对数据！");
			</script>
<% 
  	}else{
  %>
      <script language='jscript'>
				rdShowMessageDialog("操作成功！" );
				location = "f0124_1.jsp?department=<%=department%>&team_flag=<%=team_flag%>";
			</script>
<% 
  	}

%>
