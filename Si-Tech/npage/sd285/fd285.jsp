<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>���Ѷ�������</title>
	<%
		String opCode = "d285";
		String opName = "���Ѷ�������";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		
		/** ��ѯ������֯���� **/
		String sReleaseGroupName = "";
		String getGroupNameSql = "select group_name ,root_distance from dChnGroupMsg where group_id  = '"+groupId+"'";		
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=getGroupNameSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
	<%
		int root_distance_int = 0;
		if(retCode1.equals("000000")){
			String root_distance = sVerifyTypeArr[0][1];
			root_distance_int = Integer.parseInt(root_distance);
			if(root_distance_int>3)
			{
	%>
				<script>
					rdShowMessageDialog("�ù���������Ȩ��!");
					window.close();
				</script>
	<%
				return ;
			}
			
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				sReleaseGroupName = sVerifyTypeArr[0][0];
			}
		}
	%>
	<%
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	%>
			
		
	<script language="javascript">
		function doReset(){
			window.location.href = "fd285.jsp"
		}
		function chkTime(time1,time2)
		{
			if(parseInt(time2.value)<=parseInt(time1.value))
			{
				time2.select();
				rdShowMessageDialog("ʧЧʱ��Ӧ������Чʱ��");
				return;
			}
		}
		/**�ı䷢���ڵ����ʹ������¼�**/
		function doChangePromNodeType(){
			document.all.townByRegionTr.style.display = "none";
			$("#sGroupInfo").val("");
			$("#sGroupId").val("");
			var promulgateNodeType = document.all.promulgateNodeType;
			if(promulgateNodeType.value=="none"){
				document.getElementById("promulgateNodeFrame").style.display="none";
				return false;
			}
			document.getElementById("promulgateNodeFrame").style.display = "block";
			if(promulgateNodeType.value=="0"){
				document.promulgateNodeFrame.location = "fd285_getPromNodeByProvince.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
			}
			else if(promulgateNodeType.value=="1"){
				document.promulgateNodeFrame.location = "fd285_getPromNodeByRegion.jsp?root_distance_int=<%=root_distance_int%>";
			}else if(promulgateNodeType.value=="2"){
				document.all.townByRegionTr.style.display = "block";
				document.promulgateNodeFrame.location = "fd285_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
			}
		}
		/**�����ڵ�������"����"ʱ,ѡ��"����"���õĺ���**/
		function doChangeTownByRegion(){
			document.promulgateNodeFrame.location = "f9605_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
		}
		function doConfirm(){
			/* У����Ŵ����Ƿ���� */
			if(document.all.msgCode.value.trim()==""){
				rdShowMessageDialog("����д���Ŵ���!");
				document.all.msgCode.focus();
				return false;
			}
			/* У�����������Ƿ�ѡ�� */
			if(document.getElementById("Channels_Code").value=="none")
			{
				rdShowMessageDialog("��ѡ����������");
				return false
			}
			/*��֤��Чʱ����ʧЧʱ��*/
			if(document.all.sValidTime.value.trim()==""){
				rdShowMessageDialog("��Чʱ�䲻��Ϊ��!");
				return false;
			}
			if(document.all.sInvalidTime.value.trim()==""){
				rdShowMessageDialog("ʧЧʱ�䲻��Ϊ��!");
				return false;
			}
			if(parseInt(document.all.sValidTime.value.trim())<<%=dateStr%>){
				rdShowMessageDialog("��Чʱ�䲻��С�ڵ�ǰʱ��!");
				return false;						
			}
			if(parseInt(document.all.sInvalidTime.value.trim())<<%=dateStr%>){
				rdShowMessageDialog("ʧЧʱ�䲻��С�ڵ�ǰʱ��!");
				return false;						
			}
			chkTime(document.getElementById('sValidTime'),document.getElementById('sInvalidTime'));
			/* У��ʱ����� */
			/* У���������� */
			if($("#sMsgContent").val().trim()==""){
				rdShowMessageDialog("��������Ų�������");
				$("#sMsgContent")[0].focus();
				return false;
			}
			/* У���������ݳ��� */
			var msgContent =  $("#sMsgContent").val();
			var msgByteLen = getByteLen(msgContent);
			if(msgByteLen > 124){
				rdShowMessageDialog("���ֻ��������62������");
				return false;
			}
			/* У�鷢������ */
			if(document.all.sGroupId.value==""){
					rdShowMessageDialog("��ѡ�񷢲�����!");
					return false;
			}
			/* У�������� */
			if(document.all.sAuditLogins.value == ""){
					rdShowMessageDialog("��ѡ��������,������������Ҫһ��!");
					return false;							
			}
			/* �ύҳ�� */
			var confirmFlag = rdShowConfirmDialog("ȷ��Ҫ�ύ������?");
			if(confirmFlag!=1){
				return false;
			}
			/**�������²���,�������disabled���ܴ�ֵ����**/
			var iPromptType = document.all.iPromptType.value;
			var sValidFlag = document.all.sValidFlag.value;
			var sCreateLogin = document.all.sCreateLogin.value;
			var sCreateTime = document.all.sCreateTime.value;

			document.frm.action = "fd285Cfm.jsp?iPromptType="+iPromptType+"&sValidFlag="+sValidFlag+"&sCreateLogin="+sCreateLogin+"&sCreateTime="+sCreateTime;
			document.frm.submit();			
		}
		function getByteLen(str){ 
			var byteLen=0,len=str.length; 
			if(str){ 
				for(var i=0; i<len; i++){ 
					if(str.charCodeAt(i)>255){ 
						byteLen += 2; 
					} 
					else{ 
						byteLen++; 
					} 
				} 
				return byteLen; 
			} 
			else{ 
				return 0; 
			} 
		}
		function getMsgInfo(){
			/* ���ݶ��Ŵ��������ģ����ѯ����ģ�� */
			var sMsgCode = $("#msgCode").val();
			var sMsgName = $("#msgNote").val();
			var sKindCode = $("#kindCode").val();
			if(sMsgCode.trim() == "" && sMsgName.trim() =="" ){
				rdShowMessageDialog("ģ�������ģ�����Ʊ�������һ��!<br>(֧��ģ����ѯ,ֻ�����벿����Ϣ)");
				document.all.msgCode.focus();
				return false;
			}
			var h = 500;
      var w = 350;
      var t = screen.availHeight / 2 - h / 2;
      var l = screen.availWidth / 2 - w / 2;
      var impFrm = document.frm;
      var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
      var path = "fd285_getMsgInfo.jsp?kindCode="+sKindCode+"&sMsgCode="+sMsgCode+"&sMsgName="+sMsgName;
      var ret = window.showModalDialog(path, impFrm, prop);
      if(typeof(ret) != "undefined"){
	      setMsgInfo(ret);
	    }
		}
		function setMsgInfo(allStr){
			var valueArr = allStr.split("|");
			$("#msgCode").val(valueArr[0]);
			$("#msgNote").val(valueArr[1]);
			$("#sTemplateContent").val(valueArr[2]);
			/*2014/03/06 9:15:44 gaopeng  �����޸�12580��������ȵ���������ݵ����� �ص�֮����и�ֵ�󣬽�������û�*/
			if($.trim($("#msgCode").val()).length != 0){
				/*ģ������ģ�����Ʋ����޸�*/
				$("#msgCode").attr("readonly","readonly");
				$("#msgNote").attr("readonly","readonly");
			}
			/*2014/03/06 9:15:44 gaopeng  �����޸�12580��������ȵ���������ݵ����� �ص�֮����и�ֵ�󣬽�������û�*/
		}
		function clearMsgInfo(){
			$("#msgCode").val("");
			$("#msgNote").val("");
			$("#msgCode").attr("readonly","");
			$("#msgNote").attr("readonly","");
			$("#sTemplateContent").val("");
			$("#msgCode")[0].focus();
		}
		function checklen(){
			/* ��̬�޸�ʣ������ */
			var msgContent =  $("#sMsgContent").val();
			var msgByteLen = getByteLen(msgContent);
			var addedWordNumber = Math.ceil(msgByteLen / 2);
			var wordNumberObj = $("#wordNumber");
			if(msgByteLen <= 124){
				var surplusNum = 62 - addedWordNumber;
				var innetText = "�Ѿ����" + addedWordNumber + "�֣����������" + surplusNum + "��";
				wordNumberObj.html(innetText);
				wordNumberObj.css("color","");
			}else{
				var overTopNum = addedWordNumber - 62;
				var innetText = "�Ѿ�����" + overTopNum + "��";
				wordNumberObj.html(innetText);
				wordNumberObj.css("color","red");
			}
		}
		function changeMsgsCode(){
			/*$("#allKind").hide();*/
			$("#kindCode").val($("#msgsCode").val());
			$("#msgsCode").attr("disabled","disabled");
			$("#mainBody").show();
			$("#reselection").show();
			document.sAuditLoginInfoFrame.location = "fd285_getAuditLoginInfo.jsp?createLoginNo=<%=workNo%>";
		}
	</script>
<body>
<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���Ѷ�������</div>
	</div>
	<div id="allKind">
		<table cellspacing="0">
			<tr>
				<td class="blue">��ѡ����Ŵ����</td>
				<td>
				<select name="msgsCode" id="msgsCode" onchange="changeMsgsCode()">
					<option value="none">--��ѡ��--</option>
					<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>select distinct kind_code,kind_name from sshortmsgscode</wtc:sql>
					</wtc:qoption>
				</select>
				<input type="hidden" name="kindCode" id="kindCode" />
				<input type="button" name="reselection" id="reselection" style="display:none"
				 class="b_text" value="��ѡ" onclick="doReset()" />
				</td>
			</tr>
		</table>
	</div>
	<div id="mainBody" style="display:none;">
	<!--������������,1,����,2,�ջ�,3,����-->
	<input type="hidden" name="iReleaseAction" value="1">
	<table>
		<tr>
			<td width="15%" class="blue" nowrap>����ģ�����</td>
			<td width="35%">
				<input name="msgCode" id="msgCode" />
				<input name="" type="button" class="b_text" style="cursor:hand" onClick="getMsgInfo()" value="��ȡ">&nbsp;
				<input name=""  type="button" class="b_text" style="cursor:hand" onClick="clearMsgInfo()" value="���">
			</td>
			<td width="15%" class="blue" nowrap>����ģ������</td>
			<td>
				<input type="text" name="msgNote" id="msgNote" value="">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
			</td>
		</tr>
		<tr>
			<td class="blue">��������</td>
			<td >
				<input type="text" name="sReleaseGroupName" value="<%=sReleaseGroupName%>" disabled>
				<input type="hidden" name="sReleaseGroup" value="<%=groupId%>">
				<!-- ��ʾ����,�������ͣ�Ӧ�г���Ҫ������ -->
				<input type="hidden" name="iPromptType" value="20" />
				<input type="hidden" name="Channels_Code" value="01" />
			</td>
			<td width="15%" class="blue" nowrap>��Ч��־</td>
			<td>
				<select name="sValidFlag" disabled>
					<option value="Y" selected>��Ч</option>
					<option value="N">��Ч</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">��������</td>
			<td><input type="text" name="sCreateLogin" value="<%=workNo%>" disabled></td>
			<td class="blue">����ʱ��</td>
			<td><input type="text" name="sCreateTime" value="<%=dateStr1%>" disabled></td>
		</tr>
		<tr>
			<td class="blue">��Чʱ��</td>
			<td><input type="text" name="sValidTime" value="<%=dateStr%>" maxlength="8" 
						 onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;">
			</td>
			<td class="blue">ʧЧʱ��</td>
			<td><input type="text" name="sInvalidTime" value="20500101" maxlength="8" 
					 onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"
					 onblur="chkTime(document.getElementById('sValidTime'),document.getElementById('sInvalidTime'))" 	/>
			</td>
		</tr>
		<tr>
			<td class="blue">ģ������</td>
			<td colspan="3">
				<textarea name="sTemplateContent" id="sTemplateContent" rows="4" cols="75" disabled readonly></textarea>
				<font class="orange"><span id="wordNumber">(ע:$��Ϊ����)</span></font>
			</td>
		</tr>
		<tr>
			<td class="blue">���Ų�������</td>
			<td colspan="3">
				<textarea name="sMsgContent" id="sMsgContent" rows="4" cols="75" 
					 onpropertychange="checklen(this)" ></textarea>
				<font class="orange"><span id="wordNumber">(ע:���62������)</span></font>
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>������������</td>
			<td colspan="3">
				<select name="promulgateNodeType" onchange="doChangePromNodeType()">
					<option value="none" selected>��ѡ��</option>
							<%
							if(root_distance_int==1)
							{
							%>
								<option value="0">ʡ</option>
								<option value="1">����</option>
							<%
							}
							if(root_distance_int==2)
							{
							%>
								<option value="1">����</option>
								<option value="2">����</option>
							<%}
							if(root_distance_int>2)
							{
							%>
								<option value="2">����</option>
							<%}%>
				</select>
			</td>
		</tr>
		<tr id="townByRegionTr" style="display:none">
			<td width="15%" class="blue">��ѡ�����</td>
			<td colspan="3">
				<select name="townByRegionSelect" onchange="doChangeTownByRegion()">
					<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>select group_id,group_id||'->'||group_name from dChnGroupMsg where group_id in (select parent_group_id from dChnGroupInfo  where group_id = '<%=groupId%>' ) and ROOT_DISTANCE = 2</wtc:sql>
					</wtc:qoption>
				</select> 
			</td>
		</tr>
		<tr>
			<td colspan="4" style="height:0;">
				<iframe frameBorder="0" id="promulgateNodeFrame" align="center" 
					 name="promulgateNodeFrame" scrolling="no" style="height:100%; 
					 visibility:inherit; width:100%; z-index:1; display:none;"  
					 onload="document.getElementById('promulgateNodeFrame').style.height=promulgateNodeFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>��ѡ�ķ�������</td>
			<td colspan="3">
				<textarea name="sGroupInfo" id="sGroupInfo" rows="5" cols="75" readonly></textarea>
				<input type="hidden" name="sGroupId" id="sGroupId" value="">
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>��ѡ��������</td>
			<td colspan="3">
				<iframe frameBorder="0" id="sAuditLoginInfoFrame" align="center" name="sAuditLoginInfoFrame" 
					scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1;"  
					onload="document.getElementById('sAuditLoginInfoFrame').style.height=sAuditLoginInfoFrame.document.body.scrollHeight+'px'"></iframe>
				<input type="hidden" name="sAuditLogins" value="">
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>������ע</td>
			<td colspan="3">
				<input type="text" name="opNote" value="" size="90" maxlength="60">
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="����" onclick="doReset()" />
				&nbsp;
				<input type="button" name="subbtn" class="b_foot" value="�ύ���" onclick="doConfirm()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>