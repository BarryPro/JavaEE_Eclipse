
<%
/********************
 version v2.0
������: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
		String opCode = "9493";
		String opName = "��Ʊ��Ϣ��ѯ";
		

		String check_key = request.getParameter("check_num");
		//int check = Integer.parseInt(check_key);
		int key = 99999;
		//int realKey = key ^ check;
		
		String phoneNo = request.getParameter("phoneNo");
		String login_accept =  request.getParameter("login_accept");
		String print_time = request.getParameter("print_time");
		String bill_type = "2";
		String[] inParas1 = new String[2];
		
		inParas1[0] = "select to_char(print_content) from Dservorderprtcntt"+print_time+" where serv_order_id in (select serv_order_id from Dservorderprt"+print_time+" where serv_order_id = :login_accept  ) and bill_type = :bill_type order by col_num asc";
		inParas1[1] = "login_accept="+login_accept+",bill_type="+bill_type;
		//String sqlStr = "select print_content from Dservorderprtcntt"+print_time+" where serv_order_id = (select serv_order_id from Dservorderprt"+print_time+" where serv_order_id = '"+login_accept+"' and rownum=1) and bill_type in ('1','2') order by col_num asc";
//		System.out.println("========QQQQQQQQQQQQQQQQQQ======="+sqlStr);

		 String[][] result = new String[][]{};

		 // xl add ���ݲ�ѯ��function_code ����ҵ���չʾ��Ϣ
		String s_function_code="";
		String s_function_name="";
		String[] inParas2 = new String[2];
		inParas2[0]="select a.op_code,b.function_name from Dservorderprtcntt"+print_time+" a,sfunccode b where a.serv_order_id = (select serv_order_id from Dservorderprt"+print_time+" where serv_order_id = :login_accept and rownum=1) and a.bill_type ='2' and a.op_code =b.function_code and rownum=1";
		inParas2[1]="login_accept="+login_accept;


%>
		<wtc:service name="TlsPubSelCrm"   retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>	
		</wtc:service>
		<wtc:array id="ret_val" scope="end" />
<%
	//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaa"+inParas2[0]);
	if(ret_val!=null && ret_val.length>0)
	{
		s_function_code=ret_val[0][0].trim();
		s_function_name=ret_val[0][1].trim();
	}
	else
	{
		%><script language="javascript">
				rdShowMessageDialog("��Ʊ��Ϣ��ѯʧ�ܣ�����������!");	
				window.location.href='s9493.jsp?opCode=9493&opName=��Ʊ��Ϣ��ѯ&crmActiveOpCode=9493';
		  </script><%
	}
		Date nowTime = new Date();
		//System.out.println("by zhangyta for test��s9493_query.jsp===========����ʱ�䣺"+nowTime+"========================= s_function_code��"+s_function_code);
		%>
		<!--
		<script language="javascript">alert("test s_function_code is "+"<%=s_function_code%>");</script>
		-->
		<%
%>	
<wtc:service name="TlsPubSelCrm"   retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:param value="<%=inParas1[0]%>"/>
			<wtc:param value="<%=inParas1[1]%>"/>	
		</wtc:service>
<wtc:array id="retList" scope="end" />	
		
<%
		result = retList;
		
%>
 
<HTML>
<HEAD>
<title>��Ʊ��Ϣ��ѯ</title>

 

</HEAD>

<BODY>
<FORM action="" method="post" name="frm">
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��Ʊ��Ϣ</div>
		</div>
 <%	if(retList.length != 0)
 // 88-168��Ӧ ��opcodeȥ����
 {%>
    <script language="javascript">//alert("t = "+"<%=retList.length%>");</script>
	<table cellspacing="0">
   <%
	 /*
		 if(s_function_code.equals("2289")||s_function_code.equals("8379")||s_function_code.equals("1220")||s_function_code.equals("8027")||s_function_code.equals("8379"))
		 {
				
		 }
		 else
		 {
		 }
	 */
	 //xl add 4130
	 
     if(s_function_code.equals("q046") || s_function_code.equals("1220"))
     {
     	 %>
       <tr>
       	  <td class="blue" width="15%">�ɷ����ڣ�<%=result[8][0]%>��<%=result[9][0]%>��<%=result[10][0]%>��</td>
			   
			    <td class="blue" width="15%">���ţ�<%=result[0][0]%></td>
			 </tr>
       <tr>
	   <%
     }
 	else
 	{
			   		String date = result[1][0];
   %>
       <tr>
       	  <td class="blue" width="15%">�ɷ����ڣ�<%=date.substring(0,4)%>��<%=date.substring(4,6)%>��<%=date.substring(6,8)%>��</td>
			   
			    <td class="blue" width="15%">���ţ�<%=result[0][0]%></td>
			 </tr>
       <tr>
	  <%
	}		 
				
		 if(s_function_code.equals("3172"))
		 {
					%>
					 <td class="blue" width="15%">�ɷ��˺ţ�<%=result[3][0]%></td>
			    <td class="blue" width="15%"><%=result[4][0]%></td>
					<%
		 }else if(s_function_code.equals("q046"))
		 {
		 	%>
			  <td class="blue" width="15%">�ɷѺ��룺<%=result[13][0]%></td>
			    <td class="blue" width="15%">&nbsp;</td>
			 <%		 
		 }
		 else
	     {
			 %>
			  <td class="blue" width="15%">�ɷѺ��룺<%=result[2][0]%></td>
			    <td class="blue" width="15%"><%=result[4][0]%></td>
			 <%
		 }	
	   %>
         
    </tr>
    <tr>
    <%
     if(s_function_code.equals("q046"))
     {
     %>
         <td class="blue" width="15%">�ɷѽ��(��д)��<%=result[16][0]%></td>
     <%    
     }
 	else
 	{
 	  %>
 	      <td class="blue" width="15%">�ɷѽ��(��д)��<%=result[5][0]%></td>
 	 <%     
 	}
          
	 
	 if(retList.length==13)
	 {
	    %>
          <td class="blue" width="15%">�ɷѽ��(Сд)��: <%=result[7][0]%></td>
			  
		<%
	 }else if(s_function_code.equals("q046"))
	 {
	 		%>
          <td class="blue" width="15%">�ɷѽ��(Сд)��: <%=result[17][0]%></td>
			  
				<%
	 }
	 
	 else{
				%>
          <td class="blue" width="15%">�ɷѽ��(Сд)��: <%=result[6][0]%></td>
			  
				<%
	}   
	   %>		
		</tr>
       <%
       if(retList.length>7)
       {
       %>
       
       <tr>
          <%
          if(retList.length>12 &&(!s_function_code.equals("q046")) &&(!s_function_code.equals("1321"))&&(!s_function_code.equals("1354"))&&(!s_function_code.equals("1356")) &&(!s_function_code.equals("1362"))&&(!s_function_code.equals("1366"))&&(!s_function_code.equals("1352"))&&(!s_function_code.equals("1370"))&&(!s_function_code.equals("1378"))&&(!s_function_code.equals("1779"))&&(!s_function_code.equals("d340")))
          {
          %>
           <td class="blue" width="15%"><%=result[7][0]%> </td>
			     <td class="blue" width="15%"><%=result[8][0]%></td>
			  
		<%
			   }	
		else if (s_function_code.equals("1354")||s_function_code.equals("1356")||s_function_code.equals("1352")||(s_function_code.equals("1362"))||(s_function_code.equals("1366"))||(s_function_code.equals("1370"))||(s_function_code.equals("1378"))||(s_function_code.equals("1779"))&&(s_function_code.equals("d340"))){
				%>
				 <!--���1321���޸�-->
				 <td class="blue" width="15%">�˺ţ�<%=result[3][0]%></td>
			     <td class="blue" width="15%"> <%=result[8][0]%> </td>
			  
				<%
			}
		else if (s_function_code.equals("q046")){
				%>
				 <!--���q046���޸�-->
				 <td class="blue" width="15%"><%=result[19][0]%></td>
			     <td class="blue" width="15%">���ν��ѽ� <%=result[20][0]%>&nbsp;&nbsp;<%=result[21][0]%>&nbsp;&nbsp;<%=result[22][0]%> </td>
			  
				<%
			}
		else{
				%>
				 <!--���1321���޸�-->
				 <td class="blue" width="15%">�˺ţ�<%=result[3][0]%></td>
			     <td class="blue" width="15%"> <%=result[11][0]%> </td>
			  
				<%
			}   
	   %>		
       </tr>
       <tr>
          <%if(retList.length>15 && retList.length!=32  ){%>
           <td class="blue" width="15%">��Ʊ����:<%=result[24][0]%></td>
			     <td class="blue" width="15%">��Ʊ����:<%=result[23][0]%></td>
			  
		<%
			   }
		 
		else if (retList.length==15)
			  	{
			  	 %>
				  <td class="blue" width="15%">��Ʊ����:<%=result[14][0]%></td>
			      <td class="blue" width="15%">��Ʊ����:<%=result[13][0]%></td>
			  
				   <%
			  	}
			  else if (retList.length==13)
			  	{
			  	 %>
				  <td class="blue" width="15%">��Ʊ����:<%=result[12][0]%></td>
			      <td class="blue" width="15%">��Ʊ����:<%=result[11][0]%></td>
			  
				   <%
			  	}
			   	else if(retList.length==11){
				%>
           <td class="blue" width="15%">��Ʊ����:<%=result[10][0]%></td>
			     <td class="blue" width="15%">��Ʊ����:<%=result[9][0]%></td>
			  
				<%
			} 
				else if(retList.length==14){//1321
				%>
           <td class="blue" width="15%">��Ʊ����:<%=result[13][0]%></td>
			     <td class="blue" width="15%">��Ʊ����:<%=result[12][0]%></td>
			  
				<%
			}
		 else if(retList.length==32){//Ӫ������
				%>
           <td class="blue" width="15%">��Ʊ����:<%=result[31][0]%></td>
			     <td class="blue" width="15%">��Ʊ����:<%=result[30][0]%></td>
			  
				<%
			}
			else{
				%>
           <td class="blue" width="15%">��Ʊ����:<%=result[8][0]%></td>
			     <td class="blue" width="15%">��Ʊ����:<%=result[7][0]%></td>
			  
				<%
			} 	

	   %>		
       </tr>
      <!--
	   <tr>
          <td class="blue" width="15%">�û�������<%//=result[15][0]%></td>
		  <td class="blue" width="15%">ҵ�����ƣ�<%//=result[15][0]%></td>
       </tr>
	   -->
	   <tr>
		<td class="blue" colspan=2>ҵ�����ƣ�<%=s_function_name%> </td>
	   </tr>
       <tr>
          <%
			if(  (!s_function_code.equals("q046"))&& (!s_function_code.equals("1378"))&& (!s_function_code.equals("4130"))&&(!s_function_code.equals("1779"))  &&(!s_function_code.equals("1321"))&&(!s_function_code.equals("1322"))&&(!s_function_code.equals("3172"))&&(!s_function_code.equals("5255")) )
			{
				%>
				<td class="blue" colspan=2>��ע��Ϣ��<%=result[11][0]%> <%=result[12][0]%> <%=result[9][0]%> <%=result[10][0]%> <%=result[13][0]%> <%=result[14][0]%> <%=result[15][0]%> <%=result[16][0]%> <%=result[17][0]%> <%=result[18][0]%> <%=result[19][0]%> <%=result[20][0]%> <%=result[21][0]%> <%=result[22][0]%> </td>
				<%
			}
			else if(s_function_code.equals("q046"))
		    {
				%>
				<td class="blue" colspan=2>��ע��Ϣ��<%=result[24][0]%> �û�������<%=result[11][0]%> ҵ�����ƣ�����</td>
				<%
			}
			else if(s_function_code.equals("1378"))
		    {
				%>
				<td class="blue" colspan=2>��ע��Ϣ��<%=result[7][0]%> �û�������<%=result[3][0]%> ҵ�����ƣ�Ƿ�Ѵ߽�</td>
				<%
			}
			else if(s_function_code.equals("1779"))
		    {
				%>
				<td class="blue" colspan=2>��ע��Ϣ��<%=result[7][0]%> <%=result[8][0]%> �û�������<%=result[3][0]%> ҵ�����ƣ�Ƿ�ѳ���</td>
				<%
			}
		 
			else if(s_function_code.equals("1322"))
		    {
				%>
				<td class="blue" colspan=2>��ע��Ϣ��<%=result[8][0]%> <%=result[11][0]%> </td>
				<%
			}	
            else if(s_function_code.equals("3172"))
		    {
				%>
				<td class="blue" colspan=2>��ע��Ϣ��<%=result[12][0]%> <%=result[11][0]%> </td>
				<%
			}
			else if(s_function_code.equals("5255"))
		    {
				%>
				<td class="blue" colspan=2>��ע��Ϣ��<%=result[12][0]%> <%=result[11][0]%> �û��˺ţ�<%=result[3][0]%> <%=result[9][0]%></td>
				<%
			}
			else
		    {
				%>
				<td class="blue" colspan=2>��ע��Ϣ��<%=result[9][0]%> <%=result[10][0]%> </td>
				<%
			}
		  %>
	   </tr>
	 
       <%}%>
    </table>
      <%
	}
	   else{	%>
      <table cellspacing="0">
       <tr>
          <td class="blue" align="center">�޷�Ʊ��Ϣ</td>
       </tr>
	   
      </table>
      <%}%>
	  <table cellspacing="0">
		<tr>
			<td id="footer" align="center" colspan="2">           
			
				<input class="b_foot" name=reset type=reset value=���� onclick="window.location.href='s9493.jsp?opCode=9493&opName=��Ʊ��Ϣ��ѯ&crmActiveOpCode=9493'">
			</td>
		</tr>
	  </table> 
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
