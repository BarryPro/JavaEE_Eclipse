<%
/********************
 version v1.0
 开发商 si-tech
 ningtn 2012-3-15 09:30:18
********************/
%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.xml.namespace.QName"%>
<%@ page import="javax.xml.rpc.ServiceException"%>
<%@ page import="org.apache.axis.client.Call"%>
<%@ page import="org.apache.axis.client.Service"%>
<%!
	public String getTreasuryStatus(String url, String method,
			String localPart, String xml) {
		Call call = null;
		String ResXML = "";
		try {
			if (call == null) {
				Service serv = new Service();
				try {
					call = (Call) serv.createCall();
				} catch (ServiceException e) {
					System.out.println("Create Call error...");
					e.printStackTrace();
				}
				call.setTargetEndpointAddress(url);
				/*call.setReturnType(org.apache.axis.encoding.XMLType.XSD_INT);*/
				call.addParameter("reqMsg",
						org.apache.axis.encoding.XMLType.XSD_STRING,
						javax.xml.rpc.ParameterMode.IN);
				call.setOperationName(new QName(url, localPart));
			}
			System.out.println("connect4A   xml:[" + xml + "]");
			ResXML = (String) call.invoke(method, new Object[] { xml });
			System.out.println("connect4A   ResXML:[" + ResXML + "]");
		} catch (Exception e) {
			System.out.println("Call webservice error...");
			System.err.println(e.getMessage());
		}
		return ResXML;
	}
	
	public String getRandomNum(String NumType,int NumLength){
		/**
			NumType 随机数类型  allChar:字母数字组合  letterChar:纯字母   numberChar:纯数字
			NumLength 随机串长度
		**/
		String allChar = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String letterChar = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String numberChar = "0123456789";
		String charStr = "";
		if("allChar".equals(NumType)){
			charStr = allChar;
		}else if("letterChar".equals(NumType)){
			charStr = letterChar;
		}else if("numberChar".equals(NumType)){
			charStr = numberChar;
		}
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < NumLength; i++) {
			sb.append(charStr.charAt(random.nextInt(charStr.length())));
		}
		return sb.toString();
	}
%>