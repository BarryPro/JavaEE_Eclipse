<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ����
�� * �汾: v1.0
�� * ����: 2013/10/17
�� * ����: wangjxc
�� * ��Ȩ: sitech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<head>
	<title>��˰����������</title>
	<%
		String opCode = request.getParameter("opCode");
		String UpCustOne = request.getParameter("UpCustOne");
		String UptCustId = request.getParameter("UptCustId");
		String modelflag = request.getParameter("modelflag");
		
		String opName = "��˰����������";
	%>
	<script language="JavaScript">
		function ApproveCom(CheckFlag)
		{
			var AppStatus = "";
			var AppFlag = '<%=modelflag%>';
			var AppState = "";
			if(AppFlag == "2")
			{ 
				if(CheckFlag == "1")
				{
					AppStatus = "03";
					AppState = "Y"
				}
				else if(CheckFlag == "2")
				{
					AppStatus = "04";
					AppState = "W"
				}
			}
			else if(AppFlag == "3")
			{
				if(CheckFlag == "1")
				{
					AppStatus = "02";
					AppState = "Y"
				}
				else if(CheckFlag == "2")
				{
					AppStatus = "05";
					AppState = "W"
				}
			}
						
			if(!check(frmo003))return false;
			var ApproveIdea = $("#approve_idea").val();
			var packet = new AJAXPacket("fo003_ajax_doApproveCom.jsp","���Ժ�...");
			packet.data.add("ApproveIdea",ApproveIdea);
			packet.data.add("UpCustOne",'<%=UpCustOne%>');
			packet.data.add("UptCustId",'<%=UptCustId%>');
			packet.data.add("AppFlag",AppFlag);
			packet.data.add("AppStatus",AppStatus);
			packet.data.add("AppState",AppState);
			core.ajax.sendPacket(packet,doSuccessOk,true);
	  		packet = null;
		}
		
		function doSuccessOk(packet)
		{
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000")
			{
				rdShowMessageDialog("����������ɣ�",2);
				window.close();
				window.opener.doQueryApprove();
			} 
			else
			{
				rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
			}
		}	
		
	
	</script>
<body>
<form id="frmg645" name="frmo003" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�������</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">���������</td>
			<td colspan="2">
					<input type=text name="approve_idea" id="approve_idea" v_must="1" size="50"  class="isLengthOf" v_maxlength="255"/>
					<font class=orange>*</font>
			</td>
        </tr>
    </table>
    <div id="operation_button"><input type="button" class="b_foot"
	value="ͨ��" onclick="ApproveCom('1')" />
	<input type="button" class="b_foot" value="��ͨ��" onClick="ApproveCom('2')" />
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
