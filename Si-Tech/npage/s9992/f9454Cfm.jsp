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
		String opName="营业厅重置支付密码";
		String paraAray[] = new String[6];
		
		paraAray[0] = work_no;
		paraAray[1] = op_code;
		paraAray[2] = request.getParameter("phoneNo");
		paraAray[3] = request.getParameter("loginAccept");
		
%>

	<wtc:service name="s9454Cfm" routerKey="phone" routerValue="<%=paraAray[2]%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:params value="<%=paraAray%>"/>
		</wtc:service>
	<wtc:array id="result" scope="end" />
<%

	if(errCode.equals("0")||errCode.equals("000000"))
	{
		System.out.println("调用服务s9454Cfm in f9454_login.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");

		String statisLoginAccept = request.getParameter("loginAccept"); /*流水*/
		String statisOpCode=op_code;
		String statisPhoneNo= request.getParameter("phoneNo");	
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

          		<script language="JavaScript">
					rdShowMessageDialog("操作成功!");
					window.location="f9454_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
				</script>
<%
 	        		        	
 	     	}else{
	 			System.out.println("调用服务s9454Cfm in f9454_login.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("操作失败!<%=errMsg%>");
					window.location="f9454_login.jsp?opCode=<%=op_code%>&opName=<%=opName%>";
				</script>
<%	
 			}
%>

