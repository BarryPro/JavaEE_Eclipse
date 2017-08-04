<%
	/* 
	 * version v2.0
	 * 开发商: si-tech
	 * zhouby 
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<%
		request.setCharacterEncoding("GBK");
		
		String opCode="7378";
		String opName="自有业务宣传名单管理";
    String workNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ip = request.getRemoteAddr();
  
    String listType = (String)request.getParameter("listtype");
    String switchFlag = (String)request.getParameter("switchFlag");
    String publicityTypes = (String)request.getParameter("publicityTypes");
    String opType = (String)request.getParameter("opType");
    String opCategorys = (String)request.getParameter("opCategorys");
    String recordLength = (String)request.getParameter("recordLength");
    
		String execResult = "上传结果未知！";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept"/>
<%
		/* 拼接文件名 */
    String filename = regionCode + sysAccept + ".txt";
    String sSaveName = request.getRealPath("/npage/tmp/") + "/" + filename;
		
		/* 准备上传至webloigc侧服务器 */
		SmartUpload mySmartUpload =new SmartUpload();
		mySmartUpload.initialize(pageContext);
		
		try {
				mySmartUpload.setAllowedFilesList("txt,TXT");//允许上传的类型
				mySmartUpload.upload();
		} catch (Exception e){
		
%>
				<SCRIPT language=javascript>
						rdShowMessageDialog("只允许上传.txt类型文本文件！", 0);
						window.location.href = "f7378_batchOperation.jsp";
				</script>
<%
        return;
		}
		
		try{ 
				com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
				if (myFile.isMissing()){
%>
						<SCRIPT language=javascript>
								rdShowMessageDialog("文件丢失或上传不成功！", 0);
								window.location.href = "f7378_batchOperation.jsp";
						</script>
<%
            return;
				}else{
						myFile.saveAs(sSaveName, SmartUpload.SAVE_PHYSICAL);
				}
		}catch (Exception e){
				System.out.println(e.toString()); 
%>
				<script language=javascript>
						rdShowMessageDialog("<%=e.toString()%>", 0);
						window.location.href = "f7378_batchOperation.jsp";
				</script>
<%
        return;
		}
		
		System.out.println("==============文件上传完成==========");
		/* 读取文件，写入tuxedo侧服务器 */
		FileReader fr = new FileReader(sSaveName);
		BufferedReader br = new BufferedReader(fr);   
		String line = br.readLine();
		while(line != null && !line.trim().equals("")){
				String tmp = line + "\n";
%>
				<wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode2" retmsg="errMsg2"  outnum="2" >
						<wtc:param value="<%=filename%>"/>
						<wtc:param value="<%=tmp%>"/>
				</wtc:service>
				<wtc:array id="resultArr" scope="end" />
<%
				line = br.readLine();
		}
		br.close();
		fr.close();
		
%>
		<wtc:service name="s7378CfmBat" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg" outnum="6" >
	      <wtc:param value="<%=sysAccept%>"/>
      	<wtc:param value="01" />
      	<wtc:param value="<%=opCode%>" />
      	<wtc:param value="<%=workNo%>"/>
      	<wtc:param value="<%=passWord%>" />	
      	<wtc:param value=""/>
        <wtc:param value="" />
    		<wtc:param value="<%=opType%>"/>
    		<wtc:param value="<%=listType%>"/>
    		<wtc:param value="<%=switchFlag%>"/>
    		<wtc:param value="<%=recordLength%>"/>
    		<wtc:param value="<%=publicityTypes%>"/>
    		<wtc:param value="<%=opCategorys%>"/>
        <wtc:param value="<%=filename%>"/>
		</wtc:service>
		<wtc:array id="result1" start="0" length="1" scope="end"/>
		<wtc:array id="result2" start="1" length="3" scope="end"/>
<%

String retcode = Code;
String retmsg = Msg;

if(!"000000".equals(Code)){
%>
    <script language="javascript">
  			rdShowMessageDialog("提交服务调用失败！<%=retcode%>, <%=retmsg%>");
  			window.location.href = "f7378_batchOperation.jsp";
  	</script>
<%
}
		execResult = result1[0][0];
%>
		<script language="javascript">
				function goback(){
						window.location.href = "f7378_batchOperation.jsp";
				}
		</script>
		</head>
		<body>
		<form name="form1" id="form1" method="POST">
		<%@ include file="/npage/include/header.jsp" %>
			<div>
			<div class="title">
				<div id="title_zi">导入结果</div>
			</div>
			
			<table cellspacing="0">
				<tr>
					<td width="100%"><%=execResult%></td>
				</tr>
			</table>
			
			<div class="title">
				<div id="title_zi">错误提示</div>
			</div>
			<table cellspacing="0">
				<tr>
					<th>序号</th>
					<th>电话号</th>
					<th>提示信息</th>
				</tr>
<%
		  	int retLength = result2.length;
		  	for(int i = 0; i < retLength; i++ ){
%>
					  <tr>
							<td><%=result2[i][0]%></td>
							<td><%=result2[i][1]%></td>
							<td><%=result2[i][2]%></td>
						</tr>
<%
		  	}
%>
			  <tr>
			  	<td id="footer" colspan="3">
			  		<input type="button" name="back" class="b_foot" value="返回" onClick="goback()"  >
			  	</td>
			  </tr>
		  </table>
			</div>
		  <%@ include file="/npage/include/footer.jsp"%>
		</form>
		</body>
</html>