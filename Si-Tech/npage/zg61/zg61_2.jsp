<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String groupId = (String)session.getAttribute("groupId");
	String workno = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	//regionCode="12";
	String workname = (String)session.getAttribute("workName");
	String opCode = "zg61";
    String opName = "月结发票作废";
	//document.frm.action="zg61_2.jsp?invoice_number="+invoice_number+"&invoice_code="+invoice_code+"&phone_no="+phone_no+"&year_month="+year_month+"&zfyy="+zfyy+"&radios="+radios;
	String invoice_number=request.getParameter("invoice_number"); 
	String invoice_code=request.getParameter("invoice_code"); 
	String phone_no=request.getParameter("phone_no"); 
	String year_month=request.getParameter("year_month"); 
	String zfyy=request.getParameter("zfyy"); 
	String radios=request.getParameter("radios");  
	 
 
%>
 

		<wtc:service name="bs_zg20Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="2">
			<wtc:param value="<%=invoice_number%>"/>
			<wtc:param value="<%=invoice_code%>"/>	
			<wtc:param value=""/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=zfyy%>"/>
			<wtc:param value="2"/>
			<wtc:param value="<%=radios%>"/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=year_month%>"/>
		</wtc:service>
		<wtc:array id="ret_1" scope="end" />  
		<%
			//retCode11="000000";
			if(retCode11=="000000" || retCode11.equals("000000"))
			{
				%>
					<script language="javascript">
						rdShowMessageDialog("月结发票作废成功");
						window.location.href="zg61_1.jsp";
					</script> 
				<%
			}
			else
			{
				%>
					<script language="javascript">
						rdShowMessageDialog("月结发票作废失败,错误原因:"+"<%=retCode11%>"+",错误原因:"+"<%=retMsg11%>");
						window.location.href="zg61_1.jsp";
					</script>
				<%
			}

%>

