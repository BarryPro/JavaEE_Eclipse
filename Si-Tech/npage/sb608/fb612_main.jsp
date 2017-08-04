<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-26 三口之家
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>三口之家家庭信息查询</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String pwrf = WtcUtil.repNull(request.getParameter("pwrf"));
	System.out.println("=========wanghfa========= fb612_main.jsp " + opCode + ", " + opName + ", " + pwrf);
	
	String fatherPhone4 = WtcUtil.repNull(request.getParameter("fatherPhone4"));
	String fatherPwd4 = WtcUtil.repNull(request.getParameter("fatherPwd4"));
	
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String result[][] = new String[1][15];
	
	System.out.println("===========wanghfa=sB608Qry==0====== loginAccept = ");
	System.out.println("===========wanghfa=sB608Qry==1====== chnSource = 01");
	System.out.println("===========wanghfa=sB608Qry==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB608Qry==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB608Qry==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB608Qry==5====== 家长号码 = " + fatherPhone4);
	System.out.println("===========wanghfa=sB608Qry==6====== 家长密码 = " + fatherPwd4);
	System.out.println("===========wanghfa=sB608Qry==7====== 成员号码 = ");
	System.out.println("===========wanghfa=sB608Qry==8====== 成员密码 = ");
	System.out.println("===========wanghfa=sB608Qry==9====== 查询类型 = 1");
%>
<wtc:service name="sB608Qry" routerKey="phone" routerValue="<%=fatherPhone4%>" retcode="retCode2" retmsg="retMsg2" outnum="15">
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value="<%=fatherPhone4%>"/>
	<wtc:param value="<%=fatherPwd4%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="1"/>
</wtc:service>
<wtc:array id="result2" scope="end"/>
<%
	System.out.println("===========wanghfa======= sB608Qry : " + retCode2 + ", " + retMsg2);
	
	if (!"000000".equals(retCode2)) {
%>
		<script language=javascript>
			rdShowMessageDialog("sB608Qry : <%=retCode2%>, <%=retMsg2%>", 0);
			history.go(-1);
		</script>
<%
	} else if ("000000".equals(retCode2)) {
		if (result2.length != 0) {
			for (int j = 0; j < result2[0].length; j ++) {
				System.out.print("========wanghfa======= sB608Qry : result2[0][" + j + "] = ");
				System.out.println(result2[0][j]);
				result[0][j] = result2[0][j];
			}
		} else {
%>
			<script language=javascript>
				rdShowMessageDialog("该用户不是三口之家的用户", 1);
				history.go(-1);
			</script>
<%
		}
	}
%>


<script language=javascript>
	if (!<%=pwrf%>) {
		checkFatherPwd();
	}
	
	function checkFatherPwd() {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
		checkPwd_Packet.data.add("custType", "01");						//01:手机号码 02 客户密码校验 03帐户密码校验
		checkPwd_Packet.data.add("phoneNo", "<%=fatherPhone4%>");		//移动号码,客户id,帐户id
		checkPwd_Packet.data.add("custPaswd", "<%=fatherPwd4%>");		//用户/客户/帐户密码
		checkPwd_Packet.data.add("idType", "un");						//en 密码为密文，其它情况 密码为明文
		checkPwd_Packet.data.add("idNum", "");							//传空
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//工号
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}
	
	function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog("家长密码错误，" + msg, 1);
			history.go(-1);
		}
	}
	
</script>
</head>
<body>

<form name="frm" action="fb608_cfm.jsp" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="fatherPhone4" id="fatherPhone4" value="<%=fatherPhone4%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">用户信息</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			客户姓名
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[0][5]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			用户号码
		</td>
		<td width="30%">
			<input type="text" name="fatherPhone4" id="fatherPhone4" value="<%=fatherPhone4%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			业务品牌
		</td>
		<td>
			<input type="text" name="smName" id="smName" value="<%=result[0][7]%>--<%=result[0][6]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue">
			<%=result[0][8]%>
		</td>
		<td>
			<input type="text" name="idNo" id="idNo" value="<%=result[0][9]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			当前主套餐
		</td>
		<td>
			<input type="text" name="currentProduct" id="currentProduct" size="40" value="<%=result[0][10]%>--<%=result[0][11]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue">
			客户类型
		</td>
		<td>
			<input type="text" name="bigCust" id="bigCust" value="<%=result[0][12]%>--<%=result[0][13]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			客户地址
		</td>
		<td colspan="3">
			<input type="text" name="custAddr" id="custAddr" size="60" value="<%=result[0][14]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
</table>
<div class="title">
	<div name="title_zi" id="title_zi">家庭信息</div>
</div>
<table cellspacing="0">
	<tr>
		<th width="20%">家庭代码</th>
		<th width="20%">用户号码</th>
		<th width="20%">成员身份</th>
		<th width="20%">生效日期</th>
		<th width="20%">失效日期</th>
	</tr>
<%
	for (int i = 0; i < result2.length; i ++) {
%>
		<tr>
			<td>
				<input type="text" name="familyGroupId" id="familyGroupId" value="<%=result2[i][0]%>" class="InputGrey" readonly>
			</td>
			<td>
				<input type="text" name="" id="" value="<%=result2[i][2]%>" class="InputGrey" readonly>
			</td>
			<td>
				<input type="text" name="memberDesc" id="memberDesc" value="<%=result2[i][1]%>" class="InputGrey" readonly>
			</td>
			<td>
				<input type="text" name="" id="" value="<%=result2[i][3]%>" class="InputGrey" readonly>
			</td>
			<td>
				<input type="text" name="" id="" value="<%=result2[i][4]%>" class="InputGrey" readonly>
			</td>
		</tr>
<%
	}
%>
</table>
<table cellspacing="0">
	<tr>
	    <td id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="返回" onClick="window.location = 'fb608.jsp?opCode=<%=opCode%>&opName=<%=opName%>';">
	      <input class="b_foot" type=button name=qryPage value="关闭" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
