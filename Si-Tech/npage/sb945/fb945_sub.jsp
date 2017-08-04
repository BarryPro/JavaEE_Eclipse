<%/**
	* 功能: 管理系数配置
	* 版本: 1.8.2
	* 日期: 2010/12/9
	* 作者: wanglm
	* 版权: sitech
	*/
	%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String workNo = (String)session.getAttribute("workNo");
    String loginNo = request.getParameter("loginNo");
    System.out.println("--------------------------------------------------------------- loginNo" + loginNo);
	String group_id = request.getParameter("groupId");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
    String opCode = request.getParameter("opCode");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
    String opCount=(String)request.getParameter("opCount");
    String operType = WtcUtil.repNull((String)request.getParameter("operType"));/* diling add for 新增操作类型参数@2012/11/6 */
    String opName = WtcUtil.repNull((String)request.getParameter("opName"));
    
    System.out.println("zhangyan@page=[fb945_sub.jsp]0=["+workNo+"]");
    System.out.println("zhangyan@page=[fb945_sub.jsp]1=["+loginNo+"]");
    System.out.println("zhangyan@page=[fb945_sub.jsp]2=[a357]");
    System.out.println("zhangyan@page=[fb945_sub.jsp]3=[0]");
    System.out.println("zhangyan@page=[fb945_sub.jsp]4=["+opCount+"]");
    System.out.println("zhangyan@page=[fb945_sub.jsp]5=["+startTime+"]");
    System.out.println("zhangyan@page=[fb945_sub.jsp]6=["+endTime+"]");

%>
  <wtc:service name="s8302Cfm" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=operType%>"/>
	<wtc:param value="0"/>
	<wtc:param value="<%=opCount%>"/>	
	<wtc:param value="<%=startTime%>"/>
	<wtc:param value="<%=endTime%>"/>

	</wtc:service>
	<wtc:array id="result"  scope="end"/>
	
	<%
	   if("000000".equals(retCode)){
	      %>
	        <script language="javascript">
	        	rdShowMessageDialog("授权成功！");
	        	window.location="fb945.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	        </script>
	      <%
	   }else{
	   	%>
	   	    <script language="javascript">
	   	    	rdShowMessageDialog("错误信息:  <%=retMsg%>  错误代码 <%=retCode%> ");
	   	    	window.location="fb945.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	        </script> 
	   	<%
	   	}
	%>