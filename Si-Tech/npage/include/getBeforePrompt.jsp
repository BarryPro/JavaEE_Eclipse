<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String opCode = (String)request.getParameter("opCode");
  String regionCode =((String)session.getAttribute("orgCode")).substring(0,2);
  String groupId =(String)session.getAttribute("groupId");
  String accountType=(String)session.getAttribute("accountType");
  String channelsCode=( accountType.equals("2")?"08":"01" );
  System.out.println("zhangyan~~~channelsCode="+channelsCode);
  
%>
<wtc:service name="s9611Cfm1" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="2" >
	<wtc:param value="<%=opCode%>"/>
    <wtc:param value="1"/>
    <wtc:param value="11"/>
    <wtc:param value="<%=groupId%>"/>
    <wtc:param value="<%=channelsCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
if(ret_code.equals("000000"))
{
	if(result.length>0)
	{
	%>
	<ul>
		<%
		for(int i=0;i<result.length;i++)
		{
		%>
	    <li><%=i+1%>.<%=result[i][0].trim()%></li>
		<%
		}
		%>
	</ul>
	<%
	}
}else
{
	//out.println("未取到提示信息");
}
%>
