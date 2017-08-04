<%
/********************
 * version v2.0
 * ������: si-tech
 * author: huangrong
 * date  : 20101103
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String regionCode = (String)session.getAttribute("regCode");
  
	String iLoginAccept = "";
	String iChnSource = "01";
	String iLoginNo = (String)session.getAttribute("workNo");
	String iLoginPwd = (String)session.getAttribute("password");
	String b_order_code = (String)request.getParameter("b_order_code");
	String s_order_code = (String)request.getParameter("s_order_code");
	System.out.println("++++++++++++++++++++++++++++"+s_order_code);
	String workName   = (String)session.getAttribute("workName");
	String [] inParas = new String[9];
	inParas[0] = iLoginAccept;
	inParas[1] = iChnSource;
	inParas[2] = opCode;
	inParas[3] = iLoginNo;
	inParas[4] = iLoginPwd;
	inParas[5] = "";
	inParas[6] = "";
	inParas[7] = b_order_code;
	inParas[8] = s_order_code;
String svcName = "sOrderQry";//"sOrderQry";
%>
<wtc:service name="<%=svcName%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="50">
	<wtc:param value="<%=inParas[0]%>" />
	<wtc:param value="<%=inParas[1]%>" />
	<wtc:param value="<%=inParas[2]%>" />
	<wtc:param value="<%=inParas[3]%>" />
	<wtc:param value="<%=inParas[4]%>" />
	<wtc:param value="<%=inParas[5]%>" />
	<wtc:param value="<%=inParas[6]%>" />
	<wtc:param value="<%=inParas[7]%>" />
	<wtc:param value="<%=inParas[8]%>" />
</wtc:service>
	<wtc:array id="result"      scope="end" start="0"  length="25"/>
	<wtc:array id="acceptRel"   scope="end" start="25"  length="1"  />
	<wtc:array id="custNameRel" scope="end" start="26"  length="1" />	

<%
	String billAccept   = "";//��Ʊ��ӡ����ˮ
	String billCustName = "";//��Ʊ��ӡ�Ŀͻ�����
	
	if(acceptRel.length>0){
		if(acceptRel[0].length>0){
			billAccept = acceptRel[0][0];
		}
	}
	
	if(custNameRel.length>0){
		if(custNameRel[0].length>0){
			billCustName = custNameRel[0][0];
		}
	}
	
%>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ѯ</title>
<script language=javascript>
//hejwa add ��ӡ��Ʊ ���ڸ�ʡBOSSϵͳ������֧�ֻ����̳�˫�汾���е�֪ͨ
function showPrtDlgbill(printType,DlgMessage,submitCfm){
	
	var custPhoneNo = "";
	var custPayNum  = 0.00;
	var custName    = "<%=billCustName%>";
	$("#shoTable tr:gt(0)").each(function(){
		if(custPhoneNo==""){
			custPhoneNo = $(this).find("td:eq(0)").text().trim();
		}
		custPayNum += parseFloat($(this).find("td:eq(15)").text().trim());
	});
 
	var loginAccept = "<%=billAccept%>";
	if(custPayNum>0){//���Ϊ0����ӡ��Ʊ
		//20140321155339396798
		//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
			var printinfo = "";
			    printinfo += "<%=iLoginNo%>|";
			    printinfo += loginAccept+"|";//��ˮ
			    printinfo += "�����̳ǻ����ֽ���֧��" + "|";  //ҵ������
			    printinfo += "<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>"+"|";
			    printinfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>"+"|";
			    printinfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>"+"|";
					printinfo += custName+"|";
					printinfo += "|";
					printinfo += custPhoneNo+"|";
					printinfo += "|";
					printinfo += "|";
					printinfo += custPayNum+"|"; //��д
					printinfo += custPayNum+"|"; //Сд
					printinfo += "�ֽ�֧����"+custPayNum+"Ԫ|";
					printinfo += "<%=workName%>|";
					printinfo += "|";
					printinfo += "|";
					
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		
		var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=" + DlgMessage;
		
		var path = path + "&printInfo="+printinfo+"&submitCfm=submitCfm";
		var path = path + "&infoStr="+printinfo+"&loginAccept="+loginAccept+"&opCode=1121&submitCfm=submitCfm";
		var ret=window.showModalDialog(path, "", prop);
	}else{
		rdShowMessageDialog("����Ӧ���ܽ��Ϊ0�������ӡ��Ʊ");
	}
}	
</script>
</head>

<body>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<div style="overflow-x:auto;overflow-y:hidden;">
<table cellspacing="0" id="shoTable">
	<tr>
		<th class="blue" align="center">�ͻ��ֻ�����</th>			
		<th class="blue" align="center">�󶩵����</th>									
		<th class="blue" align="center">��������</th>
		<th class="blue" align="center">��������</th>
		<th class="blue" align="center">�����˷ѻ���</th>
		
		<th class="blue" align="center">������Ʒ����</th>
		<th class="blue" align="center">�ֿ���</th>
		<th class="blue" align="center">�Ӷ������</th>
		<th class="blue" align="center">��Ʒ����</th>
		<th class="blue" align="center">��Ʒ����</th>
		
		<th class="blue" align="center">��Ʒ����ֵ</th>
		<th class="blue" align="center">�Ӷ���״̬</th>
		
		<!-- hejwa add ���ڸ�ʡBOSSϵͳ������֧�ֻ����̳�˫�汾���е�֪ͨ -->
		<th class="blue" align="center">����Ӧ���ܻ���</th>
		<th class="blue" align="center">���������ܻ���</th>
		<th class="blue" align="center">������ƷӦ���ܻ���</th>
		<th class="blue" align="center">����Ӧ���ܽ��</th>
		<th class="blue" align="center">����Ӧ�����</th>
		<th class="blue" align="center">��Ʒȫ����</th>
		<th class="blue" align="center">������ƷӦ�����</th>
		<th class="blue" align="center">֧��״̬</th>
		<th class="blue" align="center">֧����ʽ</th>
		<th class="blue" align="center">����֧������</th>
		<th class="blue" align="center">֧����Ч��</th>
		
	</tr>	
	<%	
	if (retCode.equals("000000"))
	{
		System.out.println("result.length==================="+result.length);
		if(result.length>0 && result[0][0]!=null && result[0][0]!="")
		{
			for ( int i = 0 ; i < result.length ; i ++ )
			{
	%>
				<tr align="center">
					<td nowrap><%=result[i][2]%></td>
					<td nowrap><%=result[i][3]%></td>
					<td nowrap><%=result[i][4]%></td>
					<td nowrap><%=result[i][5]%></td>
					<td nowrap><%=result[i][6]%></td>
					                          
					<td nowrap><%=result[i][7]%></td>
					<td nowrap><%=result[i][8]%></td>
					<td nowrap><%=result[i][9]%></td>
					<td nowrap><%=result[i][10]%></td>
					<td nowrap><%=result[i][11]%></td>		
					                           
					<td nowrap><%=result[i][12]%></td>		
					<td nowrap><%=result[i][13]%></td>		
					
					<td nowrap><%=result[i][14]%></td>		
					<td nowrap><%=result[i][15]%></td>		
					<td nowrap><%=result[i][16]%></td>		
					<td nowrap><%=result[i][17]%></td>		
					<td nowrap><%=result[i][18]%></td>		
					<td nowrap><%=result[i][19]%></td>		
					<td nowrap><%=result[i][20]%></td>		
					<td nowrap><%=result[i][21]%></td>		
					<td nowrap><%=result[i][22]%></td>		
					<td nowrap><%=result[i][23]%></td>		
					<td nowrap><%=result[i][24]%></td>		
				</tr>
	<%
			}
		}
	}
	else{
	%>
	<script language="JavaScript">
		rdShowMessageDialog("��ѯ����!<br>������룺'<%=retCode%>'��������Ϣ��'<%=retMsg%>'��",0);
		history.go(-1);
	</script>
<%
	}
%>	
</table>
<br>
</div>
<table cellspacing="0">
	<tr>
    <td noWrap colspan="12" id="footer">
			<div align="center">
 				<input type="button" name="print" class="b_foot" value="ȷ��" onClick="removeCurrentTab()">
               &nbsp;
				<input type="button" name="return1" class="b_foot" value="����" onClick="history.go(-1)">
              &nbsp;
        <input type="button" name="close1" class="b_foot" value="�ر�" onClick="removeCurrentTab()">
      </div>
   	</td>
	</tr>
<table>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>


