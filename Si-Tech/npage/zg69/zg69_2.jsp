<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String phone_no = request.getParameter("phone_no");              //��������
	String begin_time = request.getParameter("begin_time");
	String end_time = request.getParameter("end_time");
	String work_no = (String)session.getAttribute("workNo"); 
	
	
	
%>
<wtc:service name="zg71Qry" routerKey="phone" routerValue="<%=phone_no%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="19" >
    <wtc:param value="<%=phone_no%>"/>
    <wtc:param value="<%=begin_time%>"/> 
    <wtc:param value="<%=end_time%>"/>
    <wtc:param value="<%=work_no%>"/>
</wtc:service>
<wtc:array id="ret_1" scope="end" start="0"  length="2"/>
<wtc:array id="sVerifyTypeArr" scope="end" start="2"  length="17"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");

	String errMsg = s4141CfmMsg;
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa sVerifyTypeArr.length is "+sVerifyTypeArr.length+" and s4141CfmCode is "+s4141CfmCode);
	if (sVerifyTypeArr.length > 0 && s4141CfmCode.equals("000000"))
	{
	
%>

<html>
	<head>
	<title></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
			
var excelObj;
function printTable(obj){
	var regionChecks = document.getElementsByName("regionCheck");
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	excelObj = new ActiveXObject('excel.Application');
	excelObj.Visible = true;
 	excelObj.WorkBooks.Add; 
	for(j=1;j< 15;j++)
	{
		excelObj.Cells(1,j+1).Value=obj.rows[0].cells[j].innerText;
	}
	var xy=0;
	for(var a=0;a <regionChecks.length;a++)
	{
		if(regionChecks[a].checked)
		{
			var impValue = regionChecks[a].value;
			var impArr = impValue.split("|");
			
				try
				{	
					for(var j = 0; j < 814; j++)
					{											
						excelObj.Cells(xy+2,j+2).value = impArr[j];						
					}		
					xy++;						
				}
				catch(e)
				{
					alert('����excelʧ��!');
				}	
		}		
	}
	 
}					
		//-->
	</script>
	
</head>
<body>	
	<div id="Operation_Table">
     <table cellspacing="0" id='t1' width="200px" >
			<tr>
				<!--
				<th nowrap>ѡ��</th>
				-->
				<th>����</th>
				<th>������ˮ</th>
				<th>Ͷ�ߵ绰��</th>
				<th>����ʱ��</th> 
				<th>�˷�ҵ��</th>
				<th>Sp��ҵ����</th>
				<th>Sp��ҵ����</th>
				<th>Spҵ�����</th>
				<th>Spҵ������</th>
				<th>�˷ѿ�ʼʱ��</th>
				<th>�˷ѽ���ʱ��</th>
				<th>�Ʒ�����</th>
				<th>����</th>
				<th>����</th>
				<th>�˷ѽ��</th>
				<th>�˷�����</th>
				<th>ʵ���˷ѹ���</th>
			</tr> 
	<%		
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='17'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++)
				{
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr>
							<!--<td class="<%=tbclass%>">
							
								<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][6]%>|<%=sVerifyTypeArr[i][7]%>|<%=sVerifyTypeArr[i][8]%>|<%=sVerifyTypeArr[i][9]%>|<%=sVerifyTypeArr[i][10]%>|<%=sVerifyTypeArr[i][11]%>|<%=sVerifyTypeArr[i][12]%>|<%=sVerifyTypeArr[i][13]%>" onclick="doChange()">	
							</td>-->
							<td><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][10]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][11]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][12]%></td>
							<td><%=sVerifyTypeArr[i][13]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][14]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][15]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][16]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>   
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	   
				<input type="button"  class="b_text" onClick="exportExcel('Operation_Table')" value="����EXCEL">
				<!--
				<input type="button"  class="b_text" onClick="window.location.href='zg69_1.jsp'" value="����">
				-->
			</td>
	  </tr>
 </table>  
 	</div>
</body>
</html>  

<script language="javascript">
	function exportExcel(DivID){
 //������Excel�����Excel�������ȶ���
 var jXls, myWorkbook, myWorksheet;
 
 try {
  //�����ʼ��ʧ��ʱ������ʾ
  jXls = new ActiveXObject('Excel.Application');
 }catch (e) {
	return false;
 }
 
 //����ʾ���� 
 jXls.DisplayAlerts = false;
 
 //����AX����excel
 myWorkbook = jXls.Workbooks.Add();
 //myWorkbook.Worksheets(3).Delete();//ɾ����3����ǩҳ(�ɲ���)
 //myWorkbook.Worksheets(2).Delete();//ɾ����2����ǩҳ(�ɲ���)
 
 //��ȡDOM����
 var curTb = document.getElementById(DivID);
 
 //��ȡ��ǰ��Ĺ�����(����һ��)
 myWorksheet = myWorkbook.ActiveSheet; 
 
 //���ù���������
 myWorksheet.name="NPͳ��";
 
 //��ȡBODY�ı���Χ
 var sel = document.body.createTextRange();
 
 //���ı���Χ�ƶ���DIV��
 sel.moveToElementText(curTb);
 
 //ѡ��Range
 sel.select();
 
 //��ռ�����
 window.clipboardData.setData('text','');
 
 //���ı���Χ�����ݿ�����������
 sel.execCommand("Copy");
 
 //������ճ����������
 myWorksheet.Paste();
 
 //�򿪹�����
 jXls.Visible = true;
 
 //��ռ�����
 window.clipboardData.setData('text','');
 jXls = null;//�ͷŶ���
 myWorkbook = null;//�ͷŶ���
 myWorksheet = null;//�ͷŶ���
}
</script>
<%
	}else{
			out.println("<tr height='25' align='center'><td colspan='11'>");
			out.println("<font class='orange'>û���κμ�¼��</font>");
			out.println("</td></tr>");
		 }
%>

