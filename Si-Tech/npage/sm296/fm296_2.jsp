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
	String opNote = workNo + opName+"��������";
	String execResult = "�ϴ����δ֪��";  	
	String upload_type = WtcUtil.repNull(request.getParameter("upload_type")); 
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sysAccept"/>
<%
	fileName = regionCode + sysAccept + ".txt";
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+fileName;
	System.out.println("zhouby : sSaveName:"+sSaveName);
	/* ׼���ϴ���webloigc������� */
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
				rdShowMessageDialog("ֻ�����ϴ�.txt�����ı��ļ���", 1);
				window.location = "fm296_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
		<%
	}
	if (flag) {
		try{ 
		com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
		if (myFile.isMissing()){
			%>
				<SCRIPT language=javascript>
					rdShowMessageDialog("����ѡ��Ҫ�ϴ����ļ���", 1);
					window.location = "fm296_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				</script>
			<%
		}else{
			myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
		}
	} catch (Exception e) {
		System.out.println(e.toString()); 
		%>
			<SCRIPT language=javascript>
				window.location = "fm296_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
		<%
	}
	/* ��ȡ�ļ���д��tuxedo������� */
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
}
	System.out.println("====hejwa================sm296Cfm====0==== iLoginAccept = 0");
	System.out.println("====hejwa================sm296Cfm====1==== iChnSource = 01");
	System.out.println("====hejwa================sm296Cfm====2==== iOpCode = " + opCode);
	System.out.println("====hejwa================sm296Cfm====3==== iloginNo = " + workNo);
	System.out.println("====hejwa================sm296Cfm====4==== iloginPwd = " + password);
	System.out.println("====hejwa================sm296Cfm====5==== iPhoneNo = ");
	System.out.println("====hejwa================sm296Cfm====6==== iUserPwd = ");
	System.out.println("====hejwa================sm296Cfm====7==== opNote = " + opNote);
	System.out.println("====hejwa================sm296Cfm====8==== ifileName = " + fileName);
	System.out.println("====hejwa================sm296Cfm====9==== iIpAddr = " + ipAddr);
	System.out.println("====hejwa================sm296Cfm====10=== upload_type = " + upload_type);
	
%>
<wtc:service name="sm296Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
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
		<wtc:param value="<%=upload_type%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end" />
	<wtc:array id="result2" start="2" length="1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷��� sm296Cfm  �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		
%>
	<script language="JavaScript">
		
	</script>
<%
	}else{
		System.out.println(" ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location.href = "fm296_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
		<div id="title_zi">������Ϣ�б�</div>
	</div>
	<div>
		<table>
			<%if(errCode.equals("0")||errCode.equals("000000")){
				if(result2.length > 0){
				%>
			<tr>
				<td colspan="2">ʧ��������<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>�ֻ�����</th>
				<th>ʧ��ԭ��</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>
			 <tr> 
					<td align="center" colspan="2" id="footer">
						<input class="b_foot" name="sure"  type="button" value="����"  onclick="window.location.href='/npage/sm296/fm296_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>';">
						<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
					</td>
			 </tr>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

