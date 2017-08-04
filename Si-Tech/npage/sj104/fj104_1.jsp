<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wangwg @ 20170608
 ********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String opCode = "J104";
	String opName = "ħ�ٺͻ����лؿ�";
	String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String op_name =  "ħ�ٺͻ����лؿ�";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=op_name%></TITLE>
		<script language=javascript>
			function isNumberString (InString,RefString){
				if(InString.length==0) return (false);
				for (Count=0; Count < InString.length; Count++)  {
				        TempChar= InString.substring (Count, Count+1);
				        if (RefString.indexOf (TempChar, 0)==-1)  
				        return (false);
				}
				return (true);
			}
			function doProcess(packet)
			{
				//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
				var error_code = packet.data.findValueByName("errorCode");
				var error_msg =  packet.data.findValueByName("errorMsg");
				var verifyType = packet.data.findValueByName("verifyType");
				self.status="";
				if(verifyType=="phoneno"){
					if( parseInt(error_code) == 0 ){
						rdShowMessageDialog(error_msg,2);
						location.reload();
					}else{
						rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]",0);
						return false;
					}
				}
			}
			function docheck(){
				
				if(document.form1.phoneNo.value.length<11 || isNumberString(document.form1.phoneNo.value,"1234567890")!=1) {
					rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
					document.form1.phoneNo.focus();
					return false;
				}
				
				if(document.form1.PARM_VALUE.value.length!=1)
				{
					rdShowMessageDialog("��ѡ�������");
					return false;
				}
				
				if(document.form1.ImeiNo.value.length<15 || isNumberString(document.form1.ImeiNo.value,"1234567890")!=1) {
					rdShowMessageDialog("Imei��ʽ��֤��ͨ��!!");
					document.form1.phoneNo.focus();
					return false;
				}
				
				if(document.form1.UnitId.value.length<32 || isNumberString(document.form1.UnitId.value,"1234567890ABCDEFabcdef")!=1) {
					rdShowMessageDialog("������ID��ʽ��֤��ͨ��!!");
					document.form1.phoneNo.focus();
					return false;
				}
				
				var myPacket = new AJAXPacket("fj104_cfm.jsp","����ȷ�ϣ����Ժ�......");
				myPacket.data.add("verifyType","phoneno");
				myPacket.data.add("phoneno",document.form1.phoneNo.value);  
				myPacket.data.add("imeino",document.form1.ImeiNo.value);  
				myPacket.data.add("unitid",document.form1.UnitId.value);  
				myPacket.data.add("typeid",document.form1.PARM_VALUE.value);  
	  			core.ajax.sendPacket(myPacket);
	 			myPacket=null;
			}
		</script>
	</HEAD>
	<BODY>
		<FORM action="fj104_Cfm.jsp" method=post name="form1" id="form1">
			<%@ include file="/npage/include/header.jsp"%>
			<div class="title">
        		<div id="title_zi">ħ�ٺͻ����лؿ�</div>
    		</div>
			<table cellSpacing="0">
				<tr> 
					<td class=blue>�ֻ�����</td>
					<td>
						<input type="text" size="20" name="phoneNo" id="phoneNo">
					</td>
					<td class=blue>������</td>
					<td>
						<select name="PARM_VALUE">
						  <option value="2">������</option> 				<!--������:������:2-->
						  <option value="3">����</option>   				<!--���ϻ���:����:3-->
						  <option value="5" selected>���ٴ�����</option>  	<!--���ٴ�����:����:5-->
						</select>
					</td>
				</tr> 
				<tr> 
				
					<td class=blue>IMEI��</td>
					<td>
						<input type="text" size="40" name="ImeiNo" id="ImeiNo">
					</td>
					<td class=blue>������ID</td>
					<td>
						<input type="text" size="40" name="UnitId" id="UnitId">
					</td>
				</tr>
			</table>
			<table cellspacing="0">
				<tr>
					<td noWrap id="footer">
					<div align="center">
						<input type="button" name="next" class="b_foot" value="���" onclick="docheck()"/>
						&nbsp;
						<input type="button" name="query" class="b_foot" value="���" onclick="location.reload();" />
						&nbsp;
						<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
					</div>
					</td>
				</tr>
			</table>
		</FORM>
	</BODY
</html>