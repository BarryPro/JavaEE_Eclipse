 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-20 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "b857";
	String opName = "WLAN��̬�����޸�";
%>
<HTML>
	<HEAD>
		<TITLE>WLAN��̬�����޸�</TITLE>

<script language=javascript>
			function CheckForm(frm){
				var phone=document.frm.phone.value.trim();
				var oldPass=document.frm.oldPass.value.trim();
				var newPass=document.frm.newPass.value.trim();
				var cfmPass=document.frm.cfmPass.value.trim();
				if(phone==""){
					rdShowMessageDialog("�������û����룡");
					return false;
				}
				if(oldPass==""){
					rdShowMessageDialog("�������û�ԭ���룡");
					return false;
				}
				if(newPass==""){
					rdShowMessageDialog("�����������룡");
					return false;
				}
				if(cfmPass==""){
					rdShowMessageDialog("������ȷ�����룡");
					return false;
				}
				if(newPass==oldPass){
					rdShowMessageDialog("�������ԭ���벻����ͬ��");
					return false;
				}
				if(newPass!=cfmPass){
					rdShowMessageDialog("�������������벻һ�£�");
					return false;
				}
				if(!check(frm)) return false;
			}
			function doProcess(packet){
				var count = packet.data.findValueByName("count");
				if(count=="0")
				{
					rdShowMessageDialog("�û�����������������룡");
					document.frm.phone.value='';
				}
			}
			function checkPhone(){
				var phone = document.frm.phone.value.trim();
				if(phone!=""){
					var myPacket = new AJAXPacket("checkPhone.jsp","���ڶ��û����������֤�����Ժ�......");
					myPacket.data.add("phone",phone);
					core.ajax.sendPacket(myPacket);
					myPacket=null;
				}
			}
</script>
	</HEAD>
	<body>
		<FORM action="fb857_sub.jsp" method=post name="frm" id="form1" onsubmit="return CheckForm(this)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">WLAN��̬�����޸�</div>
			</div>
			<table id=tbs9 cellspacing=0>
				<TBODY>
			        <tr>
			        	<td class="blue">�û�����</td>
			       		<TD ><input name="phone" type="text" id="phone" size=20 maxlength="11"  onblur = "checkPhone()">
			       			<font class="orange">*</font>
						</TD>

				     <td class="blue" >ҵ������</td>
						<td colspan=3>
			                <select name='BizType'>
			                	<option value='02' selected >02->WLAN����ҵ��</option>
			                	<!--<option value='92' >92->WLAN��Уҵ��</option>-->
			                </select>
			            </td>
				</tr>
				<tr>
			       <jsp:include page="/npage/common/pwd_b857.jsp">
					  <jsp:param name="width1" value=""  />
					  <jsp:param name="width2" value=""  />
					  <jsp:param name="poname" value="oldPass"  />
					  <jsp:param name="pname" value="newPass"  />
					  <jsp:param name="pcname" value="cfmPass"  />
					  <jsp:param name="pwdLength" value="64"  />
					</jsp:include>
					<jsp:include page="/npage/common/pwd_comm.jsp"/>
				</tr>
				 </TBODY>
			</table>
			<table cellSpacing=0>
				<TBODY>
			            <TR>
			              <TD  id="footer">
				              	<input class="b_foot" name=submit  type=submit value="ȷ��" id=Button1>&nbsp;&nbsp;
				                <input class="b_foot" name=back  type=button value="���" id=Button2 onclick="">&nbsp;&nbsp;
				                <input class="b_foot" name=back1  type=button value=�ر� id=Button2 onclick="removeCurrentTab()">
			                </TD>
			            </TR>
				</TBODY>
			</TABLE>
			<input type=hidden name=op_code value="b857">
			<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>

