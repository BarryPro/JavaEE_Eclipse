<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:wanghfa@2010-9-26 ����֮��
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>����֮��</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	System.out.println("=========wanghfa========= fb608.jsp " + opCode + ", " + opName);
	
    String workNo = (String)session.getAttribute("workNo");
	 //begin add by diling for ������Ȩ������ @2012/3/13 
    boolean pwrf = false;
	  String pubOpCode = opCode;
%>
	  <%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==������======fb068.jsp==== pwrf = " + pwrf);
    //end add by diling for ������Ȩ������ @2012/3/13 
%>

<script language=javascript>
	var opFlag;
	var pwdIsRight;
	
	window.onload = function() {
		opchange();
		changeoptype();
	}
	
	function opchange() {
		if (document.getElementsByName("opFlag")[0].checked) {
			opFlag = "1";
			
			$("#qry").slideUp("500", function() {
				$("#op").slideDown("500");
			});
		} else if (document.getElementsByName("opFlag")[1].checked) {
			opFlag = "2";
			
			$("#op").slideUp("500", function() {
				$("#qry").slideDown("500");
			});
		}
		changeoptype();
	}
	
	function changeoptype() {
		if (opFlag == "2") {
			return;
		}
		
		var opTypeObj = document.getElementById("opType");
		
		if (opTypeObj.value == "0") {
			$("#opOne").slideUp("500", function() {
				$("#opTwo").slideUp("500", function() {
					$("#opThree").slideUp("500", function() {
						$("#opZero").slideDown("500");
					});
				});
			});
			opFlag = "10";
		} else if (opTypeObj.value == "1") {
			$("#opZero").slideUp("500", function() {
				$("#opTwo").slideUp("500", function() {
					$("#opThree").slideUp("500", function() {
						$("#opOne").slideDown("500");
					});
				});
			});
			opFlag = "11";
		} else if (opTypeObj.value == "2") {
			$("#opZero").slideUp("500", function() {
				$("#opOne").slideUp("500", function() {
					$("#opThree").slideUp("500", function() {
						$("#opTwo").slideDown("500");
					});
				});
			});
			opFlag = "12";
		} else if (opTypeObj.value == "3") {
			$("#opZero").slideUp("500", function() {
				$("#opOne").slideUp("500", function() {
					$("#opTwo").slideUp("500", function() {
						$("#opThree").slideDown("500");
					});
				});
			});
			opFlag = "13";
		}
	}
	
	function closeTip(obj) {
		var objValue = obj.value;
		obj.value = "12345678901";
		checkElement(obj);
		obj.value = objValue;
	}
	
	function checkUserPwd(phoneId, pwdId) {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("custType", "01");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
		checkPwd_Packet.data.add("phoneNo", document.getElementById(phoneId).value);		//�ƶ�����,�ͻ�id,�ʻ�id
		checkPwd_Packet.data.add("custPaswd", document.getElementById(pwdId).value);//�û�/�ͻ�/�ʻ�����
		checkPwd_Packet.data.add("idType", "");							//en ����Ϊ���ģ�������� ����Ϊ����
		checkPwd_Packet.data.add("idNum", "");							//����
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//����
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}
	
	function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			pwdIsRight = "0";
		} else {
			pwdIsRight = "1";
		}
	}
	
	function submitt() {
		var buttonSub = document.getElementById("cubmitt");
		//buttonSub.disabled = "true";
		
		if (opFlag == "10") {
			var fatherPhone0Obj = document.getElementById("fatherPhone0");
			
			if (!checkElement(fatherPhone0Obj)) {
				if (fatherPhone0Obj.value == "") {
					rdShowMessageDialog("�ҳ����벻��Ϊ��", 1);
					fatherPhone0Obj.focus();
				} else {
					rdShowMessageDialog("�ҳ������ʽ����ȷ", 1);
					fatherPhone0Obj.focus();
				}
				closeTip(fatherPhone0Obj);
				return;
			} else if (!<%=pwrf%>) {
				if (document.getElementById("fatherPwd0").value == "") {
					rdShowMessageDialog("������ҳ����������", 1);
					return;
				}
			}
			
			document.getElementById("opCode").value = "b608";
			document.getElementById("opName").value = "����֮���½���ͥ";
			frm.action = "fb608_main.jsp";
		} else if (opFlag == "11") {
			var fatherPhone1Obj = document.getElementById("fatherPhone1");
			var memberPhone1Obj = document.getElementById("memberPhone1");
			
			if (!checkElement(fatherPhone1Obj)) {
				if (fatherPhone1Obj.value == "") {
					rdShowMessageDialog("�ҳ����벻��Ϊ��", 1);
					fatherPhone1Obj.focus();
				} else {
					rdShowMessageDialog("�ҳ������ʽ����ȷ", 1);
					fatherPhone1Obj.focus();
				}
				closeTip(fatherPhone1Obj);
				return;
			} else if (!checkElement(memberPhone1Obj)) {
				if (memberPhone1Obj.value == "") {
					rdShowMessageDialog("��Ա���벻��Ϊ��", 1);
					memberPhone1Obj.focus();
				} else {
					rdShowMessageDialog("��Ա�����ʽ����ȷ", 1);
					memberPhone1Obj.focus();
				}
				closeTip(memberPhone1Obj);
				return;
			} else if (!<%=pwrf%>) {
				if (document.getElementById("fatherPwd1").value == "") {
					rdShowMessageDialog("������ҳ����������", 1);
					return;
				} else if (document.getElementById("memberPwd1").value == "") {
					rdShowMessageDialog("�������Ա���������", 1);
					return;
				}
			}
			
			document.getElementById("opCode").value = "b609";
			document.getElementById("opName").value = "����֮�Ҽ����ͥ";
			frm.action = "fb609_main.jsp";
		} else if (opFlag == "12") {
			var memberPhone2Obj = document.getElementById("memberPhone2");
			
			if (!checkElement(memberPhone2Obj)) {
				if (memberPhone2Obj.value == "") {
					rdShowMessageDialog("��Ա���벻��Ϊ��", 1);
					memberPhone2Obj.focus();
				} else {
					rdShowMessageDialog("��Ա�����ʽ����ȷ", 1);
					memberPhone2Obj.focus();
				}
				closeTip(memberPhone2Obj);
				return;
			} else if (!<%=pwrf%>) {
				if (document.getElementById("memberPwd2").value == "") {
					rdShowMessageDialog("�������Ա���������", 1);
					return;
				}
			}
			
			document.getElementById("opCode").value = "b610";
			document.getElementById("opName").value = "����֮���˳���ͥ";
			frm.action = "fb610_main.jsp";
		} else if (opFlag == "13") {
			var fatherPhone3Obj = document.getElementById("fatherPhone3");
			
			if (!checkElement(fatherPhone3Obj)) {
				if (fatherPhone3Obj.value == "") {
					rdShowMessageDialog("��Ա���벻��Ϊ��", 1);
					fatherPhone3Obj.focus();
				} else {
					rdShowMessageDialog("��Ա�����ʽ����ȷ", 1);
					fatherPhone3Obj.focus();
				}
				closeTip(fatherPhone3Obj);
				return;
			} else if (!<%=pwrf%>) {
				if (document.getElementById("fatherPwd3").value == "") {
					rdShowMessageDialog("������ҳ����������", 1);
					return;
				}
			}
			
			document.getElementById("opCode").value = "b611";
			document.getElementById("opName").value = "����֮�ҽ�ɢ��ͥ";
			frm.action = "fb611_main.jsp";
		} else if (opFlag == "2") {
			var fatherPhone4Obj = document.getElementById("fatherPhone4");
			
			if (!checkElement(fatherPhone4Obj)) {
				if (fatherPhone4Obj.value == "") {
					rdShowMessageDialog("�ҳ����벻��Ϊ��", 1);
					fatherPhone4Obj.focus();
				} else {
					rdShowMessageDialog("�ҳ������ʽ����ȷ", 1);
					fatherPhone4Obj.focus();
				}
				closeTip(fatherPhone4Obj);
				return;
			} else if (!<%=pwrf%>) {
				if (document.getElementById("fatherPwd4").value == "") {
					rdShowMessageDialog("������ҳ����������", 1);
					return;
				}
			}
			
			document.getElementById("opCode").value = "b612";
			document.getElementById("opName").value = "����֮����Ϣ��ѯ";
			frm.action = "fb612_main.jsp";
		}
		
		frm.submit();
	}
</script>
</head>
<body>

<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="pwrf" id="pwrf" value="<%=pwrf%>">

<%@ include file="/npage/include/header.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>

<div class="title">
	<div name="title_zi" id="title_zi">����֮��</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="30%">
			��������
		</td>
		<td width="70%">
<%
			if ("b608".equals(opCode) || "b609".equals(opCode) || "b610".equals(opCode) || "b611".equals(opCode)) {
%>
				<input type="radio" name="opFlag" value="1" onclick="opchange()" checked>ҵ�����&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="2" onclick="opchange()">��ͥ��Ϣ��ѯ&nbsp;&nbsp;
<%
			} else if ("b612".equals(opCode)) {
%>
				<input type="radio" name="opFlag" value="1" onclick="opchange()">ҵ�����&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>��ͥ��Ϣ��ѯ&nbsp;&nbsp;
<%
			}
%>
		</td>
	</tr>
</table>
<div class="itemContent" id="op" name="op">
	<table>
		<tr>
			<td class="blue" width="30%">
				��������
			</td>
			<td width="70%">
				<select id="opType" name="opType" onchange="changeoptype();">
<%
					if ("b608".equals(opCode) || "b612".equals(opCode)) {
%>
						<option value="0" selected>�½�����֮��</option>
						<option value="1">��������֮��</option>
						<option value="2">�˳�����֮��</option>
						<option value="3">��ɢ����֮��</option>
<%
					} else if ("b609".equals(opCode)) {
%>
						<option value="0">�½�����֮��</option>
						<option value="1" selected>��������֮��</option>
						<option value="2">�˳�����֮��</option>
						<option value="3">��ɢ����֮��</option>
<%
					} else if ("b610".equals(opCode)) {
%>
						<option value="0">�½�����֮��</option>
						<option value="1">��������֮��</option>
						<option value="2" selected>�˳�����֮��</option>
						<option value="3">��ɢ����֮��</option>
<%
					} else if ("b611".equals(opCode)) {
%>
						<option value="0">�½�����֮��</option>
						<option value="1">��������֮��</option>
						<option value="2">�˳�����֮��</option>
						<option value="3" selected>��ɢ����֮��</option>
<%
					}
%>
				</select>
			</td>
		</tr>
	</table>
	
	<div class="itemContent" id="opZero" name="opZero">
		<div class="title">
			<div name="title_zi" id="title_zi">�½�����֮��</div>
		</div>
		<table>
			<tr>
				<td class="blue" width="20%">
					�ҳ�����
				</td>
				<td width="30%">
					<input type="text" name="fatherPhone0" id="fatherPhone0" value="" size="17" maxlength=11 v_maxlength=11 v_type="phone" v_must="1">
				</td>
<%
				if (pwrf) {
%>
					<td width="50%" class="orange">
						�ù��ž��С������롱Ȩ�ޣ�����Ҫ�����û�����
					</td>
<%				
				} else {
%>
					<td class="blue" width="20%">
						�ҳ��û�����
					</td>
					<td width="30%">
						<jsp:include page="/npage/common/pwd_1.jsp">
							<jsp:param name="width1" value="16%"/>
							<jsp:param name="width2" value="34%"/>
							<jsp:param name="pname" value="fatherPwd0"/>
							<jsp:param name="pwd" value=""/>
						</jsp:include>
					</td>
<%
				}
%>
			</tr>
		</table>
	</div>
	
	<div class="itemContent" id="opOne" name="opOne">
		<div class="title">
			<div name="title_zi" id="title_zi">��������֮��</div>
		</div>
		<table>
			<tr>
				<td class="blue" width="20%">
					�ҳ�����
				</td>
				<td width="30%">
					<input type="text" name="fatherPhone1" id="fatherPhone1" value="" v_must="1" size="17" maxlength=11 v_maxlength=11 v_type="phone" v_must="1">
				</td>
<%
				if (pwrf) {
%>
					<td width="50%" class="orange">
						�ù��ž��С������롱Ȩ�ޣ�����Ҫ�����û�����
					</td>
<%				
				} else {
%>
					<td class="blue" width="20%">
						�ҳ��û�����
					</td>
					<td width="30%">
						<jsp:include page="/npage/common/pwd_1.jsp">
							<jsp:param name="width1" value="16%"/>
							<jsp:param name="width2" value="34%"/>
							<jsp:param name="pname" value="fatherPwd1"/>
							<jsp:param name="pwd" value=""/>
						</jsp:include>
					</td>
<%
				}
%>
			</tr>
			<tr>
				<td class="blue" width="20%">
					��Ա����
				</td>
				<td width="30%">
					<input type="text" name="memberPhone1" id="memberPhone1" value="" v_must="1" size="17" maxlength=11 v_maxlength=11 v_type="phone" v_must="1">
				</td>
<%
				if (pwrf) {
%>
					<td width="50%" class="orange">
						�ù��ž��С������롱Ȩ�ޣ�����Ҫ�����û�����
					</td>
<%				
				} else {
%>
					<td class="blue" width="20%">
						��Ա�û�����
					</td>
					<td width="30%">
						<jsp:include page="/npage/common/pwd_1.jsp">
							<jsp:param name="width1" value="16%"/>
							<jsp:param name="width2" value="34%"/>
							<jsp:param name="pname" value="memberPwd1"/>
							<jsp:param name="pwd" value=""/>
						</jsp:include>
					</td>
<%
				}
%>
			</tr>
		</table>
	</div>
	
	<div class="itemContent" id="opTwo" name="opTwo">
		<div class="title">
			<div name="title_zi" id="title_zi">�˳�����֮��</div>
		</div>
		<table>
			<tr>
				<td class="blue" width="20%">
					��Ա����
				</td>
				<td width="30%">
					<input type="text" name="memberPhone2" id="memberPhone2" value="" v_must="1" size="17" maxlength=11 v_maxlength=11 v_type="phone" v_must="1">
				</td>
<%
				if (pwrf) {
%>
					<td width="50%" class="orange">
						�ù��ž��С������롱Ȩ�ޣ�����Ҫ�����û�����
					</td>
<%				
				} else {
%>
					<td class="blue" width="20%">
						��Ա�û�����
					</td>
					<td width="30%">
						<jsp:include page="/npage/common/pwd_1.jsp">
							<jsp:param name="width1" value="16%"/>
							<jsp:param name="width2" value="34%"/>
							<jsp:param name="pname" value="memberPwd2"/>
							<jsp:param name="pwd" value=""/>
						</jsp:include>
					</td>
<%
				}
%>
			</tr>
		</table>
	</div>
	
	<div class="itemContent" id="opThree" name="opThree">
		<div class="title">
			<div name="title_zi" id="title_zi">��ɢ����֮��</div>
		</div>
		<table>
			<tr>
				<td class="blue" width="20%">
					�ҳ�����
				</td>
				<td width="30%">
					<input type="text" name="fatherPhone3" id="fatherPhone3" value="" v_must="1" size="17" maxlength=11 v_maxlength=11 v_type="phone" v_must="1">
				</td>
<%
				if (pwrf) {
%>
					<td width="50%" class="orange">
						�ù��ž��С������롱Ȩ�ޣ�����Ҫ�����û�����
					</td>
<%				
				} else {
%>
					<td class="blue" width="20%">
						�ҳ��û�����
					</td>
					<td width="30%">
						<jsp:include page="/npage/common/pwd_1.jsp">
							<jsp:param name="width1" value="16%"/>
							<jsp:param name="width2" value="34%"/>
							<jsp:param name="pname" value="fatherPwd3"/>
							<jsp:param name="pwd" value=""/>
						</jsp:include>
					</td>
<%
				}
%>
			</tr>
		</table>
	</div>
</div>

<div class="itemContent" id="qry" name="qry">
	<div class="title">
		<div name="title_zi" id="title_zi">��ͥ��Ϣ��ѯ</div>
	</div>
	<table>
		<tr>
			<td class="blue" width="20%">
				�ҳ�/��Ա����
			</td>
			<td width="30%">
				<input type="text" name="fatherPhone4" id="fatherPhone4" value="" v_must="1" size="17" maxlength=11 v_maxlength=11 v_type="phone" v_must="1">
			</td>
<%
				if (pwrf) {
%>
					<td width="50%" class="orange">
						�ù��ž��С������롱Ȩ�ޣ�����Ҫ�����û�����
					</td>
<%				
				} else {
%>
					<td class="blue" width="20%">
						�û�����
					</td>
					<td width="30%">
							<jsp:include page="/npage/common/pwd_1.jsp">
								<jsp:param name="width1" value="16%"/>
								<jsp:param name="width2" value="34%"/>
								<jsp:param name="pname" value="fatherPwd4"/>
								<jsp:param name="pwd" value=""/>
							</jsp:include>
					</td>
<%
				}
%>
		</tr>
	</table>
</div>

<table cellspacing="0">
	<tr>
	    <td id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="ȷ��" onClick="submitt();">
	      <input class="b_foot" type=button name=qryPage value="�ر�" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
  <%@ include file="/npage/include/footer_simple.jsp" %> 
   </form>
</body>
</html>
