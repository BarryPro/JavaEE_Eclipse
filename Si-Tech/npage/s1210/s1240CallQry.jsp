<%
  /*
   * ����:�������״̬��Ϣ��ѯ-��ѯ���ҳ��
   * �汾: 1.0
   * ����: 20121015
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**
 * ������:sQryKdState
 * input : 
 *			0 ҵ����ˮ			iLoginAccept
 *			1 ������ʶ			iChnSource
 *			2 ��������			iOpCode
 *			3 ����					iLoginNo
 *			4 ��������			iLoginPwd
 *			5 ����					iPhoneNo
 *			6 ��������			iUserPwd
 *			7 ��֯��������	iGroupId
 *			8 ����˺�			sKdUser
 *			9 �쳣��				sErrFlag (��ʶ����ѯ�쳣������1Ϊ��ѯ�쳣����0Ϊȫ��)
 *		 10 ��ʼʱ��			iStartTime
 *     11 ����ʱ��			iEndTime

*/

	/*===========��ȡ����============*/
  String iLoginAccept = "0";  //0||''
	String iChnSource = "01";  //01
  String opCode = (String)request.getParameter("opCode");//
  String iLoginNo = (String)session.getAttribute("workNo");//(String)session.getAttribute("workNo");
  String iLoginPwd = (String)session.getAttribute("password");;//(String)session.getAttribute("password");
  String iPhoneNo = (String)request.getParameter("activePhone");//ǰ̨
  String iUserPwd = (String)request.getParameter("iUserPwd");//''
  String regionCode = (String)session.getAttribute("regCode");
  String opName = (String)request.getParameter("opName");//
   
%>
<wtc:service name="sCallTransQry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="5">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
	</script>
	</head>
	
<%
		if("000000".equals(errCode)){
			System.out.println("============ s1240CallQry.jsp ==========" + result1.length);
		}else{
%>
			<script language="javascript">
	      rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
	      window.location = 's1240Jump.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	   	</script>
<%
		}
%>	
<body>
	<form action="" method="post" name="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0" name="t1" id="t1">
		<% if(!"".equals(result1[0][1])){%>
			<tr>
				<td class="blue" width="25%">��������ת����</td><td><%=result1[0][1]%></td>
			</tr>
		<%}%>
		<% if(!"".equals(result1[0][2])){%>
		<tr>
			<td class="blue" width="25%">��æ��ת����</td><td><%=result1[0][2]%></td>
		</tr>
		<%}%>
		<% if(!"".equals(result1[0][3])){%>
		<tr>
			<td class="blue" width="25%">��Ӧ���ת����</td><td><%=result1[0][3]%></td>
		</tr>
		<%}%>
		<% if(!"".equals(result1[0][4])){%>
		<tr>
			<td class="blue" width="25%"> ���ɼ���ת����</td><td><%=result1[0][4]%></td>
		</tr>
		<%}%>
	</table>
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<!--
			<input type="button" class="b_foot" value="��ѯ" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			-->
			<input type="button" class="b_foot"  value="����" onclick="javascript:window.location.href='/npage/s1210/s1240Jump.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=request.getParameter("crmActiveOpCode")%>&activePhone=<%=request.getParameter("activePhone")%>'"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
