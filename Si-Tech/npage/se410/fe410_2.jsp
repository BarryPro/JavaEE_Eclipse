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
String opCode="e410";
String opName="����ת�Ʋ�����־��ѯ";
String region_code = (String)session.getAttribute("regCode");
String phone_no=		request.getParameter("phone_no");		
String login_no=		request.getParameter("login_no");		
String begin_time=		request.getParameter("begin_time");	
String end_time=		request.getParameter("end_time");	
System.out.println("begin_time========================="+begin_time);
String iLoginAccept=	"";
String iChnSource=		"";
String iOpCode=        	opCode;
String iLoginNo=		work_no;       								/*��ѯ����*/
String iLoginPwd=		(String)session.getAttribute("password");     
String iPhoneNo=		"";										/*��׼��Σ���ʱ����*/    
String iUserPwd=   		"";										/*��׼��Σ���ʱ����*/


String iStartTime=begin_time;/*��ʼʱ�� YYYY-MM-DD HH:mi:ss*/
String iEndTime=end_time;/*����ʱ�� YYYY-MM-DD HH:mi:ss*/
String iShiftPhoneNo=phone_no;/*�������*/
String iOpLoginNo=login_no;/*��������*/

System.out.println("zhangyan add iLoginAccept= 	["+iLoginAccept+"]");
System.out.println("zhangyan add iChnSource = 	["+iChnSource+"]");
System.out.println("zhangyan add iOpCode = 	["+iOpCode+"]");
System.out.println("zhangyan add iLoginNo = 	["+iLoginNo+"]");
System.out.println("zhangyan add iLoginPwd = 	["+iLoginPwd+"]");
System.out.println("zhangyan add iPhoneNo = 	["+iPhoneNo+"]");
System.out.println("zhangyan add iUserPwd = 	["+iUserPwd+"]");
System.out.println("zhangyan add iStartTime =	["+iStartTime+"]");
System.out.println("zhangyan add iEndTime = 	["+iEndTime+"]");
System.out.println("zhangyan add iShiftPhoneNo = 	["+iShiftPhoneNo+"]");
System.out.println("zhangyan add iOpLoginNo = 	["+iOpLoginNo+"]");
%>

<wtc:service name="s1240Qry" routerKey="regionCode" routerValue="<%=region_code%>" 
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
		<wtc:param value="<%=iShiftPhoneNo%>"/>
		<wtc:param value="<%=iOpLoginNo%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end" />


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-ҵ���ѯ-����ת�Ʋ�����־��ѯ </title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div id="divBody">
<form action="" method=post name="form1">   
	<DIV id="Operation_Table">   
		<div class="title">
			<div id="title_zi">����ת�Ʋ�����־��ѯ 
		</div>
	</div>
	<table cellspacing="0" id = "tabList">
	<tr>
		<th class="blue">�ֻ�����</th>
		<th class="blue">��������</th>
		<th class="blue">����ʱ��</th>
		<th class="blue">��ת����</th>
		<th class="blue">��ת����</th>
		<th class="blue">��ת����</th>		
	</tr>
	<%
	for ( int i=0 ; i<resultList.length ; i++ )
	{
		if (resultList[i][4].equals("0"))
		{
			resultList[i][4]="ȡ��";
		}else if (  resultList[i][4].equals("1") )
		{
			resultList[i][4]="����";
		}else if (  resultList[i][4].equals("2") )
		{
			resultList[i][4]="ȡ��";
		}else if (  resultList[i][4].equals("3") )
		{
			resultList[i][4]="����";
		}else if (  resultList[i][4].equals("4") )
		{
			resultList[i][4]="ȡ��";
		}else if (  resultList[i][4].equals("5") )
		{
			resultList[i][4]="����";
		}
		
		if (  resultList[i][5].equals("51") )
		{
			resultList[i][5]="��������ת";
		}else if (  resultList[i][5].equals("52") )
		{
			resultList[i][5]="���ɼ���ת";
		}else if (  resultList[i][5].equals("53") )
		{
			resultList[i][5]="��Ӧ���ת";
		}else if (  resultList[i][5].equals("54") )
		{
			resultList[i][5]="��æ��ת";
		}
		
		
	%>
		<tr>
			<td ><%=resultList[i][1]%></td>
			<td ><%=resultList[i][3]%></td>			
			<td ><%=resultList[i][0]%></td>			
			<td ><%=resultList[i][4]%></td>	
			<td ><%=resultList[i][5]%></td>
			<td ><%=resultList[i][2]%></td>			
		</tr>		
	
	<%
	}
	%>
	
	<tr>
		<td align=center colspan="6"> 
			<input class="b_foot" name=sure  type=button value="����"  onClick="printTable(tabList)" >
			<input class="b_foot" name=close onClick="window.close()" type=button value=�ر�>
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



