<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%String regionCode = (String)session.getAttribute("regCode");%>
<%@ page contentType="text/html;charset=GBK"%>
<%	
	String WorkNo         =	request.getParameter("sWorkNo");        //0 ��������                        
	String PassWord       =	request.getParameter("sPassWord");      //1 ��������                    
	String OpCode         =	request.getParameter("sOpCode");        //2 ���ܴ���                             
	String PONumber       =	request.getParameter("sPONumber");      //3 �������           
	String POOper         =	request.getParameter("sPOOper");        //4 ����������           
	String PONote         =	request.getParameter("sPONote");        //5 ע��                       
	String POType         =	request.getParameter("sPOType");        //6 ����������       

	System.out.println("0 ��������    WorkNo        :"+WorkNo        );
	System.out.println("1 ��������    PassWord      :"+PassWord      );
	System.out.println("2 ���ܴ���    OpCode        :"+OpCode        );
	System.out.println("3 �������    PONumber      :"+PONumber      );
	System.out.println("4 �ͻ�ID      POOper        :"+POOper        );
	System.out.println("5 ҵ����û�  PONote        :"+PONote        ); 
	System.out.println("6 �������    POType        :"+POType        );
%>

<wtc:service name="s7417Cfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=WorkNo%>"/>
	<wtc:param value="<%=PassWord%>"/>
	<wtc:param value="<%=OpCode%>"/>
	<wtc:param value="<%=PONumber%>"/>
	<wtc:param value="<%=POOper%>"/>
	<wtc:param value="<%=PONote%>"/>
	<wtc:param value="<%=POType%>"/>									
</wtc:service>
<wtc:array id="result" scope="end" start="0" length="2"/>
<%
	retCode="999999";
	retMsg="ϵͳ����";
	if(result.length>0){
	  	retCode = result[0][0];
	  	retMsg = result[0][1].trim();
	  	System.out.println("retCode:"+retCode);
	  	System.out.println("retMsg:"+retMsg);
	}
%>
var response = new AJAXPacket();
var retCode ='<%=retCode%>';
var retMsg ='<%=retMsg%>';
response.data.add("retCode",retCode);
response.data.add("retMsg",retMsg);
core.ajax.receivePacket(response);
