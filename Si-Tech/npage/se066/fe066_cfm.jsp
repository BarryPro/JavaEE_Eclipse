<%
  /*
   * 功能: WLan网络覆盖批量导入
   * 版本: 1.0
   * 日期: 20110715
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>

<html>
<head>
<title>WLan网络覆盖批量导入</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = "e066";	//WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = "WLan网络覆盖批量导入";	//WtcUtil.repStr(request.getParameter("opName"), "");
  String password = (String)session.getAttribute("password");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String fileName = "";	//WtcUtil.repStr(request.getParameter("fileName"), "");
	String regionCode=(String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String execResult = "上传结果未知！";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sysAccept"/>
<%
	fileName = regionCode + sysAccept + ".txt";
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+fileName;
	System.out.println("sSaveName:"+sSaveName);
	/* 准备上传至webloigc侧服务器 */
	SmartUpload mySmartUpload =new SmartUpload();
	mySmartUpload.initialize(pageContext);
	boolean flag = false;
	try {
		mySmartUpload.setAllowedFilesList("txt,TXT");
		mySmartUpload.upload();
		flag = true;
	} catch (Exception e) {
		%>
			<script language=javascript>
				rdShowMessageDialog("只允许上传.txt类型文本文件！", 1);
				window.location = "fe066.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
		<%
	}
	if (flag) {
		try{ 
		com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
		if (myFile.isMissing()){
			%>
				<SCRIPT language=javascript>
					rdShowMessageDialog("请先选择要上传的文件！", 1);
					window.location = "fe066.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				</script>
			<%
		}else{
			myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
		}
	} catch (Exception e) {
		System.out.println(e.toString()); 
		%>
			<SCRIPT language=javascript>
				alert("<%=e.toString()%>");
				window.location = "fe066.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
		<%
	}
	System.out.println("==============文件上传完成==========");
	/* 读取文件，写入tuxedo侧服务器 */
	FileReader fr = new FileReader(sSaveName);
	BufferedReader br = new BufferedReader(fr);   
	String phoneText="";
	String line = null;
	String paraAray2[] = new String[2];
	paraAray2[0] = fileName;
	paraAray2[1] = phoneText;
	do {
		line = br.readLine();
		if (line==null) continue;       
		if (line.trim().equals("")) continue;   
		phoneText+=line+"\n"; 
		System.out.println("==phoneText== " + phoneText);
		if (phoneText.length()>=1000){
			paraAray2[1] = phoneText;
				%>
					<wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode2" retmsg="errMsg2"  outnum="2" >
						<wtc:param value="<%=paraAray2[0]%>"/>
						<wtc:param value="<%=paraAray2[1]%>"/>
					</wtc:service>
					<wtc:array id="resultArr" scope="end" />
				<%
			phoneText="";
		}
	} while (line!=null);
	br.close();
	fr.close();
	paraAray2[1] = phoneText;
%>
	<wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
		<wtc:param value="<%=paraAray2[0]%>"/>
		<wtc:param value="<%=paraAray2[1]%>"/>
	</wtc:service>
	<wtc:array id="resultArr3" scope="end" />
	<%
	
	}

	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====0==== iLoginAccept = 0");
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====1==== iChnSource = 01");
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====2==== iOpCode = " + opCode);
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====3==== iloginNo = " + workNo);
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====4==== iloginPwd = " + password);
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====5==== iPhoneNo = ");
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====6==== iUserPwd = ");
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====7==== iIpAddr = " + ipAddr);
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp====8==== ifileName = " + fileName);
	
%>
	<wtc:service name="se066Imp" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=fileName%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="1" scope="end"/>
	<wtc:array id="result2" start="1" length="3" scope="end"/>
	
<%
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp==== " + retCode1 + ", " + retMsg1);
	System.out.println("====wanghfa====fe066_cfm.jsp====se066Imp==== result2.length = " + result2.length);
	
	if (!"000000".equals(retCode1)) {
	%>
		<script language="javascript">
			rdShowMessageDialog("se066Imp服务：<%=retCode1%>，<%=retMsg1%>", 0);
			window.location = "fe066.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
	<%
	} else {
		execResult = result1[0][0];
	%>
	<script language=javascript>
		function closeWindow() {
			if(window.opener == undefined) {
				removeCurrentTab();
			} else {
				window.close();
			}
		}
	</script>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">导入结果</div>
</div>
<table cellspacing="0">
	<tr>
		<td width="100%"><%=execResult%></td>
	</tr>
</table>
<div class="title">
	<div id="title_zi">错误信息</div>
</div>
<table cellspacing="0">
	<tr>
		<th width="10%">错误行号</th>
		<th width="45%">错误行数描述</th>
		<th width="45%">错误信息描述</th>
	</tr>
	<%
		if (result2[0][0] != null) {
			for (int i = 0; i < result2.length; i ++) {
			%>
				<tr>
					<td><%=result2[i][0]%></td>
					<td><%=result2[i][1]%></td>
					<td><%=result2[i][2]%></td>
				</tr>
			<%
			}
		}
	%>
	<tr>
		<td colspan="3" align="center" id="footer">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="返回" onClick="window.location = 'fe066.jsp?opCode=<%=opCode%>&opName=<%=opName%>';">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="closeWindow();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
	<%
	}
%>
