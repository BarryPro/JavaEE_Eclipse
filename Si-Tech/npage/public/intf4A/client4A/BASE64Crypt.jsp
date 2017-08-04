<%
/********************
 version v1.0
 ¿ª·¢ÉÌ si-tech
 ningtn 2012-3-15 11:26:01
********************/
%>
<%@ page import="java.io.IOException"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="sun.misc.BASE64Encoder"%>

<%!
	public String decode(String str) {
		BASE64Decoder base64De = new BASE64Decoder();
		String returnStr = "";
		byte[] bytePri = null;
		try{
			bytePri = base64De.decodeBuffer(str);
			returnStr = new String(bytePri,"UTF-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return returnStr;
	}
	public String encode(String str){
		BASE64Encoder base64en = new BASE64Encoder();
		String returnStr = "";
		byte[] bytePri = null;
		try{
			bytePri = str.getBytes("UTF-8");
			returnStr = base64en.encodeBuffer(bytePri);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return returnStr;
	}
%>