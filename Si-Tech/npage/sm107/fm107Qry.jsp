<%
  /*
   * ����:����ͳ��ҵ��ʡ����ʡ֧��ģʽ֧�Ÿ���
   * �汾: 1.0
   * ����: 2014/11/04 9:20:00
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
		
		String iLoginAccept = (String)request.getParameter("iLoginAccept");
		String iChnSource = (String)request.getParameter("iChnSource");
		String iOpCode = (String)request.getParameter("iOpCode");
		String iOpName = (String)request.getParameter("iOpName");
		String iLoginNo = (String)request.getParameter("iLoginNo");
		String iLoginPwd = (String)request.getParameter("iLoginPwd");
		String iPhoneNo = (String)request.getParameter("iPhoneNo");
		String iUserPwd = (String)request.getParameter("iUserPwd");
		String iSuitID = (String)request.getParameter("suitID");
		String regionCode = (String)session.getAttribute("regCode");
		
		
		String opCode = iOpCode;
		String opName = iOpName;
		
		 String paraAray[] = new String[10];
		 paraAray[0]=iLoginAccept;
		 paraAray[1]=iChnSource;
		 paraAray[2]=iOpCode;
		 paraAray[3]=iLoginNo;
		 paraAray[4]=iLoginPwd;
		 paraAray[5]=iPhoneNo;
		 paraAray[6]=iUserPwd;
		 paraAray[7]=iSuitID;
		 
%>
<wtc:service name="sm107Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
	if(errCode.equals("0") || errCode.equals("000000")){
		System.out.println("���÷��� sm107Qry in fm107Qry.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
<%
	}else{
		System.out.println("���÷��� sm107Qry in fm107Qry.jsp �ɹ� ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
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
		function giveOpenerVal(){
			
			var selectVal = $.trim($("input[name='selectRadio'][checked]").val());
			if(selectVal == ""){
				rdShowMessageDialog("��ѡ���Ա��",1);
				return false;
			}
			var relationID = selectVal.split("|")[0];
			var suitID = selectVal.split("|")[1];
			
			var relationIDObj = window.opener.$("#relationID");
			var suitIDObj = window.opener.$("#suitID");
			var submitBtnObj = window.opener.$("#submitBtn");
			
			
			suitIDObj.val(relationID);
			suitIDObj.attr("disabled","disabled");
			submitBtnObj.attr("disabled","");
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
			<th>����</th>
			<th>�ײ�ID</th>
			<th>�ײ�����</th>
		</tr>
		<%if((errCode.equals("0")||errCode.equals("000000")) && result.length > 0){
				for(int i=0;i<result.length;i++){
		%>
				<tr>
					<td><input type="radio" name="selectRadio" value="<%=result[i][0]%>|<%=result[i][1]%>" /></td>
					<td><%=result[i][0]%></td>
					<td><%=result[i][1]%></td>
				</tr>
				
		<%
			
			 }
			}
		%>
		
	</table>
		<div>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="ȷ��" onclick="giveOpenerVal()" id="Button1">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="window.close()">
						</td>
					</tr>
	</table>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
