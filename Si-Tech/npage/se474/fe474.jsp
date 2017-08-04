<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<head>  
<title>����û���Ϣ���</title>
<%
  System.out.println(" =========== ningtn  ======  ");
	String opCode = "e474";
	String opName = "����û���Ϣ���";
	String phoneNo = (String)request.getParameter("activePhone");
	String broadPhone = (String)request.getParameter("broadPhone");
	String regionCode= (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String loginAccept = "";
	String custName = "";
	String contactName = "";
	String contactPhone = "";
	String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		loginAccept = seq;
%>
	<wtc:service name="sE474Init" outnum="7" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=broadPhone%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if("000000".equals(retCode)){
		if(result != null && result.length > 0){
			custName = result[0][1];
			contactName = result[0][2];
			contactPhone = result[0][3];
		}
	}else{
		%>
	<script language="javascript">
		rdShowMessageDialog("û�в�ѯ���û���Ϣ<%=retCode%> : <%=retMsg%>");
		removeCurrentTab();
	</script>
		<%
	}
%>
</head>
<script language="javascript">
	function nextStep(subButton){
		if(!check(document.form1)){
			return false;
		}
		controlButt(subButton);
		getAfterPrompt();
		printCommit();
	}
	function printCommit(){
			var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
					frmCfm();
				}
			}
			return true;
	}
	function showPrtDlg(printType,DlgMessage,submitCfm){
		var h=210;
		var w=400;
		var t = screen.availHeight / 2 - h / 2;
		var l = screen.availWidth / 2 - w / 2;
		var opCode="<%=opCode%>";
		var pType="subprint";
		var billType="1";
		var mode_code=null;
		var fav_code=null;
		var area_code=null;
		var sysAccept = $("#loginAccept").val();
		var printStr = printInfo(printType);
		var iRetrun = 0;
		var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret = window.showModalDialog(path, printStr, prop);
	}
	
	/*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
	function getPubSmCode(kdNo){
			var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("phoneNo","");
			getdataPacket.data.add("kdNo",kdNo);
			core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
			getdataPacket = null;
	}
	function doPubSmCodeBack(packet){
		retCode = packet.data.findValueByName("retcode");
		retMsg = packet.data.findValueByName("retmsg");
		smCode = packet.data.findValueByName("smCode");
		if(retCode == "000000"){
			$("#pubSmCode").val(smCode);
		}
	}
	
	function printInfo(printType){
		
		getPubSmCode($("#cfm_login").val());
		var pubSmCode = $("#pubSmCode").val();
		
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		var cTime = "<%=cccTime%>";
		        
		cust_info += "����ʺţ�" + $("#cfm_login").val() + "|";
		cust_info += "�ͻ�������" + $("#cust_name").val() + "|";
		
		opr_info += "ҵ������ʱ�䣺" + cTime + "|";
		opr_info += "ҵ��������ƣ��û���Ϣ���       ������ˮ:" + $("#loginAccept").val() + "|";
		opr_info += "�ͻ�������" + "|";
		opr_info += "��ϵ��������" + $("#contact_name").val() + "|";
		opr_info += "��ϵ�绰��" + $("#contact_phoneno").val() + "|";
		/* 
	   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
	   * ����ʡ���kg������Ʒ��kh
	   */
		if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh"){
			note_info1 += "��ע��"+"|";
			note_info1 += "1������ϵ�绰�䶯ʱ���뼰ʱ���ƶ���˾��ϵ���Ա������»�������ʱ��ʱ�յ�֪ͨ��"+"|";
			note_info1 += "2������������벦��������ߣ�10086��"+"|";
		}
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
	}
	function frmCfm(){
		showLightBox();
		form1.action="fe474Cfm.jsp";
		form1.submit();
	}
</script>
<body>  
<form name="form1" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">����û���Ϣ���</div>
	</div>
  <table cellspacing="0">
  	<tr>
  		<td class="blue">����˺�</td>
  		<td>
  			<input type="text" id="cfm_login" name="cfm_login" class="InputGrey" readOnly value="<%=broadPhone%>" />
  		</td>
  		<td class="blue">�ͻ�����</td>
  		<td>
  			<input type="text" id="cust_name" name="cust_name" class="InputGrey" readOnly value="<%=custName%>" />
  		</td>
  	</tr>
  	<tr>
  		<td class="blue">��ϵ��</td>
  		<td>
  			<input type="text" id="contact_name" name="contact_name" maxlength="30" 
  				v_type="string" v_must="1" onblur="checkElement(this)" value="<%=contactName%>" />
  			<font class="orange">*</font>
  		</td>
  		<td class="blue">��ϵ�绰</td>
  		<td>
  			<input type="text" id="contact_phoneno" name="contact_phoneno" maxlength="15" 
  				v_type="phone" v_must="1" onblur="checkElement(this)" value="<%=contactPhone%>" />
  			<font class="orange">*</font>
  		</td>
  	</tr>
  </table>
  <table cellspacing="0">
  	<tr>
  		<td id="footer">
  		<div align="center"> 
  			<input name="confirm" onClick="nextStep(this)" type="button" class="b_foot" value="ȷ��" />
  			&nbsp;&nbsp;
				<input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�" />
			</div>
  		</td>
  	</tr>
  </table>
  <input type="hidden" name="opCode" value="<%=opCode%>" />
  <input type="hidden" name="opName" value="<%=opName%>" />
  <input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>" />
  <input type="hidden" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" />
  <input type="hidden" name="broadPhone" id="broadPhone" value="<%=broadPhone%>" />
  <!-- 2014/04/04 11:15:23 gaopeng Ʒ��sm_code -->
	<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</html>  
