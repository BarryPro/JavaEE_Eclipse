<%
  /* *********************
   * 功能: 烟草通
   * 版本: 1.0
   * 日期: 2011-8-2 15:10:22
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String phoneNo = request.getParameter("phoneNo");
  String productType = request.getParameter("productType");
  String opNote = request.getParameter("opNote");
  if("e148".equals(opCode)){
  	productType = "";
  }
  System.out.println("##############################productType : " + productType);
%>

		<wtc:service name="s147ExCfm" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=productType%>"/>
				<wtc:param value="<%=opNote%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
		if (retCode1.equals("0")||retCode1.equals("000000")){
%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=opName%>成功! ");
				window.location="fe147.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=opName%>失败：" + "<%=retCode1%>" + "<%=retMsg1%>");
				window.location="fe147.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			</script>
<%
	}
%>