<%
  /*
   * 功能: 更新客服登陆配置
　 * 版本: 1.0.0
　 * 日期: 2009/04/11
　 * 作者: fangyuan
　 * 版权: sitech
	 *update: by yinzx 20091123
	 *不清楚这个页面是否使用 但是在替换新服务后没有to_char
　*/
%>
<%
	String opCode = "K099";
	String opName = "查询登记密码状态";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	//System.out.println("############################################");
	
	String login_no = WtcUtil.repNull(request.getParameter("login_no"));
	String Sql ="select to_char(round(sysdate-t.login_date)),t.remarks from dlogincfg t where t.login_no=:login_no";
	myParams = "login_no="+login_no ;

%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	<wtc:param value="<%=Sql%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("everyDay","<%=rows[0][0]%>");
response.data.add("remarks","<%=rows[0][1]%>");
core.ajax.receivePacket(response);





