<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-16 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = request.getParameter("op_code");
	String opName = request.getParameter("opName");
	
	String op_code = request.getParameter("op_code");          /*��������*/
	String loginAccept = request.getParameter("loginAccept");  /*������ˮ*/
	String vLoginAccept=loginAccept;
	String phoneno = request.getParameter("phoneno");
	String strTranType = request.getParameter("TranType");	/*ҵ������*/
	String strCustName = request.getParameter("cust_name"); /*�û�����*/
	String strIdType = request.getParameter("IdType");      /*֤������*/
	String strIdTypeNo = request.getParameter("IdTypeNo");  /*֤������*/
	String strContactNo = request.getParameter("ContactNo");/*��ϵ��*/
	String strUserAddress = request.getParameter("user_address");
	String strOpMark = request.getParameter("op_mark");
	
	
	//String[][] result = new String[][]{};	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	
	String work_no = (String)session.getAttribute("workNo");		
	String pass = (String)session.getAttribute("password");
	
	String paraAray[] = new String[11]; 
	paraAray[0] = work_no;  		//��������
	paraAray[1] = pass;  				//��������
	paraAray[2] = loginAccept; 	//��ˮ
	paraAray[3] = op_code; 			//����������
	paraAray[4] = phoneno;			//�û�����
	paraAray[5] = strCustName;   
	paraAray[6] = strIdType; 
	paraAray[7] = strIdTypeNo;  
	paraAray[8] = strContactNo; 
	paraAray[9] = strUserAddress;	
	paraAray[10] = strOpMark;	
	
	//String[] ret = impl.callService("s2267Cfm",paraAray,"1","phone",phoneno);
%>
	
	<wtc:service name="s2267Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
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
	<wtc:array id="result1" scope="end"/>
	<%
	String retCode= retCode1;
	String retMsg = retMsg1;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);	
	
	String errMsg = retMsg1;	
	if (result1 != null &&result1.length>0&& retCode.equals("000000"))
	{
		loginAccept = result1[0][0]; 
		System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("�ֻ��û�ʵ���Ǽ�/�޸Ĵ���ɹ���",2);
	history.go(-1);
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�ֻ��û�ʵ���Ǽ�/�޸�: <%=retCode%>",0);
	history.go(-1);
</script>
<%}
%>

<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+vLoginAccept+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
	System.out.println(url);
%>
<jsp:include page="<%=url%>" flush="true" />