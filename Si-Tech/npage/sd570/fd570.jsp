<%
  /*
   * ����: ���ּ�ͥ
   * �汾: 1.0
   * ����: 20110428
   * ����: wanglma 
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ּ�ͥ</title>
<%
	
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    //String[][] favInfo=(String[][])session.getAttribute("favInfo");
	//boolean workNoFlag=false;
	//if(workNo.substring(0,1).equals("k"))
	//	workNoFlag=true;
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

onload=function()
{
  	var opCode = "<%=opCode%>";
  	if(opCode=="d570")
  	{
		document.all.opFlag[0].checked=true;
		opchange();		
  	}
  	if(opCode=="d571")
  	{
		document.all.opFlag[1].checked=true;  
		opchange();			
  	}
  	if(opCode=="d572")
  	{
		document.all.opFlag[2].checked=true;
		opchange();			
  	}
  	if(opCode=="d573")
  	{
		document.all.opFlag[3].checked=true;  
		opchange();			
  	}
  	if(opCode=="d574")
  	{
		document.all.opFlag[4].checked=true;  
		opchange();			
  	}
}

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	//controlButt(subButton);			//��ʱ���ư�ť�Ŀ�����
	subButton.disabled = true;
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one") { //����
		  	document.all.opCode.value = "d570";
		  	document.all.opName.value = "�������ּ�ͥ";
				frm.action="fd570_main.jsp";
			} else if(opFlag=="two") { //����
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("������ҵ����ˮ��",1)
					subButton.disabled = false;
					return;
				}
				frm.action="fd571_main.jsp";
				document.all.opCode.value="d571";
			}
			else if(opFlag=="three") { //����
				if($("#member_no").val() == "" ){
					rdShowMessageDialog("��Ա���벻��Ϊ�գ�");
					return;
				}
				if($("#cus_pass").val() == "" ){
					rdShowMessageDialog("��Ա�������벻��Ϊ�գ�");
					return;
				}
				frm.action="fd572_main.jsp";
				document.all.opCode.value="d572";
			}
			else if(opFlag=="four") { //�˳�
				if($("#exitPhone").val() == "" ){
					rdShowMessageDialog("���벻��Ϊ�գ�");
					return;
				}
				frm.action="fd573_main.jsp";
				document.all.opCode.value="d573";
			}else if(opFlag=="five") { //ȡ��
				frm.action="fd574_main.jsp";
				document.all.opCode.value="d574";
			}
		}
  }
	frm.submit();	
	return true;
}

function opchange() {
	if(document.all.opFlag[0].checked==true) {
		$("#confirm").attr("disabled",false);
		$("#opCode").val("d570");
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.comboTypeDiv.style.display = "";
	  	//document.all.tdPhoneDiv.style.display = "";
	  	//document.all.gsmPhoneDiv.style.display = "";
	  	document.all.exitShow.style.display = "none";
	  	document.all.member_no_tr.style.display = "none";
	  	comboTypeChange();
	} else if(document.all.opFlag[1].checked==true) {
		$("#confirm").attr("disabled",false);
		$("#opCode").val("d571");
	  	document.all.comboTypeDiv.style.display = "none";
	  	//document.all.tdPhoneDiv.style.display = "none";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	  	document.all.backaccept_id.style.display = "";
	  	document.all.exitShow.style.display = "none";
	  	document.all.member_no_tr.style.display = "none";
	} else if(document.all.opFlag[2].checked==true) {
		$("#confirm").attr("disabled",true); 
		$("#opCode").val("d572");
	  	document.all.comboTypeDiv.style.display = "none";
	  	//document.all.tdPhoneDiv.style.display = "none";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.exitShow.style.display = "none";
	  	document.all.member_no_tr.style.display = "";
	} else if(document.all.opFlag[3].checked==true) {
		$("#confirm").attr("disabled",true);
		$("#opCode").val("d573");
		fd573_checkPhone();
	  	document.all.comboTypeDiv.style.display = "none";
	  	//document.all.tdPhoneDiv.style.display = "none";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.member_no_tr.style.display = "none";
	} else if(document.all.opFlag[4].checked==true) {
		$("#confirm").attr("disabled",false);
		$("#opCode").val("d574");
	  	document.all.comboTypeDiv.style.display = "none";
	  	//document.all.tdPhoneDiv.style.display = "none";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.exitShow.style.display = "none";
	  	document.all.member_no_tr.style.display = "none";
	}
}

function comboTypeChange() {
	var obj = document.getElementById("comboType");
	if (obj.value == "B") {
	  	document.all.comboTypeDiv.style.display = "";
	  	//document.all.tdPhoneDiv.style.display = "";
	  	//document.all.gsmPhoneDiv.style.display = "";
	} else {
	  	document.all.comboTypeDiv.style.display = "";
	  	//document.all.tdPhoneDiv.style.display = "";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	}
}

function checkPassWord(){
    //��֤���� �Ƿ���ȷ
    var passWord = "";
    var phoneNo = "";
    if($("#opCode").val() == "d572"){
    	passWord = $("#cus_pass").val();
    	phoneNo = $("#member_no").val();
    }
   	var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ��к���У�飬���Ժ�......");
    checkPwd_Packet.data.add("custType", "01"); //01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
    checkPwd_Packet.data.add("phoneNo", phoneNo); //�ƶ�����,�ͻ�id,�ʻ�id
    checkPwd_Packet.data.add("custPaswd",passWord);//�û�/�ͻ�/�ʻ�����
    checkPwd_Packet.data.add("idType", ""); //en ����Ϊ���ģ�������� ����Ϊ����
    checkPwd_Packet.data.add("idNum", ""); //����
    checkPwd_Packet.data.add("loginNo", "<%=workNo%>"); //����
    core.ajax.sendPacket(checkPwd_Packet,doMsg);
    checkPwd_Packet = null;
}

function doMsg(packet){
  	var retCode=packet.data.findValueByName("retResult");
  	var retMsg=packet.data.findValueByName("msg");
  	if(retCode == "000000"){
  		 $("#confirm").attr("disabled",false);	
  	}else{
  	   	rdShowMessageDialog("���벻ƥ�䣬���������룡");
  	   	$("#cus_pass").val("");
  	   	$("#cus_pass").focus();
  	   	$("#confirm").attr("disabled",true);
  	}
}
function fd573_checkPhone(){
	var packet = new AJAXPacket("fd573_ajaxCheckPhone.jsp","���ڽ��к���У�飬���Ժ�......");
  	packet.data.add("phoneNo", $("#activePhone").val());
  	core.ajax.sendPacket(packet,doCheckPhone);
    packet = null;
}
function doCheckPhone(packet){
  	var retCode=packet.data.findValueByName("retCode");
  	var retMsg=packet.data.findValueByName("retMsg");
  	var flag=packet.data.findValueByName("flag");
  	document.all.exitShow.style.display = "";
  	$("#flag").val(flag);
  	if(retCode == "000000" && flag == "0"){//��Ա
  	   	$("#exitTd").html("�ҳ�����");
  	   	$("#confirm").attr("disabled",false);
  	}else if(retCode == "000000" && flag == "1"){//�ҳ�
  		$("#exitTd").html("��Ա����");
  		$("#confirm").attr("disabled",false);
  	}else if(retCode == "000000" && flag == "2"){//����Ⱥ��
  		rdShowMessageDialog("�˺��벻�ڻ��ּ�ͥȺ�飬���ּ�ͥ�ʷ���ԤԼ���������ɰ����ҵ��");
  		$("#confirm").attr("disabled",true);
  	   	return;
  	}else{
  	   	rdShowMessageDialog("������룺"+retCode+"   "+"������Ϣ��"+retMsg);
  	   	return;
  	}
}

</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="">
 	<input type="hidden" name="opName" id="opName" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="15%">��������</td>
		<td colspan="3" >
			<input type="radio" name="opFlag" value="one" onclick="opchange()">�������ּ�ͥ&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()">���ּ�ͥ����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="three" onclick="opchange()">���뻶�ּ�ͥ&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="four" onclick="opchange()">�˳����ּ�ͥ&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="five" onclick="opchange()">��ɢ���ּ�ͥ&nbsp;&nbsp;
		</td>
	</tr>    
	<tr> 
		<td class="blue" width="15%">�绰����</td>
		<td colspan="3"> 
			<input type="text" size="12" name="activePhone" value="<%=activePhone%>" id="activePhone" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
			<font color="orange">*</font>
		</td>
	</tr>
	
		  <tr id="exitShow" name="exitShow" style="display:none">
		     	
               <td  class="blue"   width="10%" id="exitTd"> 
                  ��Ա����
                </td>
		     	<td colspan="3">
                  <input type="text" size="12" name="exitPhone"  id="exitPhone" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0"  />
                  <font color="orange">*</font>
               </td>
           </tr>
	
	<tr id="member_no_tr" name="member_no_tr" style="display:none" > 
            <td class="blue" width="15%"> 
              <div align="left">��Ա����</div>
            </td>
			<td width="20%"> 
                <input class="button"  type="text" name="member_no"  id="member_no" v_minlength=1 v_maxlength=12 size="11" maxlength=11 v_type="string" v_must=1 index="0" >
                <font color="orange">*</font>
            </td>
			<td  class="blue"   width="10%"> 
              <div align="left">����</div>
            </td>
         
           <TD id="">
			     <!--<input type="password" class="button" name="cus_pass" id="cus_pass" size="11" maxlength="8" style='none' > 		    -->
		         <input name="cus_pass" id="cus_pass" type="password" onKeyPress="return isKeyNumberdot(0)"   maxlength="6" onFocus="showNumberDialog(document.all.cus_pass)"  pwdlength="6" />
		         <input type="button" class="b_text" value="У��" onclick="checkPassWord()" />
			     <font color="orange">*</font>
		      </TD>
     </tr>
     
     
	<tr style="display:none" id="comboTypeDiv">
		<td class="blue">
			�ײ�����
		</td>
		<td>
			<select name="comboType" id="comboType" onchange="comboTypeChange()">
				<option value="A">���ּ�ͥA���ײ�</option>
				<option value="B">���ּ�ͥB���ײ�</option>
				<option value="C">���ּ�ͥC���ײ�</option>
			</select>
		</td>
	</tr>
	<tr style="display:none" id="tdPhoneDiv">
		<td class="blue">���û�TD�̻�����</td>
		<td>
			<input type="text" size="12" value="" name="tdPhone" id="tdPhone" v_minlength=1 v_maxlength=16 v_must=1 maxlength="11" />
			<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="gsmPhoneDiv"> 
		<td class="blue">���û��ֻ�����</td>
		<td>
			<input type="text" size="12" value="" name="gsmPhone" id="gsmPhone" v_minlength=1 v_maxlength=16 v_must=1 maxlength="11" />
			<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">ҵ����ˮ</td>
		<td>
			<input class="button" type="text" name="backaccept" v_must=1  />
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="confirm" id="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <input type="hidden" id="flag" name="flag" value=""/>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
