<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
<%
//	String opCode ="g807"; //"d223";
	String opName = "У԰�źż���ѽ�������޸�";//"�˷�ͳ��";
 String opCode = request.getParameter("opcode");	
	String ljffje = request.getParameter("ljffje");	
	//String ljffsj = request.getParameter("ljffsj");	
	String regionCode= (String)session.getAttribute("regCode"); 
	String workno=(String)session.getAttribute("workNo");
	String s_flag = "1";
	String s_delte_region_code = request.getParameter("s_region_code"); 
	String nopass      = (String)session.getAttribute("password");
	System.out.println("-----------------s_delte_region_code"+s_delte_region_code);
	 	System.out.println("-----------------opCode"+opCode);

/*
	 ;
 
	strcpy(s_lj_paytype,	input_parms[2]);
	f_lj_money = atof(input_parms[3]);
 	strcpy(s_lj_time,	input_parms[4]);
	strcpy(s_rest_paytype,	input_parms[5]);
	f_rest_money = atof(input_parms[6]);
 	strcpy(s_rest_time,	input_parms[7]);
  strcpy(s_region_code,	input_parms[8]);
*/
%>
	<wtc:service name="bg807" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="scode" retmsg="sret" outnum="2">
		<wtc:param value="<%=s_flag%>"/> 
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=s_delte_region_code%>"/> 
		<wtc:param value="<%=nopass%>"/> 
			<wtc:param value="<%=opCode%>"/> 	
		 
	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
	if((!scode.equals("0"))&& (!scode.equals("000000")))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("ɾ��ʧ�ܣ��������"+"<%=scode%>"+",����ԭ��:"+"<%=sret%>");
				history.go(-1);
			</script>
		<%
	}
	else
	{
		System.out.println("AAAAAAAAAAAAAAAAAA ���óɹ�");
		%>
			<script language="javascript">
				rdShowMessageDialog("ɾ���ɹ�");
				window.location="g807_1.jsp";
			</script>
		<%
	}
%> 
 	
 

