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
		String opName="�ֻ�֧�����˻���ֵ����";
		
		String phoneNoPayEd = request.getParameter("phoneNoPayEd");
		String[] str1 = phoneNoPayEd.split("~");
		String phoneNo = str1[0];
		String payEd = str1[1];
		String loginAccept = str1[2];
		
		String paraAray[] = new String[7];
					
		paraAray[0] = work_no;
		paraAray[1] = op_code;
		paraAray[2] = phoneNo;
		paraAray[3] = payEd;
		paraAray[4] = loginAccept;
		paraAray[5] = pass;
		paraAray[6] = orgCode;
		
%>

	<wtc:service name="s9995Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:params value="<%=paraAray%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	      if(errCode.equals("0")||errCode.equals("000000")){
          	System.out.println("���÷���s9995Cfm in f9994_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
          <script language="JavaScript">
							rdShowMessageDialog("�����ɹ�!");
							window.location="f9994_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
						</script>
<%
 	        		        	
 	     	}else{
			 			System.out.println("���÷���s9995Cfm in f9995Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
						<script language="JavaScript">
							rdShowMessageDialog("����ʧ��!<%=errMsg%>");
							window.location="f9994_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
						</script>
<%	
 			}
%>

