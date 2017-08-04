<%
  /*
   * 功能: 实名制修改
   * 版本: 1.0
   * 日期: 20111206
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>

<html>
<head>
<title>实名制修改批量导入</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
String opCode = "e455";
String opName = "实名制修改";
String password = (String)session.getAttribute("password");
String ipAddr = realip; //(String)session.getAttribute("ipAddr");
String fileName = "";
String regionCode=(String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String opNote = workNo + "进行批量实名制修改";
String execResult = "上传结果未知！";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sysAccept"/>
<%
	fileName = regionCode + sysAccept + ".txt";
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+fileName;
	System.out.println("zhouby : sSaveName:"+sSaveName);
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
				window.location = "fe455.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
				window.location = "fe455.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
		<%
	}
	System.out.println("======zhouby========文件上传完成==========");
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
		if (phoneText.length()<=1000){
			paraAray2[1] = phoneText;
			System.out.println("zhouby==phoneText== " + phoneText);
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
	<wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeb" retmsg="retMsgb" outnum="2" >
		<wtc:param value="<%=paraAray2[0]%>"/>
		<wtc:param value="<%=paraAray2[1]%>"/>
	</wtc:service>
	<wtc:array id="resultArr3" scope="end" />
	<%
	System.out.println("====zhouby====fe455_filecfm.jsp==== sbatchWrite = " + retCodeb + ", " + retMsgb);
	}
	
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====0==== iLoginAccept = 0");
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====1==== iChnSource = 01");
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====2==== iOpCode = " + opCode);
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====3==== iloginNo = " + workNo);
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====4==== iloginPwd = " + password);
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====5==== iPhoneNo = ");
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====6==== iUserPwd = ");
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====7==== opNote = " + opNote);
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====8==== ifileName = " + fileName);
	System.out.println("====zhouby====fe455_filecfm.jsp====sE455BaCfm====9==== iIpAddr = " + ipAddr);
	String opType22 = mySmartUpload.getRequest().getParameter("opType22");
%>
	<wtc:service name="sE455BaCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=fileName%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=opType22%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="1" scope="end"/>
	<wtc:array id="result2" start="1" length="2" scope="end"/>
<%
System.out.println("====zhouby====fe455_filecfm.jsp====结果==== " + retCode1 + ", " + retMsg1);

if (!"000000".equals(retCode1)) {
	%>
	<script language="javascript">
		rdShowMessageDialog("sE455BaCfm服务失败：<%=retCode1%>，<%=retMsg1%>", 0);
		window.location = "fe455.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
	} else {
	%>
	<HEAD><TITLE>实名制修改批量处理结果</TITLE>
	<META content="text/html; charset=gb2312" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<script language="JavaScript">
	
	</script>
	</HEAD>
	<BODY>
		<FORM action="f1008main.jsp" method=post name=form>
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">实名制修改批量处理结果</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td class="blue" width="30%">
						处理结果
					</td>
					<td width="70%">
						批量处理实名制修改成功<%=result1[0][0]%>个。
					<td>
				</tr>
			</table>
			<div class="title">
				<div id="title_zi">错误信息</div>
			</div>
			<table>
				<tr>
					<th width="30%">电话号码</th>
					<th width="70%">错误原因</th>
				</tr>
				<%
				for (int i = 0; i < result2.length; i ++) {
					%>
					<tr>
						<td>
							<%=result2[i][0]%>
						</td>
						<td>
							<%=result2[i][1]%>
						</td>
					</tr>
					
					<%
				}
				%>
				
			</table>
			<table cellspacing="0">
				<tr id="footer">
					<td>
						<input type="button" name="backBtn" id="backBtn" class="b_foot" onclick="window.location='fe455.jsp?opCode=<%=opCode%>&opName=<%=opName%>'" value="返回" >
						<input type="button" name="closeBtn" id="closeBtn" class="b_foot" onclick="removeCurrentTab()" value="关闭">
					</td>
				</tr>
			</table>
			<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
	</HTML>
	<%
}
%>
