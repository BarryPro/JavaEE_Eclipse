<%
    /********************
     version v2.0
     ������: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "";

    String work_no = (String) session.getAttribute("workNo");
    String pass = (String) session.getAttribute("password");
    
    String strOpCode = request.getParameter("opcode");
    String stream=WtcUtil.repNull(request.getParameter("printAccept"));
    String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
	String strReturnMsg = "";
	String strReturnErrMsg = "";
	String paraAray[] = new String[7];
	paraAray[0] = work_no;//����
	paraAray[1] = pass;//��������
	paraAray[2] = strOpCode;//��������
	paraAray[3] = phoneNo;//�ֻ�����
	paraAray[4] = request.getParameter("backaccept");//������ˮ��
	paraAray[5] = "�û�"+phoneNo+"ͳһ����Ʒ��������";//��ע
	paraAray[6] = stream;//ϵͳ������ˮ
	
	
    System.out.println("---------------------------------------------------");
    for(int i=0;i<paraAray.length;i++)
    {
        System.out.println("paraAray["+i+"]="+paraAray[i]);
    }

%>

<%
		strReturnMsg="����Ʒͳһ���������ɹ�";
		strReturnErrMsg = "����Ʒͳһ��������ʧ��";
		opName="����Ʒͳһ��������";
%>
		<wtc:service name="s2266BackNew" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" >
    		<wtc:param value="<%=paraAray[0]%>"/>
    		<wtc:param value="<%=paraAray[1]%>"/>
    		<wtc:param value="<%=paraAray[2]%>"/>
    		<wtc:param value="<%=paraAray[3]%>"/>
    		<wtc:param value="<%=paraAray[4]%>"/>
    		<wtc:param value="<%=paraAray[5]%>"/>
    		<wtc:param value="<%=paraAray[6]%>"/>
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
			   location="f2266.jsp?op_code=2266&activePhone=<%=phoneNo%>";
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=strReturnErrMsg%>!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
				location="f2266.jsp?op_code=2266&activePhone=<%=phoneNo%>";
			</script>
<%}%>
