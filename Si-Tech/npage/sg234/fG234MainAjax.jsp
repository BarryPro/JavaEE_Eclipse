<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%!
public static String createArray(String aimArrayName, int xDimension) 
{
	String stringArray = "var " + aimArrayName + " = new Array(";
	int flag = 1;
	for (int i = 0; i < xDimension; i++) 
	{
		if (flag == 1) 
		{
			stringArray = stringArray + "new Array()";
			flag = 0;
			continue;
		}
		if (flag == 0) 
		{
			stringArray = stringArray + ",new Array()";
		}
	}
	
	stringArray = stringArray + ");";
	return stringArray;
}
%>


<%
String regionCode = (String)session.getAttribute("regCode");
String iChnSource = request.getParameter("iChnSource");
String opCode  = request.getParameter("opCode");
String workNo  = request.getParameter("workNo");
String password = (String) session.getAttribute("password");
String phoneNo = request.getParameter("phoneNo");
phoneNo= phoneNo.trim();
String iUserPwd = request.getParameter("iUserPwd");
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sysAccept"/>
	
<%
String [] inputParam = new String [7] ;
inputParam[0] = sysAccept;
inputParam[1] = iChnSource;
inputParam[2] = opCode;
inputParam[3] = workNo;
inputParam[4] = password;
inputParam[5] = phoneNo;
inputParam[6] = iUserPwd;	

/**
System.out.println("zhouby: fG234MainAjax.jsp inputParam[0] " + inputParam[0]);
System.out.println("zhouby: fG234MainAjax.jsp inputParam[1] " + inputParam[1]);
System.out.println("zhouby: fG234MainAjax.jsp inputParam[2] " + inputParam[2]);
System.out.println("zhouby: fG234MainAjax.jsp inputParam[3] " + inputParam[3]);
System.out.println("zhouby: fG234MainAjax.jsp inputParam[4] " + inputParam[4]);
System.out.println("zhouby: fG234MainAjax.jsp inputParam[5] " + inputParam[5]);
System.out.println("zhouby: fG234MainAjax.jsp inputParam[6] " + inputParam[6]);
*/
%>
<wtc:service name="sB540Init" routerKey="phone" routerValue="<%=phoneNo%>" outnum="38" >
<wtc:param value="<%=inputParam[0]%>"/>
<wtc:param value="<%=inputParam[1]%>"/>
<wtc:param value="<%=inputParam[2]%>"/>
<wtc:param value="<%=inputParam[3]%>"/>
<wtc:param value="<%=inputParam[4]%>"/>
<wtc:param value="<%=inputParam[5]%>"/>
<wtc:param value="<%=inputParam[6]%>"/>
</wtc:service>
<wtc:array id="backUserInfo" scope="end"/>
<%
if( !(retCode.equals("000000")))
{
%>
	var response = new AJAXPacket();
	response.data.add("backString","");
	response.data.add("flag","9");
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);
<%
}
else
{
	String strArray = createArray("backUserInfo",backUserInfo.length);
	%>
	<%=strArray%>
	<%
	if(backUserInfo.length>0)
	{
		for(int j=0;j<backUserInfo[0].length;j++)
		{
			System.out.println("g234~~~backUserInfo[0]["+j+"]"+backUserInfo[0][j]);
		%>
			backUserInfo[0][<%=j%>] = "<%=backUserInfo[0][j]%>";
		<%
		}
	}
	%>
	var response = new AJAXPacket();
	response.data.add("backString",backUserInfo);
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMsg%>");
	response.data.add("phoneNo","<%=phoneNo%>");
	response.data.add("flag","0");
	core.ajax.receivePacket(response);
<%
}%>
