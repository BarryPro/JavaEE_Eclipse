<%
  /*
   * ����: ������Ϣ��ҵ������1465
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	String opCode="1465";
	String opName="������Ϣ��ҵ������";
	String work_no = (String)session.getAttribute("workNo");			//��������
	String pass = (String)session.getAttribute("password");				//��������
	String regionCode = (String)session.getAttribute("regCode");		//���д���
	String printAccept=request.getParameter("printAccept");				//��ӡ��ˮ
	String phone_no = request.getParameter("phone_no");					//�������
	String user_passwd = request.getParameter("passFromPage");			//�û�����
	String tran_type = request.getParameter("r_cus");
	String opNote = request.getParameter("opNote");
	String ip_Addr = request.getParameter("ip_Addr");
	String strFuncType = request.getParameter("func_type");		/*��������*/
   	
	String paraAray[] = new String[11];
	paraAray[0] = work_no;				//��¼����
	paraAray[1] = pass;      			//��¼��������
	paraAray[2] = "01";      			//��¼����
  	paraAray[3] = printAccept;			//��¼����ϵͳ������ˮ
	paraAray[4] = "1465";   			//��������
	paraAray[5] = phone_no;  			//�ֻ�����
	paraAray[6] = user_passwd;  		//�û�����
	paraAray[7] = tran_type; 			//��������
	paraAray[8] = opNote;				//����ע��
	paraAray[9] = ip_Addr;				//�û���������IP��ַ
	paraAray[10] = strFuncType;			//��������
	
//	String[] ret = impl.callService("s5510Cfm",paraAray,"1","phone",request.getParameter("phoneNo"));
%>
	<wtc:service name="s5510Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
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
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
	System.out.println("result=============="+result[0][0]);
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
%>
<script language="JavaScript">
	       rdShowMessageDialog("����ҵ������ɹ�!",2);
	       window.location="f1465.jsp?activePhone=<%=phone_no%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("����ҵ������ҵ����ʧ��!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	 window.location="f1465.jsp?activePhone=<%=phone_no%>";
	//history.go(-1);
</script>
<%}%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+""+"&pageActivePhone="+phone_no+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
