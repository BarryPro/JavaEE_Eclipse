<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "d287";
 		String opName = "���Ѷ���ɾ��";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());
		/**�鿴���ŵļ���,�����Ӫҵ���ļ�����С,��������޸�ҳ��**/
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region" 
			 routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}
		/**
			������ŵļ�������ظ�С,���ܽ����޸Ĳ���;1.�жϹ��ŵļ���,
			���root_distance==1,ʡ��,==2,����,==3,����,>3,Ӫҵ�����С�ļ���
		**/
		if(loginRootDistance>3){
%>
				<table cellspacing="0">
					<tr bgcolor='649ECC' height=25 align="center">
						<td>
							<font style="color:red">(�˹�����ɾ��Ȩ��)</font>
						</td>
					</tr>
				</table>
				<script language="javascript">
					<!--
					rdShowMessageDialog("�˹�����ɾ��Ȩ��");
					window.close();
					//-->
				</script>	
<%
				return;
		}
%>
<html>
	<head>
	<title>���Ѷ���ɾ��</title>
	<script language="javascript">
		function doReset(){
			//window.location.reload();
			//��"����"ҳ��ʱ,���������־�Զ���ת������ǰ���Ǹ�ҳ��
			window.location.href = "fd287.jsp";
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
      var path = "../sd285/fd285_getMsgInfo.jsp?sMsgCode="+sMsgCode+"&sMsgName="+sMsgName+"&kindCode="+sKindCode;
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
		}
		function doQuery(){
			var msgCodeVal = $("#msgCode").val().trim();
			var msgNoteVal = $("#msgNote").val().trim();
			var iPromptTypeVal = $("#iPromptType").val().trim();
			var iPromptSeqVal = $("#iPromptSeq").val().trim();
			var ichannelCode = $("#channels_Code").val().trim();
			document.getElementById("qryOprInfoFrame").style.display="block";
			var frameurl = "fd287_getMsgInfoByMsgCode.jsp?iMsgCode="
					+msgCodeVal+"&iMsgNote="+msgNoteVal+"&iPromptType="
					+iPromptTypeVal+"&iPromptSeq="+iPromptSeqVal
					+"&ichannelCode=" + ichannelCode
					+"&rootDistance=<%=loginRootDistance%>";
			document.qryOprInfoFrame.location.href = frameurl;
		}
		function doConfirm(){
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

			document.frm.action = "fd287Cfm.jsp";
			document.frm.submit();		
		}
		function changeMsgsCode(){
			$("#kindCode").val($("#msgsCode").val());
			$("#msgsCode").attr("disabled","disabled");
			$("#mainBody").show();
			$("#reselection").show();
		}
	</script>
	</head>
<body>
<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">���Ѷ���ɾ��</div>
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
		<table cellspacing="0">
			<tr>
				<td width="15%" class="blue" nowrap>����ģ�����</td>
				<td width="35%">
					<input name="msgCode" id="msgCode" />
					<input type="hidden" name="msgCodeHide" />
					<input name="getMsgInfoBtn" type="button" class="b_text" style="cursor:hand" 
					 onClick="getMsgInfo()" value="��ȡ">&nbsp;
					<input name="clearMsgInfoBtn"  type="button" class="b_text" style="cursor:hand" 
					 onClick="clearMsgInfo()" value="���">
				</td>
				<td width="15%" class="blue" nowrap>����ģ������</td>
				<td>
					<input type="text" name="msgNote" id="msgNote" value="">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
					<input type="hidden" name="msgNoteHide" />
				</td>
			</tr>
			<tr>
				<td width="15%" class="blue" nowrap>��ʾ����</td>
				<td>
					<select name="iPromptType" id="iPromptType">
						<option value="20" selected>���Ѷ���</option>
					</select>
					<input type="hidden" name="iPromptTypeHide" />
				</td>
				<td width="15%" class="blue" nowrap>��ʾ���</td>
				<td>
					<input type="text" name="iPromptSeq" id="iPromptSeq" value="">
					<input type="hidden" name="iPromptSeqHide" />
					<input type="hidden" name="channels_Code" id="channels_Code" value="01" />
					<input type="hidden" name="Channels_CodeHidden" value="">		
				</td>
			</tr>
			<tr>
				<td colspan="4" style="height:0;">
					<iframe frameBorder="0" id="qryOprInfoFrame" align="center" 
						 name="qryOprInfoFrame" scrolling="no" style="height:100%; 
						  visibility:inherit; width:100%; z-index:1; display:none;" 
						  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
				</td>
			</tr>
		</table>
		<table id="showMsgInfo" name="showMsgInfo" style="display:none">
			<tr>
				<td width="15%" class="blue" nowrap>ģ������</td>
				<td>
					<textarea name="sTemplateContent" id="sTemplateContent" rows="4" 
						 cols="75" disabled readOnly ></textarea>
				</td>
			</tr>
			<tr>
				<td width="15%" class="blue" nowrap>��ѡ��������</td>
				<td>
					<iframe frameBorder="0" id="sAuditLoginInfoFrame" align="center" 
						 name="sAuditLoginInfoFrame" scrolling="no" style="height:180px; 
						  visibility:inherit; width:100%; z-index:1;" ></iframe>
					<input type="hidden" name="sAuditLogins" value="">
				</td>
			</tr>
			<tr>
				<td width="15%" class="blue" nowrap>������ע</td>
				<td>
					<input type="text" name="opNote" size="90" maxlength="60" />
				</td>
			</tr>
		</table>
		<table>
			<tr> 
        <td id="footer"> 
        	 <input type="button" name="queryButton"  class="b_foot" value="��ѯ" 
        	 	 style="cursor:hand;" onclick="doQuery()">&nbsp;
           <input type="button" name="resetButton"  class="b_foot" value="����" 
           	 style="cursor:hand;" onclick="doReset()">&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="ȷ��ɾ��" 
           	 style="cursor:hand;" onClick="doConfirm()" disabled>&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="�ر�" 
            style="cursor:hand;" onClick="removeCurrentTab()">&nbsp;
        </td>
      </tr>
		</table>
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
