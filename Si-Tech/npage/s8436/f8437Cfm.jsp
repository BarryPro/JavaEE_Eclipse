<%
/********************
 version v2.0
������: si-tech
����: dujl
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String work_no =(String)session.getAttribute("workNo");
	String work_name =(String)session.getAttribute("workName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr =(String)session.getAttribute("ip_Addr");
	String pass = (String)session.getAttribute("password");
	String op_code=request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String opName="�����������ȡ��";
	String paraAray[] = new String[7];
	System.out.println("------------op_code------------      "+op_code);
	System.out.println("------------work_no------------      "+work_no);
	System.out.println("------------phoneNo------------      "+phoneNo);
	paraAray[0] = "";
	paraAray[1] = "1";
	paraAray[2] = op_code;
	paraAray[3] = work_no;
	paraAray[4] = "";
	paraAray[5] = phoneNo;
	paraAray[6] = "";
%>

	<wtc:service name="s8437Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%

	if(errCode.equals("0")||errCode.equals("000000"))
	{
		System.out.println("���÷���s8437Cfm in f8437Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
		<script language="JavaScript">
			rdShowMessageDialog("�����ɹ�!");
			window.location="f8437_1.jsp?opCode=8437&opName=�����������ȡ��";
		</script>
<%
 	        		        	
 	}else{
		System.out.println("���÷���s8437Cfm in f8437Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
		<script language="JavaScript">
			rdShowMessageDialog("����ʧ��!<%=errMsg%>");
			window.location="f8437_1.jsp?opCode=8437&opName=�����������ȡ��";
		</script>
<%	
	}
%>

