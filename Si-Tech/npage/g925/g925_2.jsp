<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
String opCode = "g925";
String opName = "С���������������˷�";
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//��������
String nopass =(String)session.getAttribute("password");
String regionCode = orgcode.substring(0,2);
String op_code = "g925"  ;
String phone_no = request.getParameter("phoneno");
String year_month = request.getParameter("year_month");

String[] inPutArray = new String[2];
inPutArray[0]="select to_char(phone_no),to_char(statis_month),to_char(sum(flow_fee)),to_char(sum(flow_count)) from dflowfilemsg where phone_no=:s_phone_no and statis_month =:s_month group by phone_no,statis_month";
inPutArray[1]="s_phone_no="+phone_no+",s_month="+year_month; 
%>
	<wtc:service name="TlsPubSelBoss" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="4" >
		<wtc:param value="<%=inPutArray[0]%>"/> 
		<wtc:param value="<%=inPutArray[1]%>"/> 
 
	 
	</wtc:service>
	<wtc:array id="result" scope="end"/>
 
<%   
	 
	if(result==null||result.length==0){
		%>
			 <script language="javascript">
				rdShowMessageDialog("��ѯ���Ϊ��.�����²�ѯ",0);
				window.location.href="g925_1.jsp?activePhone=<%=phone_no%>";
			</script>
		<% 
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~g925 ������Ϣ");
	}
	
	else
	{
		System.out.println("success~~~~~~~~~~~~~~~~~~~~~~~~~ !");
		%>
		<html xmlns="http://www.w3.org/1999/xhtml">
			<HEAD><TITLE>Ŀ��ͻ��˷Ѳ�ѯ</TITLE>
			</HEAD>
			<body>
			<FORM method=post name="frm1508_2">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">��ѯ���</div>
			</div>
			<table cellspacing="0" id = "PrintA">
                <tr>
					<th>Ŀ��ͻ��ֻ�����</th>
					<th>ͳ������</th>
					<th>��������</th>
					<th>����(KB)</th>
					<th>����</th> 
				</tr>
				<%
					for(int i=0;i<result.length;i++)
					{
						%>
						<tr>
							<td><%=result[i][0]%></td>
							<td><%=result[i][1]%></td>
							<td><%=result[i][2]%></td>
							<td><%=result[i][3]%></td>
							<td><input type="button" class="b_foot" value="�˷�" onclick="deletes('<%=result[i][0]%>','<%=result[i][1]%>','<%=result[i][2]%>')"></td>
						</tr>
						<%
					}
				%>
				
				
			</table>
			
			<table cellSpacing="0">
				<tr> 
				  <td id="footer"> 
				  
					   <input type="button" name="back" class="b_foot" value="����" onclick="window.location.href='g925_1.jsp'" >
					  &nbsp;
					 
				  </td>
				</tr>
			 </table>
		<%@ include file="/npage/include/footer.jsp" %>
		<script language="javascript">
			function deletes(phone_no,year_month,fee)
			{
			   var prtFlag=0;
			   if(fee>10)
			   {
				   rdShowMessageDialog("�˷ѽ����10Ԫ�������Խ����˷Ѳ���!");
				   return false;
			   }	
			   prtFlag = rdShowConfirmDialog("Ŀ��ͻ�"+phone_no+" "+year_month+"�˷�"+fee+"Ԫ,�Ƿ�ȷ���˷�?");
			   if (prtFlag==1)
			   {
				  //alert("qq "+phone_no+" and year_month is "+year_month);
				  document.frm1508_2.action="g925_3.jsp?phoneno="+phone_no+"&year_month="+year_month+"&fee="+fee;
				  //alert("qqq");
				  document.frm1508_2.submit();
			   }
			   else
			   {
				  return false;
			   }	
			}				  
		</script>
			</FORM>
		</BODY>


		</HTML>
			 
		<% 
	}
	 
	
%>
 



