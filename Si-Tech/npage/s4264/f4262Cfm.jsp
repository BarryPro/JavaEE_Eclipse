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
	String opName="������Ժ���Ϣ�޸�";
	
	String paraAray[] = new String[14];
	
	paraAray[0] = request.getParameter("phoneNo");
	paraAray[1] = work_no;
	paraAray[2] = request.getParameter("iOpCode");
	paraAray[3] = request.getParameter("warningMoney");
	paraAray[4] = request.getParameter("limitMoney");
	paraAray[5] = request.getParameter("endTime");
	paraAray[6] = request.getParameter("typeCode");
	paraAray[7] = request.getParameter("useUnit");
	paraAray[8] = request.getParameter("useDepartment");
	paraAray[9] = request.getParameter("useCenter");
	paraAray[10] = request.getParameter("useApplication");
	paraAray[11] = request.getParameter("useLevel");
	paraAray[12] = request.getParameter("custId");
	paraAray[13] = request.getParameter("monitorValue");
%>	
      	<wtc:service name="s4262Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			   <wtc:params value="<%=paraAray%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%

	      if(errCode.equals("0")||errCode.equals("000000")){
          	System.out.println("���÷���s4262Cfm in f4262_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
         %> 
          <script language="JavaScript">
							rdShowMessageDialog("�����ɹ�!");
							window.location="f4262_login.jsp?opCode=<%=op_code%>";
						</script>
         	<%
 	        		        	
 	     	}else{
			 			System.out.println("���÷���s4262Cfm in f4262Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>   
						<script language="JavaScript">
							rdShowMessageDialog("����ʧ��!<%=errMsg%>");
							window.location="f4262_login.jsp?opCode=<%=op_code%>";
						</script>
						<%	
 			}
	%>

