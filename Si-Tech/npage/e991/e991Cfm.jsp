<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Calendar"%>

<%
 String opCode = "e610";
  String opName = "ͳһ�˵���ӡ"; 
String workno = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

System.out.println("---------------------------s1351Cfm.jsp---------------------------");
DecimalFormat df = new DecimalFormat("#0.00");
String sm_code = new String();
String printway=request.getParameter("printway");//��ӡ��ʽ
String phoneNo = request.getParameter("phoneNo");
System.out.println("phoneNo="+phoneNo);
String contract_no = request.getParameter("contract_no");
System.out.println("contract_no="+contract_no);
String contract_no_sign = contract_no;
String beginDate= request.getParameter("beginDate");

String custPasswd = WtcUtil.repNull(request.getParameter("password"));//�û��ʻ�����
System.out.println("---------------------------custPasswd---------------------------"+custPasswd);
System.out.println("wxy="+custPasswd);
String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
String ny = dateStr.substring(0,4);
String nm = dateStr.substring(4,6);
String nd = dateStr.substring(6,8);
Calendar cd = Calendar.getInstance();
Calendar cr = Calendar.getInstance();
cr.setTime(new Date());
String crd = cr.get(cr.DATE) < 10 ? "0" + cr.get(cr.DATE) : "" + cr.get(cr.DATE);
String zy = beginDate.substring(0,4);
String zm = beginDate.substring(4,6);
cd.clear();
cd.set(cd.YEAR,Integer.parseInt(zy));
cd.set(cd.MONTH,Integer.parseInt(zm)-1);
String zdf = cd.getActualMinimum(cd.DAY_OF_MONTH) < 10 ? "0" + cd.getActualMinimum(cd.DAY_OF_MONTH) : "" + cd.getActualMinimum(cd.DAY_OF_MONTH);
String zdl = cd.getActualMaximum(cd.DAY_OF_MONTH) < 10 ? "0" + cd.getActualMaximum(cd.DAY_OF_MONTH) : "" + cd.getActualMaximum(cd.DAY_OF_MONTH);
String errCode="";
String sql="";
String errMsg="";
String rtnPage = "/npage/e991/e991_1.jsp";
String password="";
int row_count = 51;
 
 
 
//xl add begin new
String unid_id=request.getParameter("phoneNo");
String cust_id="";
String[] inParas2 = new String[2];
inParas2[0]="select to_char(cust_id) from dgrpcustmsg where unit_id=:unidId";
inParas2[1]="unidId="+unid_id;
%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
	
	<%
		if(ret_val==null )
		  {
			  
			   %>
				<script language="javascript">
					rdShowMessageDialog("��ѯcust_id����");
					
				</script>
			  <%
		  }
  else
  {			
  	
	 cust_id=ret_val[0][0];
 
     
   
	String id_no="";
	String[] args=new String[4];
	args[0]=cust_id;
	args[1]=beginDate;
	args[2]="e991";
	args[3]=workno;
	//resultTemp1=(String[][])coTemp1.spubqry32("1",tempSQL1).get(0);
 
 
 

	int flag = 0;  //��ѯ�����ǩ 0����ȷ 1������
%>
<wtc:service name="se991" outnum="11" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=args[0]%>" />
			<wtc:param value="<%=args[1]%>" />	
			<wtc:param value="<%=args[2]%>" />
			<wtc:param value="<%=args[3]%>" />	
	 
		</wtc:service>

	<wtc:array id="cust_name"   start="0"  length="1" scope="end"/>	 
	<wtc:array id="fee_item"  start="1"  length="1" scope="end"/>
	<wtc:array id="should"   start="2"  length="1" scope="end"/>
	<wtc:array id="favour"   start="3"  length="1" scope="end"/>
	<wtc:array id="ss"  start="4"  length="1" scope="end"/>
	<wtc:array id="fee_grade"   start="5"  length="1" scope="end"/>
	<wtc:array id="row_num"   start="6"  length="1" scope="end"/>
	<wtc:array id="total_fee"   start="7"  length="1" scope="end"/>	
	<wtc:array id="manager_name"   start="8"  length="1" scope="end"/>
	<wtc:array id="manager_phone"   start="9"  length="1" scope="end"/> 
	<wtc:array id="show_num"   start="10"  length="1" scope="end"/> 
	<%
 
	errCode=code2;
	errMsg=msg2;
	/*System.out.println("--------------errCode-------------s1351.jsp----------------"+errCode);
	 s_show_num �����ֵ�ж�
	*/
	if(!errCode.equals("000000"))
	{  
		flag=1;
%>
		<script>		
			rdShowMessageDialog('<%=errCode%>:<%=errMsg%>',0);
			document.location.replace('<%=rtnPage%>');
		</script>
<%
    } 
	else
	{
		flag=0;
		int num0=fee_item.length; 
		int show_nums = Integer.parseInt(show_num[0][0]);
		int i_page = show_nums/4+1;
		int i_last = show_nums%4;
		int i_start=0;
		
	    %>
			<script language="javascript">
				//alert("test ��Ʒ���� is "+"<%=show_nums%>"+" and ��ҳ�� "+"<%=i_page%>"+" and ���һҳ "+"<%=i_last%>");		 
			</script>
		<%
		
			 
	 
%>
<HTML>
<HEAD>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=opName%></TITLE>
<link rel="stylesheet" href="reset.css" media="all" />
<link rel="stylesheet" href="bills1.css" media="all" />
<link rel="stylesheet" href="print-reset.css" media="print" />
<style type="text/css" media=print> 

  

</style>
<%
	if (flag==0){
%>
 
</HEAD>
<BODY class="email" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<!-------------------                  ���˵����ݿ�ʼ                    -------------------------->

<%
	if(show_nums<=4)
	{
		%>
		<br><br> 
		<div class="container" id="article">
	   �𾴵�<%=cust_name[0][0]%>:<p>
	   ��λ���·��úϼ�Ϊ: <%=total_fee[0][0]%>Ԫ;
	 <table width="70%"    >
	<tr>
		<td align="center"><h2><b>�й��ƶ�ͨ�ż��ſͻ��ʵ�</b></h2></td>
	</tr>
</table>
	 
		<table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01" style="margin-bottom:0;">
		  <tr>
			<th width="100"><font color="black">���ſͻ����ƣ�</font></th>
			<td width="250"><%=cust_name[0][0]%> </td>

			<th width="100" align="left"> <font color="black">�ͻ����룺</font> </th>
			<td width="250"> <%=unid_id%> </td>
		  </tr>
		  <tr>
			<th width="100"> <font color="black">�Ʒ����ڣ�</font> </th>
			<td width="250"><%=zy%>�� <%=zm%>�� <%=zdf%>�� ��<%=zy%>�� <%=zm%>�� <%=zdl%>��  </td>

			<th width="100" align="left"><font color="black">��ӡ���ڣ�</font> </th>
			<td width="250"><%=ny%> �� <%=nm%> �� <%=nd%> ��  </td>
		  </tr>	
		  
		  
	</table> 

		   
	   <table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
		
		  <tr>
			 <td colspan=1>���Ų�Ʒ</td><td colspan=1>������Ŀ</td> <td rowspan=2>Ӧ�շ���</td><td rowspan=2>�Żݷ���</td><td rowspan=2>ʵ�շ���</td>
		  </tr>
		  <tr>
			 <td>����</td> <td>����</td>  
		  </tr>
		  <%
			for(int i=0;i<num0;i++)
			{
			  %>
				<%
					if((fee_grade[i][0]=="1")||fee_grade[i][0].equals("1"))
					{
						
						%>
						<tr>
							<td rowspan="<%=Integer.parseInt(row_num[i][0])%>"><%=fee_item[i][0]%>    </td>
							<%
								
								if((fee_grade[i+1][0]=="2")||fee_grade[i+1][0].equals("2"))
								{
									 
									%>
										<td rowspan="<%=Integer.parseInt(row_num[i+1][0])%>"><%=fee_item[i+1][0]%>    </td>
										<td><%=should[i+1][0]%></td>
										<td><%=favour[i+1][0]%></td>
										<td><%=ss[i+1][0]%></td>
									<%  
								} 
							%>
							 
						</tr>
						<%  i=i+1;
						continue;
					}
					if((fee_grade[i][0]=="2")||fee_grade[i][0].equals("2"))
					{
						 %>
						<tr>
							<td  >  <%=fee_item[i][0]%> </td>
								 <td  >  <%=should[i][0]%></td>
								 <td  >  <%=favour[i][0]%></td>
								 <td  >  <%=ss[i][0]%></td> 
						</tr>
						<% //i=i+Integer.parseInt(row_num[i][0]); 
						//i=i+1;
						continue; 
					}
				%>
			  <%
			}  
		  %> 

		  <tr>
			 <td colspan=5><div align="left">���úϼƣ�<%=total_fee[0][0]%>Ԫ</div></td> 
		  </tr>
		  
		 <!--end ����ȡֵ--> 
	 </table>
	 <table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
		<tr>
			<td colspan=5>�ͻ�������Ϣ</td>
		  </tr>
		  <tr>
			<td width=35%>�ͻ���������</td><td width=35%><%=manager_name[0][0]%></td>
		  </tr>
		  <tr>
			<td width=35%>��ϵ�绰</td><td width=35%><%=manager_phone[0][0]%></td>
		  </tr>
	 </table>
	</div>
		<%
	}
	else
	{
		//begin ��ҳ
		 
			%>
			<br><br>
			<div class="container" width=80% id="article">
   �𾴵�<%=cust_name[0][0]%>:<p>
   ��λ���·��úϼ�Ϊ: <%=total_fee[0][0]%>Ԫ;
<table width="70%"    >
	<tr>
		<td align="center"><h2><b>�й��ƶ�ͨ�ż��ſͻ��ʵ�</b></h2></td>
	</tr>
</table>
 
 
	<table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01" style="margin-bottom:0;">
      <tr>
        <th width="100"><font color="black">���ſͻ����ƣ�</font></th>
        <td width="250"><%=cust_name[0][0]%> </td>

		<th width="100" align="left"> <font color="black">�ͻ����룺</font> </th>
        <td width="250"> <%=unid_id%> </td>
      </tr>
      <tr>
        <th width="100"> <font color="black">�Ʒ����ڣ� </font></th>
        <td width="250"><%=zy%>�� <%=zm%>�� <%=zdf%>�� ��<%=zy%>�� <%=zm%>�� <%=zdl%>��  </td>

		<th width="100" align="left"> <font color="black">��ӡ���ڣ� </font></th>
        <td width="250"><%=ny%> �� <%=nm%> �� <%=nd%> ��  </td>
      </tr>	
	  
	  
</table> 

	   
   <table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
    
      <tr>
         <td >���Ų�Ʒ</td>  <td >Ӧ�շ���</td><td  >�Żݷ���</td><td  >ʵ�շ���</td>
	  </tr>
	  
	  <%
		for(int i=0;i<num0;i++)
	    {
		  %>
			<%
				 
				if((fee_grade[i][0]=="1")||fee_grade[i][0].equals("1"))
                {
					 %>
					<tr>
						<td  >  <%=fee_item[i][0]%> </td>
							 <td  >  <%=should[i][0]%></td>
							 <td  >  <%=favour[i][0]%></td>
							 <td  >  <%=ss[i][0]%></td> 
					</tr>
					<% //i=i+Integer.parseInt(row_num[i][0]); 
					//i=i+1;
					continue; 
				}
			%>
		  <%
	    }  
	  %> 

	  <tr>
		 <td colspan=5><div align="left">���úϼƣ�<%=total_fee[0][0]%>Ԫ</div></td> 
	  </tr>
	  
	  
 </table>
 <table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
	<tr>
		<td colspan=5>�ͻ�������Ϣ</td>
	  </tr>
	  <tr>
		<td width=35%>�ͻ���������</td><td width=35%><%=manager_name[0][0]%></td>
	  </tr>
	  <tr>
		<td width=35%>��ϵ�绰</td><td width=35%><%=manager_phone[0][0]%></td>
	  </tr>
 </table>
</div>
	 
		 
		<%
		//end ��ҳ
	}	
%>

	
    
  
 
<br><br><br><br>    
 <script language="javascript">
 	function print(){
 			 eval("div0").style.visibility="hidden"; 
 			document.all.wb.ExecWB(6,6);
 			eval("div0").style.visibility="visible";
 		}
 	</script>
   
 

	<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0 id=wb name=wb width=0>
</OBJECT>
	<object ID='WebBrowser' style="display:none" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' VIEWASTEXT></object>
	<object id=factory viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
  codebase="smsx.cab#Version=6,3,436,14">
    </object>
	<div id ="div0">
	<table width="70%">
	<tr >
		<td align="center"><input type="button" name="print"  id="print" class="b_foot" value="��ӡ" onclick="print(); ">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="b_foot" onClick="exportExcel('article')" value="����EXCEL"> &nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="button"  class="b_foot"value="����" title="����" onClick="window.location='e991_1.jsp?opCode=e991&opName=���ſͻ��ۺ��˵���ӡ&crmActiveOpCode=e991'" /> &nbsp;&nbsp;&nbsp;&nbsp;
 
		 
	 <input type="button"  class="b_foot"value="�ر�" title="�ر�" onClick="window.close()" />
		</td>
	</tr>
	 </table>
	</div>
 

 
 

<!-------------------                  ���˵����ݽ���                    -------------------------->

</BODY>
</HTML>
<%}
}

 }%>

<script language="javascript">
function preview(oper){ 
if (oper < 10){ 
  bdhtml = window.document.body.innerHTML;//��ȡ��ǰҳ��html���� 
  sprnstr = "<!--startprint"+oper+"-->";//���ô�ӡ��ʼ���� 
  eprnstr = "<!--endprint"+oper+"-->";//���ô�ӡ�������� 
  prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //�ӿ�ʼ�������ȡhtml 

  prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//�ӽ���������ǰȡhtml 
  window.document.body.innerHTML=prnhtml; 
  window.print(); 
  //window.document.all.wb.execwb(7,1); 
  //window.document.body.innerHTML=bdhtml; 
} else{ 
window.print(); 
} 
}
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
</script>