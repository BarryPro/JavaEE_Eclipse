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
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zg98";
		String opName = "�˷ѱ�ע��Ϣ��ѯ";
		//zg98_2.jsp?phone_no="+phoneNo+"&beginTime="+beginTime+"&endTime
		String phone_no = request.getParameter("phone_no");
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
 
		
%>
<script language="javascript">
	function goBack(phone_no)
	{
		//alert(phone_no);
		window.location.href="zg98_1.jsp?phone_no="+phone_no;
	}
</script>
<wtc:service name="s2201NoteQry" retcode="retCode1" retmsg="retMsg1" outnum="8">
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=beginTime%>"/>
	<wtc:param value="<%=endTime%>"/>
</wtc:service>
<wtc:array id="r_return_code" scope="end" start="0"  length="2" />	
<wtc:array id="ret_val" scope="end" start="2"  length="6" />
<%
	if(ret_val ==null || ret_val.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ѯ��������ڣ�");
				//return false;
				window.location.href='zg98_1.jsp'
			</script>
		<%
	}
	else
	{
		%>
		<HTML>
<HEAD>
<script language="JavaScript">

</script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
	<%@ include file="/npage/include/header.jsp" %>
	<table cellspacing="0">
		<tr>
			<th>
				�˷�ʱ��
			</th>
			<th>
				�˷ѹ���
			</th>
			<th>
				�˷ѽ��(Ԫ)
			</th>
			<th>
				�˷�ҵ�����
			</th>
			<th>
				�˷Ѳ�����ע��Ϣ
			</th>
			<th>
				�˷Ѳ���ҵ����ˮ
			</th>
		</tr>
		<%
			for(int i=0;i<ret_val.length;i++)
			{
				%>
					<tr>
						<td><%=ret_val[i][3]%></td>
						<td><%=ret_val[i][2]%></td>
						<td><%=ret_val[i][1]%></td>
						<td><%=ret_val[i][4]%></td>
						<td><%=ret_val[i][0]%></td>
						<td><%=ret_val[i][5]%></td>
					</tr>
				<%
			}	
		%>
		
	 </table>

	 <table cellSpacing="0">
		<tr> 
		  <td id="footer"> 
			    
			  <input type="button" name="return1" class="b_foot" value="����" onclick="goBack('<%=phone_no%>')" >
			  
			  &nbsp;
				  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
		  </td>
		</tr>
	 </table>
	
  
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
 </BODY>
</HTML>
		<%
	}
%>
