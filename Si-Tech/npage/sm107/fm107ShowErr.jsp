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
		String regionCode = (String)session.getAttribute("regCode");
		String errorStr = (String)request.getParameter("errorStr");
		
		
		
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
		 
%>
	
	

<html>
<head>
	<title></title>
	<script language="javascript">
		
	</script>
	</head>
<body>
	<form action="" method="post" name="form_i146Qry" id="form_i146Qry">
	<%@ include file="/npage/include/header.jsp" %>
	
	<table>
		<tr>
			<th colspan='2'>δ�ɹ������б�</th>
		</tr>
		<tr>
			<th>δ��ӳɹ�����</th>
			<th>ʧ��ԭ��</th>
		</tr>
		<%=errorStr%>
	</table>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="removeCurrentTab();">
							<input  name="back1"  class="b_foot" type="button" value=���� id="Button2" onclick="window.location='fm107_main.jsp?opCode=m107&opName=��Ա���Ӱ�����&crmActiveOpCode=m107'">
						</td>
					</tr>
	</table>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
