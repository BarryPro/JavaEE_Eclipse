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
	String opName="ʹ�õ�λ����";
	
	String paraAray[] = new String[9];
				
	paraAray[0] = work_no;
	paraAray[1] = request.getParameter("opType");

	if(paraAray[1].equals("a")){
		paraAray[2] = request.getParameter("typeCode");
		paraAray[3] = request.getParameter("aunitCode");
		paraAray[4] = request.getParameter("unitName");
	
	}else if(paraAray[1].equals("d")){
		paraAray[2] = request.getParameter("stypeCode");
		paraAray[3] = request.getParameter("sunitCode");
		paraAray[4] = request.getParameter("unitName");
	
	}
		
%>	

      	<wtc:service name="s4251Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			   <wtc:params value="<%=paraAray%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
				<%

	      if(errCode.equals("0")||errCode.equals("000000")){
          	System.out.println("���÷���s4251Cfm in f4251_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
         %> 
          <script language="JavaScript">
							rdShowMessageDialog("�����ɹ�!");
							window.location="f4251_1.jsp?opCode=<%=op_code%>";
						</script>
         	<%
 	        		        	
 	     	}else{
			 			System.out.println("���÷���s4251Cfm in f4251Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>   
						<script language="JavaScript">
							rdShowMessageDialog("����ʧ��!<%=errMsg%>");
							window.location="f4251_1.jsp?opCode=<%=op_code%>";
						</script>
						<%	
 			}
	%>

