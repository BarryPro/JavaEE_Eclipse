<%
/********************
 version v2.0
������: si-tech
*
*create by lipf 20120509
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1600";
  String opName = "�����Ϣ��ѯ֮�˿ڳ�ʼ��";
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String iLoginAccept = "0";     //��ˮ
  String iChnSource = "01";			//������ʶ
  String iOpCode=request.getParameter("iOpCode");//��������
  String iLoginNo = (String)session.getAttribute("workNo");//����
	String iLoginPwd = (String)session.getAttribute("password");//��������
	String iPhoneNo  = request.getParameter("iPhoneNo");//�ֻ�����
  String iUserPwd = "";					//�ֻ�����
	String iOpNote="�˿ڳ�ʼ��";//��ע
	String iAccount  =request.getParameter("iAccount");//�û��˺�
	String iNasPort="0000";//�󶨶˿�
%>
	<wtc:service name="sBindPortCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iOpNote%>"/>
		<wtc:param value="<%=iAccount%>"/>
		<wtc:param value="<%=iNasPort%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if ("000000".equals(retCode1)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retMsg1%>");
			history.go(-1);
		</script>
<%	
	}else{
	%>
		<script language="JavaScript">
			rdShowMessageDialog("������ʾ:<%=retMsg1%>");
			history.go(-1);
		</script>
	<%	
	}
%>

