 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-07 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");	//header.jsp��Ҫ�Ĳ���  	
	String printAccept =request.getParameter("printAccept");//ȡ����ˮ��
	System.out.println("**************************************"+printAccept);
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	String sqlStr = "";
	String colNum="4";
	//��ȡsession��Ϣ
	String work_no=(String)session.getAttribute("workNo");    //���� 	
	String pass = (String)session.getAttribute("password");
	String paraAray[] = new String[24];
    	String phoneNo = request.getParameter("phoneNo");//�������
                                                     //��������
                                                     //����
                                                     //��������
    	String bp_name = request.getParameter("bp_name");//��������
    	String eng_chi = request.getParameter("eng_chi");//��Ӣ��
    	String bp_title = request.getParameter("bp_title");//��ν
    	String bp_flag = request.getParameter("bp_flag");//bp����
    	String add_no = request.getParameter("add_no");//���Ӻ���
    	String hand_fee = request.getParameter("hand_fee");//ʵ��������
    	String should_hand_fee = request.getParameter("should_hand_fee");//Ӧ��������
    	String choice_fee = request.getParameter("choice_fee");//ʵ��ѡ�ŷ�
    	String should_choice_fee = request.getParameter("should_choice_fee");//Ӧ��ѡ�ŷ�
    	String begin_time = request.getParameter("begin_time");//��ʼʱ��
    	String system_time_flag = request.getParameter("system_time_flag");//����ʹ�ñ�ʶ
	    String opNote = request.getParameter("opNote");//������ע
    	String function_code = request.getParameter("function_code_value");//�ط�����
    	String favour_month = request.getParameter("favour_month");//�Ż�����
    	String function_type = request.getParameter("function_type");//�ط�����
    	String fic_no = request.getParameter("fic_no");//�������
    	String ask_type = request.getParameter("ask_type");//��������

    	paraAray[0] = phoneNo ;//�������
    	paraAray[1] = "1297";//��������
    	paraAray[2] = work_no;//����
   		paraAray[3] = pass; //��������
    	paraAray[4] = bp_name ;//��������
    	paraAray[5] = eng_chi ;//��Ӣ��
    	paraAray[6] = bp_title;//��ν
    	paraAray[7] = bp_flag;//bp����
    	paraAray[8] = add_no;//���Ӻ���
    	paraAray[9] = hand_fee ;//ʵ��������
    	paraAray[10] = should_hand_fee ;//Ӧ��������
    	paraAray[11] = choice_fee ;//ʵ��ѡ�ŷ�
    	paraAray[12] = should_choice_fee ;//Ӧ��ѡ�ŷ�
    	paraAray[13] =  begin_time ;//��ʼʱ��
    	paraAray[14] =  system_time_flag ;//����ʹ�ñ�ʶ
		paraAray[15] =  opNote ;//������ע
    	paraAray[16] =  function_code ;//�ط�����
    	paraAray[17] =  favour_month ;//�Ż�����
    	paraAray[18] =  function_type ;//�ط�����
    	paraAray[19] =  fic_no  ;//�������
    	paraAray[20] =  ask_type ;//��������
    	//String[] ret = impl.callService("s1297_Apply",paraAray,"2","phone",phoneNo);
	%>
		<wtc:service name="s1297_Apply" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
			
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>		
			<wtc:param value="<%=paraAray[1]%>"/>
			<wtc:param value="<%=paraAray[2]%>"/>
			<wtc:param value="<%=paraAray[3]%>"/>
			<wtc:param value="<%=paraAray[0]%>"/>
			<wtc:param value=""/>
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
			<wtc:param value="<%=paraAray[16]%>"/>	
			<wtc:param value="<%=paraAray[17]%>"/>	
			<wtc:param value="<%=paraAray[18]%>"/>	
			<wtc:param value="<%=paraAray[19]%>"/>	
			<wtc:param value="<%=paraAray[20]%>"/>	
			<wtc:param value="<%=printAccept%>"/>
				
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
	<%	
		String errCode="0";
		String errMsg="";
		errCode=retCode1;
		errMsg=retMsg1;				
		
		float fHandFee = Float.parseFloat(hand_fee);
	if ("000000".equals(errCode) )
	{
		if(fHandFee>0)
		{
%>
	<script language="JavaScript">
		   rdShowMessageDialog("12580�����ɹ�! ���潫��ӡ��Ʊ��",2);
		   var infoStr="";
		   infoStr+=" "+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+=" "+"|";
		   infoStr+=" "+"|";
		   infoStr+=" "+"|";
		   infoStr+=" "+"|";
		   infoStr+="�ʻ����ϱ����*�����ѣ�"+"  "+"*��ˮ�ţ�"+"  "+"|";
		   location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1297/f1297_login.jsp";
	</script>
<%
		}else
		{
%>
			<script language="JavaScript">
			   rdShowMessageDialog("12580�����ɹ�!",2);
			   history.go(-2);
			</script>
<%
		}
		}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("12580����ʧ��!<br>errCode: <%=errCode%><br>errMsg: <%=errMsg%>",0);
			history.go(-1);
		</script>
<%}%>
 <%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+printAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />       
