<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: Ͷ���˷Ѳ�ѯ-���ݽ����ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2009-08-10
�� * ����: zhangshuaia
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=GBK"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>

<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "g431";
 		String opName = "ǩԼ�û��۷ѽ���ѯ";
		 
		/**��ҪregionCode���������·��**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
 
		//xl add for �û�����
  
	String custPass = request.getParameter("custPass");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAaa custPass is "+custPass);
	custPass = Encrypt.encrypt(custPass);
	

%>
	 
<%
		 					
		
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));
		String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
		String end_time = WtcUtil.repNull(request.getParameter("end_time"));	
		String login_no = WtcUtil.repNull(request.getParameter("login_no"));	
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));			
		String nopass = (String)session.getAttribute("password"); 
		System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbb custPass is "+custPass+" and nopass is "+nopass);  
		 
		String[][] result1  = null ;
%>
		<wtc:service name="sg431Qry"  routerKey="region"  routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="5"> 
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=custPass%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=nopass%>"/>
		</wtc:service> 
		<wtc:array id="sVerifyTypeArr1"   scope="end"/> 
 
<%	
result1 = sVerifyTypeArr1;
System.out.println("retCode===="+retCode5);
System.out.println("retMsg===="+retMsg5);
System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSS result1.length=" + result1.length);
	if(retCode5=="000000" ||retCode5.equals("000000") )
	{
		%>
			
			<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>ǩԼ�û��۷ѷ�ֵ��ѯ</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>�ֻ�����</th>
				  <th>ǩԼ��ʶ</th>
                  <th>ǩԼʱ��</th> 
				  <th>�۷ѽ��</th>
				  <th>��ֵ</th>
				  <th>����</th>
				</tr>
			<tr>
				<td><%=phone_no%></td>
				<%
					if(result1[0][0].equals("1"))
					{
						%>
							<td>ǩԼ�û�</td>
						<%
					}
					if(result1[0][0].equals("0"))
					{
						%>
							<td>��ǩԼ�û�</td>
						<%
					}
				%>
			 
				<td><%=result1[0][1]%></td>
				<td><%=result1[0][2]%></td>
				<td><%=result1[0][3]%></td>
				<%
					if(result1[0][4].equals("1"))
					{
						%>
							<td>��</td>
						<%
					}
					if(result1[0][4].equals("0"))
					{
						%>
							<td>��</td>
						<%
					}
				%>
			 
			</tr>			

         
          <tr id="footer"> 
      	    <td colspan="9">
     
			  <input class="b_foot" name=back onClick="window.location = 'g431.jsp' " type=button value=����>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
			  
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
		<%
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("�û���ѯʧ��!"+"�������"+"<%=retCode5%>"+",����ԭ��"+"<%=retMsg5%>");
				window.location="g431.jsp";
			</script>
		<%
	}
	
%>
 
 