<%
  /*
   * ����: ������ò���ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/10/14
�� * ����: mixh
�� * ��Ȩ: sitech
	 *update:
��*/
%>
<%
	//String opCode = "K082";
	//String opName = "������ò���ҳ��";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>ǩ�������ò���ҳ��</title>
	<link href="/nresources/default/css/main.css" rel="stylesheet" type="text/css" />
	<script>


	<%--------------------------------------------------------------------------%>
	/*�Է���ֵ���д���*/
	function doProcessK005(packet)
	{
		alert("Begin call doProcessK005()......");
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		alert(retType);
		alert(retCode);
		alert(retMsg);
		if(retType=="sK005insert"){
			if(retCode=="000000"){
				alert("�ɹ���ȡ����������Ϣ!");
			}else{
				alert("�޷���ı���������Ϣ!");
				return false;
			}
		}
		alert("End call doProcessK005()......");
	}

	/*����mac��ַ����ñ���mac��ַ*/
	function sK005insert()
	{
		alert("Begin call sK005insert()....");
	    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K005/K005.jsp","���ڻ�ȡ����������Ϣ,���Ժ�...");
	    chkPacket.data.add("retType","sK005insert");
		chkPacket.data.add("login_no","kfaa15");
		chkPacket.data.add("ipaddress","10.204.1.1");
		chkPacket.data.add("grade_code","1");
		chkPacket.data.add("staffstatus","1");
		chkPacket.data.add("checkno","1");
		chkPacket.data.add("ccsworkno","102");
		chkPacket.data.add("kf_no","102");
		chkPacket.data.add("kf_name","MrZhang");
		chkPacket.data.add("class_id","1");
		chkPacket.data.add("org_id","1");
		chkPacket.data.add("duty","1");
		chkPacket.data.add("op_code","1");
	    core.ajax.sendPacket(chkPacket,doProcessK005,true);
		chkPacket =null;
		alert("End call sK005insert()....");
	}
	<%--------------------------------------------------------------------------%>



    /*��ת����ҳ��*/
	function customOnsubmit()
	{
		getLocalCfg();
	}

	function changeLoginType(ob){
	  var el=document.getElementById("loginPhone");
	  if(ob.value=="2"){
	  	 el.style.display="none"
	  }else if(ob.value=="2"){
	  	 el.style.display="block";
	  }
	}
	</script>
</head>

<body>
<form action="/csp/bsf/afterLogin.action" onsubmit="customOnsubmit(); return validateForm_passwordForm();" method="post" id="passwordForm">
		<table width="400" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="25" class="basicinfo_bg">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="title_boldtext">
								������ò���
							</td>
							<td width="100%">
								&nbsp;
							</td>
							<td class="basic_arrow">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		    <tr>
		        <td height="2"></td>
		    </tr>
		</table>
			<table width="400" align="center" border="0" cellpadding="0" cellspacing="0" class="table_listoutline" style="display: black;">
				<tr id="loginType">
				    <td width="100"><span><label id="null_">��¼����</label></span></td>
					<td>
					    <select id="loginTypeSelect" name="loginType"  onchange="changeLoginType(this)" style="width:170px" disabled>
						    <option value="2" selected>��ͨ��ϯ</option>
						    <option value="4">�绰��ϯ</option>
						</select>
					</td>
				</tr>
				<tr id="loginPhone" >
				    <td id="teleTitle" width="100"><span><label id="null_">�绰����</label></span></td>
					<td>
					    <input type="text" id="cellphone" name="cellphone" style="width:166px" disabled/>
					</td>
				</tr>
				<tr id="loginStatus">
					<td width="100">�ͷ�����</td>
					<td>
					    <select id="WorkNo" name="WorkNo" style="width:170px" disabled>
						    <option value="102" selected>mixh102</option>
						    <option value="103">tancf103</option>
						    <option value="104">zhangjc104</option>
						    <option value="105">kouwb105</option>
					    </select>
					</td>
			    </tr>
			    <tr>
				    <td width="100">��¼״̬</td>
					<td>
					    <select id="login_status" name="loginStatus" style="width:170px" disabled>
						    <option value="0" selected>����̬</option>
						    <option value="1">ѧϰ̬</option>
						    <option value="2">ʾæ̬</option>
					    </select>
					</td>
				</tr>
				<tr id="checkArea">
				    <td width="100">&nbsp;</td>
					<td>
					    <input type="checkbox" id="signCti" name="signCti" value="checkbox" onchange=""  class="input_none" disabled/>ǩ���������
									&nbsp;
						<input type="checkbox" id="signAcd" name="signAcd" value="checkbox" o class="input_none" disabled/>ǩ���Ŷӻ�
					</td>
				</tr>
				<tr id="callCenter" style="display:none">
					<td width="100">
						<span><label id="null_">�������ı��</label></span>
					</td>
					<td>
						<span nowrap> </span><select name="ccId" size="1" id="select_cc" style="width:170px" onchange="change()" disabled><option value="1">ɽ���ƶ�-����</option></select>
					</td>
				</tr>
				<tr id="vdnNo" style="display:none">
					<td width="100">
						<span><label id="null_">VDN���</label></span>
					</td>
					<td>
						<span nowrap> </span><select name="vdnId" id="select_vdn" style="width:170px"><option value="1">1</option></select>

					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="ȷ��" name="modify" id="submitBtn" class="button_38px" onClick="customOnsubmit()" onmouseover="this.className='button_38px_over'" onmouseout="this.className='button_38px'"/>
					</td>
				</tr>
			</table>
            <input type="hidden" id="loginIp" name="loginIp" value=""/>
		</form>

</html>
