<%
/********************
 version v2.0
������: si-tech
����: jianglei
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String work_no =(String)session.getAttribute("workNo");
	String work_name =(String)session.getAttribute("workName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String opCode="d125";
	String opName="MMҵ��APN����";
	String custStatus = request.getParameter("CustStatus");
	String oprCode = "";
	String phoneNo = request.getParameter("phoneNo");
	String bizType = request.getParameter("bizType");
	if(custStatus.equals("0"))
	{
		oprCode = "06";
	}
	else
	{
		oprCode = "07";
	}
	String paraAray[] = new String[9];
	
	paraAray[0] = "";
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[5] = "";
	paraAray[5] = phoneNo;
	paraAray[6] = "";
	paraAray[7] = oprCode;
	paraAray[8] = bizType;
	
%>

	<wtc:service name="sd125Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

		if(errCode.equals("0")||errCode.equals("000000"))
		{
			System.out.println("���÷���sd125Cfm �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
			<script language="JavaScript">
				rdShowMessageDialog("�����ɹ�!");
				window.location="fd125Info.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>&bizType=<%=bizType%>";
			</script>
<%
 	        		        	
		}else
		{
			System.out.println("���÷���sd125Cfm ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
			<script language="JavaScript">
				rdShowMessageDialog("����ʧ��!<%=errCode%>:<%=errMsg%>");
				window.location="fd125Info.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>&bizType=<%=bizType%>";
			</script>
<%	
 		}
%>

