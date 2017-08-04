<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%

String from = request.getParameter("from").trim();
String to = request.getParameter("to").trim();
String zbr = request.getParameter("zbr").trim();
String shr = request.getParameter("shr").trim();
//String jsr = request.getParameter("jsr").trim();
String date = request.getParameter("date").trim();
 
    	String s_in_ModeTypeCode = request.getParameter("s_in_ModeTypeCode");
		String s_in_CaseTypeCode = request.getParameter("s_in_CaseTypeCode");
//		String year = request.getParameter("year");
//		String jd = request.getParameter("jd");
		if(s_in_CaseTypeCode == null) s_in_CaseTypeCode = "";
		String workno = (String)session.getAttribute("workNo");
	  String return_page = "e673_4.jsp";
	  String return_code="";
	  String ret_msg="";
	  String return_code1="";
	  String ret_msg1="";
	  String [] inParas = new String[5];
	  inParas[0]  = from;
	  inParas[1]  = to;
	  inParas[2]  = s_in_ModeTypeCode;
	  inParas[3]  = s_in_CaseTypeCode;
	  if(s_in_CaseTypeCode.length()==4)
	  {
	     inParas[3]  = s_in_CaseTypeCode.substring(2);
	  }
	  inParas[4]  = workno;

System.out.println("s_in_ModeTypeCode:"+inParas[3]);
%>
	<wtc:service name="bs_6734Cfm" routerKey="region" routerValue="<%=inParas[3]%>" outnum="13" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   
    String[] inParas2 = new String[2];
	inParas2[0]="select taxpay_code,taxpay_name from DBCUSTADM.SINVOICECODE where region_code=:region_code1 and dis_code='01'";
	inParas2[1]="region_code1="+inParas[3];
	
%>

	<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
<%
    return_code1 = retCode1;
    ret_msg1 = retMsg1;
%>		
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<body >	
	
<%	
	if (return_code.equals("000000") && return_code1.equals("000000") && ret_val.length>0)
	{	
	    request.setAttribute("taxpay_code",ret_val[0][0]);
		request.setAttribute("taxpay_name",ret_val[0][1]);
		request.setAttribute("result",tempArr);
		request.setAttribute("year",from);
		request.setAttribute("jd",to);
		request.setAttribute("zbr",zbr);
		request.setAttribute("shr",shr);
//		request.setAttribute("jsr",jsr);
		request.setAttribute("date",date);
	    request.getRequestDispatcher("e673_4Txt.jsp").forward(request, response);
	}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("导出txt文件失败!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%	}
%>
</body></html>
