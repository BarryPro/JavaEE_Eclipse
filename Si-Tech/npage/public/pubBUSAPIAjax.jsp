<%
/********************
 version v1.0
������: si-tech
*
*create:zhangyan@2011-11-30
*
********************/
%>

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%

/*������ˮ*/
String inLoginAccept="0";
/*������ʶ*/
String inChnSource="01";
/*��������*/
String opCode=request.getParameter("opCode");
/*��������*/
String workNo=(String)session.getAttribute("workNo");
/*��������*/
String inLoginPwd=(String)session.getAttribute("password");
/*�ֻ�����*/
String inPhoneNo="";
/*��������*/
String inUserPwd="";

/*�����ļ�*/
String bus_realPath = request.getRealPath("npage/properties")
	+"/busInfo.properties";
/*����ʺ�*/
String bus_netCode=request.getParameter("netCode");
//String bus_netCode="13644603214";
/*���ߵ�ַ*/
String bus_ip = readValue("bus","info","ip",bus_realPath);	
/*���߶˿�*/
String bus_port =  readValue("bus","info","port",bus_realPath);	
/*ҵ���ʶ*/	
String bus_appid =readValue("bus","info","appid",bus_realPath); 	
/*�ӿڱ�ʶ*/
String  bus_transcode = readValue("bus","info","transcode",bus_realPath);	
/*��ʱʱ������*/
String bus_timout = "90";	
/*��ʾ��Ϣ*/
String showMsg="";

if (opCode.equals("e301"))
{
	/*liyana 20140603 cuiqiӪ������Ҫ���޸ġ�
	/*showMsg="�ͻ���������Ӫ������"		+"ȡ���������ҵ����ͬʱȡ�����Ӫ����";*/
	showMsg="�˿��ΪӪ��������Ŀ������������ȡ��";
}
else if (opCode.equals("b542"))
{
	showMsg="�ͻ���������Ӫ������ȡ�����ҵ����ͬʱȡ�����Ӫ����";
}
else if (opCode.equals("e083"))
{
	showMsg="�ͻ��������˿��Ӫ���������ȳ�����ȡ��Ӫ������������������ҵ��";
}

/*���÷�����regCode·��*/
String regCode=(String)session.getAttribute("regCode");

/*���������봮*/
String orderArrayID=request.getParameter("orderArrayID");
try{
%>

<wtc:service name="sGetinter" routerKey="regCode" 
	routerValue="<%=regCode%>"  
	retcode="rcGI" retmsg="rmGI"  outnum="4" >
    <wtc:param value="<%=inLoginAccept%>"/>
    <wtc:param value="<%=inChnSource%>"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=inLoginPwd%>"/>
    <wtc:param value="<%=inPhoneNo%>"/>
    <wtc:param value="<%=inUserPwd%>"/>
    	
    <wtc:param value="<%=bus_ip%>"/>
    <wtc:param value="<%=bus_port%>"/>
    <wtc:param value="<%=bus_appid%>"/>
    <wtc:param value="<%=bus_transcode%>"/>
    <wtc:param value="<%=orderArrayID%>"/>
    <wtc:param value="<%=bus_netCode%>"/>
</wtc:service>
<wtc:array id="rstGI" scope="end" />
	
<%
String busRTC="";
String busRTM="";

if ( rcGI.equals("000000")  )
{
	/*�������ز���*/
	if (rstGI[0][2]==null)
	{
	%>
		var response = new AJAXPacket();
		response.data.add("retCode","ZY0004");
		response.data.add("retMsg"
			,"ƽ̨������ϢΪ�ղ��ܰ���!");
		core.ajax.receivePacket(response);		
	<%	
	}
	else
	{
		String busOMs[]=rstGI[0][2].split("~");

		/*���ش���:000000��ʾ������óɹ�*/
		if(busOMs.length<2)
		{
		%>
			var response = new AJAXPacket();
			response.data.add("retCode","ZY0004");
			response.data.add("retMsg"
				,"ƽ̨������Ϣ�����ܰ���!������Ϣ:"+"<%=busOMs[0]%>");
			core.ajax.receivePacket(response);		
		<%
		}
		else
		{
			busRTC=busOMs[0].split("=")[1];
			/*������Ϣ:no��ʾû�й�����Ϣ*/
			busRTM=busOMs[1].split("=")[1];
			
			if (busRTC.equals("000000") )
			{
				if (busRTM.equals("no"))
				{
				%>
					var response = new AJAXPacket();
					response.data.add("retCode","000000");
					response.data.add("retMsg","У��ɹ�");
					core.ajax.receivePacket(response);					
				<%
				}
				else
				{
				%>
					var response = new AJAXPacket();
					response.data.add("retCode","ZY0003");
					response.data.add("retMsg","<%=showMsg%>");
					core.ajax.receivePacket(response);										
				<%					
				}
			}else{
				%>
					var response = new AJAXPacket();
					response.data.add("retCode","ZY0003");
					response.data.add("retMsg","<%=showMsg%>");
					core.ajax.receivePacket(response);		
				<%
			}
		}	
	}
}
else
{
%>
	var response = new AJAXPacket();
	response.data.add("retCode","ZY0003");
	response.data.add("retMsg","<%=rmGI%>");
	core.ajax.receivePacket(response);		
<%
}	
}catch(Exception e){
%>
	var response = new AJAXPacket();
	response.data.add("retCode","444444");
	response.data.add("retMsg","����δ����������쳣������ϵϵͳ����Ա��");
	core.ajax.receivePacket(response);		

<%
}
%>	
