<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����:���Ѷ��Ÿ��²�ѯ
   * ����: 2011/4/6
   * ����: ningtn
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = "d290";
	String opName = "���Ѷ��Ÿ��²�ѯ";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String beginTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String updateType = request.getParameter("opFlag");
	String msgCode = request.getParameter("msgCode");
	System.out.println("==fd290_2.jsp==" + beginTime + "|" + endTime+ "|" + updateType+ "|" + msgCode);
	
	String  inputParsm [] = new String[4];
	inputParsm[0] = beginTime;
	inputParsm[1] = endTime;
	inputParsm[2] = updateType;
	inputParsm[3] = msgCode;
%>	
  <wtc:service name="sd290Qry" routerKey="region" routerValue="<%=regionCode%>" 
  	 retcode="retCode2" retmsg="retMsg2" outnum="35">			
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	</wtc:service>
	<wtc:array id="tempArr1" start="0" length="10"  scope="end"/>
	<wtc:array id="tempArr2" start="10" length="10"  scope="end"/>
	<wtc:array id="tempArr3" start="20" length="15"  scope="end"/>
<%
	if(!(retCode2.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("������Ϣ:<%=retCode2%><%=retMsg2%>");
	 	history.go(-1);
		</script>
<%
		return;
	}
%>
<head>
<script language="JavaScript">
<!--
	$(document).ready(function(){
		var updateTypeVal = "<%=updateType%>";
		$("#addAndDelDiv").hide();
		$("#updateDiv").hide();
		if("A" == updateTypeVal || "D" == updateTypeVal){
			$("#addAndDelDiv").show();
		}else{
			$("#updateDiv").show();
		}
	});
-->
</script>

<title>���Ѷ��Ÿ��²�ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���Ѷ��Ÿ��²�ѯ</div>
	</div>
	<div id="addAndDelDiv">
		<table id="addTabList" cellspacing="0">
			<tr>
				<th>��������</th>
				<th>����ʱ��</th>
				<th>��������</th>
				<th>����ģ�����</th>
				<th>����ģ������</th>
				<th>������Ա��������</th>
				<th>��������</th>
				<th>���Ѷ��Ų�������</th>
				<th>������ʶ</th>
				<th>��Чʱ��</th>
				<th>ʧЧʱ��</th>
			</tr>
			<%
			for(int i = 0; i < tempArr1.length; i++){
%>
				<tr>
					<td><%=tempArr1[i][0]%></td>
					<td><%=tempArr1[i][1]%></td>
					<td>����</td>
					<td><%=tempArr1[i][2]%></td>
					<td><%=tempArr1[i][3]%></td>
					<td><%=tempArr1[i][4]%></td>
					<td><%=tempArr1[i][5]%></td>
					<td><%=tempArr1[i][6]%></td>
					<td><%=tempArr1[i][7]%></td>
					<td><%=tempArr1[i][8]%></td>
					<td><%=tempArr1[i][9]%></td>
				</tr>
<%
			}
			%>
			<%
			for(int ii = 0; ii < tempArr2.length; ii++){
%>
				<tr>
					<td><%=tempArr2[ii][0]%></td>
					<td><%=tempArr2[ii][1]%></td>
					<td>ɾ��</td> 
					<td><%=tempArr2[ii][2]%></td>
					<td><%=tempArr2[ii][3]%></td>
					<td><%=tempArr2[ii][4]%></td>
					<td><%=tempArr2[ii][5]%></td>
					<td><%=tempArr2[ii][6]%></td>
					<td><%=tempArr2[ii][7]%></td>
					<td><%=tempArr2[ii][8]%></td>
					<td><%=tempArr2[ii][9]%></td>
				</tr>
<%
			}
			%>
		</table>
	</div>
	<div id="updateDiv">
		<table id="updateTabList" width="100%" cellspacing="0">
			<tr>
				<td align='center' class="blue"><div><b>��������</b></div></td>
				<td align='center' class="blue"><div><b>����ʱ��</b></div></td>
				<td align='center' class="blue"><div><b>��������</b></div></td>
				<td align='center' class="blue"><div><b>����ģ�����</b></div></td>
				<td align='center' class="blue"><div><b>����ģ������</b></div></td>
				<td align='center' class="blue"><div><b>������Ա��������</b></div></td>
				<td align='center' class="blue"><div><b>�޸�ǰ��������</b></div></td>
				<td align='center' class="blue"><div><b>��������</b></div></td>
				<td align='center' class="blue"><div><b>�޸�ǰ���Ѷ��Ų�������</b></div></td>
				<td align='center' class="blue"><div><b>���Ѷ��Ų�������</b></div></td>
				<td align='center' class="blue"><div><b>�޸�ǰ��Чʱ��</b></div></td>
				<td align='center' class="blue"><div><b>��Чʱ��</b></div></td>
				<td align='center' class="blue"><div><b>�޸�ǰʧЧʱ��</b></div></td>
				<td align='center' class="blue"><div><b>ʧЧʱ��</b></div></td>
<%
			for(int iii = 0; iii < tempArr3.length; iii++){
%>
				<tr>
					<td><%=tempArr3[iii][0]%></td>
					<td><%=tempArr3[iii][1]%></td>
					<td>�޸�</td>
					<td><%=tempArr3[iii][2]%></td>
					<td><%=tempArr3[iii][3]%></td>
					<td><%=tempArr3[iii][4]%></td>
					<td><%=tempArr3[iii][5]%></td>
					<td><%=tempArr3[iii][10]%></td>
					<td><%=tempArr3[iii][6]%></td>
					<td><%=tempArr3[iii][11]%></td>
					<td><%=tempArr3[iii][8]%></td>
					<td><%=tempArr3[iii][13]%></td>
					<td><%=tempArr3[iii][9]%></td>
					<td><%=tempArr3[iii][14]%></td>
				</tr>
<%
			}
			%>
			</tr>
		</table>
	</div>
		<table>
			<tr>
				<td>
				<div align="center">
				<input class="b_foot" name="sure" type="button" value="����" 
				 onClick="printTable();">
				&nbsp; 
				<input class="b_foot" name="goback"  onClick="history.go(-1)" 
				 type="button" value="����">
				</div>
				</td>
			</tr>
		</table>
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</BODY>
</html>
	

<script>
var excelObj;
function printTable(){
	var obj;
	var updateTypeVal = "<%=updateType%>";
	if("A" == updateTypeVal || "D" == updateTypeVal){
		obj = $("#addTabList")[0];
	}else if("U" == updateTypeVal){
		obj = $("#updateTabList")[0];
	}
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(obj.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add; 
		for(a=0;a<obj.length;a++)
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
