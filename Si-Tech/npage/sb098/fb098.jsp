<%
  /* *********************
   * 功能:集团成员资费变更冲正
   * 版本: 1.0
   * 日期: 2010/07/29
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>集团成员资费变更冲正</title>
	<%
		String opCode = "b098";
		String opName = "集团成员资费变更冲正";
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String sysAccept = "";
	%>
	<%
		try{
	%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 
			routerValue="<%=regionCode%>"  id="seq"/>
	<%
		sysAccept = seq;
		}catch(Exception ex){
			ex.printStackTrace();
	%>
			<script language="javascript">
				rdShowMessageDialog("取系统操作流水失败！");
				removeCurrentTab();
			</script>
	<%
		}
	%>
	<script language="javascript">
		function doQuery(){
			//查询
			if(!checkElement(document.frm.accept_no)){
				return false;
			}
			var acceptNo = $("#accept_no").val();
			var myPacket = new AJAXPacket("fb098_query.jsp","正在获得查询信息，请稍候......");	
			myPacket.data.add("acceptNo",acceptNo);
			myPacket.data.add("opcode","<%=opCode%>");
			myPacket.data.add("opName","<%=opName%>");
			core.ajax.sendPacket(myPacket,doQueryReturn);
			myPacket = null;
		}
		function doQueryReturn(packet){
			//查询回调函数
			var errorCode=packet.data.findValueByName("errorCode");
			var errorMsg=packet.data.findValueByName("errorMsg");
			if(errorCode == "000000"){
				var loginAccept = packet.data.findValueByName("loginAccept");
				var phoneNo 	= packet.data.findValueByName("phoneNo");
				var memberName 	= packet.data.findValueByName("memberName");
				var smName	 	= packet.data.findValueByName("smName");
				var offerIdA 	= packet.data.findValueByName("offerIdA");
				var offerNameA 	= packet.data.findValueByName("offerNameA");
				var offerIdB 	= packet.data.findValueByName("offerIdB");
				var offerNameB 	= packet.data.findValueByName("offerNameB");
				var loginName 	= packet.data.findValueByName("loginName");
				var loginTime 	= packet.data.findValueByName("loginTime");
				var smCode 		= packet.data.findValueByName("smCode");
				var idNo 		= packet.data.findValueByName("idNo");
				
				var sysNote = "集团成员资费变更冲正: <%=workNo%>对手机号码: "+phoneNo;
				
				$("#loginAccept").val(loginAccept);
				$("#phoneNo").val(phoneNo);
				$("#memberName").val(memberName);
				$("#smName").val(smName);
				$("#offerIdA").val(offerIdA);
				$("#offerNameA").val(offerNameA);
				$("#offerIdB").val(offerIdB);
				$("#offerNameB").val(offerNameB);
				$("#loginName").val(loginName);
				$("#loginTime").val(loginTime);
				$("#smCode").val(smCode);
				$("#idNo").val(idNo);
				
				$("#sys_note").val(sysNote);
				$("#confirm").removeAttr("disabled");
			}else{
				rdShowMessageDialog("信息查询失败！错误代码:"+errorCode+"；错误信息:"+errorMsg);
				return false;
			}
		}
		function doSubmit(){
			//业务提交
			var acceptNo = $("#accept_no").val();
			var sysaccept = $("#sysaccept").val();
			var opNote = $("#sys_note").val();
			var idNo = $("#idNo").val();
			var smCode = $("#smCode").val();
			
			var myPacket = new AJAXPacket("fb098_submit.jsp","正在进行冲正，请稍候......");	
			myPacket.data.add("opcode","<%=opCode%>");
			myPacket.data.add("opName","<%=opName%>");
			myPacket.data.add("opNote",opNote);
			myPacket.data.add("acceptNo",acceptNo);
			myPacket.data.add("sysaccept",sysaccept);
			myPacket.data.add("idNo",idNo);
			myPacket.data.add("smCode",smCode);
			core.ajax.sendPacket(myPacket,doSubReturn);
			myPacket = null;
		}
		function doSubReturn(packet){
			//提交回调函数
			var errorCode=packet.data.findValueByName("errorCode");
			var errorMsg=packet.data.findValueByName("errorMsg");
			if(errorCode == "000000"){
				rdShowMessageDialog("集团成员资费变更冲正成功");
				frm.reset();
				$("#confirm").attr("disabled","disabled");
			}else{
				rdShowMessageDialog("集团成员资费变更冲正失败！错误代码:"+errorCode+"；错误信息:"+errorMsg);
				return false;
			}
		}
		function printCommit(){
			//打印
			getAfterPrompt();
			if(!check(document.frm)){
				return false;
			}
			if($("#phoneNo").val() == null || $("#phoneNo").val() == ""){
				rdShowMessageDialog("用户手机号码不能为空");
				return false;
			}
			var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if (rdShowConfirmDialog("是否提交确认操作？")==1){
				doSubmit();
			}
			else{
				return false;	
			}
		}
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{  //显示打印对话框
		   var h=180;
		   var w=350;
		   var t=screen.availHeight/2-h/2;
		   var l=screen.availWidth/2-w/2;
		   var printStr = printInfo(printType);
		   if(printStr == "failed")
		   {
		   		return false;   
		   }
		
		   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
		   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
		   var ret=window.showModalDialog(path,"",prop);
		}
		
		function printInfo(printType)
		{
				var retInfo = "";
		 		retInfo+='<%=workName%>'+"|";
		    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		    	retInfo+="资费变更流水号:"+$("#accept_no").val()+"|";
		    	retInfo+="用户手机号码:"+$("#phoneNo").val()+"|";
		    	retInfo+="用户名称:"+$("#memberName").val()+"|";
		    	retInfo+="成员ID:"+$("#idNo").val()+"|";
		    	retInfo+="变更前资费名称:"+$("#offerNameA").val()+"|";
		    	retInfo+="变更后资费名称:"+$("#offerNameB").val()+"|";
				retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+="业务类型：集团成员资费变更冲正"+"|";
		    	retInfo+="流水："+"<%=sysAccept%>"+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=$("#sys_note").val()+"|";
				return retInfo;
		}
	</script>
	
</head>
<body>
<form name="frm" method="POST" action="selectserv_Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团成员资费变更冲正</div>
	</div>

	<table cellspacing="0">
		<tr>
			<td class="blue">资费变更流水号</td>
			<td colspan="3">
				<input type="text" name="accept_no" id="accept_no" maxlength="12" v_type="0_9" v_must="1" value="">
	            <font class="orange"> *</font>
	            <input type="button" class="b_text" name="Button1" value="查询" onclick="doQuery()">
			</td>
		</tr>
		<tr>
			<td class="blue">用户手机号码</td>
			<td>
				<input type="text" name="phoneNo" id="phoneNo" readonly class="InputGrey" value="">
			</td>
			<td class="blue">用户名称</td>
			<td>
				<input type="text" name="memberName" id="memberName" readonly class="InputGrey" value="">
			</td>
		</tr>
		<tr>
			<td class="blue">成员ID</td>
			<td>
				<input type="text" name="idNo" id="idNo" readonly class="InputGrey" value="" />
			</td>
			<td class="blue">业务品牌名称</td>
			<td>
				<input type="text" name="smName" id="smName" readonly class="InputGrey" value="" />
			</td>
		</tr>
		<tr>
			<td class="blue">变更前的资费代码</td>
			<td>
				<input type="text" name="offerIdA" id="offerIdA" readonly class="InputGrey" value="" />
			</td>
			<td class="blue">变更前的资费名称</td>
			<td>
				<input type="text" name="offerNameA" id="offerNameA" readonly class="InputGrey" value="" size="30" />
			</td>
		</tr>
		<tr>
			<td class="blue">变更后的资费代码</td>
			<td>
				<input type="text" name="offerIdB" id="offerIdB" readonly class="InputGrey" value="" />
			</td>
			<td class="blue">变更后的资费名称</td>
			<td>
				<input type="text" name="offerNameB" id="offerNameB" readonly class="InputGrey" value="" size="30" />
			</td>
		</tr>
		<tr>
			<td class="blue">操作员姓名</td>
			<td>
				<input type="text" name="loginName" id="loginName" readonly class="InputGrey" value="" />
			</td>
			<td class="blue">操作时间</td>
			<td>
				<input type="text" name="loginTime" id="loginTime" readonly class="InputGrey" value="" />
			</td>
		</tr>
		<tr>
			<td class="blue">备注</td>
			<td colspan="3">
				<input class="InputGrey" name="sys_note" id="sys_note" size="70" readonly />
			</td>
		</tr>
		<tr id="footer">
			<td colspan="4">
				<input type="button" name="confirm" id="confirm" class="b_foot" value="确认" onClick="printCommit()" disabled />
				&nbsp;
				<input type="reset" name="clear" class="b_foot" value="清除" >
				&nbsp;
				<input type="button" name="back" class="b_foot" value="关闭" onClick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	<input type="hidden" name="sysaccept" id="sysaccept" value="<%=sysAccept%>" />
	<input type="hidden" name="smCode" id="smCode" />
	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

