<%
/********************
 version v1.0
 ¿ª·¢ÉÌ si-tech
 gaopeng 2015/7/24 10:33:33
********************/
%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>

<%!
public static boolean checkParamStr(String str) {
		String t1 = "\\\\";
		String t2 = "\\+";
	    String[] regEx = { "<", ">", "'", "\"", ";", "<javascript", "<script", "%20", "%22", "%27", "%3C", "%3E", "%0D%0A", "%5C", "%2D", "<iframe", 
	    	      "</iframe", 
	    	      "<frame", 
	    	      "</frame", 
	    	      "set-cookie", 
	    	      "%3cscript", 
	    	      "%3c/script", 
	    	      "%3ciframe", 
	    	      "%3c/iframe", 
	    	      "%3cframe", 
	    	      "%3c/frame", 
	    	      "src=\"javascript:", 
	    	      "<body", 
	    	      "</body", 
	    	      "%3cbody", 
	    	      "%3c/body", 
	    	      "alert",
	    	      t1, t2 };
		String urlde = str;
		try {
			urlde = URLDecoder.decode(str, "UTF-8");
		} catch (Exception e) {
			System.out.println("URLDecoderException:" + urlde);
		}
		for (int i = 0; i < regEx.length; i++) {
			String regExStr = regEx[i];
			Pattern pattern = Pattern.compile(regExStr, 2);
			Matcher matcher = pattern.matcher(urlde);
			if (matcher.find())
				return true;
		}

		return false;
	}


%>
