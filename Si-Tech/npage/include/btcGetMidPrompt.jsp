/*
	zhangyan create 2012-2-9 15:15:02
*/
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
String opCode 		= 	(String)request.getParameter("opCode");
String classCode 	= 	(String)request.getParameter("classCode");
String strId 		= 	(String)request.getParameter("id");
String classValue 	= 	(String)request.getParameter("classValue");
String regionCode 	=	((String)session.getAttribute("orgCode")).substring(0,2);
String groupId 		=	(String)session.getAttribute("groupId");
String sm_code 		= 	(String)request.getParameter("smCode");
String classValues[]=	classValue.split("\\|");
String strClassValue=	"";

  String accountType=(String)session.getAttribute("accountType");
  String channelsCode=( accountType.equals("2")?"08":"01" );
  System.out.println("zhangyan~~~channelsCode="+channelsCode);	
if(sm_code == null || sm_code.equals("undefined"))
{
    sm_code = "";
}
%>
<wtc:service name="s9611Cfm2" routerKey="regionCode" routerValue="<%=regionCode%>"  
	retcode="ret_code" retmsg="retMessage"  outnum="4" >
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="1"/>
    <wtc:param value="12"/>
    <wtc:param value="<%=groupId%>"/>
 	<wtc:params value="<%=classValues%>"/>
    <wtc:param value="<%=classCode%>"/>
    <wtc:param value="<%=regionCode%>"/>
    <wtc:param value="<%=sm_code%>"/>
    <wtc:param value="<%=channelsCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
String retCode = "-1";
String retMsg = "";
int pos=0;
String promptContent[]	=new String[result.length];
String id1s[]			=new String[result.length];
if(ret_code.equals("000000"))
{
	System.out.println("zhangyan result.length="+result.length);
	for(int i=0;i<result.length;i++)
	{
		promptContent[i]="";
		id1s[i]			=result[i][2];
		retCode="000000";
		if(i==0)
		{
			promptContent[i] +=result[i][2].trim()+"-"+result[i][3].trim()+"<br/>"
						 +(pos+1)+"."+result[i][0].trim()+"<br/>";
		}else
		{
			if(result[i][2].equals(result[i-1][2]))//同一code
			{
				promptContent[i] +=(pos+1)+"."+result[i][0].trim()+"<br/>";
			}
			else //新一条code
			{
				pos=0;
				promptContent[i] +=result[i][2].trim()+"-"+result[i][3].trim()+"<br/>"
				   +(pos+1)+"."+result[i][0].trim()+"<br/>";
			}
		}
		pos++;
		System.out.println( "zhangyan@page=[btcGetMidPrompt.jsp]promptContent="+promptContent[i] );
		System.out.println( "zhangyan@page=[btcGetMidPrompt.jsp]id1s="+id1s[i] );
	}
}
%>
var promptContent1	=new Array();
var id1s1			=new Array();
<%
for (int i=0; i<promptContent.length; i++)
{
	promptContent[i] = promptContent[i].replaceAll("\r\n","</br>");  
	promptContent[i] = promptContent[i].replaceAll("\r","</br>"); 
	promptContent[i] = promptContent[i].replaceAll("\n","</br>"); 
	promptContent[i] = promptContent[i].replaceAll("\'","&quot;"); 
	promptContent[i] = promptContent[i].replaceAll("\"","&quot;"); 	
%>
	id1s1[<%=i%>]			='<%=id1s[i]%>';
	promptContent1[<%=i%>]	='<%=promptContent[i]%>';
<%
}
%>

var response = new AJAXPacket();
response.data.add("retCode"			,"<%=retCode%>");
response.data.add("retMsg"			,"<%=retMsg%>");
response.data.add("strId"			,"<%=strId%>");
response.data.add("id1s"			,id1s1);
response.data.add("promptContent"	,promptContent1);
core.ajax.receivePacket(response);
