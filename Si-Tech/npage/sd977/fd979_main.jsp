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
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String phoneType = request.getParameter("phoneType");
  String workNo = (String)session.getAttribute("workNo");
  String[] result = new String[3];
	String[][] beginTimeArr = new String[][]{};
	String[][] phoneNoArr = new String[][]{};
	String[][] custNameArr = new String[][]{};
	String[][] limitPayArr = new String[][]{};
	String[][] sumPayArr = new String[][]{};
  String[][] stateFlagArr = new String[][]{};
  String[][] flagArr = new String[][]{};
  String[][] billFeeArr = new String[][]{};
	String mainCartState = "";
	String mainCartOwe = "";
	String mainCartOweMoney = "";
  
  System.out.println("====fd979_main.jsp====wanghfa==== opCode = " + opCode);
  System.out.println("====fd979_main.jsp====wanghfa==== opName = " + opName);
	
	System.out.println("====wanghfa====fd979_main.jsp====s7327Sel====0==== iPhoneNo = " + activePhone);
	System.out.println("====wanghfa====fd979_main.jsp====s7327Sel====1==== iOpCode = " + opCode);
	System.out.println("====wanghfa====fd979_main.jsp====s7327Sel====2==== iSelFlag = " + phoneType);
%>
	<wtc:service name="s7327Sel" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="14">
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=phoneType%>"/>
	</wtc:service>
	<wtc:array id="result1"  start="0" length="2" scope="end"/>
	<wtc:array id="result2"  start="2" length="1" scope="end"/>
	<wtc:array id="result3"  start="3" length="1" scope="end"/>
	<wtc:array id="result4"  start="4" length="1" scope="end"/>
	<wtc:array id="result5"  start="5" length="1" scope="end"/>
	<wtc:array id="result6"  start="6" length="1" scope="end"/>
	<wtc:array id="result7"  start="7" length="1" scope="end"/>
	
	<wtc:array id="result8"  start="8" length="1" scope="end"/>
	<wtc:array id="result9"  start="9" length="1" scope="end"/>		
	<wtc:array id="result10"  start="10" length="1" scope="end"/>	
	
	<wtc:array id="result11"  start="11" length="3" scope="end"/>
<%
	System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel : " + retCode1 + "," + retMsg1);
	
	if (!retCode1.equals("000000")) {
%>
	<script language="JavaScript">
		rdShowMessageDialog("s7327Sel代码：<%=retCode1%>，信息：<%=retMsg1%>",0);
		history.go(-1);
	</script>
<%
	} else {
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result1 = " + result1[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result2 = " + result2[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result3 = " + result3[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result4 = " + result4[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result5 = " + result5[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result6 = " + result6[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result7 = " + result7[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result8 = " + result8[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result9 = " + result9[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result10 = " + result10[0][0]);
		System.out.println("====wanghfa=====fd979_main.jsp====s7327Sel==== result11 = " + result11[0][0]);
		if(result1.length>0) {
			beginTimeArr = result2;			//付费时间 
			phoneNoArr = result3;		//主卡号码 或 副卡号码
			custNameArr = result4;		//客户姓名
			limitPayArr = result5;		//付费金额
			sumPayArr = result6;			//付费总金额
			
			stateFlagArr = result8;    //副卡状态
			flagArr = result9;        //副卡欠费原因
			billFeeArr = result10;    //副卡欠费金额
			mainCartState = result11[0][0];
			mainCartOwe = result11[0][1];
			mainCartOweMoney = result11[0][2];
		}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>家庭合账分享查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	window.onload = function() {
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
</script>
</head>
<body>

<form name="frm" method="POST" action="fd570_cfm.jsp">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="opNote" id="opNote" value="">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">当前用户信息</div>
</div>
<table>
	<tr>
		<td class="blue" width="30%">
			电话号码
		</td>
		<td width="70%">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly>
		</td>
	</tr>
<%
	if ("0".equals(phoneType)) {
	%>
	<tr>
		<td class="blue" >
			用户身份
		</td>
		<td>
			主用户（付费用户）
		</td>
	</tr>
	<tr>
		<td class="blue" >
			用户状态
		</td>
		<td>
			<%=mainCartState%>
		</td>
	</tr>
	<tr>
		<td class="blue">
			停机原因
		</td>
		<td>
			<%
				if("0".equals(flagArr[0][0])){
			%>
					主卡欠费
			<%
				}else if("1".equals(flagArr[0][0])){
			%>
					副卡欠费
			<%
				}else{
			%>
					<%=flagArr[0][0]%>
			<%	
				}
			%>
		</td>
	</tr>
	<tr>
		<td class="blue" >欠费金额</td>
		<td colspan="3">
			<%=billFeeArr[0][0]%>
		</td>
	</tr>
	<%
	} else if ("1".equals(phoneType)) {
	%>
	<tr>
		<td class="blue">
			用户身份
		</td>
		<td>
			副用户（被付费用户）
		</td>
	</tr>
	<tr>
		<td class="blue">
			用户状态
		</td>
		<td>
			<%=stateFlagArr[0][0]%>
		</td>
	</tr>
	<tr>
		<td class="blue">
			停机原因
		</td>
		<td>
			<%
				if("0".equals(flagArr[0][0])){
			%>
					主卡欠费
			<%
				}else if("1".equals(flagArr[0][0])){
			%>
					副卡欠费
			<%
				}else{
			%>
					<%=flagArr[0][0]%>
			<%	
				}
			%>
		</td>
	</tr>
	<tr>
		<td class="blue" >欠费金额</td>
		<td>
			<%=mainCartOweMoney%>
		</td>
	</tr>
	<%
	}
%>
</table>
<br/>
<%
	String userText = "";
	if ("0".equals(phoneType)) {
		userText = "副用户";
	} else if ("1".equals(phoneType)) {
		userText = "主用户";
	}
%>
<div class="title">
	<div id="title_zi"><%=userText%>信息</div>
</div>
<table>
	<tr>
		<th width="10%" align=center>开始时间</th>
		<th width="15%" align=center><%=userText%>号码</th>
		<th width="20%" align=center>客户姓名</th>
		<th width="25%" align=center>主用户为副用户付费的实际金额(6个月内含当月)</th>
		<th width="10%" align=center><%=userText%>状态</th>
		<th width="10%" align=center><%=userText%>停机原因</th>
		<th width="10%" align=center><%=userText%>欠费金额</th>
	</tr>
		<% 
			for(int j = 0; j < phoneNoArr.length; j ++){
			%>
			<tr> 
				<TD align=center><%=beginTimeArr[j][0]%></TD>
				<TD align=center><%=phoneNoArr[j][0]%></TD>
				<TD align=center><%=custNameArr[j][0]%></TD>
				<!--TD align=center><%=limitPayArr[j][0]%></TD-->
				<TD align=center><%=sumPayArr[j][0]%></TD>
			<%
				if ("0".equals(phoneType)) {
				%>
					<TD align=center><%=mainCartState%></TD>
				<%
					if("1".equals(mainCartOwe)){
					%>
						<TD align=center>副卡欠费</TD>
					<%
					}else if("0".equals(mainCartOwe)){
					%>
						<TD align=center>主卡欠费</TD>
					<%
					} else {
					%>
						<TD align=center><%=mainCartOwe%></TD>
					<%
					}
					%>
					  <TD align=center><%=mainCartOweMoney%></TD>
					<%
				} else if ("1".equals(phoneType)) {
				%>
					<TD align=center><%=stateFlagArr[j][0]%></TD>
				<%
					if("1".equals(flagArr[j][0])){
					%>
						<TD align=center>副卡欠费</TD>
					<%
					}else if("0".equals(flagArr[j][0])){
					%>
						<TD align=center>主卡欠费</TD>
					<%
					}else{
					%> 
						<TD align=center><%=flagArr[j][0]%></TD>
					<%	
					}
					%>
					  <TD align=center><%=billFeeArr[j][0]%></TD>
					<%
				}
			%>
			</tr>
			<%
			}         
		%>
</table>
<table>
	<tr>
		<td colspan="4" id="footer">
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
<%
	}
%>
