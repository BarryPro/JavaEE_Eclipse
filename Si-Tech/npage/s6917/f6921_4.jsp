<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * ����:��������Ʊ������Ϣ����
   * �汾: 1.0
   * ����: 2009/5/14
   * ����: wangjya
   * ��Ȩ: si-tech
   */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6921";
	String opName = "��������Ʊ������Ϣ����";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	

	
	String orderCode = request.getParameter("order_code");	
	String mobileNo = request.getParameter("mobileNo");
	String phoneNo = request.getParameter("phoneNo");
	String custName = request.getParameter("custName");
	String idType = request.getParameter("idType");
	String idCard = request.getParameter("idCard");
	String custAddress = request.getParameter("custAddress");
	String postCode = request.getParameter("postCode");
	String ticket_type = null == request.getParameter("ticket_type") ? "" : request.getParameter("ticket_type");
	String ticket_sum = null == request.getParameter("ticket_sum") ? "" : request.getParameter("ticket_sum");
	String ticket_date = null == request.getParameter("ticket_date") ? "" : request.getParameter("ticket_date");

	/*00������ɹ�����ʱ����ͷ�е�RspCode��0000
	01�����ʧ�ܣ������ͣ����ʧ��ʱ����ͷ�е�RspCode��2998
	02�����ʧ�ܣ����ʹ�
	03�����ʧ�ܣ��ö������޴�Ʊ�֣�
	04�����ʧ�ܣ����Ʊ��>������Ʊ��
	05�����ʧ�ܣ��ö������޴���Ʊʱ��*/
	Map errType = new HashMap();
	errType.put("01","������");
	errType.put("02","���ʹ�");
	errType.put("03","�ö������޴�Ʊ��");
	errType.put("04","���Ʊ�����ڶ�����Ʊ��");
	errType.put("05","�ö������޴���Ʊʱ��");
	
	String inputParsm[] = new String[13];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = orderCode;
	inputParsm[3] = mobileNo;
	inputParsm[4] = phoneNo;	
	inputParsm[5] = custName;
	inputParsm[6] = idType;
	inputParsm[7] = idCard;
	inputParsm[8] = custAddress;
	inputParsm[9] = postCode;
	inputParsm[10] = ticket_type;
	inputParsm[11] = ticket_sum;
	inputParsm[12] = ticket_date;
%>

   <wtc:service name="s6921Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="5">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	<wtc:param value="<%=inputParsm[5]%>"/>	
	<wtc:param value="<%=inputParsm[6]%>"/>	
	<wtc:param value="<%=inputParsm[7]%>"/>	
	<wtc:param value="<%=inputParsm[8]%>"/>	
	<wtc:param value="<%=inputParsm[9]%>"/>
	<wtc:param value="<%=inputParsm[10]%>"/>	
	<wtc:param value="<%=inputParsm[11]%>"/>	
	<wtc:param value="<%=inputParsm[12]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="5"  scope="end"/>
<% 		

	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("���ʧ�ܣ�" + "<%=errMsg%>",0);	
	 	window.location="f6923_1.jsp?opCode=6921&opName=��������Ʊ������Ϣ����";
		</script>
<%		
		return;				 			
	}
	else if(tempArr[0][0].equals("0000")){
%>
		<script language="javascript">
		rdShowMessageDialog("���ĳɹ���",2);	
		window.location="f6923_1.jsp?opCode=6921&opName=��������Ʊ������Ϣ����";
	 	
		</script>
<%		
		return;				 			
	}
	else if(tempArr[0][0].equals("2998"))
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("���ʧ�ܣ�" + "<%=null == errType.get(tempArr[0][4])?tempArr[0][1]:errType.get(tempArr[0][4])%>",0);	
	 	window.location="f6923_1.jsp?opCode=6921&opName=��������Ʊ������Ϣ����";
		</script>
	<%	
	}
	else 
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("���ʧ�ܣ�" + "<%=tempArr[0][1]%>",0);	
	 	window.location="f6923_1.jsp?opCode=6921&opName=��������Ʊ������Ϣ����";
		</script>
	<%	
	}
%>

