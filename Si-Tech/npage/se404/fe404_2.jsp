<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ������Ϣ�ٱ���ѯ
   * �汾: 1.0
   * ����: 2011-11-8 8:15:06
   * ����: zhangyan
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String work_no =(String)session.getAttribute("workNo");//����
String opCode="e404";
String opName="������Ϣ�ٱ���ѯ";
String region_code = (String)session.getAttribute("regCode");
String phone_no=		request.getParameter("phone_no");		
String phone_no_pos=	request.getParameter("phone_no_pos");	
String login_no=		request.getParameter("login_no");	
String op_type=		request.getParameter("op_type");		
String begin_time=		request.getParameter("begin_time");	
String end_time=		request.getParameter("end_time");	
System.out.println("begin_time========================="+begin_time);
String iLoginAccept=		"";
String iChnSource=		"";
String iOpCode=        	opCode;
String iLoginNo=		work_no;       								/*��ѯ����*/
String iLoginPwd=		(String)session.getAttribute("password");     
String iPhoneNo=		"";										/*��׼��Σ���ʱ����*/    
String iUserPwd=   		"";										/*��׼��Σ���ʱ����*/
String iStartTime=		begin_time;								/*��ʼʱ�� YYYY-MM-DD HH:mi:ss*/
String iEndTime=		end_time;									/*����ʱ�� YYYY-MM-DD HH:mi:ss*/
String iProsType=		op_type;									/*�ٱ�����*/
String iOpPhoneNo=		phone_no;								/*�������*/
String iProsPhoneNo=	phone_no_pos;							/*���ٱ�����*/
String iProsLoginNo=	login_no;									/*�ٱ�����*/

System.out.println("zhangyan add iLoginAccept= 	["+iLoginAccept+"]");
System.out.println("zhangyan add iChnSource = 	["+iChnSource+"]");
System.out.println("zhangyan add iOpCode = 		["+iOpCode+"]");
System.out.println("zhangyan add iLoginNo = 		["+iLoginNo+"]");
System.out.println("zhangyan add iLoginPwd = 	["+iLoginPwd+"]");
System.out.println("zhangyan add iPhoneNo = 	["+iPhoneNo+"]");
System.out.println("zhangyan add iUserPwd = 	["+iUserPwd+"]");
System.out.println("zhangyan add iStartTime =	["+iStartTime+"]");
System.out.println("zhangyan add iEndTime = 	["+iEndTime+"]");
System.out.println("zhangyan add iProsType = 	["+iProsType+"]");
System.out.println("zhangyan add iOpPhoneNo = 	["+iOpPhoneNo+"]");
System.out.println("zhangyan add iProsPhoneNo = 	["+iProsPhoneNo+"]");
System.out.println("zhangyan add iProsLoginNo = 	["+iProsLoginNo+"]");
%>

<wtc:service name="sShoMsgProsQry" routerKey="regionCode" routerValue="<%=region_code%>" 
			retcode="errCode" retmsg="errMsg"  outnum="8">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iStartTime%>"/>
		<wtc:param value="<%=iEndTime%>"/>
		<wtc:param value="<%=iProsType%>"/>
		<wtc:param value="<%=iOpPhoneNo%>"/>
		<wtc:param value="<%=iProsPhoneNo%>"/>
		<wtc:param value="<%=iProsLoginNo%>"/>
</wtc:service>
<wtc:array id="arrsShoMsgProsQry" scope="end" />

<%
	if (!"000000".equals(errCode)  )
	{
		System.out.println("zhangyan add errCode = 	["+errCode+"]");
		%>
			<script>
			rdShowMessageDialog(errCode+":"+errMsg , 0);
			history.go(-1);
			</script>
		<%
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-ҵ���ѯ��������Ϣ�ٱ���ѯ���</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div id="divBody">
<form action="" method=post name="form1">   
	<DIV id="Operation_Table">   
		<div class="title">
			<div id="title_zi">������Ϣ�ٱ���ѯ
		</div>
	</div>
	<table id = "tabList">
	<tr>
		<th class="blue">�������</th>
		<th class="blue">���ٱ�����</th>
		<th class="blue">�ٱ�����</th>
		<th class="blue">�ٱ�����</th>
		<th class="blue">�ٱ�����</th>
		<th class="blue">����ʱ��</th>
	</tr>
	<%
		for ( int i = 0 ; i < arrsShoMsgProsQry.length ; i ++  )
		{
		%>
		<tr>
			<td class="blue"><%=arrsShoMsgProsQry[i][2]%></td>
			<td class="blue"><%=arrsShoMsgProsQry[i][3]%></td>
			<td class="blue"><%=arrsShoMsgProsQry[i][4]%></td>
			<td class="blue"><%=arrsShoMsgProsQry[i][1]%></td>
			<td class="blue"><%=arrsShoMsgProsQry[i][5]%></td>
			<td class="blue"><%=arrsShoMsgProsQry[i][0]%></td>
		</tr>	
		<%
		}
	%>

	<tr>
		<td align=center colspan="6"> 
			<input class="b_foot" name=sure  type=button value="����"  onClick="printTable(tabList)" >
			<input class="b_foot" name=close onClick="iframeClose()" type=button value=�ر�>
		</td>
	</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>

</form>
</div>
</body>
</html>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
	function iframeClose()
	{
		var 	divBody = document.getElementById("divBody");
		divBody.style.display="none"
	}
	
	
	var excelObj;
	function printTable(obj)
	{
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		total_row = 0;
		if(document.all.tabList.length > 1)	
		{
			excelObj = new ActiveXObject('excel.Application');
			excelObj.Visible = true;
 			excelObj.WorkBooks.Add;
			for(a=0;a<document.all.tabList.length;a++)
			{
				rows=obj[a].rows.length;
				if(rows>0)
				{
	 				try
					{
						for(i=0;i<rows;i++)					{
							cells=obj[a].rows[i].cells.length;
							for(j=0;j<cells;j++)
								excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
						}
					}
					catch(e)
					{
						//alert('����excelʧ��!');
					}
				}
				else
				{
					alert('no data');
	 			}
	 			total_row = eval(total_row+rows);
			}
		}
		else
		{
			excelObj = new ActiveXObject('excel.Application');
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			rows=obj.rows.length;
			if(rows>0)
			{
	 			try
				{
					for(i=0;i<rows;i++)
					{
						cells=obj.rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('����excelʧ��!');
				}
				total_row = eval(total_row+rows);
			}
			else
			{
				alert('no data');
			}
		}
	}
</script>



