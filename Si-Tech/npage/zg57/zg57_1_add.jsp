<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = "zg57";
	String opName = "������ϢͶ�߹ػ�_���";
	String work_no = (String) session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");
	String org_code = (String) session.getAttribute("orgCode");
	String regionCode = org_code.substring(0, 2);
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginaccept = WtcUtil.repNull(request.getParameter("printAccept"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<META http-equiv=Content-Type content="text/html; charset=GBK">
	<head>
		<title><%=opName%></title>
		<script language=javascript>
			function confirm(){
				if(document.all.shandlingtype.value == ""){
					rdShowMessageDialog("����ԭ�򲻿�Ϊ�գ�");
					return -1;
				}
				if(document.all.sSourceData.value == ""){
					rdShowMessageDialog("�Ӻ����Ͳ���Ϊ�գ�");
					return -2;
				}
				if(document.all.sSourceType.value == ""){
					rdShowMessageDialog("������Դ����Ϊ�գ�");
					return -3;
				}
				if(document.all.blackReason.value == ""){
					rdShowMessageDialog("ԭ��˵������Ϊ�գ�");
					return -4;
				}
				frm.submit();
			}
		</script>
	</head>
	<body>
		<form name="frm" method="POST" action="zg57_1_cfm.jsp">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			  <div id="title_zi">�û���Ϣ</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td class="blue" width="10%" nowrap>�ֻ�����</td>
			    <td class="blue" width="20%">
			    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="30" readonly>
			    </td>
			    <td class="blue" width="10%" nowrap>����ԭ��</td>
			    <td class="blue" width="20%">
			    	<select name="shandlingtype" id="shandlingtype" class="button" >
			    		<option value="0101">���ι���Υ��</option>
			    		<option value="0102">�˹����Υ��</option>
			    		<option value="0103" selected >Ͷ��</option>
			    		<option value="0104">�˹�����</option>
			    		<option value="0105">����</option>
			    	</select>
			    </td>
			    <td class="blue" width="10%" nowrap>�Ӻ�����</td>
			    <td class="blue" width="20%">
			    	<select name="sSourceData" id="sSourceData" class="button" >
			    		<!--<option value="" selected>��ѡ��</option>   huangrong ��ע 2011-6-21 -->
			    		<option value="01">��������</option>
			    		<option value="02" selected>ɧ�ŵ绰</option>
			    		<option value="03" >��������</option>
			    	</select>
			    </td>	    
				</tr>
	      <TR id="bltys"  > 
	      	<TD width="16%" class="blue">������Դ</TD>
          <TD colspan="5">
						<select id="sSourceType" name="sSourceType" style="width:100px;">
							<option value="01">ȫ�����ƽ̨</option>
							<option value="02" >ʡ�ڼ��</option>
							<option value="03" >�ٱ�����</option>
							<option value="04" selected>�û�Ͷ��</option>
						</select>
	         </TD>
	      </TR> 
				<tr>
					<td class="blue" width="10%" nowrap>ԭ��˵��</td>
					<td width="90%" class="blue" colspan="5">
						<input class="button" type="text" name="blackReason" id="blackReason" value="" size="140" maxlength="70">
						<!--huangrong add �޸�ҳ��չʾ��ʽ������ԭ�������70������ 2011-6-21 -->
					</td>
				</tr>
				<tr>
					<td colspan="6" id="footer">
						<input class="b_foot" type="button" name="b_add" value="ȷ��" onClick="confirm();">
						&nbsp;
						<input class="b_foot" type="button" name="b_back" value="����" onClick="history.go(-1);">
						&nbsp;
						<input class="b_foot" type="button" name="b_close" value="�ر�" onClick="removeCurrentTab();">
					</td>
				</tr>
			</table>
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="loginaccept" value="<%=loginaccept%>">
    	<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>