<%
    /********************
     version v2.0
     ������: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "b859";
    String opName = "�����ݲ�����ѯ";	
    String workNo = (String)session.getAttribute("workNo");  //����
    String org_code_note = (String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
    String searchType=request.getParameter("searchType");
		String workno=request.getParameter("workno");
		String beginTime=request.getParameter("beginTime");
		String endTime=request.getParameter("endTime");
		String iLoginAccept = "0";
		String iChnSource = "01";
		String searchbeginTime = beginTime +"000000";
		String searchendTime = endTime + "235959";
%>
<wtc:service name="sb559OpQry" routerKey="region" routerValue="<%=regionCode%>" outnum="10" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=searchbeginTime%>"/>
		<wtc:param value="<%=searchendTime%>"/>
		<wtc:param value="<%=searchType%>"/>
		</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String return_code =retCode;
	String return_message =retMsg;
	
	if (!return_code.equals("000000"))
	{
	%>
		<script language="JavaScript">
			rdShowMessageDialog("��ѯʧ��! "+return_message,0);
			history.go(-1);
		</script>
	<%
	}
	else if(result.length>1000)
	{
	%>
	<script language="JavaScript">
		rdShowMessageDialog("��¼������1000��������С��Χ��ѯ,��ʾ����ǰ��1000��!");
	</script>
	<%
	}
%>
<HTML>
	<HEAD>
		<TITLE>�����ݲ�����ѯ</TITLE>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
			function gohome() 
			{
	   		document.location.replace("fb859_1.jsp");
			}
		</SCRIPT>
		<FORM method=post name="frm1507_2">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">�����ݲ�����ѯ</div>
			</div>
			<table border="0" align="center" cellspacing="0">
				<tr>
					<td class=orange>������</td>
					<td class=blue><%=result.length-1%></td>
					<td class=orange>��ʼʱ�䣺</td>
					<td class=blue><%=beginTime%></td>
					<td class=orange>����ʱ�䣺</td>
					<td class=blue><%=endTime%></td>
				</tr>
			</table>
			<table cellspacing="0" id="tabList">
			<tr>
				<th nowrap>��������</th>
				<th nowrap>���빤��</th>
				<th nowrap>�����ļ�����</th>
				<th nowrap>��������</th>
				<th nowrap>����ʱ��</th>
				<th nowrap>������ˮ</th>
				<th nowrap>��������</th>
				<th nowrap>�ļ���ַ</th>
			</tr>
<%
		 for(int y=0;y<result.length;y++)
	   {
	    if(result[y][2]!=null)
	    {
		   	out.println("<tr>");
		   	for(int j=2;j<result[0].length;j++)
		   	{
		   		out.println("<td align='left' nowrap>" + result[y][j] + "</td>");
		   	}
		   	out.println("</tr>");
		  }
	   }
%>
			<tr>
				<td align="center" id="footer" colspan="8">
					<input class="b_foot" name="sure" type="button" value="����" onClick="">
		&nbsp; <input class="b_foot" name=back onClick="gohome()" type=button value=����>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>