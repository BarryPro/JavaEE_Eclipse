<%
    /*************************************
    * ��  ��: ����Ԥ������Ϣ�޸Ĺ���
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-10-26
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "e364";
    String loginNo= (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
	String projectcode = request.getParameter("projectcode");
	String projecttype = request.getParameter("projecttype");
	String stop_time = request.getParameter("stop_time");
	String regionCode = request.getParameter("regionCode");
%>
	<wtc:service name="sE364Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=projecttype%>"/>
		<wtc:param value="<%=projectcode%>"/>
		<wtc:param value="<%=stop_time%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
	    
<%
   if("000000".equals(retCode)){
%>
        <script language="JavaScript">
            rdShowMessageDialog("�޸ĳɹ���",2);
        	window.location="/npage/s1141/f8377_Qry.jsp?opCode=8377&opName=����Ԥ������ϸ��Ϣ";
        </script>
<%
    }else{
%>
        <script language="JavaScript">
             rdShowMessageDialog("�޸�Ӫ������ʱ��ʧ��!<br>(������Ϣ��<%=retMsg%>)",0);
             window.location="/npage/s1141/f8377_Qry.jsp?opCode=8377&opName=����Ԥ������ϸ��Ϣ";
        </script>
<%
    }
%>

	    