<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ע��������ѯ-���ݽ����ѯ��Ϣ
�� * �汾: 
�� * ����: 2009-05-26
�� * ����: dujl
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**��Ҫ�������.�������ҳ��,��ɾ��**/
response.setHeader("Pragma","No-Cache"); 
response.setHeader("Cache-Control","No-Cache");
response.setDateHeader("Expires", 0); 

String opCode = "9648";
String opName = "ע��������ѯ";

/**��ҪregionCode���������·��**/
String regionCode  = (String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");

 
String op_code = WtcUtil.repNull(request.getParameter("op_code1"));
String op_time_begin = WtcUtil.repNull(request.getParameter("op_time_begin1"));
String op_time_end = WtcUtil.repNull(request.getParameter("op_time_end1"));
String region_code = WtcUtil.repNull(request.getParameter("region_code1"));

%>
<wtc:service  name="s9648Qry"  routerKey="region"  routerValue="<%=regionCode%>" outnum="14">
	<wtc:param  value="1"/>
	<wtc:param  value="<%=op_code%>"/>
	<wtc:param  value="<%=region_code%>"/>
	<wtc:param  value="<%=op_time_begin%>"/>
	<wtc:param  value="<%=op_time_end%>"/>
	<wtc:param  value=""/>
	<wtc:param  value=""/>
	<wtc:param  value=""/>
	<wtc:param  value=""/>	     		
</wtc:service>
<wtc:array  id="sVerifyTypeArr1" start="0" length="2"  scope="end"/>
<wtc:array  id="sVerifyTypeArr" start="2" length="11"  scope="end"/>
<%	
System.out.println("retCode===="+retCode);
System.out.println("retMsg===="+retMsg);
System.out.println("sVerifyTypeArr.length=" + sVerifyTypeArr.length);
%>

<html>
<head>
<title><%=opName%></title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<script language="javascript">
<!--

//-->
</script>
</head>
<body>
	<div id="Operation_Table">
		<table cellspacing="0" id="tabList" vColorTr='set'>
			<tr align="center">
				<th nowrap>�������</th>
				<th nowrap>��������</th>
				<th nowrap>��������</th> 
				<th nowrap>ע����������</th>
				<th nowrap>���ѷ�ʽ</th>
				<th nowrap>��ӡѡ��</th>
				<th nowrap>��Чʱ��</th>
				<th nowrap>ʧЧʱ��</th>
				<th nowrap>���õ�λ</th>
				<th nowrap>������</th>
				<th nowrap>��������</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
				
			}else if(sVerifyTypeArr.length>0)
			{
				for(int i=0;i<sVerifyTypeArr.length;i++)
				{
	%>
					<tr align="center">
						<td ><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][10]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
					</tr>
	<%				
				}
			}
	%>
 		</table>
 		<table>
			<tr>
				<td>
					<div align="center">
					<input class="b_foot" name="sure" type="button" value="����" onClick="printTable(tabList);">
					</div>
				</td>
			</tr>
		</table>
  	</div>
  	
</body>
</html>    

<script>
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	{
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
