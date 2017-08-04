<%
/********************
 version v1.0
 ������ si-tech
 ningtn 2014-2-19 09:13:46
********************/
%>
<%@ page import="java.io.IOException"%>
<%@ page import="com.sitech.crmpd.inter.commagent.CommagentClient"%>
<%@ page import="com.sitech.crmpd.inter.exception.CommagentException"%>

<%!
	public String callPD(String crmpdIp,String crmpdPort,String appId,String data) {
		/*
		����CRMPDӦ�ü���ƽ̨��������
		crmpdIp��Ӧ�ü���ƽ̨IP��ַ
		crmpdPort��Ӧ�ü���ƽ̨�˿ڵ�ַ
		appId������Ӧ��Ψһ��ʶ
		data�����͵��ַ���
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
			System.out.println("CallCRMPD by ningtn ����Ӧ�� = [" + responseData + "]");
			client.destroy();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (CommagentException e) {
			e.printStackTrace();
		}
		return returnStr;
	}
%>