<%
   /*
   * 功能: 新增问题反馈
　 * 版本: v1.0
　 * 日期: 2008年4月18日
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
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
                          
     String subject     =request.getParameter("bugsubject");  //标题                         
     String content     =request.getParameter("bugContent");  //内容                         
     String buglevel    =request.getParameter("buglevel");    //故障级别                     
     String parrent_id  =request.getParameter("pater_id");    //回复的时候记录回复问题的bugid
     
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