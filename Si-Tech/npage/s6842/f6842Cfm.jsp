<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "�°����Ʒͳһ����ԤԼ�Ǽ�";
	String strReturnMsg = "�°����Ʒͳһ����ԤԼ�Ǽǳɹ�";
	String strReturnErrMsg = "�°����Ʒͳһ����ԤԼ�Ǽ�ʧ��";

	String work_no = (String) session.getAttribute("workNo");
	String work_name = (String) session.getAttribute("workName");
	String org_code = (String) session.getAttribute("orgCode");
	String pass = (String) session.getAttribute("password");
	String strOpCode = request.getParameter("opcode");
	String stream=WtcUtil.repNull(request.getParameter("printAccept"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));

	String paraAray[] = new String[14];
	paraAray[0] = work_no;   //����
	paraAray[1] = pass;      //��������
	paraAray[2] = strOpCode; //��������
	paraAray[3] = phoneNo;   //�ֻ�����
	paraAray[4] = request.getParameter("projectCodeI"); //Ӫ����
	paraAray[5] = request.getParameter("gradeCodeI");   //�Ǽ�
	paraAray[6] = request.getParameter("packageCodeI"); //��
	paraAray[7] = request.getParameter("winAcceptI");   //�н�
	paraAray[8] = request.getParameter("actionCodeI");  //�����

	//paraAray[9] = request.getParameter("checkLoginAcceptnew");//У��Ĳ�����ˮ
	//paraAray[10] = request.getParameter("rescode_sum_new");//������/�������콱����
	paraAray[11] = request.getParameter("printAccept");//ϵͳ������ˮ
	//paraAray[12] = request.getParameter("card_no");
	paraAray[13] = request.getParameter("gradeCode");//gradeCode liyan 20090429 �����н��ȼ�

	for (int i=0;i<paraAray.length;i++){
		System.out.println("ԤԼ�Ǽ�ȷ�����paraAray["+i+"]="+paraAray[i]);
	}
%>
		<wtc:service name="s6842Reg" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" >
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
		</wtc:service>
<%
  int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	String loginAccept = stream;//����δ������ˮ,�����ÿ�
	String cnttActivePhone = phoneNo;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+strOpCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
	if (errCode == 0 )
	{
%>
			<script language="JavaScript">
			   rdShowMessageDialog("<%=strReturnMsg%>",2);
			   location="f6842.jsp?op_code=6842&activePhone=<%=phoneNo%>";
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=strReturnErrMsg%>!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
				location="f6842.jsp?op_code=6842&activePhone=<%=phoneNo%>";
			</script>
<%}%>
