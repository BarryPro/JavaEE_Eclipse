<%
/********************
 version v2.0
������: si-tech
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
			String payType = request.getParameter("payType");/** tianyang add for ֧Ʊ�ɷ�**/
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
    System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
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
System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%"); 	


	      if(errCode.equals("0")||errCode.equals("000000")){
          System.out.println("���÷���s6906Cfm in f6906Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
          
			String chinaFee="";
						   %>
						   <wtc:service name="sToChinaFee" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="errMsg1"  outnum="3" >
				          <wtc:param value="<%=WtcUtil.formatNumber(prepay_fee,2)%>"/>
							</wtc:service>
							<wtc:array id="result" scope="end" />
						
						
						<%
						 if(ret_code1.equals("0")||ret_code1.equals("000000")){
				          System.out.println("���÷���sToChinaFee in f6905Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
				 	       	
				 	       	if(result.length!=0){
				 	       	  chinaFee=result[0][2];
				 	       	  
				 	       	   	
													%>
													<script language="JavaScript">
													   rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��");
													   var infoStr="";
													   infoStr+="<%=work_no%>  <%=work_name%>"+"       <%=opName%>"+"|";//����  
													   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=cust_name%>'+"|";
													   infoStr+=" "+"|";
													   infoStr+='<%=paraAray[1]%>'+"|";
													   infoStr+=" "+"|";//Э�����                                                          
													   infoStr+=" "+"|";//Э�����    
													   infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
													   infoStr+="<%=WtcUtil.formatNumber(prepay_fee,2)%>"+"|";//Сд 
													   infoStr+="�������ƣ�"+"<%=unit_name.trim()%>"+"~";//�ֻ��ͺ� 
													   
													   
											/********* tianyang add for ֧Ʊ�ɷ� start **************************************/
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
											infoStr+="�ͻ�Ԥ���ֽ�:"+money_0+"��֧Ʊ:"+money_9+
												"��������Ʒ���ƣ�<%=paper_name%>"+"|";												 
											/********* tianyang add for ֧Ʊ�ɷ� end **************************************/
											
													   /*infoStr+="�ͻ�Ԥ��  <%=WtcUtil.formatNumber(prepay_fee,2)%> "+
													    "������Ʒ���ƣ� <%=paper_name%>"+"|";*/
															
													
														 infoStr+="<%=work_name%>"+"|";//��Ʊ��
														 infoStr+=" "+"|";//�տ���
														 
														 
													  // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
													   var dirtPage="/npage/s1141/f6905_login.jsp?activePhone=<%=paraAray[1]%>%26opCode=6905";
													   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage;
													   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=paraAray[2]%>&loginAccept=<%=loginAccept%>&dirtPage="+dirtPage;
													   
													</script>
											  
													<%	 	       	
				 	       	
				 	       	}
				 	        	
				 	     	}else{
				 			System.out.println("���÷���sToChinaFee in f6906Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
				 			}

		
          
          ///____________________________________________________
          
 	        	
 	        	
 	     	}else{
			 			System.out.println("���÷���s6906Cfm in f6906Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>   
						<script language="JavaScript">
							rdShowMessageDialog("����ʧ��!<%=errMsg%>");
							window.location="f6905_login.jsp?activePhone=<%=paraAray[1]%>&opCode=<%=op_code%>";
						</script>
						<%
 			
 			
 			}

	
	
	%>
