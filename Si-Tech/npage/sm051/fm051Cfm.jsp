<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:R_CMI_HLJ_xueyz_2014_1365513@���ڿ����������vip���ܵ�����
   * �汾: 1.0
   * ����: 2014/03/12 16:22:30
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	0 iLoginAccept ��ˮ
		1 iChnSource  ��������
		2 iOpCode    ��������
		3 iLoginNo    ����
		4 iLoginPwd   ��������
		5 iPhoneNo   �û��ֻ�����
		6 iUserPwd   �û��ֻ�����
		7 sOfferId    �ʷѴ���
		8 sSchool     ѧУ����
		9 sClass      �༶����
*/

	/*===========��ȡ����============*/
 	String iLoginAccept = 	(String)request.getParameter("iLoginAccept");
 	String iChnSource = 	(String)request.getParameter("iChnSource");
 	String iOpCode = 	(String)request.getParameter("iOpCode");
 	String iLoginNo = 	(String)request.getParameter("iLoginNo");
 	String iLoginPwd = 	(String)request.getParameter("iLoginPwd");
 	String iPhoneNo = 	(String)request.getParameter("iPhoneNo");
 	String iUserPwd = 	(String)request.getParameter("iUserPwd");
 	String iFileNo = 	(String)request.getParameter("iFileNo");
 	String iFileName = 	(String)request.getParameter("iFileName");
 	String iOpNote = 	(String)request.getParameter("iOpNote");
 	String iOpSource = 	(String)request.getParameter("iOpSource");
 	String iInputFile = 	(String)request.getParameter("iInputFile");
 	String iFileIpAddr = 	(String)request.getParameter("iFileIpAddr");
 	String opName = 	(String)request.getParameter("opName");
 	String opCode = iOpCode;
 	
  String regionCode = (String)session.getAttribute("regCode");			
  
  String inParam[] = new String[13];
  inParam[0] = iLoginAccept;
  inParam[1] = iChnSource;
  inParam[2] = iOpCode;          
  inParam[3] = iLoginNo;
  inParam[4] = iLoginPwd;
  inParam[5] = iPhoneNo;
  inParam[6] = iUserPwd;
  inParam[7] = iFileNo;
  inParam[8] = iFileName;
  inParam[9] = iOpNote;
  inParam[10] = iOpSource;
  inParam[11] = iInputFile;
  inParam[12] = iFileIpAddr;
%>
<%
			/********************************************
				*@�������ƣ�sm051Cfm
				*@�������ڣ�2014/03/12
				*@����汾��Ver1.0
				*@������Ա��liuminga
				*@����������
				*@���������
				*@ iLoginAccept ҵ����ˮ
				*@ iChnSource ������ʶ
				*@ iOpCode ��������
				*@ iLoginNo ��������
				*@ iLoginPwd ��������
				*@ iPhoneNo �������
				*@ iUserPwd ��������
				*@ iFileNo �ļ����
				*@ iFileName �ļ�����
				*@ iOpNote ������ע
				*@ iOpSource ������Դ������/ʡ��˾
				*@ iInputFile �ļ�·��
				*@ iFileIpAddr �ļ�IP��ַ
				
				*@���ز�����
				*@ oRetCode ���ش���
				*@ oRetMsg ������Ϣ
			*********************************************/
		%>
<wtc:service name="sm051Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
		<wtc:param value="<%=inParam[0]%>" />
		<wtc:param value="<%=inParam[1]%>" />
		<wtc:param value="<%=inParam[2]%>" />
		<wtc:param value="<%=inParam[3]%>" />
		<wtc:param value="<%=inParam[4]%>" />
		<wtc:param value="<%=inParam[5]%>" />
		<wtc:param value="<%=inParam[6]%>" />
		<wtc:param value="<%=inParam[7]%>" />
		<wtc:param value="<%=inParam[8]%>" />
		<wtc:param value="<%=inParam[9]%>" />
		<wtc:param value="<%=inParam[10]%>" />
		<wtc:param value="<%=inParam[11]%>" />
		<wtc:param value="<%=inParam[12]%>" />
	</wtc:service>
	<wtc:array id="result1" start="0" length="1"  scope="end"/>
	<wtc:array id="result2" start="1" length="2"  scope="end"/>
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷��� sm051Cfm in fm051Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("����ɹ������ڽ�չʾ������Ϣ");
		
	</script>
<%
	}else{
		System.out.println("���÷��� sm051Cfm in fm051Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		
	</script>
<%
	}		
%>	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
	</script>
</head>
<body>
	<form >
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�������б�</div>
	</div>
	<div>
	<table>
		<%if(errCode.equals("0")||errCode.equals("000000")){%>
			<tr>
				<td class="blue" width="30%">ִ�гɹ�����</td>
				<td><%=result1[0][0]%></td>
			</tr>
		<%}%>
		<tr>
			<th>�ֻ�����</th>
			<th>������Ϣ</th>
		</tr>
		<%if(errCode.equals("0")||errCode.equals("000000")){
				for(int i=0;i<result2.length;i++){
		%>
			<tr>
				<td><%=result2[i][0]%></td>
				<td><%=result2[i][1]%></td>
			</tr>
		<%}
		}%>
	</table>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="����" onclick="history.go(-1)" id="submitr" >&nbsp;&nbsp;
							
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>