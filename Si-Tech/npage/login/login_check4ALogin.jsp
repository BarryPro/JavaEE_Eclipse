<%

    /*************************************

    * 功  能: 校验登陆工号 是否需要强制4A登陆

    * 版  本: version v1.0

    * 开发商: si-tech

    * 创建者: diling @ 2011-9-16

    **************************************/

%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.login.ejb.*"%>
<%@ page import="com.sitech.boss.login.wrapper.*"%>
<%@ page import="java.io.UnsupportedEncodingException"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<%!
// 加密  
    public static String getBase64Pub(String str) {  
        byte[] b = null;  
        String s = null;  
        try {  
            b = str.getBytes("utf-8");  
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        }  
        if (b != null) {  
            s = new BASE64Encoder().encode(b);  
        }  
        return s;  
    }  
  
    // 解密  
    public static String getFromBase64Pub(String s) {  
        byte[] b = null;  
        String result = null;  
        if (s != null) {  
            BASE64Decoder decoder = new BASE64Decoder();  
            try {  
                b = decoder.decodeBuffer(s);  
                result = new String(b, "utf-8");  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
        return result;  
    }  

%>
<%
    String staffNo_Check = WtcUtil.htmlEncode((String)request.getParameter("staffNo"));
    String password_Check = WtcUtil.htmlEncode((String)request.getParameter("password"));
    staffNo_Check = getFromBase64Pub(staffNo_Check);
    password_Check = getFromBase64Pub(password_Check);
    System.out.println("--gaopengSeeLogLogin--staffNo_Check==="+staffNo_Check);
    System.out.println("--gaopengSeeLogLogin--password_Check==="+password_Check);
    String uuidCode_Check = WtcUtil.htmlEncode((String)request.getParameter("uuidCode"));//add by gaolw 客户端mac地址
    String versonType_Check = WtcUtil.htmlEncode((String)request.getParameter("versonType")); // 页面框架版本:: normal:普通版;simple:高速版.
    String addressFlag_Check = WtcUtil.htmlEncode((String)request.getParameter("addressFlag")==null? "" : request.getParameter("addressFlag"));
    String token4a_Check = WtcUtil.htmlEncode((String)request.getParameter("token4a")==null? "" : request.getParameter("token4a"));
    String localclientip = WtcUtil.htmlEncode((String)request.getParameter("localclientip"));
	String ipAddr = request.getRemoteAddr();//从请求中获得ip地
%>

<html >
<head>
<title></title>
</head>
<body>
<form name="check4AForm" id="check4AForm" method="POST" >
 	<input type="hidden" name="staffNo" id="staffNo" value="<%=staffNo_Check%>" />
	<input type="hidden" name="password" id="password" value="<%=password_Check%>" />
	<input type="hidden" name="uuidCode" id="uuidCode" value="<%=uuidCode_Check%>" />
	<input type="hidden" name="versonType" id="versonType" value="<%=versonType_Check%>" />
	<input type="hidden" name="addressFlag" id="addressFlag" value="<%=addressFlag_Check%>" />
	<input type="hidden" name="token4a" id="token4a" value="<%=token4a_Check%>" />
 	<input type="hidden" name="localclientip" id="localclientip" value="<%=localclientip%>" />
</form>
</body>
</html>
 
	<wtc:service name="sChkIsWhiteList" retcode="retCode" retmsg="retMsg" outnum="1">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value=" "/> 
		<wtc:param value="<%=staffNo_Check%>"/>
		<wtc:param value="<%=password_Check%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=ipAddr%>"/>
	</wtc:service>
	<wtc:array id="retCheckResult"  scope="end"/>
<%
    if(!retCode.equals("000000")){
%>
    <script language="javascript">
        rdShowMessageDialog("错误代码：<%=retCode%><br>错误信息：<%=retMsg%>",0);
        document.check4AForm.action="/npage/login/login.jsp";
        document.check4AForm.submit();
    </script>
<%
    }else{
         String retCheck4AFlag = retCheckResult[0][0];
         System.out.println("------------login_check4ALogin.jsp----retCheck4AFlag-------"+retCheck4AFlag);
        if("1".equals(retCheck4AFlag)){   //1为跳转到boss系统进行登陆
%>
        <script language="javascript">
    	    document.check4AForm.action="/npage/login/index.jsp";
		    document.check4AForm.submit();
         </script>
<%  
        }else{                     //0为跳转到4A系统进行登陆
%>
        <script language="javascript">
    		document.check4AForm.action="http://10.117.70.123:8084/portal/login.jsp";
		    document.check4AForm.submit();
    	 </script> 
<%  
        }
    }
%>


	    