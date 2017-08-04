<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String opCode = (String)request.getParameter("opCode");
	String passWord = (String)session.getAttribute("password");
  String regionCode =((String)session.getAttribute("orgCode")).substring(0,2);
%>
<wtc:service name="sGetOpRela" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="5" >
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=passWord%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
if(ret_code.equals("000000"))
{
	if(result.length>0)
	{
	%>
		<%
		for(int i=0;i<result.length;i++)
		{
			System.out.println("||||yanpx test ||||"+result[i][3]);
		%>
	    <a href="javascript:topage('<%=result[i][0]%>','<%=result[i][1]%>','<%=result[i][2]%>','<%=result[i][3]%>','<%=result[i][4]%>')">
	    	<%=result[i][3].trim()%>
	    </a>
		<%
			if(i+1!=result.length)
			{
				out.println("|");
			}
		}
	}
}else
{
	//out.println("未取到提示信息");
}
%>
