   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5275";
  String opName = "������������";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%
  String myretFlag="",myretMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
//��ȡsession��Ϣ
	String loginNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	
	String region_code = request.getParameter("sales_region");
	String min_pay = request.getParameter("min_pay");
	String max_pay = request.getParameter("max_pay");
	String allow_abackfee = request.getParameter("allow_abackfee");
	String allow_abackhours = request.getParameter("allow_abackhours");
	String allow_abackdays = request.getParameter("allow_abackdays");
	String retMsg = null;
	

	/****************����  sDemoGetMsg  ***********************/
   
	String[] paraStrIn = new String[8];
	paraStrIn[0] = loginNo;                 //����
	paraStrIn[1] = nopass;                  //��������
	paraStrIn[2] = region_code;             //���д���
	paraStrIn[3] = min_pay;					//���γ�ֵ��С���
	paraStrIn[4] = max_pay;                 //���γ�ֵ�����
	paraStrIn[5] = allow_abackfee;          //�����Զ����������
	paraStrIn[6] = allow_abackhours;        //�����Զ��������Сʱ��
	paraStrIn[7] = allow_abackdays;         //�����˹������������

	String srvName = "s5275Cfm"; //������1
	String outParaNums = "0"; //�����������

	//impl.callFXService(srvName, paraStrIn,outParaNums,"region",regionCode);
%>

    <wtc:service name="s5275Cfm" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraStrIn[0]%>" />
			<wtc:param value="<%=paraStrIn[1]%>" />
			<wtc:param value="<%=paraStrIn[2]%>" />
			<wtc:param value="<%=paraStrIn[3]%>" />
			<wtc:param value="<%=paraStrIn[4]%>" />
			<wtc:param value="<%=paraStrIn[5]%>" />
			<wtc:param value="<%=paraStrIn[6]%>" />
			<wtc:param value="<%=paraStrIn[7]%>" />							
		</wtc:service>

<% 
	String returnCode = code; //�������
	String returnMsg = msg; //������Ϣ
System.out.println("-------------returnCode-------------"+returnCode);
System.out.println("-------------returnMsg-------------"+returnMsg);
	if(returnCode.equals("000000")){
		retMsg = "�����������óɹ�";
		
%>
<script language="JavaScript">
	 rdShowMessageDialog("<%=retMsg%>",2);
    history.go(-1);
</script>

<%		
	}else{
		retMsg = returnMsg;
%>
		<script language="JavaScript">
    rdShowMessageDialog("<%=retMsg%>",0);
    history.go(-1);
</script>

<%		
	}
	
%>
