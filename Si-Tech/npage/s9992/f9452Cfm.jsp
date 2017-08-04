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
		String op_code=request.getParameter("opCode");
		String opName="异地主账户现金充值";
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
				System.out.println("调用服务s9452Cfm in f9452_login.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
          		<script language="JavaScript">
					rdShowMessageDialog("操作成功!");
					window.location="f9452_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
				</script>
<%
 	        		        	
 	     	}else{
	 			System.out.println("调用服务s9452Cfm in f9452_login.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("操作失败!<%=errMsg%>");
					window.location="f9452_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
				</script>
<%	
 			}
%>

