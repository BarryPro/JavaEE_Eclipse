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
	String opCode = "zgad";
	String opName = "���Ų�Ʒת�˳���";
	String workno = (String)session.getAttribute("workNo");
 	String[][] result = new String[][]{}; 
	String jtcpzh = request.getParameter("jtcpzh");
	String jtkhid = request.getParameter("jtkhid");
	String zrzh = request.getParameter("zrzh");
	String zzls = request.getParameter("zzls");
	String je = request.getParameter("je");
	String note = workno+"����"+ opCode+",���"+je;
 
%> 
<wtc:service name="bs_zgadCfm" retcode="sretCode" retmsg="sretMsg" outnum="2">
    <wtc:param value="0"/> 
    <wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=note%>"/>
	<wtc:param value="<%=jtcpzh%>"/>
	<wtc:param value="<%=jtkhid%>"/>
	<wtc:param value="<%=zrzh%>"/>
	<wtc:param value="<%=zzls%>"/>
</wtc:service>
<wtc:array id="ret_val"  scope="end" />
<%
if(sretCode=="000000"  ||sretCode.equals("000000"))
{
	%>
		<script language="javascript">
			rdShowMessageDialog("���Ų�Ʒת�˳����ɹ�");
			window.location.href="zgad_1.jsp";
		</script>
	<%
}
else
{
	%>
		<script language="javascript">
			rdShowMessageDialog("���Ų�Ʒת�˳���ʧ��,�������"+"<%=sretCode%>,����ԭ��"+"<%=sretMsg%>");
			window.location.href="zgad_1.jsp";
		</script>
	<%
}
%>	 
 
 

