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
	String group_id = request.getParameter("groupId");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
    String opCode = request.getParameter("opCode");
    String groupName = request.getParameter("groupName");
%>
    <wtc:service name="sb901Qry" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=group_id%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
	
	<%
	   String varyBusy = result[0][1];
	   String busy = result[0][2];
	   String waitePeoples = result[0][3];
	   String waiteTime = result[0][4];
	   String serviceNo = result[0][5];
	   String administratorNo = result[0][6];
	   System.out.println("======================= 终于能看清了 =========================");
	   System.out.println("======================= + varyBusy" + varyBusy);
	   System.out.println("======================= + busy" + busy);
	   System.out.println("======================= + waitePeoples" + waitePeoples);
	   System.out.println("======================= + waiteTime" + waiteTime);
	   System.out.println("======================= + serviceNo" + serviceNo);
	   System.out.println("======================= + administratorNo" + administratorNo);
	   if("000000".equals(retCode)){
	      %>
	        <script language="javascript">
	        	window.location = "fb901_show.jsp?opCode=<%=opCode%>&opName=管理系数配置&varyBusy=<%=varyBusy%>&busy=<%=busy%>&waitePeoples=<%=waitePeoples%>&waiteTime=<%=waiteTime%>&serviceNo=<%=serviceNo%>&administratorNo=<%=administratorNo%>&groupId=<%=group_id%>&groupName=<%=groupName%>";
	        </script>
	      <%
	   }else{
	   	%>
	   	    <script language="javascript">
	   	    	rdShowMessageDialog("错误信息  <%=retMsg%>  错误代码 <%=retCode%> ");
	        	window.location = "fb901_sel.jsp";
	        </script> 
	   	<%
	   	}
	%>