<%/**
	* 功能: 服务运营数据分析
	* 版本: 1.8.2
	* 日期: 2010/12/1
	* 作者: wanglm
	* 版权: sitech
	*/
	%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String workNo = (String)session.getAttribute("workNo");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String group_id = request.getParameter("groupId");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
    String opCode = request.getParameter("opCode");
    String todayTime = request.getParameter("time");
%>
    <wtc:service name="sb902Qry" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=group_id%>"/>
	<wtc:param value="<%=todayTime%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
	
	<%
	   String[][] res = result;
	   if("000000".equals(retCode)){
	      request.setAttribute("result",res);
	      request.getRequestDispatcher("fb902_show.jsp").forward(request, response);
	   }else{
	   	%>
	   	    <script language="javascript">
	   	    	rdShowMessageDialog("错误信息  <%=retMsg%>  错误代码 <%=retCode%> ");
	        	window.location = "fb902.jsp";
	        </script> 
	   	<%
	   	}
	%>
