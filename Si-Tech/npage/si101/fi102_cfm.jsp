<%
  /*
   * ����: �������ѳ��� i102
   * �汾: 1.0
   * ����: 2013/9/2
   * ����: wanghyd
   * ��Ȩ: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%	
	String opCode=(String)request.getParameter("opCode");	
	String opName=(String)request.getParameter("opName");	
	String cust_name = request.getParameter("cust_name"); 
	String CashPay = request.getParameter("CashPay");     //�ɷѺϼ�
	String chinaFee = "";													//��д���
	String phoneNo = (String)request.getParameter("phone_no");				//�ֻ�����
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");			//����
	String password = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");


	String paraAray[] = new String[28];
	paraAray[0] = request.getParameter("login_accept");						//��ˮ
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[4] = password;
	paraAray[5] = request.getParameter("phone_no");							//�ֻ�����	
	paraAray[6] = "";
	paraAray[7] = request.getParameter("iAddStr");							//Ӫ������Ϣ��
	paraAray[8] = request.getParameter("opNote");							//ע����Ϣ	
	paraAray[9] = ip_Addr;                                    //IP��ַ
	paraAray[10] = request.getParameter("backaccept");         //������ˮ


%>
	<wtc:service name="sg976Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
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
		<wtc:param value="0"/>
		
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{

%>

		<script language="JavaScript">

		   rdShowMessageDialog("�������ѳ����ɹ�! ",2);
		   window.location="/npage/si101/fi101_login.jsp?activePhone=<%=phoneNo%>&opCode=i102&opName=<%=opName%>";    
	</script>
<%
	}else{
%>   
    <script language="JavaScript">
    	rdShowMessageDialog("�������ѳ���ʧ��!<%=errCode%><br/>(<%=errMsg%>)",0);
    	window.location="/npage/si101/fi101_login.jsp?activePhone=<%=phoneNo%>&opCode=i102&opName=<%=opName%>";
    </script>
<%}%>
