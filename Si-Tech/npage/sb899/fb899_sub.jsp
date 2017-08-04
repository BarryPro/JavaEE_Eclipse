<%/**
	* 功能: 管理系数配置
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
	String groupId = request.getParameter("groupId");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String groupName = request.getParameter("groupName");
    String showTime = request.getParameter("showTime");
%>
    <wtc:service name="sb899Qry" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="14">
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=groupId%>"/>
	<wtc:param value="<%=showTime%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
	<%
	   String[][] res = result;
	   for(int i=0;i<res.length;i++){
	       System.out.println("----------------------------------------------------------------------------------      " + res[i][0]);
	   }
	   if("000000".equals(retCode)){
	      request.setAttribute("result",res);
	      request.getRequestDispatcher("fb899_show.jsp").forward(request, response);
	   }else{
	   	%>
	   	    <script language="javascript">
	   	    	rdShowMessageDialog("错误信息  <%=retMsg%>  错误代码 <%=retCode%> ");
	        	window.location = "fb899.jsp";
	        </script> 
	   	<%
	   	}
	%>
