<%
/********************
 version v1.0
������: si-tech
*
*create:wanghyd@2014-09-22
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
/*��ˮ��*/
String bus_netCode=request.getParameter("loginAccept");
//String bus_netCode="114131351890";

/*���ߵ�ַ*/
String bus_ip = readValue("bus","info","ip",bus_realPath);	
/*���߶˿�*/
String bus_port =  readValue("bus","info","port",bus_realPath);	
/*ҵ���ʶ*/	
String bus_appid =readValue("bus","info","appid",bus_realPath); 
/*�ӿڱ�ʶ*/
String  bus_transcode = "6";	
/*��ʱʱ������*/
String bus_timout = "90";	
/*��ʾ��Ϣ*/
String showMsg="";


/*���÷�����regCode·��*/
String regCode=(String)session.getAttribute("regCode");


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
    <wtc:param value=""/>
    <wtc:param value="<%=bus_netCode%>"/>
</wtc:service>
<wtc:array id="rstGI" scope="end" />
	
<%
String SUMFEE="";
String EXCHFEE="";

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
		String busOMs[]=rstGI[0][2].split(",");
System.out.println("======"+busOMs[0]);
		/*���ش���:000000��ʾ������óɹ�*/
		if("0".equals(busOMs[0].split("=")[1]))
		{
		
			SUMFEE=busOMs[3].split("=")[1];
			/*������Ϣ:no��ʾû�й�����Ϣ*/
			EXCHFEE=busOMs[4].split("=")[1];
		%>
			var response = new AJAXPacket();
			response.data.add("retCode","000000");
			response.data.add("SUMFEE","<%=SUMFEE%>");
			response.data.add("EXCHFEE","<%=EXCHFEE%>");
			core.ajax.receivePacket(response);	

			
		<%
		}
		else
		{
		%>
					var response = new AJAXPacket();
			response.data.add("retCode","ZY0004");
			response.data.add("retMsg"
				,"ƽ̨������Ϣ�����ܰ���!������Ϣ:"+"<%=busOMs[0]%>");
			core.ajax.receivePacket(response);	
			
<%
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
