<%
  /*
   * ����:* 
   * �汾: 1.0
   * ����: * gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		
		String iOpCode = (String)request.getParameter("iOpCode");
		String iOpName = (String)request.getParameter("iOpName");
		String iLoginNo = (String)request.getParameter("iLoginNo");
		
		String iRegionCode = (String)session.getAttribute("regCode");
		String unitCode = (String)request.getParameter("unitCode");
		String op_type = "u10"; 
		String opCode = iOpCode;
		String opName = iOpName;
		
		 String paraAray[] = new String[10];
		 paraAray[0]=iLoginNo;
		 paraAray[1]=unitCode;
		 paraAray[2]=op_type;
		 
		 
		 
%>
<wtc:service name="s3096QryCheckE" routerKey="regionCode" routerValue="<%=iRegionCode%>" retcode="errCode" retmsg="errMsg"  outnum="14">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
	</wtc:service>
	<wtc:array id="result"   scope="end" />
<%
	if(errCode.equals("0") || errCode.equals("000000")){
		System.out.println("���÷��� s3096QryCheckE in fm260BindQry.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@result.length=="+result.length);

%>
<%
	}else{
		System.out.println("���÷��� s3096QryCheckE in fm260BindQry.jsp �ɹ� ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.close();
	</script>
<%
	}		

%>		
	

<html>
<head>
	<title></title>
	<script language="javascript">
		$(document).ready(function(){
			
		});
		/*��ҳ�渳ֵ����*/
		function giveFa(){
			
			var radVal = $("input[name='selOp'][checked]").val();
			var infoArray = new Array();
			infoArray = radVal.split("|");
			window.opener.$("#phoneNo").val(infoArray[0]);
			window.opener.$("#bindNum").val(infoArray[1]);
			window.opener.$("#product_id").val(infoArray[2]);
			/*2015/02/10 16:49:15 gaopeng �ûҲ�ѯ���Ų�Ʒ��ť*/
			window.opener.$("#qryUnitBtn").attr("disabled","disabled");
			/*2015/02/10 16:49:15 gaopeng ��ʾ��������*/
			
			window.opener.$("#unitCode").attr("readonly","readonly");
			window.opener.$("#unitCode").attr("class","InputGrey");
			window.opener.$("#phoneNo").attr("readonly","readonly");
			window.opener.$("#phoneNo").attr("class","InputGrey");
			window.opener.$("#bindNum").attr("readonly","readonly");
			window.opener.$("#bindNum").attr("class","InputGrey");
			window.close();
		}
		
	</script>
	</head>
<body>
	<form action="" method="post" name="form_i146Qry" id="form_i146Qry">
	<%@ include file="/npage/include/header.jsp" %>
	<div>
		<div>
	<table >
		<tr>
			<TH nowrap>֤������</TH>
			<TH nowrap>���ſͻ�ID</TH>
			<TH nowrap>���ſͻ�����</TH>
			<TH nowrap>���Ų�ƷID</TH>
			<TH nowrap>�����û����</TH>
			<TH nowrap>�û�����</TH>
			<TH nowrap>��Ʒ����</TH>
			<TH nowrap>��Ʒ����</TH>
			<TH nowrap>���ű��</TH>
			<TH nowrap>��Ʒ�����ʻ�</TH>
			<TH nowrap>Ʒ������</TH>
			<TH nowrap>�������</TH></TR>
		</tr>
		<%
		System.out.println("gaopengSeeLog=========result.length="+result.length);
		if((errCode.equals("0")||errCode.equals("000000")) && result.length > 0){
				for(int i=0;i<result.length;i++){
		%>
				<tr>
					<td><input type="radio" name="selOp" value="<%=result[i][12]%>|<%=result[i][13]%>|<%=result[i][3]%>"/></td>
					<td><%=result[i][1]%></td>
					<td><%=result[i][2]%></td>
					<td><%=result[i][3]%></td>
					<td><%=result[i][4]%></td>
					<td><%=result[i][5]%></td>
					<td><%=result[i][6]%></td>
					<td><%=result[i][7]%></td>
					<td><%=result[i][8]%></td>
					<td><%=result[i][9]%></td>
					<td><%=result[i][10]%></td>
					<td><%=result[i][11]%></td>
				</tr>
				
		<%
			
			 }
			}
		%>
		<td align=center colspan="12" id="footer">
				<input class="b_foot" name="sure"  type="button" value="ȷ��"  onclick="giveFa();">&nbsp;&nbsp;
		</td>
		
	</table>
		<div>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>