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
	String opCode ="zg97"; 
	String opName = "����50M�ⶥ����"; 
	String regionCode= (String)session.getAttribute("regCode"); 
	String workno=(String)session.getAttribute("workNo");
	String nopass= (String)session.getAttribute("password");
	String phoneNo = request.getParameter("phoneNo");	
	String fdType = request.getParameter("fdType");	
	String returnCode="";

%>
	<wtc:service name="zg52fd" routerKey="regionCode"   retcode="scode" retmsg="sret" outnum="4">
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=phoneNo%>"/> 
		<wtc:param value="1"/>
		<wtc:param value="<%=fdType%>"/> 

	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
	if(result!=null&&result.length>0){
		returnCode=result[0][0];
		if(returnCode.equals("000000"))
		{			
%>
				<script language="JavaScript">
					rdShowMessageDialog("����ɹ�!");
					window.location="zg97_check.jsp?phoneNo="+"<%=phoneNo%>";
				</script>
			
<%
		}else{
%>			
				<script language="javascript">
					rdShowMessageDialog("����ʧ�ܣ��������"+"<%=result[0][0]%>"+",����ԭ��:"+"<%=result[0][1]%>");
					history.go(-1);
				</script>
<%		}
	}else{
%>   
			<script language="javascript">
			rdShowMessageDialog("����ʧ�ܣ�����zg52fd���ؽ��Ϊ��!,�������Ա��ϵ��");
			//window.location="zg97_1.jsp";
			history.go(-1);
			</script>
<%
	}
%>