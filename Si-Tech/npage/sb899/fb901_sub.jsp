<%/**
	* ����: ��Ա������Ϣ��������
	* �汾: 1.8.2
	* ����: 2010/12/1
	* ����: wanglm
	* ��Ȩ: sitech
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
    String busy = request.getParameter("busy");
    String varyBusy = request.getParameter("varyBusy");
    String waitPeoples = request.getParameter("waitPeoples");
    String waitTime = request.getParameter("waitTime");
    String serviceNo = request.getParameter("serviceNo");
    String administratorNo = request.getParameter("administratorNo");
    System.out.println("======================= + varyBusy     " + varyBusy);
	   System.out.println("======================= + busy    " + busy);
	   System.out.println("======================= + waitePeoples    " + waitPeoples);
	   System.out.println("======================= + waiteTime    " + waitTime);
	   System.out.println("======================= + serviceNo    " + serviceNo);
	   System.out.println("======================= + administratorNo    " + administratorNo);
	   System.out.println("======================= + groupId    " + group_id);
%>
    <wtc:service name="sb901Cfm" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=group_id%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=varyBusy%>"/>
	<wtc:param value="<%=busy%>"/>
	<wtc:param value="<%=waitPeoples%>"/>	
	<wtc:param value="<%=waitTime%>"/>
	<wtc:param value="<%=serviceNo%>"/>
	<wtc:param value="<%=administratorNo%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
	
	<%
	   if("000000".equals(retCode)){
	      %>
	        <script language="javascript">
	        	rdShowMessageDialog("�ѳɹ����ͣ�");
	        	window.location = "fb901.jsp";
	        </script>
	      <%
	   }else{
	   	%>
	   	    <script language="javascript">
	   	    	rdShowMessageDialog("������Ϣ  <%=retMsg%>  ������� <%=retCode%> ");
	        	window.location = "fb901.jsp";
	        </script> 
	   	<%
	   	}
	%>