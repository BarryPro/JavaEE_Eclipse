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
		String op_code=request.getParameter("opcode");
		String opName="手机支付主账户现金充值";
		
		String paraAray[] = new String[6];
					
		paraAray[0] = work_no;
		paraAray[1] = op_code;
		paraAray[2] = request.getParameter("phoneNo");
		paraAray[3] = request.getParameter("payEd");
		paraAray[4] = pass;
		paraAray[5] = orgCode;
		
%>

	<wtc:service name="s9994Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:params value="<%=paraAray%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	      if(errCode.equals("0")||errCode.equals("000000")){
          	System.out.println("调用服务s9994Cfm in f9994_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
          <script language="JavaScript">
							rdShowMessageDialog("操作成功!");
							window.location="f9994_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
						</script>
<%
 	        		        	
 	     	}else{
			 			System.out.println("调用服务s9994Cfm in f9994Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
						<script language="JavaScript">
							rdShowMessageDialog("操作失败!<%=errMsg%>");
							window.location="f9994_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
						</script>
<%	
 			}
%>

