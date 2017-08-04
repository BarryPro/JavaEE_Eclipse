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
		String ip_Addr =(String)session.getAttribute("ip_Addr");
		String pass = (String)session.getAttribute("password");
		String op_code=request.getParameter("opCode");
		String opName="手机支付主账户开户";
		String idName = request.getParameter("idName");
		String paraAray[] = new String[15];
					
		paraAray[0] = work_no;
		paraAray[1] = op_code;
		paraAray[2] = request.getParameter("phoneNo");
		paraAray[3] = request.getParameter("custId");
		paraAray[4] = request.getParameter("custName");
		paraAray[5] = request.getParameter("custAdress");
		paraAray[6] = request.getParameter("runName");
		paraAray[7] = request.getParameter("smName");
		paraAray[8] = request.getParameter("idIccid");
		if(idName.equals("身份证"))
		{
			paraAray[9] = "00";
		}else if (idName.equals("VIP卡"))
		{
			paraAray[9] = "01";
		}else if (idName.equals("护照"))
		{
			paraAray[9] = "02";
		}else if (idName.equals("军官证"))
		{
			paraAray[9] = "04";
		}else if (idName.equals("武装警察身份证"))
		{
			paraAray[9] = "05";
		}else
		{
			paraAray[9] = "99";
		}
		paraAray[10] = request.getParameter("totalOwe");
		paraAray[11] = request.getParameter("prepay");
		paraAray[12] = pass;
		paraAray[13] = orgCode;
		paraAray[14] = request.getParameter("printAccept");
		
%>

	<wtc:service name="s9992Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:params value="<%=paraAray%>"/>
		</wtc:service>
	<wtc:array id="result1" scope="end" />
				<%

	      if(errCode.equals("0")||errCode.equals("000000")){
          	System.out.println("调用服务s9992Cfm in f9992_login.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
         %> 
          <script language="JavaScript">
							rdShowMessageDialog("操作成功!");
							window.location="f9992_login.jsp?opCode=<%=op_code%>&activePhone=<%=paraAray[2]%>";
						</script>
         	<%
 	        		        	
 	     	}else{
			 			System.out.println("调用服务s9992Cfm in f9992_1.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>   
						<script language="JavaScript">
							rdShowMessageDialog("操作失败!<%=errMsg%>");
							window.location="f9992_login.jsp?opCode=<%=op_code%>&activePhone=<%=paraAray[2]%>";
						</script>
						<%	
 			}
	%>

