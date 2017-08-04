<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String work_no = (String)session.getAttribute("workNo");
	  String regionCode= (String)session.getAttribute("regCode");
	  String opCode =  request.getParameter("opCode");
	  String opName =  request.getParameter("opName");
	  String parentPhone = request.getParameter("parentPhone");
	  String famChg =  request.getParameter("myJson");

%>
	<wtc:utype name="sE280Cfm" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
		<wtc:uparam value="<%=famChg%>" type="STRING"/>  
	</wtc:utype>
<%
	String retCode = retVal.getValue(0);
	String retMsg = retVal.getValue(1);
	retMsg = retMsg.replaceAll(System.getProperty("line.separator")," ");
	System.out.println("---------liujian--------fe280VaryCfm.jsp----");
	if("0".equals(retCode) || "000000".equals(retCode)){

%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=opName%>提交成功！");
			location="/npage/se280/fe280.jsp?activePhone=<%=parentPhone%>";
		</script>
<%
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=opName%>提交失败！" + "<%=retCode%>," + "<%=retMsg%>");
			location="/npage/se280/fe280.jsp?activePhone=<%=parentPhone%>";
		</script>

<%
	}
%>
