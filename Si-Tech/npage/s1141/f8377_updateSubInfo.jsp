<%
    /*************************************
    * 功  能: 赠送预存款方案信息修改功能
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-10-26
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
            rdShowMessageDialog("修改成功！",2);
        	window.location="/npage/s1141/f8377_Qry.jsp?opCode=8377&opName=赠送预存款方案详细信息";
        </script>
<%
    }else{
%>
        <script language="JavaScript">
             rdShowMessageDialog("修改营销结束时间失败!<br>(错误信息：<%=retMsg%>)",0);
             window.location="/npage/s1141/f8377_Qry.jsp?opCode=8377&opName=赠送预存款方案详细信息";
        </script>
<%
    }
%>

	    