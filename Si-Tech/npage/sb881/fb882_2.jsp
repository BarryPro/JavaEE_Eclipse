<%
  /*
 * version v2.0
 * ������: si-tech
 * author: huangrong
 * date  : 20101103
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode="b882";
	String opName="������Ʒ�һ�";
	String work_no = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password"); 
	String regionCode = (String)session.getAttribute("regCode");
	
	
	String login_accept=request.getParameter("login_accept");
	String phoneNo=request.getParameter("phoneNo");
	String userPass=request.getParameter("Ed_UserPass");		
	String regionName=request.getParameter("regionName");//����
	String type_code=request.getParameter("type_code");//����
	String sendAddress=request.getParameter("sendAddress");	//���͵�ַ
	String postCode=request.getParameter("postCode");	//�ʱ�
	String addressPerson=request.getParameter("addressPerson");			//�ռ���
	String phoneNum=request.getParameter("phoneNum");	//��ϵ�绰		
	String ItemCode=request.getParameter("ItemCode");	//�һ���Ʒ����
	String ItemNum=request.getParameter("ItemNum");		//�һ���Ʒ����
	String sendTime=request.getParameter("sendTime");		//����ʱ��
	
	String paraAray[] = new String[16];
	paraAray[0] = login_accept;
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[4] = password;
	paraAray[5] = phoneNo;
	paraAray[6] = userPass;
	paraAray[7] = ItemCode;
	paraAray[8] = ItemNum;
	paraAray[9] = addressPerson;
	paraAray[10] = regionName;	
	paraAray[11] = type_code;
	paraAray[12] = sendAddress;
	paraAray[13] = phoneNum;
	paraAray[14] = postCode;
	paraAray[15] = sendTime;

	System.out.println("ItemCode==============================="+ItemCode);
	System.out.println("ItemNum==============================="+ItemNum);
	System.out.println("addressPerson==============================="+addressPerson);
	System.out.println("phoneNum==============================="+phoneNum);
	System.out.println("regionName==============================="+regionName);
	System.out.println("ItemCode==============================="+ItemCode);
		System.out.println("postCode==============================="+postCode);
			System.out.println("sendTime==============================="+sendTime);
				System.out.println("type_code==============================="+type_code);

%>
	<wtc:service name="sOrderCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>	
		<wtc:param value="<%=paraAray[14]%>"/>	
		<wtc:param value="<%=paraAray[15]%>"/>	
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
	String a=result[0][1];
		System.out.println("dddddddddddddddddddddddd"+a);
%>

<script language="JavaScript">
   rdShowMessageDialog("�ύ�ɹ����˴ζ������Ϊ��<%=a%>",2);
   window.location="/npage/sb881/fb882_1.jsp?activePhone="+<%=phoneNo%>;
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("����ʡ���ֶһ���Ʒ����ʧ��!<%=errMsg%>",0);
  window.location="/npage/sb881/fb882_1.jsp?activePhone="+<%=phoneNo%>;
</script>
<%}%>

