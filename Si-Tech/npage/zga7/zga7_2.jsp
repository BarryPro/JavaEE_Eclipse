<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zga7";
    String opName = "һ֤���Ƿ�Ѻ����ѯ";
	String phone_no=request.getParameter("phone_no");
//	phone_no="1";
 
%>
   
	 
 

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>һ֤���Ƿ�Ѻ����ѯ���չʾ</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">һ֤���Ƿ�Ѻ����ѯ���</div>
</div>

      <table cellspacing="0" id = "PrintA">
      <tr>
		<th>
			��ǰ��ѯ����:
		</th>
		<th>
			<%=phone_no%>
		</th>
	  </tr>
	  <tr>
		 
			<th>�ֻ�����</<th>
			<th>Ƿ�ѽ��</<th>
	 
	  </tr>          
 
<wtc:service name="szga7_Valid" routerKey="phone" routerValue="<%=phone_no%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="4" >
    <wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end" start="0"  length="2" />	
<wtc:array id="fee_code" scope="end" start="2"  length="2" />
<%
	if(s4141CfmCode=="000000" ||s4141CfmCode.equals("000000"))
	{
		if(fee_code.length>0)
		{
			
			for(int i=0;i<fee_code.length;i++)
			{
				%>
					<tr>
						 
						<td align="center">
							<%=fee_code[i][0]%>
						</td>
						 
						<td align="center">
							<%=fee_code[i][1]%>
						</td>
					</tr> 
				<%
			}
		}
		
		
	}
	else
	{
		%>
			<script language="javascript">
				//alert("��ֵ "+"<%=s4141CfmCode%>"+" and msg is "+"<%=s4141CfmMsg%>");
				rdShowMessageDialog("��ѯ����,�������:"+"<%=s4141CfmCode%>"+",����ԭ��:"+"<%=s4141CfmMsg%>");
				history.go(-1);
			</script>
		<%
	}

%>

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'zga7_1.jsp?activePhone=<%=phone_no%>'" type=button value=����>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
		 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

