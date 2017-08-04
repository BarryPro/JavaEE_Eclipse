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
	String IpAddr=request.getParameter("IpAddr");
	String IDItemRange=request.getParameter("IDItemRange");
	String opType=request.getParameter("opType");
	String paraAray[] = new String[6];
	
	paraAray[0] = work_no;
	paraAray[1] = pass;
	paraAray[2] = orgCode;
	paraAray[3] = IpAddr;
	paraAray[4] = IDItemRange;
	paraAray[5] = opType;
	
%>

	<wtc:service name="s9391Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
		if(errCode.equals("0")||errCode.equals("000000"))
		{
%>
			<script language="JavaScript">
				rdShowMessageDialog("操作成功!");
				window.location="f9391.jsp";
			</script>
<%
 	        		        	
		}else
		{
			System.out.println("调用服务s9391Cfm in f9391Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
			<script language="JavaScript">
				rdShowMessageDialog("操作失败!<%=errMsg%>");
				window.location="f9391.jsp";
			</script>
<%	
 		}
%>

