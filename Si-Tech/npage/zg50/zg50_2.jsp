<%
/********************
 version v2.0
������: si-tech
*
*add :huangqi IMS��Ŀ������ sFixCodeNew �����ý���
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
<%
	String opCode = "zg50";
	String opName = "sFixCodeNew�Ŷ�����";
	String regionCode= (String)session.getAttribute("regCode"); 
	String s_login_no = request.getParameter("s_login_no");	
	String pzdsname = request.getParameter("pzdsname");	
	String nopass      = (String)session.getAttribute("password");
	String count="0";
	String configType=request.getParameter("configType");
	String note=request.getParameter("note");
	String haoduan="";
	String hdStart="";
	String hdEnd="";
	String[] inParas = new String[2];
	//inParas[0]="select phone_no from dcustres where phone_no between :phoneno1 and :phoneno2 and no_type='0000t'";
	inParas[0]="select phone_no from dcustres where phone_no >= :phoneno1 and phone_no <= :phoneno2 and no_type='0000t'";
%>

<%
if("1".equals(configType)){
		haoduan =  request.getParameter("haoduan");		
		inParas[1]="phoneno1="+haoduan+"00"+",phoneno2="+haoduan+"99";
	
}else{
		hdStart =  request.getParameter("hdStart");	
		hdEnd = request.getParameter("hdEnd");
		inParas[1]="phoneno1="+hdStart+"00"+",phoneno2="+hdEnd+"99";
}
%>
	<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val1" scope="end" />
<%

	//System.out.println("AAAAAAAAAAAAAAAAAA"+ret_val1.length);
	if(ret_val1!=null&&ret_val1.length>0)
	{
		count = ret_val1[0][0];
		System.out.println("BBBBBBBBBBBBBBBBBBBBBBB"+count);
	}
	if(!"0".equals(count)){
			System.out.println("AAAAAAAAAAAAAAAAAA ����ʧ��,��Դ�Ѿ���ռ�ã�"+count);
%>
			<script language="javascript">
				rdShowMessageDialog("����ʧ��,�ŶΣ�"+<%=count.substring(0,7)%>+"�Ѿ���⣡");
				window.location="zg50_1.jsp";
			</script>
<%
	}
	else
	{
		System.out.println("AAAAAAAAAAAAAAAAAA ��Դδ��ռ�ã�����boss��У�鼰���");
%>

<wtc:service name="bzg50" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="scode" retmsg="sret" outnum="2">
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=s_login_no%>"/>
		<wtc:param value="<%=configType%>"/> 
		<wtc:param value="<%=haoduan%>"/> 
		<wtc:param value="<%=hdStart%>"/> 
		<wtc:param value="<%=hdEnd%>"/> 
		<wtc:param value="<%=note%>"/> 
		<wtc:param value="<%=regionCode%>"/> 
	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
		if((!scode.equals("0"))&& (!scode.equals("000000")))
		{
%>
			<script language="javascript">
				rdShowMessageDialog("����ʧ�ܣ��������"+"<%=scode%>"+",����ԭ��:"+"<%=sret%>");
				history.go(-1);
			</script>
<%
		}
		else
		{
		System.out.println("AAAAAAAAAAAAAAAAAA ���óɹ�");
%>
				<script language="javascript">
				rdShowMessageDialog("���óɹ�");
				window.location="zg50_1.jsp";
			</script>
<%
		}
	}
%>

 

