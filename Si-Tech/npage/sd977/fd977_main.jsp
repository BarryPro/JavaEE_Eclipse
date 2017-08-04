<%
  /*
   * 功能: 关于“家庭合帐分享”业务需求
   * 版本: 1.0
   * 日期: 20110701
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String comboType = request.getParameter("comboType");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String ipAddr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String[][] mainArr = new String[][]{};
	String[][] memArr = new String[][]{};
	String[][] beginTimeArr = new String[][]{};
	String[][] endTimeArr = new String[][]{};
	String limitNo = new String();
	//判断是否需要输入密码
	boolean pwrf = false;
  String[][] pubFavInfo =(String[][])session.getAttribute("favInfo");
  String[] pubFavStr= new String[pubFavInfo.length];
  for(int i=0;i<pubFavStr.length;i++) pubFavStr[i]=pubFavInfo[i][0].trim();
	if(WtcUtil.haveStr(pubFavStr,"a272")) {	//有免密码权限
		System.out.println("免密码权限!!!!");
		pwrf = true;
	}
	//pwrf = false;
	
  System.out.println("====fd977_main.jsp====wanghfa==== opCode = " + opCode);
  System.out.println("====fd977_main.jsp====wanghfa==== opName = " + opName);

	String result[] = new String[3];
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
	System.out.println("====wanghfa====fd977_main.jsp====s7327Qry====0==== 家长号码 = " + activePhone);
	System.out.println("====wanghfa====fd977_main.jsp====s7327Qry====1==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd977_main.jsp====s7327Qry====2==== inOpFlag = a");
	System.out.println("====wanghfa====fd977_main.jsp====s7327Qry====3==== 0");
%>
	<wtc:service name="s7327Qry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="12">
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="a"/>
	</wtc:service>
	<wtc:array id="result0"  start="0" length="2" scope="end"/>
	<wtc:array id="result1"  start="2" length="1" scope="end"/>
	<wtc:array id="result2"  start="3" length="1" scope="end"/>
	<wtc:array id="result3"  start="4" length="1" scope="end"/>
	<wtc:array id="result4"  start="5" length="1" scope="end"/>
	<wtc:array id="result5"  start="6" length="1" scope="end"/>
	<wtc:array id="result6"  start="7" length="1" scope="end"/>
	<wtc:array id="result7"  start="8" length="3" scope="end"/>
	<wtc:array id="result8"  start="11" length="1" scope="end"/>
<%
	System.out.println("====wanghfa=====fd977_main.jsp====s7327Qry : " + retCode1 + "," + retMsg1);
	
	if (!retCode1.equals("000000")) {
%>
	<script language="JavaScript">
		rdShowMessageDialog("s7327Qry代码：<%=retCode1%>，信息：<%=retMsg1%>",0);
		history.go(-1);
	</script>
<%
	} else {
		if (result7.length > 0) {
			for (int j = 0; j < result7[0].length; j ++) {
				System.out.println("====wanghfa=====fd977_main.jsp====s7327Qry==== result7[0]["+j+"] = " + result7[0][j]);
				result[j] = result7[0][j];
			}
		}
		System.out.println("====wanghfa=====fd977_main.jsp====s7327Qry==== result1.length = " + result1.length);
		if(result1.length > 0) {
			mainArr = result1;// 主卡号码
			memArr = result8;//副卡号码
			beginTimeArr = result3;//开始日期
			endTimeArr = result4;//结束日期
			limitNo = result6[0][0];
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>家庭合账分享申请</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	window.onload = function() {
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);
		
		if (!checkElement(document.getElementById("addMemberPhone"))) {
			document.getElementById("addMemberPhone").focus();
			controlBtn(false);
			return false;
		} else if(parseInt(document.frm.numLimit.value) <= 0) {
			rdShowMessageDialog("被付费用户数已满，不能再办理此业务！", 1);
			controlBtn(false);
			return false;
		}

		<%
		if (!pwrf) {
		%>
			if (document.getElementById("memberPwd").value.length !=6) {
				rdShowMessageDialog("请输入6位密码！", 1);
				document.getElementById("memberPwd").focus();
				controlBtn(false);
				return false;
			}
			var checkPwdPacket = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行号码校验，请稍候......");
			checkPwdPacket.data.add("custType", "01"); //01:手机号码 02 客户密码校验 03帐户密码校验
			checkPwdPacket.data.add("phoneNo", document.getElementById("addMemberPhone").value); //移动号码,客户id,帐户id
			checkPwdPacket.data.add("custPaswd", document.getElementById("memberPwd").value);//用户/客户/帐户密码
			checkPwdPacket.data.add("idType", ""); //en 密码为密文，其它情况 密码为明文
			checkPwdPacket.data.add("idNum", ""); //传空
			checkPwdPacket.data.add("loginNo", "<%=workNo%>"); //工号
			core.ajax.sendPacket(checkPwdPacket, doMsg);
			checkPwdPacket = null;
		<%
		} else {
		%>
			cfm();
		<%
		}
		%>
	}
	
	function doMsg(packet) {
		var retCode = packet.data.findValueByName("retResult");
		var retMsg = packet.data.findValueByName("msg");
		if(retCode == "000000"){
			cfm();
		}else{
			rdShowMessageDialog(retMsg);
			controlBtn(false);
			return false;
		}
	}
	
	function cfm() {
		var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");	//打印免填单
		
		if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
			document.frm.submit();
		} else {
			controlBtn(false);
			return false;
		}
	}

	
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //显示打印对话框
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
		var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
		var sysAccept="<%=printAccept%>";                          // 流水号
		var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
		var mode_code=null;                                        //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var opCode="<%=opCode%>";                                  //操作代码
		var phoneNo="<%=activePhone%>";         					        //客户电话

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType) {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间
		
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info+="手机号码：" + document.getElementById("activePhone").value + "|";
		cust_info+="客户姓名：" + document.getElementById("custName").value + "|";
		cust_info+="证件号码：" + document.getElementById("idCardNo").value + "|";
		cust_info+="客户地址：" + document.getElementById("custAddr").value + "|";
		opr_info += "业务类型：<%=opName%>" + "|";
		opr_info += "业务流水：<%=printAccept%>" + "|";
		opr_info += "主卡号码：<%=activePhone%>" + "|";
		opr_info += "副卡号码：" + document.getElementById("addMemberPhone").value + "|";
		opr_info += "办理时间：" + exeDate + "|";
		opr_info += "生效时间：" + exeDate + "|";
		document.getElementById("opNote").value = "工号<%=workNo%>为<%=activePhone%>用户办理<%=opName%>。";
		
		note_info1+="操作备注："+"|";
		note_info1+="1.哈尔滨移动客户可以办理此业务，公免、公务、测试卡、托收账户及欠费、非正常状态客户除外。"+"|";
		note_info1+="2.主卡仅现金账户可以为副卡进行付费，包年等专款账户无法为副卡进行付费。"+"|";
		note_info1+="3.主卡欠费停机将引发副卡随主卡停机而停机。"+"|";
		note_info1+="4.主卡为副卡付费金额不算做主卡的底线消费内。"+"|";
		note_info1+="5.若副卡为全球通或动感地带品牌客户，主卡为副卡付费金额所引发的积分，归副卡所有。若副卡为神州行客户，则主卡为副卡付费金额不产生积分。"+"|";
		note_info1+="6.申请“合帐分享”业务，办理后立即生效，取消该业务下月生效。"+"|";
		note_info1+="7.主卡为副卡付费的金额在月底出账时一次性划拨。"+"|";
		
		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}

</script>
</head>
<body>

<form name="frm" method="POST" action="fd977_cfm.jsp">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="opNote" id="opNote" value="">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
<input type="hidden" name="numLimit" id="numLimit" value="<%=limitNo%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">主用户信息</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			电话号码
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			客户名称
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[0]%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			客户地址
		</td>
		<td colspan="3">
			<input name="custAddr" id="custAddr" type="text" size="60" class="InputGrey" value="<%=result[1]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			证件号码
		</td>
		<td colspan="3">
			<input type="text" name="idCardNo" id="idCardNo" size="40" value="<%=result[2]%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			被付费号码
		</td>
		<td>
			<input type="text" name="addMemberPhone" id="addMemberPhone" value="" maxlength="11" v_maxlength="11" v_must="1"/>
		</td>
		<td class="blue">
			密码
		</td>
		<td>
		<%
			if (pwrf) {
				%>
					此工号有免密权限，可不输入用户密码
				<%
			} else {
				%>
					<input type="password" name="memberPwd" id="memberPwd" type="text" onKeyPress="return isKeyNumberdot(0)" maxlength="6" v_maxlength="6">
					<input class="b_text" onclick="showNumberDialog(document.all.memberPwd);" type=button value="输入">
				<%
			}
		%>
		</td>
	</tr>
</table>
<br/>
<div class="title">
	<div id="title_zi">付费信息</div>
</div>
<table>
	<tr>
		<th width="20%" align=center>主卡号码</th>
		<th width="20%" align=center>副卡号码</th>
		<th width="25%" align=center>开始时间</th>
		<th width="25%" align=center>结束时间</th>
	</tr>
<%
	if (memArr.length == 0) {
		%>
		<tr>
		  <td colspan="4" align=center>无信息</td>
		</tr>
		<%
	} else {
		for (int i = 0; i < memArr.length; i ++) {
			System.out.println("====wanghfa=====fd977_main.jsp====s7327Qry==== " + mainArr[i][0] + "," + memArr[i][0] + "," + beginTimeArr[i][0] + "," + endTimeArr[i][0]);
			%>
			<tr>
			  <td align=center><%=mainArr[i][0]%></td>
			  <td align=center><%=memArr[i][0]%></td>
			  <td align=center><%=beginTimeArr[i][0]%></td>
			  <td align=center><%=endTimeArr[i][0]%></td>
			</tr>
			<%
		}
	}
%>
</table>
<table>
	<tr>
		<td colspan="4" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确定" onClick="doCfm();">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="返回" onClick="window.location = 'fd977.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>';">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
</DIV>
</DIV>

</form>
</body>
</html>
