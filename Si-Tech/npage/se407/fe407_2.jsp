<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��վԤԼ�����ѯ
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
String opCode="e407";
String opName="��վԤԼ�����ѯ";
String region_code = (String)session.getAttribute("regCode");
String phone_no=		request.getParameter("phone_no");		
String booking_id=		request.getParameter("booking_id");	

/*������Ϣ*/
String serviceName = "sE385Qry";
String sevRouteValue = region_code;
String outnum = "7";

/*��׼���*/
String iLoginAccept=	"";
String iChnSource=		"";
String iOpCode=      	opCode;
String iLoginNo=		work_no;       								/*��ѯ����*/
String iLoginPwd=		"";     
String iPhoneNo=		phone_no;										/*��׼��Σ���ʱ����*/    
String iUserPwd=   		"";										/*��׼��Σ���ʱ����*/

String inOpNote=		"";								/*��ʼʱ�� YYYY-MM-DD HH:mi:ss*/
String iIdIccid=		"";
String inLoginAccept=	booking_id;

System.out.println("zhangyan add iLoginAccept= 	["+iLoginAccept+"]");
System.out.println("zhangyan add iChnSource = 	["+iChnSource+"]");
System.out.println("zhangyan add iOpCode = 		["+iOpCode+"]");
System.out.println("zhangyan add iLoginNo = 	["+iLoginNo+"]");
System.out.println("zhangyan add iLoginPwd = 	["+iLoginPwd+"]");
System.out.println("zhangyan add iPhoneNo = 	["+iPhoneNo+"]");
System.out.println("zhangyan add iUserPwd = 	["+iUserPwd+"]");

System.out.println("zhangyan add inOpNote = 	["+inOpNote+"]");
System.out.println("zhangyan add iIdIccid = 	["+iIdIccid+"]");
System.out.println("zhangyan add inLoginAccept=	["+inLoginAccept+"]");
%>

<wtc:service name="sE385QryAll" routerKey="regionCode" routerValue="<%=region_code%>" 
	retcode="retcode" retmsg="retmsg"  outnum="9">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>	
			
		<wtc:param value="<%=inOpNote%>"/>
		<wtc:param value="<%=iIdIccid%>"/>
		<wtc:param value="<%=inLoginAccept%>"/>				
</wtc:service>
<wtc:array id="resultList" scope="end" />

<%
	System.out.println("zhangyan add resultList.length =["+resultList.length+"]");
	for ( int i=0; i< resultList.length ; i++)
	{
		System.out.println("zhangyan add resultList[i][5]=["+resultList[i][5]+"]");
	}
	

	if (!"000000".equals(retcode)  )
	{
		System.out.println("zhangyan add retcode = 	["+retcode+"]");
		%>
			<script>
			rdShowMessageDialog(retcode+":"+retmsg , 0);
			history.go(-1);
			</script>
		<%
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-ҵ���ѯ-��վԤԼ�����ѯ</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script>

</script>
</head>
<body>
<div id="divBody">
<form action="" method=post name="form1">  
	<DIV id="Operation_Table">   
		<div class="title">
			<div id="title_zi">��վԤԼ�����ѯ
		</div>
	</div>

	<table cellspacing="0" id = "tabList">
	<tr>
		<th class="blue">ҵ������</th>
		<th class="blue">ԤԼID</th>
		<th class="blue">�ֻ�����</th>
		<th class="blue">֤������</th>
		<th class="blue">Ӫҵ������</th>
		<th class="blue">�Ƿ���Ч</th>	
		<th class="blue">�鿴��ϸ</th>	
	</tr>
	<%
		for ( int i = 0 ; i < resultList.length ; i ++  )
		{
		%>
		<tr>
			<td ><%=resultList[i][6]%></td>
			<td ><%=resultList[i][1]%></td>
			<td ><%=resultList[i][2]%></td>
			<td ><%=resultList[i][4]%></td>
			<td ><%=resultList[i][8]%></td>
			<td ><%=resultList[i][7]%></td>
			<td >
				<input type="button" class="b_text" 
					name="getDetail" id="getDetail" value=" �� ѯ "
					onClick="showDetail('<%=resultList[i][1]%>' , '<%=resultList[i][0]%>');">

			</td>
		</tr>	
		<%
		}
	%>

	<tr>
		<td align=center colspan="8"> 
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
	
	
	function showDetail(bookingId , bookingOpCode)
	{
		var bookingInfo = new Object();
		bookingInfo.id = bookingId;
        window.showModalDialog("fe407_3.jsp?rnd="+Math.random()
        	+"&bookingId="+bookingId
        	+"&bookingOpCode="+bookingOpCode,bookingInfo,
        	"dialogWidth=600px;dialogHeight=400px");
	}
	
	var excelObj;
	function printTable(obj)
	{
		
		var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		total_row = 0;
		if(document.all.tabList.length > 1)	/*���table*/
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
						cells=obj.rows[i].cells.length-1 	;
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



