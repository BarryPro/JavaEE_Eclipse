<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String opCode="zg88";
	String opName="���ּ���������";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String contextPath = request.getContextPath();
	String pass = (String)session.getAttribute("password");
	
	//������� 
	String phone_no = request.getParameter("phone_no");
	 
%>

<wtc:service name="sQryRuleById" routerKey="region" routerValue="<%=regionCode%>" retcode="g089CfmCode" retmsg="g089CfmMsg" outnum="13" >
    <wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="r_return_code" scope="end" start="0"  length="2" />
<wtc:array id="r_return_detail" scope="end" start="2"  length="11" />
<%
	String retCode= g089CfmCode;
	String retMsg = g089CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = g089CfmMsg;
	if ( g089CfmCode.equals("000000"))
	{
 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>��ѯ���</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>���ּƻ���ʶ</th>
				  <th>������Ϣ</th>
                  <th>Ʒ����Ϣ</th> 
				  <th>��������</th>
				  <th>����Ҫ��</th>
				  <th>����Ҫ��ֵ</th>
				  <th>��Сֵ</th>
				  <th>���ֵ</th>
				  <th>���ֱ���</th>
				  <th>��Чʱ��</th>
				  <th>ʧЧʱ��</th>
				</tr>
<%
				for(int i=0;i<r_return_detail.length;i++)
				{
					%>
						<tr>
							<td><%=r_return_detail[i][0]%></td>
							<td><%=r_return_detail[i][1]%></td>
							<td><%=r_return_detail[i][2]%></td>
							<td><%=r_return_detail[i][3]%></td>
							<td><%=r_return_detail[i][4]%></td>
							<td><%=r_return_detail[i][5]%></td>
							<td><%=r_return_detail[i][6]%></td>
							<td><%=r_return_detail[i][7]%></td>
							<td><%=r_return_detail[i][8]%></td>
							<td><%=r_return_detail[i][9]%></td>
							<td><%=r_return_detail[i][10]%></td>
				
 
						</tr>
					<%
				}

%>

         
          <tr id="footer"> 
      	    <td colspan="15">
    	      <input class="b_foot" name=back onClick="window.location = 'zg88_1.jsp' " type=button value=����>
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
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��ѯʧ��: <%=retMsg%>,<%=g089CfmCode%>",0);
	window.location="zg88_1.jsp?opCode=g089&opName=���ź����������";
	</script>
<%}
%>
