
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "zg57";
	String opName = "������ϢͶ�߹ػ�_���������ѯ";
	String work_no = (String) session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");
	String org_code = (String) session.getAttribute("orgCode");
	String regionCode = org_code.substring(0, 2);
	
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));

	String s_flag="Y";
	String s_souce="��";
	String s_souce_name="��";
	String s_op_flag="��";
	String s_login_no="��";
	String s_op_time="��";
	String s_note="��";

	String[] inParamS = new String[2];
	inParamS[0] = "select a.OPR_CODE,a.MESSAGE_FLAG,a.LOGIN_NO,a.REASON_NOTE,a.OP_TIME,a.REASON_NOTE "
								+" from "
								+" (select  DECODE(OPR_CODE,'01','�ѼӺ�','02','�ѽ��','03','�ѼӺ�','04','�ѽ��','05','�ѼӺ�','06','�ѽ��') OPR_CODE,DECODE(MESSAGE_FLAG,'01','��������','02','ɧ�ŵ绰','03','��������') MESSAGE_FLAG, LOGIN_NO,REASON_NOTE, to_char(OP_TIME,'yyyymmdd hh24:mi:ss') OP_TIME "
								+" 	from WINFORMATIONSAFEMSG "
								+" 	where PHONE_NO =:phone_no "
								+" 	order by OP_TIME desc "
								+" ) a "
								+" WHERE ROWNUM = 1  ";
	inParamS[1] = "phone_no=" + phoneNo;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeS" retmsg="retMsgS" outnum="6">
	<wtc:param value="<%=inParamS[0]%>"/>
	<wtc:param value="<%=inParamS[1]%>"/>
</wtc:service>
<wtc:array id="resultS"  scope="end"/>
<%
	if("000000".equals(retCodeS)){
		if(resultS.length==0){
			s_flag="N";
		}else{
			s_flag="Y";
			s_op_flag=resultS[0][0]; //������״̬
			s_souce=resultS[0][1]; //���������������
			s_login_no=resultS[0][2]; //�������Ĳ�������
			s_souce_name=resultS[0][3]; //�����������ԭ��
			s_op_time=resultS[0][4]; //�������Ĳ���ʱ��
			s_note=resultS[0][5]; //�������Ĳ�����ע
		}
	}
%>
<html>
	<META http-equiv=Content-Type content="text/html; charset=GBK">
	<head>
		<title><%=opName%></title>
		<script language=javascript>
			function add(){
				frm.action="zg57_1_add.jsp";
				frm.submit();
			}

			function change(){
				frm.action="f6945_chg.jsp?";
				frm.submit();
			}
			
			function goBack(){
				window.location.href="zg57.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
		</script>
	</head>
	<body>
		<form name="frm" method="POST" action="">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">�û���Ϣ</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td class="blue" width="15%" nowrap>�ֻ�����</td>
				    <td colspan="3">
				    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="30" readonly>
				    </td>
				</tr>
				<tr>
					<td class="blue" width="15%" nowrap>������״̬</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="isBlack" id="isBlack" value="<%=s_op_flag%>" size="30" readonly>
					</td>
					<td class="blue" width="15%" nowrap>�����������ԭ��</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="blackReason" id="blackReason" value="<%=s_souce_name%>" size="30" readonly>
					</td>
				</tr>
					<tr>
					<td class="blue" width="15%" nowrap>���������������</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="blackLogin" id="blackLogin" value="<%=s_souce%>" size="30" readonly>
					</td>
					<td class="blue" width="15%" nowrap>�������Ĳ���ʱ��</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="blackTime" id="blackTime" value="<%=s_op_time%>" size="30" readonly>
					</td>
				</tr>
				<tr>
					<td class="blue" width="15%" nowrap>�������Ĳ�������</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="isGsms" id="isGsms" value="<%=s_login_no%>" size="30" readonly>
					</td>
					<td class="blue" width="15%" nowrap>�������Ĳ�����ע</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="gsmsCancle" id="gsmsCancle" value="<%=s_note%>" size="30" readonly>
					</td>
				</tr>
    		<tr>
        	<td colspan="4" id="footer">
					<%if(s_flag.equals("N")){ //�޽��%>	
					    <input class="b_foot" type="button" name="b_add" value="���" onClick="add();" />
					<%}else{ //�н��
							if(!"�ѼӺ�".equals(s_op_flag)){
					%>
								<input class="b_foot" type="button" name="b_add" value="���" onClick="add();" />
					<%	}
						}
					%>
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="����" onClick="goBack()">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="�ر�" onClick="removeCurrentTab();">
        	</td>
    		</tr>
			</table>
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">
    	<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>