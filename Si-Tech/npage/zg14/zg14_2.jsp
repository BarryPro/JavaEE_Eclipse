<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zg14";
    String opName = "������Ϣ��ѯ";
	String phone_no = request.getParameter("phone_no");
 
	 
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>һ��֧������ͳ���ֹ�����</TITLE>
	
</HEAD>
<body>


<form method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
 

<wtc:service name="s2201Select" retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:param value="<%=phone_no%>"/>
 
</wtc:service>
<wtc:array id="r_return_code" scope="end" />	
 
<%
 
 	if(!retCode1.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("������ѯ����!�������"+"<%=retCode1%>������ԭ��"+"<%=retMsg1%>");
				//history.go(-1);
				window.location.href="zg14_1.jsp?activePhone=<%=phone_no%>";
			</script>
		<%
	}
	else
	{
		%>
		
	 
		<div class="title">
			<div id="title_zi">��ѯ���</div>
		</div>

			  <table cellspacing="0" id = "PrintA">
						<tr> 
						   
						  <th>��������</th>
						  <th>���չ���</th>
						  <th>���ս��</th>
						  
						</tr>
				 
						<%
							String tbclass="";
							for(int i =0;i<r_return_code.length;i++)
							{
								%>
								<tr align="center">
									<td class="<%=tbclass%>"><%=r_return_code[i][0]%></td>
									<td class="<%=tbclass%>"><%=r_return_code[i][1]%></td>
									<td class="<%=tbclass%>"><%=r_return_code[i][2]%></td>
								</tr>
								<%
							}
						%>
						
							
			 
				 
				  <tr id="footer"> 
					<td colspan="9">
					 
					  <input class="b_foot" name=back onClick="window.location.href='zg14_1.jsp?activePhone=<%=phone_no%>'" type=button value=����>
					</td>
				  </tr>
				  
			  </table>
			  
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="id_contractNo">			
				

		<%@ include file="/npage/include/footer.jsp" %>

		<%
	}
%>
 
		 
</form>
</body>
</html>

