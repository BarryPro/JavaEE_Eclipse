 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "b857";
	String opName = "WLAN静态密码修改";
%>
<HTML>
	<HEAD>
		<TITLE>WLAN静态密码修改</TITLE>

<script language=javascript>
			function CheckForm(frm){
				var phone=document.frm.phone.value.trim();
				var oldPass=document.frm.oldPass.value.trim();
				var newPass=document.frm.newPass.value.trim();
				var cfmPass=document.frm.cfmPass.value.trim();
				if(phone==""){
					rdShowMessageDialog("请输入用户号码！");
					return false;
				}
				if(oldPass==""){
					rdShowMessageDialog("请输入用户原密码！");
					return false;
				}
				if(newPass==""){
					rdShowMessageDialog("请输入新密码！");
					return false;
				}
				if(cfmPass==""){
					rdShowMessageDialog("请输入确认密码！");
					return false;
				}
				if(newPass==oldPass){
					rdShowMessageDialog("新密码和原密码不能相同！");
					return false;
				}
				if(newPass!=cfmPass){
					rdShowMessageDialog("两次输入新密码不一致！");
					return false;
				}
				if(!check(frm)) return false;
			}
			function doProcess(packet){
				var count = packet.data.findValueByName("count");
				if(count=="0")
				{
					rdShowMessageDialog("用户号码错误，请重新输入！");
					document.frm.phone.value='';
				}
			}
			function checkPhone(){
				var phone = document.frm.phone.value.trim();
				if(phone!=""){
					var myPacket = new AJAXPacket("checkPhone.jsp","正在对用户号码进行验证，请稍候......");
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
				<div id="title_zi">WLAN静态密码修改</div>
			</div>
			<table id=tbs9 cellspacing=0>
				<TBODY>
			        <tr>
			        	<td class="blue">用户号码</td>
			       		<TD ><input name="phone" type="text" id="phone" size=20 maxlength="11"  onblur = "checkPhone()">
			       			<font class="orange">*</font>
						</TD>

				     <td class="blue" >业务类型</td>
						<td colspan=3>
			                <select name='BizType'>
			                	<option value='02' selected >02->WLAN大众业务</option>
			                	<!--<option value='92' >92->WLAN高校业务</option>-->
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
				              	<input class="b_foot" name=submit  type=submit value="确认" id=Button1>&nbsp;&nbsp;
				                <input class="b_foot" name=back  type=button value="清除" id=Button2 onclick="">&nbsp;&nbsp;
				                <input class="b_foot" name=back1  type=button value=关闭 id=Button2 onclick="removeCurrentTab()">
			                </TD>
			            </TR>
				</TBODY>
			</TABLE>
			<input type=hidden name=op_code value="b857">
			<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>

