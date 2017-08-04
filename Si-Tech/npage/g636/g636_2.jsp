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
 
    String opCode = "g636";
	String opName = "节假日配置";
	String return_code="";
	String ret_msg="";

	String region_code = request.getParameter("region_code");
	String level = request.getParameter("level");
	String begin_year = request.getParameter("begin_year");
	String begin_month = request.getParameter("begin_month");
	String begin_day = request.getParameter("begin_day");
	String begin_hour = request.getParameter("begin_hour");
	String end_year = request.getParameter("end_year");
	String end_month = request.getParameter("end_month");
	String end_day = request.getParameter("end_day");
	String end_hour = request.getParameter("end_hour");
	String holiday_name = request.getParameter("holiday_name");
	String op_note = request.getParameter("op_note");
	String return_page = "g636_1.jsp";
	String org_code = (String)session.getAttribute("orgCode");
 	String regionCode = org_code.substring(0,2);
 	String work_no = (String)session.getAttribute("workNo");
  

	String [] inParas = new String[7];
	inParas[0]  = region_code;
	inParas[1]  = level;
	inParas[2]  = begin_year+begin_month+begin_day+begin_hour;
	inParas[3]  = end_year+end_month+end_day+end_hour;
	inParas[4]  = work_no;
	inParas[5]  = holiday_name;	
	inParas[6]  = op_note;
%>
	<wtc:service name="bs_g6361Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<body >
  <%	
	if (return_code.equals("000000"))
	{	
%>	
 <script language="javascript">
	  rdShowMessageDialog("节假日配置成功！");
	  window.location.href="<%=return_page%>";
 </script>


<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("节假日配置失败!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%}
%>
</body></html>