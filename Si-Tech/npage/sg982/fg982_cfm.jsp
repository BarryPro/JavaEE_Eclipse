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
String remark = request.getParameter("remark");
String sSaveName = request.getParameter("sSaveName");
String filename = request.getParameter("filename"); 
String phone_type = request.getParameter("phone_type"); //�ն��ͺŴ���
String phone_brand = request.getParameter("phone_brand");//�ն�Ʒ�ƴ��� 
String begin_time = request.getParameter("begin_time"); 
String end_time = request.getParameter("end_time"); 
String serverIp=realip.trim();
String total_fee = "";
String total_no = "";
int flag = 0;
%>
	<wtc:service name="sg982Cfm" routerKey="regionCode" routerValue="01"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="7" >
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value="0"/>   <%/*������ʶ q ��ѯ 0 ���� 1 ɾ��*/%>
		<wtc:param value="<%=phone_brand%>"/>
		<wtc:param value="<%=phone_type%>"/>
		<wtc:param value="<%=begin_time%>"/>
		<wtc:param value="<%=end_time%>"/>
		<wtc:param value="<%=sSaveName%>"/>
		<wtc:param value="<%=serverIp%>"/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value=""/> <%/*���д��� ɾ����ֵ*/%>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%   
	if(!sReturnCode.equals("000000")){
		flag = -1;
		System.out.println(" ������Ϣ : " + sErrorMessage);
	}else{
	  if(result.length>0){
	    total_no = result[0][0];
	    flag = 0;
	  }
	}
%>
<HEAD>
    <TITLE>������BOSS-�ʷ����ն˷���Ŀ���û�����</TITLE>
    <META content="text/html; charset=gb2312" http-equiv=Content-Type>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
    
<script language="JavaScript">
var Constants = {};
function gohome(){
  document.location.replace("fg982_main.jsp?opCode=g982&opName=�ʷ����ն˷���Ŀ���û�����");
}

  window.onload = function(){
    //zhouby update
    <% if (flag == 0){%>
        Constants.IS_SUCCESS = true;
        Constants.MASSAGE = '�ϴ��ɹ�����ˮΪ��<%=total_no%>��������ԼһСʱ���ٲ�ѯ��������';
    <% } else { %>
        Constants.IS_SUCCESS = true;
        Constants.MASSAGE = '�ϴ�ʧ�ܣ�<%=sReturnCode%>��������Ϣ��<%=sErrorMessage%>��';
    <% } %>
    
      if (Constants.IS_SUCCESS){
          rdShowMessageDialog(Constants.MASSAGE, 1);
      } else {
          rdShowMessageDialog(Constants.MASSAGE, 0);
      }
      gohome();
  };
</script>
</HEAD>
<BODY>
</BODY>
</HTML>