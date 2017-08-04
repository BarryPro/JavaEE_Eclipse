<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
		String opCode = (String)request.getParameter("opCode");
		String classCode = (String)request.getParameter("classCode");
		String id = (String)request.getParameter("id");
		String [] classValueArr = request.getParameterValues("classValue");
		String regionCode =((String)session.getAttribute("orgCode")).substring(0,2);
		String groupId =(String)session.getAttribute("groupId");
		String sm_code = (String)request.getParameter("smCode");
		if(sm_code == null || sm_code.equals("undefined")){
		    sm_code = "";
		}
  String accountType=(String)session.getAttribute("accountType");
  String channelsCode=( accountType.equals("2")?"08":"01" );
  System.out.println("zhangyan~~~channelsCode="+channelsCode);		
		
%>
<wtc:service name="s9611Cfm2" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="4" >
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="1"/>
    <wtc:param value="12"/>
    <wtc:param value="<%=groupId%>"/>
 		<wtc:params value="<%=classValueArr%>"/>
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
	if(ret_code.equals("000000"))
	{
		for(int i=0;i<result.length;i++)
		{
				retCode="000000";
				if(i==0)
				{
					retMsg +=result[i][2].trim()+"-"+result[i][3].trim()+"<br/>"
								 +(pos+1)+"."+result[i][0].trim()+"<br/>";
				}else
				{
					if(result[i][2].equals(result[i-1][2]))//同一code
					{
						retMsg +=(pos+1)+"."+result[i][0].trim()+"<br/>";
					}else //新一条code
					{
						pos=0;
						retMsg +=result[i][2].trim()+"-"+result[i][3].trim()+"<br/>"
								   +(pos+1)+"."+result[i][0].trim()+"<br/>";
					}
				}
				pos++;
		}
		
		//System.out.println("111112222333444555666retMsg="+retMsg);
		
		
	}
	
	retMsg = retMsg.replaceAll("\r\n","</br>");  
	retMsg = retMsg.replaceAll("\r","</br>"); 
	retMsg = retMsg.replaceAll("\n","</br>"); 
	retMsg = retMsg.replaceAll("\"","&quot;"); 
	retMsg = retMsg.replaceAll("\'","&quot;"); 
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("id","<%=id%>");
core.ajax.receivePacket(response);
