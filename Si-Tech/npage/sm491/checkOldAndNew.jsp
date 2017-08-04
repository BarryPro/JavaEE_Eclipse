<%
/********************
 version v1.0
开发商: si-tech
*
*create:wanghyd@2014-09-22
*
********************/
%>

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%

/*操作流水*/
String inLoginAccept="0";
/*渠道标识*/
String inChnSource="01";
/*操作代码*/
String opCode=request.getParameter("opCode");
/*操作工号*/
String workNo=(String)session.getAttribute("workNo");
/*工号密码*/
String inLoginPwd=(String)session.getAttribute("password");
/*手机号码*/
String inPhoneNo="";
/*号码密码*/
String inUserPwd="";

/*配置文件*/
String bus_realPath = request.getRealPath("npage/properties")
	+"/busInfo.properties";
/*流水号*/
String bus_netCode=request.getParameter("loginAccept");
//String bus_netCode="114131351890";

/*总线地址*/
String bus_ip = readValue("bus","info","ip",bus_realPath);	
/*总线端口*/
String bus_port =  readValue("bus","info","port",bus_realPath);	
/*业务标识*/	
String bus_appid =readValue("bus","info","appid",bus_realPath); 
/*接口标识*/
String  bus_transcode = "6";	
/*超时时间设置*/
String bus_timout = "90";	
/*提示信息*/
String showMsg="";


/*调用服务用regCode路由*/
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
	/*解析返回参数*/
	if (rstGI[0][2]==null)
	{
	%>
		var response = new AJAXPacket();
		response.data.add("retCode","ZY0004");
		response.data.add("retMsg"
			,"平台返回信息为空不能办理!");
		core.ajax.receivePacket(response);		
	<%	
	}
	else
	{
		String busOMs[]=rstGI[0][2].split(",");
System.out.println("======"+busOMs[0]);
		/*返回代码:000000表示服务调用成功*/
		if("0".equals(busOMs[0].split("=")[1]))
		{
		
			SUMFEE=busOMs[3].split("=")[1];
			/*返回信息:no表示没有关联信息*/
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
				,"平台返回信息错误不能办理!返回信息:"+"<%=busOMs[0]%>");
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
	response.data.add("retMsg","服务未启动或存在异常！请联系系统管理员！");
	core.ajax.receivePacket(response);		

<%
}
%>	
