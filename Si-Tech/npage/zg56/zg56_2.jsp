<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
 

<%
    String opCode = "zg56";
    String opName = "用户发票余额查询";
    String phoneNo=request.getParameter("phoneNo");
	String[] inParas2 = new String[2];
	inParas2[0]="select to_char(nvl(sum(left_money),0)) from dinvoice_left where phone_no=:s_no ";
	inParas2[1]="s_no="+phoneNo;
 
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />   

 
<%
	if(retCode1=="000000" ||retCode1.equals("000000"))
	{
		%>
		<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>自助终端查询结果</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>用户号码</th>
				  <th colspan="3">剩余可打印总金额</th>
				</tr>
				<tr>
					<td><%=phoneNo%></td>
					<td  colspan="3"><%=ret_val[0][0]%>元</td>
				</tr>
				 
         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'zg56_1.jsp?activePhone=<%=phoneNo%>' " type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
		 
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
				rdShowMessageDialog("查询结果为空！");
				return false;
			</script>
		<%
	}
%> 


