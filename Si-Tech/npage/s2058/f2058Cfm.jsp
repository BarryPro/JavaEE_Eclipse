<%
/********************
version v2.0
开发商: si-tech
作者: dujl
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	
	String work_no =(String)session.getAttribute("workNo");
	String work_name =(String)session.getAttribute("workName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String op_code="2058";
	String phone_no=request.getParameter("phone_no");
	String rateCode=request.getParameter("rateCode");
	String printAccept=request.getParameter("printAccept");
	String opName="随e行上网本/手机叠加包受理";
	
	String paraAray[] = new String[4];
				
	paraAray[0] = phone_no;
	paraAray[1] = rateCode;
	paraAray[2] = printAccept;
	paraAray[3] = work_no;
		System.out.println("phone_no================= "+paraAray[0]);
		System.out.println("rateCode================= "+paraAray[1]);
		System.out.println("printAccept================= "+paraAray[2]);
		System.out.println("work_no================= "+paraAray[3]);
%>	

	<wtc:service name="s2058Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="4" >
		<wtc:param value="<%=paraAray[0] %>"/>
		<wtc:param value="<%=paraAray[1] %>"/>
		<wtc:param value="<%=paraAray[2] %>"/>
		<wtc:param value="<%=paraAray[3] %>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	if(errCode.equals("0")||errCode.equals("000000"))
	{
		System.out.println("调用服务s2058Cfm in f2058_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
		<script language="JavaScript">
			rdShowMessageDialog("操作成功!");
			window.location="f2058_1.jsp?opCode=<%=op_code%>&activePhone=<%=phone_no%>";
		</script>
<%
		        	
	}else{
		System.out.println("调用服务s2058Cfm in f2058Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
		<script language="JavaScript">
			rdShowMessageDialog("操作失败!<%=errMsg%>");
			window.location="f2058_1.jsp?opCode=<%=op_code%>&activePhone=<%=phone_no%>";
		</script>
<%	
	}
%>

