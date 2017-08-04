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
	String workorgcode = WtcUtil.repNull(request.getParameter("workorgcode")); 
	String password = (String)session.getAttribute("password");
	String ipAddr = realip; 
	String fileName = "";
	String workNo = (String)session.getAttribute("workNo");
	String opNote = workNo + opName+"批量操作";
	String execResult = "上传结果未知！";
	int count_row = 0;
	
	
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sysAccept"/>
<%
	fileName = regionCode + sysAccept + ".txt";
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+fileName;
	String sSaveName1=request.getRealPath("/npage/tmp");
	//System.out.println("liangyl:"+sSaveName);
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
				window.location = "fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
						window.location = "fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					</script>
				<%
			}else{
				myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
			}
		} catch (Exception e) {
			System.out.println(e.toString()); 
			%>
				<SCRIPT language=javascript>
					window.location = "fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				</script>
			<%
		}
			System.out.println("==============文件上传完成==========");
				/* 读取文件，写入tuxedo侧服务器 */
				FileReader fr = new FileReader(sSaveName);
				BufferedReader br = new BufferedReader(fr);   
				String phoneText="";
				String line = null;
				do {
					line = br.readLine();
					if (line==null) continue;       
					if (line.trim().equals("")) continue;   
					count_row ++ ;
				}while (line!=null);        
				br.close();
				fr.close();
if(count_row>500){
%>
	<script language="JavaScript">
		rdShowMessageDialog("数据记录不能超过500条，请重新上传！");
		window.location = "fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
}
else{
%>

	<wtc:service name="sm272BatchCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3" >
        <wtc:param value=" "/>
        <wtc:param value="m272"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="0"/>
        <wtc:param value=""/>
        <wtc:param value="<%=workorgcode %>"/>
        <wtc:param value="<%=fileName%>"/>
        <wtc:param value="<%=sSaveName1%>"/>
        <wtc:param value="<%=ipAddr%>"/>
	</wtc:service>	
<%if(errCode.equals("000000")){%>
	<script language=javascript>
		rdShowMessageDialog("数据批量导入成功，请在30分钟后到批量结果查询中查看批量操作结果!", 1);
		window.location = "fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%}else{%>
	<script language=javascript>
		rdShowMessageDialog("<%=errMsg%>", 1);
		window.location = "fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%}
}}

%>
