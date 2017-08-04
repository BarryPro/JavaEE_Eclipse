<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%@ page contentType="text/html; charset=GBK" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
	<head>
		<script language="javascript">
			function doReset(){
				window.location.href = "sg237.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
			}
			function qry(){
				if(!check(frm)){
					return false;
				}
				document.all.quchoose.disabled = true;
				var myPacket = new AJAXPacket("sg237_qry.jsp","���ڲ�ѯ�����Ժ�......");
				myPacket.data.add("phoneNo",$("#phoneNo").val());
				core.ajax.sendPacket(myPacket);
				myPacket = null;
			}
			function doProcess(packet){
				document.all.quchoose.disabled = false;
				var s_phone_no = $("#phoneNo").val();
				var s_flag = packet.data.findValueByName("s_flag");
				var s_datesource = packet.data.findValueByName("s_datesource"); //������Դ
				var s_op_flag = packet.data.findValueByName("s_op_flag"); //���������������
				var s_message_flag = packet.data.findValueByName("s_message_flag"); //������Ϣ����
				var s_login_no = packet.data.findValueByName("s_login_no"); //�������Ĳ�������
				var s_note = packet.data.findValueByName("s_note");
				var s_op_time = packet.data.findValueByName("s_op_time");  //��������
				if(s_flag==1){
					rdShowMessageDialog("û�в�ѯ�����û��ļӺڼ�¼�������ʵ��",0);
					return false;
				}else{
					if(s_op_flag=="�ѼӺ�"){
						$("#s_phone_no_Hid").val(s_phone_no);
						$("#s_datesource_Hid").val(s_datesource);
						$("#s_message_flag_Hid").val(s_message_flag);
						$("#s_note_Hid").val(s_note);
						document.getElementById("gongdans").innerHTML += '<table cellspacing="0" id="table1"><tr><th>�ֻ�����</th><th>������Դ</th><th>������Ϣ����</th><th>������״̬</th><th>�ӽ������ԭ������</th><th>��������</th><th>����ʱ��</th><th>����</th></tr><tr><td><input type="text" name="phone_no"  value="'+s_phone_no+'" readOnly></td><td><input type="text" name="s_datesource" value="'+s_datesource+'" readOnly></td><td><input type="text" name="s_message_flag" value="'+s_message_flag+'" readOnly></td><td><input type="text" name="s_op_flag" value="'+s_op_flag+'" readOnly></td><td><input type="text" name="s_note" value="'+s_note+'" readOnly></td><td><input type="text" name="s_login_no" value="'+s_login_no+'" readOnly></td><td><input type="text" name="s_op_time" value="'+s_op_time+'" readOnly></td><td><input type="button"  value="���" class="b_foot" onclick="doUnBal()" ></td></tr></table>';
						document.all.quchoose.disabled=true;
					}else{
						document.getElementById("gongdans").innerHTML += '<table cellspacing="0" id="table1"><tr><th>�ֻ�����</th><th>������Դ</th><th>������Ϣ����</th><th>������״̬</th><th>�ӽ������ԭ������</th><th>��������</th><th>����ʱ��</th><th>����</th></tr><tr><td colspan=8 align="center">�ѽ�ڲ����ظ�����</td></tr></table>';
						document.all.quchoose.disabled=true;
					}
				}
			}
	
			function doUnBal(){
				var s_phone_no = $("#s_phone_no_Hid").val();
				var s_datesource = $("#s_datesource_Hid").val();
				var s_message_flag = $("#s_message_flag_Hid").val();
				var s_note = $("#s_note_Hid").val();
				
				if(s_note.indexOf("�永���")!=-1){
					rdShowMessageDialog("�永��Ų�������");
					return;
				}
				//alert(s_phone_no+"--"+s_datesource+"--"+s_message_flag+"--"+s_note);
				var myPacket = new AJAXPacket("sg237_cfm.jsp","�����ύ��Ϣ�����Ժ�......");
				myPacket.data.add("phoneNo",s_phone_no);
			  myPacket.data.add("s_datesource",s_datesource);
			  myPacket.data.add("s_message_flag",s_message_flag);
			  myPacket.data.add("s_note",s_note);
			  core.ajax.sendPacket(myPacket,doSubInfo);
			  myPacket = null;
			}
			
			function doSubInfo(packet){
				var retCode = packet.data.findValueByName("retCode");
				var return_msg = packet.data.findValueByName("return_msg");
				var phoneNo = packet.data.findValueByName("phoneNo");
				//alert("retCode="+retCode+"--return_msg="+return_msg+"--phoneNo="+phoneNo);
				window.location.href="sg237_cfm_2.jsp?retCode="+retCode+"&return_msg="+return_msg+"&phoneNo="+phoneNo;
			}
			
			
	 
			function do_business(){
				var phone_no = document.frm.phoneNo.value.trim();
				//document.frm.action="sg237_cfm.jsp?phone_no="+phone_no;
				frm.submit();
			}
		</script>
	</head>
	<body>
		<form name="frm" method="POST" action="sg237_cfm.jsp">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>
	    <table cellspacing="0" >
				<tr>
					<td class="blue" width="15%">�û��ֻ�����</td>
					<td colspan="3">
						<input type="text"  name="phoneNo" id="phoneNo" value="" v_type="mobphone" v_must="1"  maxlength="11" size="17" />
						&nbsp;&nbsp;
						<input type="button"  name="quchoose" class="b_text" value="��ѯ" onclick="qry()" />
					</td>
				</tr>
			</table>
	 		<table cellspacing="0">
				<tr>
					<td noWrap id="footer">
						<div align="center">
							<input name="back" onClick="doReset()" type="button" class="b_foot"  value="���">
							&nbsp;
							<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();"/>
						</div>
					</td>
				</tr>
			</table>
			<div id="gongdans"></div>	  
		  <%@ include file="/npage/include/footer.jsp" %>
		  <input type="hidden" id="s_phone_no_Hid" name="s_phone_no_Hid" value="" />
		  <input type="hidden" id="s_datesource_Hid" name="s_datesource_Hid" value="" />
		  <input type="hidden" id="s_message_flag_Hid" name="s_message_flag_Hid" value="" />
		  <input type="hidden" id="s_note_Hid" name="s_note_Hid" value="" />
		</form>
	</body>
</html>
