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
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String op_code=request.getParameter("opCode");
		String opName=request.getParameter("opName");
		String loginAccept=request.getParameter("printAccept");
		String phoneNo=request.getParameter("phoneNo");
		
		String paraAray[] = new String[4];
					
		paraAray[0] = work_no;
		paraAray[1] = phoneNo;
		paraAray[2] = "07";
		paraAray[3] = loginAccept;
		
%>

	<wtc:service name="s7509Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:params value="<%=paraAray%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	      if(errCode.equals("0")||errCode.equals("000000"))
	      {
          		System.out.println("调用服务s7509Cfm in f7509_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
				<script language="JavaScript">
					rdShowMessageDialog("操作成功!");
					window.location="f7509_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
				</script>
<%
 	     
 	     }else{
	 			System.out.println("调用服务s7509Cfm in f7509Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("操作失败!<%=errMsg%>");
					window.location="f7509_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
				</script>
<%	
 			}
%>

