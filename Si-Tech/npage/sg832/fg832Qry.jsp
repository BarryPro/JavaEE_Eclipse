<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:���Ӫ��������Ϣ��ѯ(g832)
   * �汾: 1.0
   * ����: 2013/07/15 10:09:54
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/**			 
				 ���������
         iLoginAccept                	��ˮ
         iChnSource              	   	������ʶ
         iOpCode                 		��������
         iLoginNo              	   	����
         iLoginPwd                   	��������
         iPhoneNo              	   	�ֻ�����
         iUserPwd                 	��������
         iOpNote                 		������ע
         iCfmLogin                 	�������
		*/

	/*===========��ȡ����============*/
  String  iLoginAccept = (String)request.getParameter("iLoginAccept");  
  String  iChnSource = (String)request.getParameter("iChnSource");  
  String  iOpCode = (String)request.getParameter("iOpCode");
  String  iopName = (String)request.getParameter("iOpName");
  String  iLoginNo = (String)request.getParameter("iLoginNo");
  String  iLoginPwd = (String)request.getParameter("iLoginPwd");
  String  iPhoneNo = (String)request.getParameter("iPhoneNo");
  String  iUserPwd = (String)request.getParameter("iUserPwd");
  String  iOpNote = (String)request.getParameter("iOpNote");
  String  iCfmLogin = (String)request.getParameter("iCfmLogin");
  String 	regionCode = (String)session.getAttribute("regCode");
  
   String paraAray[] = new String[9];
		 paraAray[0]=iLoginAccept;
		 paraAray[1]=iChnSource;
		 paraAray[2]=iOpCode;
		 paraAray[3]=iLoginNo;
		 paraAray[4]=iLoginPwd;
		 paraAray[5]=iPhoneNo;
		 paraAray[6]=iUserPwd;
		 paraAray[7]=iOpNote;
		 paraAray[8]=iCfmLogin;
%>
<wtc:service name="sG832Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="10">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
		<wtc:param value="<%=paraAray[8]%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sG832Qry in fg832Qry.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
	}else{
		System.out.println("���÷���sG832Qry in fg832Qry.jsp errCode| errMsgʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@"+errCode+errMsg);
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location = 'fg832Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>';
	</script>
<%
	}	
%>
<body>
	<%
	if(errCode.equals("0")||errCode.equals("000000")){
	%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">���Ӫ��������Ϣ</div>
			</div>
	<table cellspacing="0">
		<tr>
			<td width="15%" class="blue">�ֻ�����</td>
			<td width="35%">
				<%=result1[0][0]%>
			</td>
			<td width="15%" class="blue">�������</td>
			<td width="35%">
				<%=result1[0][1]%>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">Ӫ��������</td>
			<td width="35%">
				<%=result1[0][2]%>
			</td>
			<td width="15%" class="blue">Ӫ�������ʱ��</td>
			<td width="35%">
				<%=result1[0][3]%>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">����ۿ�</td>
			<td width="35%">
				<%=result1[0][4]%>&nbsp;��
			</td>
			<td width="15%" class="blue">����ʷ�����</td>
			<td width="35%">
				<%=result1[0][5]%>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">�������ʱ��</td>
			<td width="35%">
				<%=result1[0][6]%>
			</td>
			<td width="15%" class="blue">�����ǰ״̬</td>
			<td width="35%">
				<%=result1[0][7]%>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">�������ʱ��</td>
			<td width="35%">
				<%=result1[0][8]%>
			</td>
			<td width="15%" class="blue">����������ʱ��</td>
			<td width="35%">
				<%=result1[0][9]%>
			</td>
		</tr>
		
	</table>
	<%}%>
</body>
</html>	