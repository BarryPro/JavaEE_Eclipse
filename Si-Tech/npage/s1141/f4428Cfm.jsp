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
	String op_code=request.getParameter("op_code");
	String opName="动感地带高校迎新入网赠话费";
	String phoneNo=request.getParameter("phone_no");
	String paraAray[] = new String[7];
	
	paraAray[0] = work_no;
	paraAray[1] = op_code;
	paraAray[2] = phoneNo;
	paraAray[3] = request.getParameter("login_accept");
	paraAray[4] = orgCode;
	paraAray[5] = request.getParameter("tongzhi_no");
	paraAray[6] = request.getParameter("opNote");
%>

	<wtc:service name="s4428Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:params value="<%=paraAray%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	      if(errCode.equals("0")||errCode.equals("000000")){
          	System.out.println("调用服务s4428Cfm in f4428_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
				<script language="JavaScript">
					rdShowMessageDialog("操作成功!");
					window.location="f4428_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
				</script>
<%
 	        
 	     	}else{
	 			System.out.println("调用服务s4428Cfm in f4428Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>
				<script language="JavaScript">
					rdShowMessageDialog("操作失败!<%=errMsg%>");
					window.location="f4428_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
				</script>
<%
 			}
%>

