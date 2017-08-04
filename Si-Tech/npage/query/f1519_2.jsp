<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name_boss.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
	String phone_no=request.getParameter("phoneNo");
	String begin_ym=request.getParameter("begin_ym");
	String end_ym=request.getParameter("end_ym");
	String work_no=request.getParameter("work_no");
	String work_name=request.getParameter("work_name");
	String opCode = request.getParameter("opcode");
	String opName = request.getParameter("opname");
	//号码、ID、姓名
	String sql_str="select a.phone_no,to_char(a.id_no),c.cust_name,to_char(a.cust_id) from dCustMsgdead a,dCustDoc c where a.phone_no='"+phone_no+"' and a.cust_id=c.cust_id and substr(a.run_code,2,1) in('a','b')" ;
	ArrayList arlist = new ArrayList();
	
	System.out.println("AAAAAAAAAAAAAAAAA sql is "+sql_str+" and phone_no is "+phone_no);
	%>
		<wtc:pubselect name="TlsPubSelBoss"  outnum="4">
		<wtc:sql><%=sql_str%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
<%
	String [][] result = new String[][]{{"0","1","2","3"}};
	//int result_row = Integer.parseInt((String)arlist.get(1));
    int result_row =result1.length;
//System.out.println("result_row=["+result_row+"]");
	if (result_row==0)
	{
%>
 
<script language="JavaScript">
	rdShowMessageDialog("<br>没有符合条件的数据");
	history.go(-1);
</script>
<%	}else
	{
	//	result = (String[][])arlist.get(0);
		 result =result1;
		//if(result_row==1)
		//{
			//response.sendRedirect("f1519_3.jsp?phone_no="+phone_no+"&id_no="+result[0][1]+"&begin_ym="+begin_ym+"&end_ym="+end_ym+"&work_no="+work_no+"&work_name="+work_name);
		//}
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>陈帐查询</TITLE>
 
</HEAD>
<body>

<%@ include file="/npage/include/header.jsp" %>

<FORM method=post name="frm1519_2">
<input type="hidden"  name="phone_no" value="<%= phone_no %>">
<input type="hidden"  name="id_no" value="<%= result[0][1] %>">
<input type="hidden"  name="cus_id" value="<%= result[0][3] %>">
<input type="hidden"  name="begin_ym" value="<%= begin_ym %>">
<input type="hidden"  name="end_ym" value="<%= end_ym %>">
<input type="hidden"  name="work_no" value="<%= work_no %>">
<input type="hidden"  name="work_name" value="<%= work_name %>">
<input type="hidden"  name="opCode" value="<%=opCode %>">
<input type="hidden"  name="opName" value="<%= opName %>">
<div class="title">
			<div id="title_zi">陈账查询</div>
		</div>
<table>
  <tr>
    <td  >
      
      
      <table  >
        <tr>
          <td>
            <TABLE >
            
                <tr> 
                  <td width="15%"  class="blue">手机号码</td>
                  <td width="15%"  class="blue">用户ID</td>
                  <td width="40%"  class="blue">客户姓名</td>
                  <td width="20%"  class="blue">客户ID</td>
                </tr>
<%	      for(int y=0;y<result.length;y++)
	      {
%>
	        <tr >
<%    	        for(int j=0;j<result[0].length;j++)
	        {
%>
	          <td height="25" ><a href="f1519_3.jsp?phone_no=<%=result[y][0]%>&id_no=<%=result[y][1]%>&begin_ym=<%=begin_ym%>&end_ym=<%=end_ym%>&work_no=<%=work_no%>&work_name=<%=work_name%>&cus_id=<%=result[y][3]%>"><%= result[y][j]%></a></td>
<%	        }
%>
	        </tr>
<%	      }
%>
            
	    </TABLE>
          </td>
        </tr>
      </table>
      <table  >
       
          <tr  > 
      	    <td align="center">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
      
      </table>
     
    </td>
  </tr>
</table>

</FORM>
</BODY></HTML>

