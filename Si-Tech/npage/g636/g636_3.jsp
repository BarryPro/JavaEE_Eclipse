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
 
 	String org_code = (String)session.getAttribute("orgCode");
    String opCode = "e900";
	String opName = "铁通发票信息";
	String return_code="";
	String ret_msg="";

	String region_code = request.getParameter("region_code").trim();
	String ilevel = request.getParameter("ilevel").trim();
	String begin_ymdh = request.getParameter("begin_ymdh").trim();
	String end_ymdh = request.getParameter("end_ymdh").trim();

	String workno = (String)session.getAttribute("workNo");

	String return_page = "g636_1.jsp";
  

	String [] inParas = new String[4];
	inParas[0]  = region_code;
	inParas[1]  = ilevel;
	inParas[2]  = begin_ymdh;
	inParas[3]  = end_ymdh;

%>
	<wtc:service name="bs_g6362Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
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
	  rdShowMessageDialog("节假日信息删除成功！");
	  window.location.href="<%=return_page%>";
 </script>


<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("节假日信息删除失败!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%}
%>
</body></html>