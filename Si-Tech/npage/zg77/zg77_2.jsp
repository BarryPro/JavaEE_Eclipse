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
		String opCode = "zg77";
		String opName = "���ŷ�Ʊ��ӡȡ��";
		String workno = (String)session.getAttribute("workNo");
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		String invoice_number = request.getParameter("invoice_number");
		String invoice_code = request.getParameter("invoice_code");
		String[] inParas2 = new String[2];
		String op_code = request.getParameter("op_code");
		//add for liugang
		String begin_ym = request.getParameter("begin_ym");
		String end_ym = request.getParameter("end_ym");

		if(op_code=="1322" || op_code.equals("1322"))
		{
			opName+="-���ŷ�Ʊ��ӡ";
		}
		else
		{
			opName+="-���ŷ�ƱԤ��";
		}
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa op_code is "+op_code+" and begin_ym is "+begin_ym);
		 
		String s_ret="";
%>
<script language="javascript">
	function doCfm(op_codes)
	{
		//alert("op_codes is "+op_codes);
		document.frm.action="zg77_3.jsp?invoice_number="+"<%=invoice_number%>"+"&invoice_code="+"<%=invoice_code%>"+"&op_code="+op_codes;
		//alert(document.frm.action);
		document.frm.submit();
	}
</script>
<wtc:service name="scancel_qry" retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=invoice_number%>"/>
	<wtc:param value="<%=invoice_code%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=op_code%>"/>
	<wtc:param value="<%=begin_ym%>"/>
	<wtc:param value="<%=end_ym%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end"  start="0"  length="2"/>
<wtc:array id="s_qry" scope="end" start="2"  length="7" />
<%
	 if(s_qry.length>0)
	 {
		 %>
			<HTML>
				<HEAD>
				<title>������BOSS-��ͨ�ɷ�</title>
				</head>
				<BODY>
				<form action="" method="post" name="frm">
						
					<%@ include file="/npage/include/header.jsp" %>
					<table cellspacing="0">
					 
						   
					 
							<tr>
								<td>ҵ�����</td><td>ҵ����ˮ</td><td>��Ʊ���</td><td>��Ʊ����</td><td>��Ʊ����</td><td>��Ʊ��Ӧ�ɷ�����</td>
							</tr>	 
					 
						  <%
							for(int i=0;i<s_qry.length;i++)
							{
							  %>
								<tr>
									<td><%=s_qry[i][2]%></td>
									<td><%=s_qry[i][3]%></td>
									<td><%=s_qry[i][5]%></td>
									<td><%=invoice_number%></td>
									<td><%=invoice_code%></td>
									<td><%=s_qry[i][6]%></td>
								</tr>
							  <%
							}
						  %>
						</tr>
						
					 </table>
					 <input type="hidden" name="begin_ym" value="<%=begin_ym%>">
					 <input type="hidden" name="end_ym" value="<%=end_ym%>">
					 <table cellSpacing="0">
						<tr> 
						  <td id="footer"> 
							   <input type="button" name="add" class="b_foot" value="��Ʊ����ȡ��" onclick="doCfm('<%=op_code%>')" >
							  &nbsp;
							  <input type="button" name="return1" class="b_foot" value="����" onclick="window.location.href='zg77_1.jsp'" >
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
	 else
	 {
		 %>
			<script language="javascript">
				rdShowMessageDialog("��Ʊ��Ϣ��ѯʧ��!�������:"+"<%=retCode1%>"+",����ԭ��:"+"<%=retMsg1%>");
				window.location.href="zg77_1.jsp";
			</script>
		 <%
	 }
%>
