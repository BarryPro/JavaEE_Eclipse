<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:
   * �汾: 1.0
   * ����: 
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	/*===========��ȡ����============*/
  String  iLoginAccept = (String)request.getParameter("loginAccept");  
  String  iChnSource = "01";
  String  opCode = (String)request.getParameter("iopCode");
  String  iopCode = "g293";
  String  iLoginNo = (String)request.getParameter("workNo");
  String  iLoginPwd = (String)request.getParameter("noPass");
  String  iPhoneNo = (String)request.getParameter("phoneNo");
  String  iUserPwd = "";
  String regionCode = (String)session.getAttribute("regCode");			
  String opName = 	(String)request.getParameter("iopName");           
%>
<wtc:service name="sG293Init" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="01" />
		<wtc:param value="<%=iopCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="" />
	</wtc:service>
	<wtc:array id="result22" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sG293Init in fg293Qry.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
	
	</script>
<%
	}else{
		System.out.println("���÷���sG293Init in fg293Qry.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location = 'fg293Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
	
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<tr>
			<th width="33%">
				���ڿ�ʼʱ��
			</th>
			<th width="33%">
				������
			</th>
			<th width="33%">
				��������
			</th>
		</tr>
		<%
			if(result22.length>0){
				for(int i=0;i<result22.length;i++){
		%>
			<tr>
				<td width="33%"><%=result22[i][0]%></td>
				<td width="33%" ><%=result22[i][1]%></td>
				<td width="33%"><%=result22[i][2]%></td>
			</tr>
		<%
			}
				}
		%>
	</table>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="resetsd"  class="b_foot" type="button" value="����" onclick="javascript:window.location.href='/npage/sg293/fg293Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value="�ر�" id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
