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
	paraAray[7] = request.getParameter("packCode");
	
%>

	<wtc:service name="s9387Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
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
			System.out.println("���÷���s9387Cfm in f9387Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");

			/*zhangyan add b*/
			String statisLoginAccept =  request.getParameter("printAccept"); /*��ˮ*/
			String statisOpCode=opCode;
			String statisPhoneNo=phoneNo;	
			String statisIdNo="";	
			String statisCustId="";
	
			String statisUrl = "/npage/public/pubCustSatisIn.jsp"
				+"?statisLoginAccept="+statisLoginAccept
				+"&statisOpCode="+statisOpCode
				+"&statisPhoneNo="+statisPhoneNo
				+"&statisIdNo="+statisIdNo	
				+"&statisCustId="+statisCustId;	
	    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
	    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
	    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
	    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
	    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
	    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
			%>
			<jsp:include page="<%=statisUrl%>" flush="true" />
	
			<%
			/*zhangyan add e*/
%>
			<script language="JavaScript">
				rdShowMessageDialog("�����ɹ�!");
				window.location="f9387_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			</script>
<%
 	        		        	
		}else
		{
			System.out.println("���÷���s9387Cfm in f9387Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
			<script language="JavaScript">
				rdShowMessageDialog("����ʧ��!<%=errMsg%>");
				window.location="f9387_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			</script>
<%	
 		}
%>

