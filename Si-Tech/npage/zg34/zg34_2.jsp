<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zg34";
    String opName = "ͨ�û���Ʊ��ѯ";
	String check_code=request.getParameter("check_code");
	
	String login_no=request.getParameter("login_no");
	String begin_tm=request.getParameter("begin_tm");
	String end_tm=request.getParameter("end_tm");
	String s_type=request.getParameter("s_type");
	String tax_number=request.getParameter("tax_number");
	String tax_code=request.getParameter("tax_code");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
 
%>
   
<wtc:service name="sgetInvoiceInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="13">
			<wtc:param value=""/>
			<wtc:param value="<%=login_no%>"/>
			<wtc:param value="<%=begin_tm%>"/>
			<wtc:param value="<%=end_tm%>"/>
			<wtc:param value="<%=s_type%>"/>
			<wtc:param value="<%=tax_number%>"/>
			<wtc:param value="<%=tax_code%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="zg34"/>	
</wtc:service>
  
<wtc:array id="result_mx" scope="end" start="0"  length="13"/> 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>ͨ�û���Ʊ��ѯ���</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>ͨ�û���Ʊ����</th>
				  <th>ͨ�û���Ʊ����</th>
                  <th>ͨ�û���Ʊ״̬</th> 
				  <th>��Ʊ��</th>
				 
				  <th>��Ʊ���</th>
				  <th>����</th>
				  <th>ҵ����ˮ</th>
				  <th>����ʱ��</th>
				  <th>��Ʊҵ��</th>
				  <th>�ֻ�����</th> 
                </tr>
<%
	if(retCode2=="000000" ||retCode2.equals("000000") )
	{
		for(int i=0;i<result_mx.length;i++)
		{
			%>
				<tr>
					<td><%=result_mx[i][12]%></td>
					<td><%=result_mx[i][11]%></td>
					<td><%=result_mx[i][2]%></td>
			 
					<td><%=result_mx[i][4]%></td>
					<td><%=result_mx[i][5]%></td>
					<td><%=result_mx[i][6]%></td>
					<td><%=result_mx[i][7]%></td>
					<td><%=result_mx[i][8]%></td>
					<td><%=result_mx[i][9]%></td>
					<td><%=result_mx[i][10]%></td>
			 
	 
				</tr>
			<%
		}
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog('<%=retCode2%>:<%=retMsg2%>',0);
				document.location.replace('zg33_1.jsp');
			</script>
		<%
	}
%> 
 

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'zg34_1.jsp' " type=button value=����>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
			  <!--
			  <input class="b_foot" name=back onClick="toExcel();" type=button value=����EXCEL>
			  -->
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

