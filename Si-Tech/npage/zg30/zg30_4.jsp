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
  String opName = "��ֵ˰רƱ��ӡ���ݵ�"; 
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
				rdShowMessageDialog("��ѯ���������");
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
<!-------------------                  ���˵����ݿ�ʼ                   <div id="article"> -------------------------->

<div  id="article">
 
 <div align="center"><h2><b>��ֵ˰˰�ط�Ʊ�ڲ����ݵ�</b></h2></div> 
	<table width="94%" border="0" cellpadding="0" cellspacing="0" class="left table-01" >
    
      <tr>
         <td>
			��Ʊ����
		 </td>
		 <td>
			��Ʊ����
		 </td>
		 <td>
			��Ʊ�ն�
		 </td>
		 <td>
			��Ʊ��
		 </td>
		 <td>
			������
		 </td>
		 <td>
			������
		 </td>
		 <td>
			��������
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
	 
		<input type="button" name="print"  class="b_foot" value="��ӡ" onclick="javascript:window.print();" align="center">
	 
		 &nbsp;&nbsp;&nbsp;&nbsp;
		 <input type="button"  class="b_foot"value="����" title="����" onClick="window.location='zg30_1.jsp?opCode=zg30&opName=��ֵ˰רƱ��ӡ���ݵ�'" align="center"/>
		 &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button"  class="b_foot"value="�ر�" title="�ر�" onClick="window.close()" align="center"/>
	</div>

	</table>

	 
 
		 
	</div>
</div>

 

<!-------------------                  ���˵����ݽ���                    -------------------------->

</BODY>
</HTML>
		<%
	}
%>




 