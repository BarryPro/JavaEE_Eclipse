<%
/********************
 version v1.0
开发商: si-tech
*
*create:zhangyan@2011-11-30
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
/*宽带帐号*/
String bus_netCode=request.getParameter("netCode");
//String bus_netCode="13644603214";
/*总线地址*/
String bus_ip = readValue("bus","info","ip",bus_realPath);	
/*总线端口*/
String bus_port =  readValue("bus","info","port",bus_realPath);	
/*业务标识*/	
String bus_appid =readValue("bus","info","appid",bus_realPath); 	
/*接口标识*/
String  bus_transcode = readValue("bus","info","transcode",bus_realPath);	
/*超时时间设置*/
String bus_timout = "90";	
/*提示信息*/
String showMsg="";

if (opCode.equals("e301"))
{
	/*liyana 20140603 cuiqi营销案，要求修改。
	/*showMsg="客户您参与宽带营销案，"		+"取消宽带包年业务，请同时取消相关营销案";*/
	showMsg="此宽带为营销案捆绑的宽带，不允许单独取消";
}
else if (opCode.equals("b542"))
{
	showMsg="客户您参与宽带营销案，取消宽带业务，请同时取消相关营销案";
}
else if (opCode.equals("e083"))
{
	showMsg="客户您参与了宽带营销案，请先冲正或取消营销案再来办理宽带撤单业务";
}

/*调用服务用regCode路由*/
String regCode=(String)session.getAttribute("regCode");

/*宽带子项编码串*/
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
		String busOMs[]=rstGI[0][2].split("~");

		/*返回代码:000000表示服务调用成功*/
		if(busOMs.length<2)
		{
		%>
			var response = new AJAXPacket();
			response.data.add("retCode","ZY0004");
			response.data.add("retMsg"
				,"平台返回信息错误不能办理!返回信息:"+"<%=busOMs[0]%>");
			core.ajax.receivePacket(response);		
		<%
		}
		else
		{
			busRTC=busOMs[0].split("=")[1];
			/*返回信息:no表示没有关联信息*/
			busRTM=busOMs[1].split("=")[1];
			
			if (busRTC.equals("000000") )
			{
				if (busRTM.equals("no"))
				{
				%>
					var response = new AJAXPacket();
					response.data.add("retCode","000000");
					response.data.add("retMsg","校验成功");
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
	response.data.add("retMsg","服务未启动或存在异常！请联系系统管理员！");
	core.ajax.receivePacket(response);		

<%
}
%>	
