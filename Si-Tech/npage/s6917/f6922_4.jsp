<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * ����:������ȡƱ��ά�벹��
   * �汾: 1.0
   * ����: 2009/5/15
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
 
	String opCode = "6922";
	String opName = "������ȡƱ��ά�벹��";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	

	
	String orderCode = request.getParameter("order_code");	
	String phoneNo = request.getParameter("phone_no");
		
	String  id_type = request.getParameter("id_type");
	String  id_card = request.getParameter("id_card");
	String  codeType = request.getParameter("code_type");
	String inputParsm[] = new String[5];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = orderCode;
	inputParsm[3] = phoneNo;
	inputParsm[4] = codeType;	
%>

   <wtc:service name="s6922Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="4">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="4"  scope="end"/>
<% 		
	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("�ط�ʧ�ܣ�" + "<%=errMsg%>",0);	
	 	window.location="f6922_1.jsp?opCode=6922&opName=������ȡƱ��ά�벹��";
	 	</script>
<%		
		return;				 			
	}
	else if(!(tempArr[0][0].equals("0000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("�ط�ʧ�ܣ�" + "<%=tempArr[0][1]%>",0);	
	 	window.location="f6922_1.jsp?opCode=6922&opName=������ȡƱ��ά�벹��";
	 	</script>
<%		
		return;				 			
	}
	else if((tempArr[0][2].equals("0")))
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("�ط��ɹ���",2);	
		window.location="f6922_1.jsp?opCode=6922&opName=������ȡƱ��ά�벹��";
		</script>
	<%	
	}
	else
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("�ط�ʧ�ܣ������Ŵ���!",0);	
	 	window.location="f6922_1.jsp?opCode=6922&opName=������ȡƱ��ά�벹��";
	 	</script>
	<%	
	}
%>
