<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.s1100.viewBean.S1100View" %>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<link rel="stylesheet" href="/css/style.css" type="text/css">
<%
	Logger logger = Logger.getLogger("f1024_2.jsp");
	S1100View callView = new S1100View();
	ArrayList retArray = new ArrayList();
  String[][] result = new String[][]{};
  String department = Pub_lxd.repStr(request.getParameter("department"),""); 
  String team_flag = Pub_lxd.repStr(request.getParameter("team_flag"),""); 
  String changeid = Pub_lxd.repStr(request.getParameter("changeid"),""); 
  String roleid = Pub_lxd.repStr(request.getParameter("roleid"),""); 
  int flagcount=0;
  String sqlStr="";
try{
  sqlStr ="delete sdeptrole where role_code='"+roleid+"' and dept_id <> '**'";
  retArray = callView.view_spubqry32("2",sqlStr);
	 }catch(Exception e){
			logger.error("Call sunView is Failed!");
			flagcount++;
	 } 
String[] chaid=changeid.split("%");
for(int i=0;i<chaid.length;i++){
try{
  sqlStr ="insert into sdeptrole(role_code,dept_id,parent_dept,team_flag,role_name)values('"+roleid+"','"+chaid[i]+"','"+department+"','"+team_flag+"',(select department_name  from department_message  where department_id='"+chaid[i]+"'))";
  retArray = callView.view_spubqry32("2",sqlStr);
	 }catch(Exception e){
			logger.error("Call sunView is Failed!");
			flagcount++;
} 
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
