 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-07 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	String[][] result = new String[][]{};
	
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");	//header.jsp��Ҫ�Ĳ���	
	String printAccept =request.getParameter("printAccept");//ȡ����ˮ��
	
	ArrayList retArray = new ArrayList();	
	String work_no=(String)session.getAttribute("workNo");    //���� 
	String pass = (String)session.getAttribute("password");
	String paraAray[] = new String[16];
	String phoneNo= request.getParameter("phoneNo");//�������
	paraAray[0] = request.getParameter("phoneNo");//�������
	paraAray[1] = "7193";//��������
	paraAray[2] = work_no;//����
	paraAray[3] = pass;  //��������
	paraAray[4] = request.getParameter("bp_name");//��������
	paraAray[5] = request.getParameter("eng_chi");//��Ӣ��
	paraAray[6] = request.getParameter("bp_title");//��ν
	paraAray[7] = request.getParameter("bp_flag");//bp����
	paraAray[8] = request.getParameter("add_no");//���Ӻ���
	paraAray[9] = request.getParameter("hand_fee");//ʵ��������
	paraAray[10] = request.getParameter("should_hand_fee");//Ӧ��������
	paraAray[11] = request.getParameter("opNote");//������ע
	paraAray[12] = request.getParameter("function_code");//�ط�����
	
	    //String[] ret = impl.callService("s1298_Apply",paraAray,"2","phone",request.getParameter("phoneNo"));
	    %>
	    <wtc:service name="s1298_Apply" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
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
			<wtc:param value="<%=printAccept%>"/>				
	    </wtc:service>
	    <wtc:array id="ret" scope="end"/>
	    <%
		String errCode=retCode1;
		String errMsg=retMsg1;
		float handFee = Float.parseFloat(request.getParameter("hand_fee"));
	if (errCode.equals("000000"))
	{
		if(handFee>0)
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