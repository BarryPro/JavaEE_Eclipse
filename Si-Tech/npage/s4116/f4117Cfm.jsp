<%
/********************
 version v2.0
开发商: si-tech
作者: dujl
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%	
	
	String work_no =(String)session.getAttribute("workNo");
	String work_name =(String)session.getAttribute("workName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr =(String)session.getAttribute("ip_Addr");
	String pass = (String)session.getAttribute("password");
	String op_code=request.getParameter("opCode");
	//String printAccept = request.getParameter("printAccept");
	String user_passwd = request.getParameter("user_passwd");
	System.out.println("user_passwduser_passwduser_passwd=="+user_passwd);
	String opName="一卡多号解除";
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);
		
	String paraAray[] = new String[12];
	paraAray[0] = "S41170";
	paraAray[1] = "site";
	paraAray[2] = "0";
	paraAray[3] = "0";
	paraAray[4] = printAccept;
	paraAray[5] = work_no;
	paraAray[6] = pass;
	paraAray[7] = op_code;
	paraAray[8] = request.getParameter("phoneNo1");
	paraAray[9] = request.getParameter("user_passwd");
	paraAray[10] = request.getParameter("phoneNo2");
	paraAray[11] = request.getParameter("user_passwd2");
	for(int i=0;i<12;i++)
	System.out.println("paraAray["+i+"]="+paraAray[i]);
%>	

	<wtc:service name="s4117Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:param value="<%=paraAray[0] %>"/>
		<wtc:param value="<%=paraAray[1] %>"/>
		<wtc:param value="<%=paraAray[2] %>"/>
		<wtc:param value="<%=paraAray[3] %>"/>
		<wtc:param value="<%=paraAray[4] %>"/>
		<wtc:param value="<%=paraAray[5] %>"/>
		<wtc:param value="<%=paraAray[6] %>"/>
		<wtc:param value="<%=paraAray[7] %>"/>
		<wtc:param value="<%=paraAray[8] %>"/>
		<wtc:param value="<%=paraAray[9] %>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
		System.out.println("121212121="+errCode);
		if(errCode.equals("0")||errCode.equals("000000"))
		{
			System.out.println("调用服务s4117Cfm in f4117_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
			<script language="JavaScript">
				rdShowMessageDialog("操作成功!");
				window.location="f4117_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
			</script>
<%
 	        		        	
		}else
		{
			System.out.println("调用服务s4117Cfm in f4117Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
			<script language="JavaScript">
				rdShowMessageDialog("操作失败!<%=errMsg%>");
				window.location="f4117_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
			</script>
<%	
 		}
%>

