 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	
	String op_code = request.getParameter("op_code");          /*��������*/
	String opCode = op_code;
	String opName = (String)request.getParameter("opName");	
	String sysAccept = (String)request.getParameter("sysAccept");	
	
	String loginAccept = "0";  /*������ˮ*/
	String phoneno = request.getParameter("phoneno");
	String strOpType = request.getParameter("TranType");
	String strOldMachineType = request.getParameter("old_machine_type");
	String strOldSimNo = request.getParameter("old_sim_no");
	String strNewMachineType = request.getParameter("new_machine_type");
	String strNewSimNo = request.getParameter("new_sim_no");
	String strOpMark = request.getParameter("op_mark");
	
	
	System.out.println("strOpType="+strOpType);
	
	//String[][] result = new String[][]{};
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retArray = new ArrayList();
	
	String work_no =(String)session.getAttribute("workNo");	
	String pass =  (String)session.getAttribute("password");
	
	String paraAray[] = new String[11]; 	
	System.out.println("strOpType="+strOpType);	
	if (strOpType.equals("a")){ 
	  	System.out.println("inser into \n");
		paraAray[0] = work_no;  		//��������
		paraAray[1] = pass;  		//������������
		paraAray[2] = op_code; 			//����������
		paraAray[3] = sysAccept; 	//��ˮ
		paraAray[4] = phoneno;			//�û�����
		paraAray[5] = strOpType;		//��������
		paraAray[6] = strOldMachineType;			//�ɻ�������
		paraAray[7] = strOldSimNo;	//��simNO
		paraAray[8] = strNewMachineType;   //�»�������
		paraAray[9] = strNewSimNo; //��simnos
		paraAray[10] = strOpMark; //������ע
	}else{
		System.out.println("delete into \n");
	  	System.out.println("inser into \n");
		paraAray[0] = work_no;  		//��������
		paraAray[1] = pass;  		//������������
		paraAray[2] = op_code; 			//����������
		paraAray[3] = sysAccept; 	//��ˮ
		paraAray[4] = phoneno;			//�û�����
		paraAray[5] = strOpType;		//��������
		paraAray[6] = strOldMachineType;			//�ɻ�������
		paraAray[7] = strOldSimNo;	//��simNO
		paraAray[8] = strNewMachineType;   //�»�������
		paraAray[9] = strNewSimNo; //��simnos
		paraAray[10] = strOpMark; //������ע
	}
	//String[] ret = impl.callService("s7115Cfm",paraAray,"1","phone",phoneno);
%>

	<wtc:service name="s7115Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="8" >
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
	<wtc:array id="ret" scope="end"/>	
<%
	//String retCode= String.valueOf(impl.getErrCode());
	//String retMsg = impl.getErrMsg();
	String retCode= retCode1;
	String retMsg = retMsg1;	
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	if (ret != null && ret.length>0 && retCode.equals("000000")){		
		System.out.println("success");
%>
	<script language="JavaScript">
		rdShowMessageDialog("����绰��ѻ���ҵ����ɹ���",2);
		removeCurrentTab();
	</script>
<%
	}else{
%>   
	<script language="JavaScript">
		rdShowMessageDialog("����绰��ѻ���ҵ��ʧ��:<%=retCode%><%=retMsg%>",0);
		history.go(-1);
	</script>
<%}
%>


<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+sysAccept+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
