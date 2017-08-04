<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Calendar"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
 

<%
 String opCode = "zg30";
  String opName = "增值税专票打印传递单"; 
String workno = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

String[] inParas2 = new String[2];
inParas2[0]="select to_char(tax_invoice_num),to_char(tax_invoice_code),vterminal,vapplyloginno,vexamineloginno from winvoiceopr where vapplyloginno=:s_no ";
inParas2[1]="s_no="+	workno; 
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
	if(ret_val.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询结果不存在");
				history.go(-1);
			</script>
		<%
	}
	else
	{
		%>
		<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=opName%></TITLE>
 
<link rel="stylesheet" href="../e610/reset.css" media="all" />
<link rel="stylesheet" href="../e610/bills1.css" media="all" />
<link rel="stylesheet" href="../e610/print-reset.css" media="print" />
 
</HEAD>
<BODY>
<!-------------------                  新账单内容开始                   <div id="article"> -------------------------->

<div  id="article">
 
 <div align="center"><h2><b>增值税税控发票内部传递单</b></h2></div> 
	<table width="94%" border="0" cellpadding="0" cellspacing="0" class="left table-01" >
    
      <tr>
         <td>
			发票代码
		 </td>
		 <td>
			发票号码
		 </td>
		 <td>
			开票终端
		 </td>
		 <td>
			开票人
		 </td>
		 <td>
			申请人
		 </td>
		 <td>
			接收人
		 </td>
		 <td>
			接收日期
		 </td>
	  </tr>
	  <%
 
			//for(int i =0;i<Integer.parseInt(len_check);i++)
			for(int i =0;i<ret_val.length;i++)
			{
				%>
					<tr>
						<td><%=ret_val[i][0]%></td>
						<td><%=ret_val[i][1]%></td>
						<td><%=ret_val[i][2]%></td>
						<td><%=ret_val[i][3]%></td>
						<td><%=ret_val[i][4]%></td>
						<td></td>
						<td></td>
					</tr>
				<%
			}
			 
	 %>
     
						 
	   
	
    </table>
 

  
 	

 <table align="center">
	<div align="center">
		<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" width="0" height="0" id="wb" name="wb"></OBJECT> 
		<object ID='WebBrowser' style="display:none" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' VIEWASTEXT></object>
		<object id=factory viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
	  codebase="smsx.cab#Version=6,3,436,14">
		</object>
	 
		<input type="button" name="print"  class="b_foot" value="打印" onclick="javascript:window.print();" align="center">
	 
		 &nbsp;&nbsp;&nbsp;&nbsp;
		 <input type="button"  class="b_foot"value="返回" title="返回" onClick="window.location='zg30_1.jsp?opCode=zg30&opName=增值税专票打印传递单'" align="center"/>
		 &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button"  class="b_foot"value="关闭" title="关闭" onClick="window.close()" align="center"/>
	</div>

	</table>

	 
 
		 
	</div>
</div>

 

<!-------------------                  新账单内容结束                    -------------------------->

</BODY>
</HTML>
		<%
	}
%>




 