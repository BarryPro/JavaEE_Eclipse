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
		String op_code=request.getParameter("opCode");
		String opName="������˻��ֽ��ֵ";
		String paraAray[] = new String[6];
		
		paraAray[0] = work_no;
		paraAray[1] = op_code;
		paraAray[2] = request.getParameter("phoneNo");
		paraAray[3] = request.getParameter("homeProvCode");
		paraAray[4] = request.getParameter("payMoney");
		paraAray[5] = request.getParameter("loginAccept");
		
%>

	<wtc:service name="s9452Cfm" routerKey="phone" routerValue="<%=paraAray[2]%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:params value="<%=paraAray%>"/>
		</wtc:service>
	<wtc:array id="result" scope="end" />
<%

			if(errCode.equals("0")||errCode.equals("000000"))
			{
				System.out.println("���÷���s9452Cfm in f9452_login.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
          		<script language="JavaScript">
					rdShowMessageDialog("�����ɹ�!");
					window.location="f9452_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
				</script>
<%
 	        		        	
 	     	}else{
	 			System.out.println("���÷���s9452Cfm in f9452_login.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("����ʧ��!<%=errMsg%>");
					window.location="f9452_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
				</script>
<%	
 			}
%>

