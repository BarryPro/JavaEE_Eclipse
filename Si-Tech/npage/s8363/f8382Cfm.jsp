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
	String op_code=request.getParameter("opcode");
	String opName="Ӫҵ����������Ϣ������";
	
	String paraAray[] = new String[5];
	
	paraAray[0] = work_no;
	paraAray[1] = request.getParameter("opCode");
	paraAray[2] = request.getParameter("macAddr");
	paraAray[3] = request.getParameter("groupId");
	paraAray[4] = request.getParameter("iLoginAccept");
	
%>	

	<wtc:service name="s8382Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:params value="<%=paraAray%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	if(errCode.equals("0")||errCode.equals("000000")){
	System.out.println("���÷���s8382Cfm in 8382_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("�����ɹ�!");
		window.location="f8382_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
	</script>
<%
 	
 	}else{
		System.out.println("���÷���s8382Cfm in f8382Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>
		<script language="JavaScript">
			rdShowMessageDialog("����ʧ��!<%=errMsg%>");
			window.location="f8382_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
		</script>
<%
	}
%>

