<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: Ͷ���˷Ѳ�ѯ-���ݽ����ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2009-08-10
�� * ����: zhangshuaia
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
    
 		String opCode = "4141";
 		String opName = "Ͷ���˷�--������ѯ";
		 
		/**��ҪregionCode���������·��**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
	 
		String value_new = "";
		//����ַ��� ��Ҫsplit
		String  tar = ""; 
		String lgNameArrays = "";
		 
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("22222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa checkSql->"+checkSql);
		//xl add
		String qry_value = request.getParameter("qry_value");
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr1"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr1 !=null && sVerifyTypeArr1.length>0){
				loginRootDistance = sVerifyTypeArr1[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr1[0][0]);
				System.out.println("33333 loginRootDistance->"+loginRootDistance);
			}
		}					
		
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));
		String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
		String end_time = WtcUtil.repNull(request.getParameter("end_time"));	
		String login_no = WtcUtil.repNull(request.getParameter("login_no"));	
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));			
		 
		//xl add 
		String s_region_code = WtcUtil.repNull(request.getParameter("qry_region"));
		String[][] result1  = null ;
%>
		<wtc:service name="s4141Qry"  routerKey="region"  routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="20"> 
			<wtc:param value="<%=lgNameArrays%>"/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=begin_time%>"/>
			<wtc:param value="<%=end_time%>"/>
			<wtc:param value="<%=qry_value%>"/>
			<wtc:param value="<%=s_region_code%>"/>
			
		</wtc:service> 
		<wtc:array id="sVerifyTypeArr1" start="0" length="2" scope="end"/>
		<wtc:array  id="sVerifyTypeArr" start="2" length="18" scope="end"/>
 
<%	
result1 = sVerifyTypeArr;
System.out.println("retCode===="+retCode);
System.out.println("retMsg===="+retMsg);
System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSS result1.length=" + result1.length);
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
				/**��ѡ��ȫ��ѡ��**/
			function doSelectAllNodes(){
				document.all.sure.disabled=false;
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=true;
				}
				doChange();	
			}
			
			/**ȡ����ѡ��ȫ��ѡ��**/
			function doCancelChooseAll(){
				document.all.sure.disabled=true;
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=false;
				}
				doChange();				
			}
							
				function doChange(){
					document.all.sure.disabled=false;					
					parent.document.all.begin_time.disabled=true;
					parent.document.all.op_code.disabled=true;
					parent.document.all.end_time.disabled=true;
					parent.document.all.login_no.disabled=true;					
					var regionChecks = document.getElementsByName("regionCheck");
					var impCodeStr = "";
					var regionLength=0;
					for(var i=0;i<regionChecks.length;i++){		
						if(regionChecks[i].checked){
							var impValue = regionChecks[i].value;
								var impArr = impValue.split("|");
								if(regionLength==0){
									impCodeStr = impArr[7];
								}else{
									impCodeStr += (","+impArr[7]);								
								}
						regionLength++;
				}				
			}
			document.all.loginAccept.value = impCodeStr;
			if(document.all.loginAccept.value.length==0)
			{
				document.all.sure.disabled=true;
			}		
		}
				
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
	parent.window.location.href = "f4141.jsp?op_code=<%=op_code%>";
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
				<th>�˷�����ԭ��</th>
				<th>Sp��ҵ����</th>
				<th>Sp��ҵ���</th>
				<th>Spҵ�����</th>
				<th>Spҵ������</th>
				<th>ҵ��ʹ��ʱ��</th>	
				<th>�Ʒ�����</th>
				<th>����</th>
				<th>����</th>
				<th>�˷ѽ��</th>
				<th>�˷�����</th>
				<th>��������</th>
				<th>���������</th>
				<th>Ʒ��</th>
			</tr> 
	<%		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA "+sVerifyTypeArr.length);
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='14'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				System.out.println("AAAAAAAAAAAAAAAAAAAAAAA sVerifyTypeArr.length is "+sVerifyTypeArr.length);
				for(int i=0;i<result1.length;i++)
				{
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr>
							<!--<td class="<%=tbclass%>">
							
								<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][6]%>|<%=sVerifyTypeArr[i][7]%>|<%=sVerifyTypeArr[i][8]%>|<%=sVerifyTypeArr[i][9]%>|<%=sVerifyTypeArr[i][10]%>|<%=sVerifyTypeArr[i][11]%>|<%=sVerifyTypeArr[i][12]%>|<%=sVerifyTypeArr[i][13]%>" onclick="doChange()">	
							</td>-->
							<td><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][14]%>&nbsp;</td>
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
							<td><%=sVerifyTypeArr[i][15]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][16]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][17]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>   
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	      <!--
		   <input type="button" name="allchoose"  class="b_text" value="ȫ��ѡ��" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       <input type="button" name="cancelAll" class="b_text" value="ȡ��ȫѡ" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;				
				<input class="b_text" name="sure" type="button" value="����EXCEL" style="cursor:hand;" onClick="printTable(t1);" disabled>
				<input class="blue" name="loginAccept" type="hidden" >					
				<input class="blue" name="opNote" type="hidden" value="����Ա��<%=workNo%> ����˵���ע���������Ϣ����" >									
				<input class="blue" name="op_code" type="hidden" value="<%=op_code%>">
				&nbsp;&nbsp;
				-->
				<input type="button"  class="b_text" onClick="exportExcel('Operation_Table')" value="����EXCEL">
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