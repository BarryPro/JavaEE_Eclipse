<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.09
 ģ��:�ĺ�֪ͨ
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%	
 
	String op_code = request.getParameter("opCode");
	String loginAccept = request.getParameter("loginAccept");
	String phoneno = request.getParameter("phoneno");
	String transPhone = request.getParameter("transPhone");
	String t_sys_remark = request.getParameter("t_sys_remark");
	String money = request.getParameter("vHandFee");
	String opName = request.getParameter("opName");
	String money1 =  "-" + request.getParameter("paymoney");
	
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	
	String paraAray[] = new String[7];   

	paraAray[0] = loginAccept; //��ˮ
	                          //���ܴ���
	paraAray[2] = work_no;	//��������
	paraAray[3] = phoneno;	//�û�����
	paraAray[4] = transPhone;  //��ת����
	paraAray[5] = t_sys_remark;	//�û���ע
	
     if(opName.equals("ȡ��"))
	{
	paraAray[6] ="0";	//������
    paraAray[1] = "1447";
	}   
	
	//«ѧ�20060313 add ����������ͨ�û� -- begin --
	else if(opName.equals("����(��ͨ��)"))
	{
		paraAray[1] = "1446";
		paraAray[6] = money;//����ǰ̨��0

	}
	else if(opName.equals("ȡ��(��ͨ��)"))//��������Ϊ��,
	{
		System.out.println("1446BackCfm.jspҳ�� �������������!!");
	}                 
	//«ѧ�20060313 add --- end---
	
	else{
	   if(opName.equals("����"))
	    {
	     paraAray[6] =money1;	//������
         paraAray[1] = "1447";
	    }
       else 
	   {
	   paraAray[6] = money;   //������
	   paraAray[1] = "1446";
	   }
	 }

	//String[] ret = impl.callService("s1446Cfm",paraAray,"1","phone",phoneno);
%>
	<wtc:service name="s1446Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>	
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>	
	<wtc:param value="<%=paraAray[6]%>"/>	
	</wtc:service>	
	<wtc:array id="ret"  scope="end"/>
<%
	
	String retCode= retCode1;
	String retMsg = retMsg1;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	//int errCode = impl.getErrCode();
	
	String errMsg = retMsg1;
	//String loginAccept = "";
	if (ret.length>0 && retCode.equals("000000"))
	{
		loginAccept = ret[0][0];

%>

<script language="JavaScript">
	rdShowMessageDialog("�ĺ�֪ͨ�ɹ���",2);
	removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�ĺ�֪ͨʧ��!(<%=errMsg%>",0);
	history.go(-1);
</script>
<%}
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+op_code+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />

