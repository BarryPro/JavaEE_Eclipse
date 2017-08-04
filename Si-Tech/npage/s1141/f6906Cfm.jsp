<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.04
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
			String cust_name=request.getParameter("cust_name");
			String op_code=request.getParameter("op_code");
			String unit_name=request.getParameter("vUnitName");
			String paper_name=request.getParameter("prepay_code");
			String prepay_fee=request.getParameter("paper_money");
			String opName=request.getParameter("op_name");
			String payType = request.getParameter("payType");/** tianyang add for 支票缴费**/
			String paraAray[] = new String[7];
			
			

		paraAray[0] =request.getParameter("login_accept");
		paraAray[1] = request.getParameter("phone_no");
		paraAray[2] = request.getParameter("opcode");
		paraAray[3] = work_no;
		paraAray[4] = request.getParameter("old_accept");
		paraAray[5] = request.getParameter("opNote");
		paraAray[6] = request.getRemoteAddr();
		
  	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
%>
          <wtc:service name="s6906Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			        <wtc:param value="<%=paraAray[0]%>"/>
			        <wtc:param value="<%=paraAray[1]%>"/>
			        <wtc:param value="<%=paraAray[2]%>"/>
			        <wtc:param value="<%=paraAray[3]%>"/>
			        <wtc:param value="<%=paraAray[4]%>"/>
			        <wtc:param value="<%=paraAray[5]%>"/>
			        <wtc:param value="<%=paraAray[6]%>"/>
			</wtc:service>
			<wtc:array id="result1" scope="end" />

<%
    System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String retCodeForCntt = errCode ;
		String loginAccept = paraAray[0]; 
		
		if(errCode.equals("0")||errCode.equals("000000")){
				if(result1.length>0){
				  //loginAccept=result1[0][0];
				}
		}
		
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[2] +"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		
		
		%>
		<jsp:include page="<%=url%>" flush="true" />
		<%
System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	


	      if(errCode.equals("0")||errCode.equals("000000")){
          System.out.println("调用服务s6906Cfm in f6906Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
          
			String chinaFee="";
						   %>
						   <wtc:service name="sToChinaFee" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="errMsg1"  outnum="3" >
				          <wtc:param value="<%=WtcUtil.formatNumber(prepay_fee,2)%>"/>
							</wtc:service>
							<wtc:array id="result" scope="end" />
						
						
						<%
						 if(ret_code1.equals("0")||ret_code1.equals("000000")){
				          System.out.println("调用服务sToChinaFee in f6905Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
				 	       	
				 	       	if(result.length!=0){
				 	       	  chinaFee=result[0][2];
				 	       	  
				 	       	   	
													%>
													<script language="JavaScript">
													   rdShowMessageDialog("提交成功! 下面将打印发票！");
													   var infoStr="";
													   infoStr+="<%=work_no%>  <%=work_name%>"+"       <%=opName%>"+"|";//工号  
													   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=cust_name%>'+"|";
													   infoStr+=" "+"|";
													   infoStr+='<%=paraAray[1]%>'+"|";
													   infoStr+=" "+"|";//协议号码                                                          
													   infoStr+=" "+"|";//协议号码    
													   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
													   infoStr+="<%=WtcUtil.formatNumber(prepay_fee,2)%>"+"|";//小写 
													   infoStr+="集团名称："+"<%=unit_name.trim()%>"+"~";//手机型号 
													   
													   
											/********* tianyang add for 支票缴费 start **************************************/
											var money_pos = "<%=WtcUtil.formatNumber(0,2)%>" ;
											var money_9 = "<%=WtcUtil.formatNumber(0,2)%>" ;
											var money_0 = "<%=WtcUtil.formatNumber(0,2)%>" ;		
											if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
												money_pos = "<%=WtcUtil.formatNumber(prepay_fee,2)%>" ;
											}else if("<%=payType%>"=="9"){
												money_9 = "<%=WtcUtil.formatNumber(prepay_fee,2)%>" ;
											}else{
												money_0 = "<%=WtcUtil.formatNumber(prepay_fee,2)%>" ;
											}
											infoStr+="客户预存款：现金:"+money_0+"　支票:"+money_9+
												"　赠送礼品名称：<%=paper_name%>"+"|";												 
											/********* tianyang add for 支票缴费 end **************************************/
											
													   /*infoStr+="客户预存款：  <%=WtcUtil.formatNumber(prepay_fee,2)%> "+
													    "赠送礼品名称： <%=paper_name%>"+"|";*/
															
													
														 infoStr+="<%=work_name%>"+"|";//开票人
														 infoStr+=" "+"|";//收款人
														 
														 
													  // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
													   var dirtPage="/npage/s1141/f6905_login.jsp?activePhone=<%=paraAray[1]%>%26opCode=6905";
													   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage;
													   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=paraAray[2]%>&loginAccept=<%=loginAccept%>&dirtPage="+dirtPage;
													   
													</script>
											  
													<%	 	       	
				 	       	
				 	       	}
				 	        	
				 	     	}else{
				 			System.out.println("调用服务sToChinaFee in f6906Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
				 			}

		
          
          ///____________________________________________________
          
 	        	
 	        	
 	     	}else{
			 			System.out.println("调用服务s6906Cfm in f6906Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>   
						<script language="JavaScript">
							rdShowMessageDialog("操作失败!<%=errMsg%>");
							window.location="f6905_login.jsp?activePhone=<%=paraAray[1]%>&opCode=<%=op_code%>";
						</script>
						<%
 			
 			
 			}

	
	
	%>
