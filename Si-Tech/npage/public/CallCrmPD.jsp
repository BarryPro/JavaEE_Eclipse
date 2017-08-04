<%
/********************
 version v1.0
 开发商 si-tech
 ningtn 2014-2-19 09:13:46
********************/
%>
<%@ page import="java.io.IOException"%>
<%@ page import="com.sitech.crmpd.inter.commagent.CommagentClient"%>
<%@ page import="com.sitech.crmpd.inter.exception.CommagentException"%>

<%!
	public String callPD(String crmpdIp,String crmpdPort,String appId,String data) {
		/*
		调用CRMPD应用集成平台公共方法
		crmpdIp：应用集成平台IP地址
		crmpdPort：应用集成平台端口地址
		appId：调用应用唯一标识
		data：发送的字符串
		*/
		String returnStr = "";
	
		CommagentClient client;
		System.out.println("======== CallCRMPD by ningtn ==data=[" + data+"]");
		try {
			client = CommagentClient.getInstance(crmpdIp, crmpdPort);
			String responseData = null;
			Object[] response = client
					.call(appId, "1", data, 120);
			if (response[0] != null) {
				responseData = new String((byte[]) response[0]);
			}
			returnStr = responseData;
			System.out.println("CallCRMPD by ningtn 接收应答 = [" + responseData + "]");
			client.destroy();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (CommagentException e) {
			e.printStackTrace();
		}
		return returnStr;
	}
%>