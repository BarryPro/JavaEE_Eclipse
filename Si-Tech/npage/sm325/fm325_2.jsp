<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%
 	
  String regionCode = (String)session.getAttribute("regCode");		
	String opCode = WtcUtil.repNull(request.getParameter("opCode")); 
	String opName = WtcUtil.repNull(request.getParameter("opName")); 
	String password = (String)session.getAttribute("password");
	String ipAddr = realip; 
	String fileName = "";
	String workNo = (String)session.getAttribute("workNo");
	String opNote = workNo + opName+"批量操作";
	String execResult = "上传结果未知！";  	
	String upload_type = WtcUtil.repNull(request.getParameter("upload_type")); 
	System.out.println("-------------upload_type----------hejwa---------->"+upload_type);
	int count_row = 0;
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sysAccept"/>
<%
	fileName = regionCode + sysAccept + ".txt";
	
	String path_name = request.getRealPath("/npage/tmp/");
	String sSaveName=path_name+"/"+fileName;
	System.out.println("-------------hejwa----------sSaveName---------->"+sSaveName);
	
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
				window.location = "fm325_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
					window.location = "fm325_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				</script>
			<%
		}else{
			myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
		}
	} catch (Exception e) {
		System.out.println(e.toString()); 
		%>
			<SCRIPT language=javascript>
				window.location = "fm325_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
		<%
	}
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
		count_row ++ ;
	} while (line!=null);
	br.close();
	fr.close();
}

System.out.println("------------hejwa-----count_row-------------->"+count_row);

if(count_row>100){
%>
	<script language="JavaScript">
		rdShowMessageDialog("数据记录不能超过100条");
		window.location.href = "fm325_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
}else{

%>
<wtc:service name="sm325Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="5">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=fileName%>"/>
		<wtc:param value="<%=path_name%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=upload_type%>"/>
		<wtc:param value="<%=opNote%>"/>
	</wtc:service>
<wtc:array id="result1" start="0" length="3" scope="end" />
<wtc:array id="result2" start="3" length="1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		
		
%>
	<script language="JavaScript">
		
	</script>
<%
	}else{
		System.out.println(" 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location.href = "fm325_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	}		
%>	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
	</script>
</head>
<body>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">错误信息列表</div>
	</div>
	<div>
		<table>
			<%if(errCode.equals("0")||errCode.equals("000000")){
				%>
			<tr>
				<td colspan="3">失败条数：<%=result1.length%></td>
			</tr>
			<%}%>
			<tr>
				<th width="20%">主卡号码</th>
				<th width="20%">副卡号码</th>
				<th>失败原因</th>
			</tr>
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
					<td><%=result1[i][2]%></td>
				</tr>
				<%}}%>
			 <tr> 
					<td align="center" colspan="3" id="footer">
						<input class="b_foot" name="sure"  type="button" value="返回"  onclick="window.location.href='fm325_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>';">
						<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
					</td>
			 </tr>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

<%}%>