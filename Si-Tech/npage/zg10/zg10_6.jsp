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

<%
    String opCode = "zg10";
    String opName = "�������ɻ���";
	String group_no_id = request.getParameter("group_no_id"); 
 
	
 
 
%>
   
<wtc:service name="zg10Del" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=group_no_id%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />

<%
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbb retCode1 is "+retCode1);
	if(retCode1=="000000" ||retCode1.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("ɾ���ɹ�!");
				window.location = "zg10_1.jsp";
			</script>
		<%
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("ɾ��ʧ��!�������:"+retCode1+",����ԭ��:"+retMsg1);
				history.go(-1);
			</script>
		<%
	}
%>
