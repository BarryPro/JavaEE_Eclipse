<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
String opCode = "g982";
String opName = "�ʷ����ն˷���Ŀ���û����� ";
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//��������
String nopass =(String)session.getAttribute("password");
String ipAddr =(String)session.getAttribute("ipAddr");
String regionCode = orgcode.substring(0,2);
String op_code = "g982";
String remark = "����Ա��"+workno+"�������ʷ����ն˷���Ŀ���û�����-ɾ���ύ";
String regionCode1 = WtcUtil.repStr(request.getParameter("regionCode"), "");
String phone_type = request.getParameter("phone_type"); //�ն��ͺŴ���
String phone_brand = request.getParameter("phone_brand");//�ն�Ʒ�ƴ��� 
String begin_time = request.getParameter("begin_time"); 
String end_time = request.getParameter("end_time"); 
String serverIp=realip.trim();

%>
	<wtc:service name="sg982Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="7" >
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value="1"/>   <%/*������ʶ q ��ѯ 0 ���� 1 ɾ��*/%>
		<wtc:param value="<%=phone_brand%>"/>
		<wtc:param value="<%=phone_type%>"/>
		<wtc:param value="<%=begin_time%>"/>
		<wtc:param value="<%=end_time%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=regionCode%>"/> <%/*���д��� ɾ����ֵ*/%>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
  if("000000".equals(sReturnCode)){
%>
    <script language="JavaScript">
      rdShowMessageDialog("ɾ���ɹ�!",2);
      window.location="fg982_main.jsp?opCode=g982&opName=�ʷ����ն˷���Ŀ���û�����";
    </script>
<%  
  }else{
%>
    <script language="JavaScript">
      rdShowMessageDialog("ɾ��ʧ��!<%=sReturnCode%><br><%=sErrorMessage%>",0);
      window.location="fg982_main.jsp?opCode=g982&opName=�ʷ����ն˷���Ŀ���û�����";
    </script>
<%  
  }
%>





