<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zgb4";
    String opName = "΢��֧������״̬��ѯ";
	String phoneNo=request.getParameter("phoneNo");
	 
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
%>
   
<wtc:service name="sOrderPayQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="9">
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
		 	
</wtc:service>
  
<wtc:array id="result1" scope="end" start="0"  length="4"/>
<wtc:array id="result_mx" scope="end" start="4"  length="4" />
<wtc:array id="result_ds" scope="end" start="8"  length="1" /> 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>΢��֧������״̬��ѯ</TITLE>
</HEAD>
<body>
<%
	if(retCode2=="000000" ||retCode2.equals("000000") )
	{
	 
%>

<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>
	  <table cellspacing="0">
		<tr>
			<td>�û��ֻ�����</td>
			<td><%=result1[0][2]%></td>
		</tr>
		<tr>
			<td>�û���������</td>
			<td><%=result_ds[0][0]%></td>
		</tr>
	  </table>
      <table cellspacing="0">
      <tr> 
        <th>����״̬</th>
		<th>�ɷ�ʱ��</th>
        <th>ʵ�ʸ�����(Ԫ)</th> 
		<th>��ֵ���(Ԫ)</th> 
      </tr>
<%
	
 
		for(int i=0;i<result_mx.length;i++)
		{
			//result_mx[i][2]="222";
			//Integer.parseInt(result_mx[i][2])/100 ���ǿ�У�����ת��
			%>
				<tr>
					<td><%=result_mx[i][0]%></td>
					<td><%=result_mx[i][1]%></td>
					<td><%=Integer.parseInt(result_mx[i][2])/100.00%></td>
					<td><%=Integer.parseInt(result_mx[i][3])/100.00%></td>
				</tr>
			<%
		}
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog('<%=retCode2%>:<%=retMsg2%>',0);
				document.location.replace('zgb4_1.jsp');
			</script>
		<%
	}
%> 
 

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'zgb4_1.jsp' " type=button value=����>
    	      <input class="b_foot" name=back onClick="removeCurrentTab();" type=button value=�ر�>
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

