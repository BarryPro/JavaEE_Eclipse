<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.04
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	
	
			String work_no =(String)session.getAttribute("workNo");
			String work_name =(String)session.getAttribute("workName");
			String orgCode =(String)session.getAttribute("orgCode");
			String regionCode = orgCode.substring(0,2);
			String ip_Addr =(String)session.getAttribute("ip_Addr");
			String pass = (String)session.getAttribute("password");
			String op_code=request.getParameter("opcode");
			
			String paraAray[] = new String[9];
			
			String opName=request.getParameter("op_name");
		paraAray[0] = request.getParameter("sim_no");
		paraAray[1] = request.getParameter("opcode");
		paraAray[2] = work_no;
		paraAray[3] = request.getParameter("phone_no");
		paraAray[4] = request.getParameter("card_no");
		paraAray[5] = request.getParameter("id_no");
		paraAray[6] = request.getParameter("imsi_no");
		paraAray[7] =request.getParameter("login_accept");
		paraAray[8] = request.getParameter("opNote");
		
  
%>
          <wtc:service name="s7047Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			        <wtc:params value="<%=paraAray%>"/>
			</wtc:service>
			<wtc:array id="result1" scope="end" />

<%
    System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String retCodeForCntt = errCode ;
		String loginAccept = paraAray[7]; 
		
		if(errCode.equals("0")||errCode.equals("000000")){
				if(result1.length>0){
				  //loginAccept=result1[0][0];
				}
		}
		
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[1] +"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		
		
		%>
		<jsp:include page="<%=url%>" flush="true" />
		<%
		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	


	      if(errCode.equals("0")||errCode.equals("000000")){
          	System.out.println("调用服务s7047Cfm in f7047Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
          
         %>   
						<script language="JavaScript">
							//alert("sssssssssssssss");
							rdShowMessageDialog("操作成功!");
							window.location="f7047_1.jsp?opCode=<%=op_code%>";
							
						</script>
		<%
 	        	
 	        	
 	     	}else{
			 			System.out.println("调用服务s6905Cfm in f6905Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>   
						<script language="JavaScript">
							rdShowMessageDialog("操作失败!<%=errMsg%>");
							window.location="f7047_1.jsp?opCode=<%=op_code%>";
						</script>
						<%
 			
 			
 			}

	
	
	%>
