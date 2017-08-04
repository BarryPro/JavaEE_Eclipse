<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
version v3.0
������: si-tech
ningtn 2012-4-9 09:29:41
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String workNo = (String)session.getAttribute("workNo");
    boolean pwrf=false;
    String pubOpCode = opCode;
		String pubWorkNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		
%>
<wtc:service name="sChkUnSecret" routerKey="region" routerValue="<%=regionCode%>" 
	retcode="retCode" retmsg="retMsg" outnum="1" >
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="<%=opCode%>" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
</wtc:service>
<wtc:array id="func" scope="end"/>
<%
	if("000000".equals(retCode)){
		pwrf = true;
	}else{
		pwrf = false;
	}
	System.out.println("====ningtn====fe759Login.jsp==== pwrf = " + pwrf);
%>
<link href="css/prodRevoStyle.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	var pwdIsRight = "0";
	$(document).ready(function(){
		if ("true" == "<%=pwrf%>") {
			document.all.chief_cus_pass.disabled = true;
			document.all.cus_pass_button.disabled = true;
		}else if ("false" == "<%=pwrf%>") {
		 	document.all.chief_cus_pass.disabled = false;
			document.all.cus_pass_button.disabled = false;
		}
	});
	function doNext(subButton){
		controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
		if(!check(document.form1)){
			return false;
		}
		var custPass = document.all.chief_cus_pass.value;
		if("false" == "<%=pwrf%>"){
			/*������*/
			if(custPass.trim() == ""){
				rdShowMessageDialog("���������룡",0);
		  	return false;
			}
			checkUserPwd($("#phoneNo").val(),custPass);
		}else{
			pwdIsRight = "1";
		}
		if(pwdIsRight == "1"){
			if("<%=opCode%>" == "e759"){
				form1.action = "/npage/se761/fe759Main.jsp";
				form1.submit();
			}else if("<%=opCode%>" == "e760"){
				form1.action = "/npage/se761/fe760Main.jsp";
				form1.submit();
			}else if("<%=opCode%>" == "e782"){
				form1.action = "/npage/se761/fe782Main.jsp";
				form1.submit();
			}else if("<%=opCode%>" == "e783"){
				form1.action = "/npage/se761/fe783Main.jsp";
				form1.submit();
			}else if("<%=opCode%>" == "e897"){
				form1.action = "/npage/se761/fe897Main.jsp";
				form1.submit();
			}
		}
	}
	function checkUserPwd(phoneNo,custPwd){
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("custType", "01");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
		checkPwd_Packet.data.add("phoneNo", phoneNo);		//�ƶ�����,�ͻ�id,�ʻ�id
		checkPwd_Packet.data.add("custPaswd", custPwd);//�û�/�ͻ�/�ʻ�����
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
			pwdIsRight = "0";
			rdShowMessageDialog(msg);
		}else{
			pwdIsRight = "1";
		}
	}
	function doBack(){
		window.location.href="fe761Main.jsp"
	}
</script>
<body>
	<form name="form1" method="post">
	<%@ include file="/npage/common/pwd_comm.jsp" %>
	<div id="Operation_Title">
		<div class="icon"></div>
			<B><font face="Arial"><%=WtcUtil.repNull(opCode)%></font>��<%=WtcUtil.repNull(opName)%></B>
	</div>
	<div class="prodContent">
	<div class="m-box">
		<div class="m-box1-top">
			�û���Ϣ
		</div>
		<div class="m-box-txt2">
			<table>
				<tr>
					<td>�ֻ�����</td>
					<td>
						<input type="text" name="phoneNo" id="phoneNo" maxlength="11" v_type="mobphone" 
						 v_must="1" onblur = "checkElement(this)"/>
						<font class="orange">*</font>
					</td>
					<td>����</td>
					<td>
						<jsp:include page="/npage/common/pwd_one_new.jsp">
						  <jsp:param name="width1" value="16%"  />
						  <jsp:param name="width2" value="34%"  />
						  <jsp:param name="pname" value="chief_cus_pass"  />
						  <jsp:param name="pwd" value="12345"  />
						</jsp:include>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<table cellspacing="0">
		<tr id="footer"> 
			<td> 
				<div align="center"> 
				<input name="confirm" type="button" class="b_foot" value="��һ��" onClick="doNext(this)" />
				&nbsp; 
				<input name="clear" type="reset" class="b_foot" value="���" />
				&nbsp; 
				<input name="goBack" type="button" class="b_foot" value="����" onclick="doBack()" />
				&nbsp; 
				<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
				&nbsp; 
				</div>
			</td>
		</tr>
	</table>
	</div>
	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
</form>
</body>
</html>