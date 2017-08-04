<%
/********************
 version v2.0
开发商: si-tech
作者: dujl
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String work_no =(String)session.getAttribute("workNo");
	String work_name =(String)session.getAttribute("workName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String pass = (String)session.getAttribute("password");
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String phoneNo=request.getParameter("phoneNo");
	String paraAray[] = new String[8];
	
	paraAray[0] = request.getParameter("printAccept");
	paraAray[1] = "9";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[4] = pass;
	paraAray[5] = phoneNo;
	paraAray[6] = "";
	paraAray[7] = request.getParameter("oldPackCode");
	
%>

	<wtc:service name="s9389Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

		if(errCode.equals("0")||errCode.equals("000000"))
		{
			System.out.println("调用服务s9389Cfm in f9389Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
			<script language="JavaScript">
				rdShowMessageDialog("操作成功!");
				window.location="f9387_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			</script>
<%
		}else
		{
			System.out.println("调用服务s9389Cfm in f9389Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>
			<script language="JavaScript">
				rdShowMessageDialog("操作失败!<%=errMsg%>");
				window.location="f9387_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			</script>
<%
		}
%>

