<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����:���ø澯��ѯ
   * ����: 2009/4/8
   * ����: dujl
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "4266";
	String opName = "���ø澯��ѯ";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String typeCode = request.getParameter("typeCode");
  	String useUnit = request.getParameter("useUnit");
  	String useDepartment = request.getParameter("useDepartment");
  	String useCenter = request.getParameter("useCenter");
	
	/**************** ��ҳ���� ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
	
	String[][] allNumStr = new String[][]{};
	String[][] result = new String[][]{};
	
	String  inputParsm [] = new String[7];
	inputParsm[0] = workNo;
	inputParsm[1] = orgCode;
	inputParsm[2] = opCode;
	inputParsm[3] = typeCode;
	inputParsm[4] = useUnit;
	inputParsm[5] = useDepartment;
	inputParsm[6] = useCenter;
%>	
    <wtc:service name="s4266Query" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="15">			
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>
	<wtc:param value="<%=inputParsm[6]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" start="2" length="13"  scope="end"/>
	<wtc:array id="tempArr1" start="0" length="2"  scope="end"/>
<%
	if(!(tempArr1[0][0].equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("������Ϣ:<%=tempArr1[0][1]%>");
		</script>
<%
		return;
	}
%>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--
</script>

<title>���ø澯��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���ø澯��ѯ</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>
				<td  align='center' class="blue"><div ><b>ʡ�б�־</b></div></td>
				<td  align='center' class="blue"><div ><b>ʹ�õ�λ</b></div></td>
				<td  align='center' class="blue"><div ><b>ʹ�ò���</b></div></td>
				<td  align='center' class="blue"><div ><b>ʹ������</b></div></td>
				<td  align='center' class="blue"><div ><b>�ͻ�����</b></div></td>
				<td  align='center' class="blue"><div ><b>ְλ����</b></div></td>
				<td  align='center' class="blue"><div ><b>�ֻ�����</b></div></td>
				<td  align='center' class="blue"><div ><b>��������</b></div></td>
				<td  align='center' class="blue"><div ><b>ʹ����;</b></div></td>
				<td  align='center' class="blue"><div ><b>���ø澯ֵ</b></div></td>
				<td  align='center' class="blue"><div ><b>�����޶�ֵ</b></div></td>
				<td  align='center' class="blue"><div ><b>Ӧ�ջ���</b></div></td>
			</tr>
	<%
	if(tempArr.length<=10){
		for(int i = 0; i < tempArr.length; i++)
			{
	%>
				<tr>
					<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][2].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][5].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][6].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][7].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][9].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][10].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][11].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][12].trim()%>&nbsp;</td>
				</tr>
	<%
		}
		}else if(tempArr.length-iStartPos<10){
		
		for(int i = iStartPos; i < tempArr.length; i++)
		{
	%>
			<tr>
				<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][7].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][9].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][10].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][11].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][12].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	}else{
		for(int i = iStartPos; i < iStartPos+iPageSize; i++)
		{
	%>
			<tr>
				<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][7].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][9].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][10].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][11].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][12].trim()%>&nbsp;</td>
			</tr>
	<%
		}
		}
	%>
		
			<tr>
				<td colspan="12">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
					    //ʵ�ַ�ҳ
					    int iQuantity = tempArr.length;
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
	%>
					</div>
				</td>				
			</tr>
					
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
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</BODY>
</HTML>

<script>
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	excelObj = new ActiveXObject('excel.Application');
	excelObj.Visible = true;
	excelObj.WorkBooks.Add; 

	for(j=0;j<12;j++)
	{
		excelObj.Cells(1,j+1).Value=obj.rows[0].cells[j].innerText;
	}
	<%	
	for(int i = 0; i < tempArr.length; i++)
	{
	%>
		try
		{
			
			<%	
			for(int j = 0; j < 12; j++)
			{
			%>
				
				excelObj.Cells(<%=i%>+2,<%=j%>+1).Value="<%=tempArr[i][j].trim()%>";
			<%	
			}
			%>
		}
		catch(e)
		{
			alert('����excelʧ��!');
		}
	<%	
	}
	%>

	excelObj.Range('A1:'+str.charAt(12-1)
+1+<%=tempArr.length%>).Borders.LineStyle=1;
}
</script>
