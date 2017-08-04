<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.lang.Integer"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
 
<%
	  //Çå³ý»º´æ
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String regionCode =((String)session.getAttribute("orgCode")).substring(0,2);
  String offerId = WtcUtil.repNull(request.getParameter("offerId"));
 System.out.println("=========================="); 
  System.out.println("offerId="+offerId); 
 System.out.println("==========================");  
  String timeChangeFlag = "";
  String errCode = "";
  String errMsg = "";
%>
 
<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
   <wtc:param value="77"/>
   <wtc:param value="<%=offerId%>"/>
   </wtc:service>
<wtc:array id="rows" scope="end"/>
<%
if("000000".equals(retCode)){
	if(rows.length>0){
		errCode = retCode;
		errMsg = retMsg;
		timeChangeFlag=rows[0][0];
System.out.println("=========timeChangeFlag======="+timeChangeFlag);		
	}else{
		errCode = retCode;
		errMsg = retMsg;
	}
}
out.println(errCode+ "@" + errMsg + "@" + timeChangeFlag);
%>
