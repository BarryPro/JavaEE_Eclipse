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
	String opName=request.getParameter("opName");
	String phoneNo=request.getParameter("phoneNo");
	String login_accept=request.getParameter("login_accept");
	String saleType=request.getParameter("saleType");
	String saleCode=request.getParameter("sale_code");
	String prepayPay=request.getParameter("prepay_pay");
	String cust_name=request.getParameter("oCustName");
	String award_flag=request.getParameter("award_flag");
	String sale_name=request.getParameter("sale_name");
	
	String paraAray[] = new String[9];
				
	paraAray[0] = work_no;
	paraAray[1] = opCode;
	paraAray[2] = phoneNo;
	paraAray[3] = login_accept;
	paraAray[4] = saleType;
	paraAray[5] = saleCode;
	paraAray[6] = regionCode;
	paraAray[7] = ip_Addr;
	paraAray[8] = award_flag;
	
%>

	<wtc:service name="s9896Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
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
		System.out.println("���÷���s9896Cfm in f9896_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=WtcUtil.formatNumber(prepayPay,2)%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
<%	
		String chinaFee = result1[0][2];   	//��д���
		System.out.print(chinaFee);
%>
<%
		String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+login_accept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />
		
		<script language="JavaScript">
			function codeChg(s)
			{
			  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
			  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
			  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
			  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
			  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
			  return str;
			}
			rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
			var infoStr="";

			infoStr+="<%=work_no%>  <%=work_name%>"+"       sp��ֵҵ��<%=sale_name%>"+"|";//����
			infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=cust_name%>'+"|";
			infoStr+=" "+"|";//����
			infoStr+='<%=phoneNo%>'+"|";//�ƶ�̨��
			infoStr+=" "+"|";//Э�����

   			infoStr+=" "+"|";//֧Ʊ����
   			
			infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
			infoStr+="<%=WtcUtil.formatNumber(prepayPay,2)%>"+"|";//Сд
			infoStr+="�ɷѺϼƣ�<%=WtcUtil.formatNumber(prepayPay,2)%>Ԫ    "+"|";

			infoStr+="<%=work_name%>"+"|";//��Ʊ��
			infoStr+=" "+"|";//�տ���
			infoStr+=" "+"|";//�տ���
			infoStr+="��ֵҵ���ײ����ͣ�"+"<%=sale_name%>"+"|";
			infoStr+=" "+"|";//�տ���
	 
			dirtPate = "/npage/s1141/f9896_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
		</script>
<%
 	        		        	
	}else
	{
		System.out.println("���÷���s9896Cfm in f9896Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
		<script language="JavaScript">
			rdShowMessageDialog("����ʧ��!<%=errMsg%>");
			window.location="f9896_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%	
 	}
%>

