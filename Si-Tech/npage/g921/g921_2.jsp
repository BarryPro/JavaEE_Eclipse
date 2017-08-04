<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "g921";
    String opName = "飞豆充值记录查询";
	 
	  String phoneno=request.getParameter("phoneno");
	  //开始 结束
	  String print_begin = request.getParameter("print_begin");
	  String print_end = request.getParameter("print_end");
	 
	
	
		String[] inParas2 = new String[2];
		inParas2[0]="select to_char(phone_no),to_char(op_time,'YYYYMMDD hh24:mi:ss'),to_char(pay_money,'fm999999990.999999999') from wflybeansoprhis where phone_no = :s_phone and to_char(op_time,'YYYYMM')<=:s_end and to_char(op_time,'YYYYMM')>=:s_begin ";
		inParas2[1]="s_phone="+phoneno+",s_end="+print_end+",s_begin="+print_begin;
%>
   
<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneno%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
<wtc:array id="ret_val" scope="end" />	 
 
<script language = "javascript">
	function toExcel(){
		 var oXL = new ActiveXObject("Excel.Application"); 
	　　 var oWB = oXL.Workbooks.Add(); 
	　　 var oSheet = oWB.ActiveSheet; 
	　　 var Lenr = PrintA.rows.length;
	　　 for (i=0;i<Lenr;i++) 
	　　 { 
	　　 var Lenc = PrintA.rows(i).cells.length; 
	　　 for (j=0;j<Lenc;j++) 
	　　 { 
	　　 oSheet.Cells(i+1,j+1).value = PrintA.rows(i).cells(j).innerText; 
	　　 } 
	　　 } 
	　　 oXL.Visible = true; 
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>飞豆充值记录查询结果</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">飞豆充值记录查询结果</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>手机号码</th>
				  <th>充值时间</th>
                  <th>充值金额(元)</th> 
				   
				  
                </tr>

<%//13603662712
	if(ret_val==null ||ret_val.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询结果为空，");
				window.location.href="g921_1.jsp?activePhone=<%=phoneno%>";
			</script>
		<%
	}
	else
	{
		for(int i=0;i<ret_val.length;i++)
		{
			%>
				<tr>
					<td>
						<%=ret_val[i][0]%>
					</td>
					<td>
						<%=ret_val[i][1]%>
					</td>
					<td>
						<%=ret_val[i][2]%>
					</td>
				</tr>
			<%
		}
	}
%>

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'g921_1.jsp?activePhone=<%=phoneno%>' " type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
			  <!--
			  <input class="b_foot" name=back onClick="toExcel();" type=button value=导出EXCEL>
    		  -->	
			</td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

