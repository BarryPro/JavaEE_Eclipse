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
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String opCode=request.getParameter("opCode");
	String phoneNo=request.getParameter("phone_no");
	String backaccept=request.getParameter("backaccept");		//ԭ��ˮ
	String login_accept=request.getParameter("login_accept");	//������ˮ
	String saleType=request.getParameter("sale_type");
	String saleCode=request.getParameter("sale_code");
	String opName="sp��ֵҵ���ײͳ���";
	String prepayPay=request.getParameter("prepay_pay");
	String cust_name=request.getParameter("cust_name");
	String chinaFee = "";
	
	String paraAray[] = new String[9];
				
	paraAray[0] = work_no;
	paraAray[1] = opCode;
	paraAray[2] = phoneNo;
	paraAray[3] = backaccept;
	paraAray[4] = login_accept;
	paraAray[5] = saleType;
	paraAray[6] = saleCode;
	paraAray[7] = regionCode;
	paraAray[8] = ip_Addr;
		
%>

	<wtc:service name="s9897Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	if(errCode.equals("0")||errCode.equals("000000"))
	{
		System.out.println("���÷���s9897Cfm in f9897_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(prepayPay,2)%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	    if(result.length>0 && sToChinaFeeCode.equals("0")){
	        chinaFee = result[0][2];
	    }
    
		System.out.print(chinaFee);
%>
<%
		String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+login_accept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
		System.out.println("url===="+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
		
		<script language="JavaScript">
			rdShowMessageDialog("ȷ�ϳɹ�! ���潫��ӡ��Ʊ��",2);
			var infoStr="";
			infoStr+="<%=work_no%>  <%=work_name%>"+"       sp��ֵҵ���ײͳ���"+"|";//����  
			infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=cust_name%>'+"|";
			infoStr+=" "+"|";
			infoStr+='<%=phoneNo%>'+"|";
			infoStr+=" "+"|";//Э�����                                                          
			infoStr+=" "+"|";
			infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
			infoStr+="<%=WtcUtil.formatNumber(prepayPay,2)%>"+"|";//Сд 
			infoStr+="��Ԥ��  <%=prepayPay%>Ԫ"+"|";
			
			infoStr+="<%=work_name%>"+"|";//��Ʊ��
			infoStr+=" "+"|";//�տ���
			dirtPate = "/npage/s1141/f9896_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
			
//			rdShowMessageDialog("�����ɹ�!");
//			window.location="f9896_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
 	        		        	
	}else
	{
		System.out.println("���÷���s9897Cfm in f9897Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
		<script language="JavaScript">
			rdShowMessageDialog("����ʧ��!<%=errMsg%>");
			window.location="f9896_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%	
	}
%>

