<%
  /*
   * ����:˫���ں�V����Ա�ײ�����
   * �汾: 1.0
   * ����: 2013/11/21 16:11:37
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		
 		String loginAccept = getMaxAccept();
 		String  inputParsm [] = new String[7];
		inputParsm[0] = loginAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = loginNo;
		inputParsm[4] = noPass;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		
	
%>
<wtc:service name="si356Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="9">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
		</wtc:service>
<wtc:array id="currentInfo" start="0" length="4" scope="end"/>
<wtc:array id="historyInfo" start="4" length="5" scope="end"/>


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
	<form action="" method="post" name="form_i356" id="form_i356">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ǰ״̬�б�</div>
	</div>
	<div>
	<table >
		<tr>
			<th>�ֻ�����</th>
			<th>��ֵ���</th>
			<th>����ʱ��</th>
			<th>��������</th>
			<th>�Ƿ����ý��߹���</th>
		</tr>
		<%if(currentInfo.length > 0){%>
		<tr>
			<td><%=phoneNo%></td>
			<td><%=currentInfo[0][0]%></td>
			<td><%=currentInfo[0][1]%></td>
			<td><%=currentInfo[0][2]%></td>
			<td><% if("1".equals(currentInfo[0][3])){out.print("��");}if("0".equals(currentInfo[0][3])){out.print("��");}%></td>
		</tr>
	<%}%>
	</table>
	
</div>
<div class="title">
		<div id="title_zi">��ʷ״̬�б�</div>
	</div>
	<div>
	<table >
	<tr>
			<th>�ֻ�����</th>
			<th>��ֵ���</th>
			<th>����ʱ��</th>
			<th>��������</th>
			<th>�Ƿ����ý��߹���</th>
			<th>״̬</th>
		</tr>
		<%if(historyInfo.length > 0){
			for(int i=0;i<historyInfo.length;i++){
		%>
		<tr>
			<td><%=phoneNo%></td>
			<td><%=historyInfo[i][0]%></td>
			<td><%=historyInfo[i][1]%></td>
			<td><%=historyInfo[i][2]%></td>
			<td><% if("1".equals(historyInfo[0][4])){out.print("��");}if("0".equals(historyInfo[0][4])){out.print("��");}%></td>
			<td><% if("A".equals(historyInfo[0][3])){out.print("����");}if("U".equals(historyInfo[0][3])){out.print("�޸�");}if("D".equals(historyInfo[0][3])){out.print("ɾ��");}%></td>
		</tr>
		<%
			}
		}
		%>
	</table>
	
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
