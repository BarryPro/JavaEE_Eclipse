<%
	/* 
	 * version v2.0
	 * 开发商: si-tech
	 * zhouby 20121212
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
	  response.setHeader("Pragma","No-Cache"); 
	  response.setHeader("Cache-Control","No-Cache");
	  response.setDateHeader("Expires", 0);
		request.setCharacterEncoding("GBK");
		
		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ip = request.getRemoteAddr();
    
    String ipowerRight = (String)request.getParameter("ipowerRight");
    String ipowerChg = (String)request.getParameter("ipowerChg");
    String irptRight = (String)request.getParameter("irptRight");
    String irptChg = (String)request.getParameter("irptChg");
    String iallowBegin = (String)request.getParameter("iallowBegin");
    String iallowbChg = (String)request.getParameter("iallowbChg");
    String iallowEnd = (String)request.getParameter("iallowEnd");
    String iallowEChg = (String)request.getParameter("iallowEChg");
    String oaNumber = request.getParameter("oaNumber");//OA编号
	String oaTitle = request.getParameter("oaTitle");  //OA标题
	System.out.println("liangyl===oaNumber========================"+oaNumber);
	System.out.println("liangyl===oaTitle========================"+oaTitle);

/*
		System.out.println("zhouby: ipowerRight " + ipowerRight);
		System.out.println("zhouby: ipowerChg " + ipowerChg);
		System.out.println("zhouby: irptRight " + irptRight);
		System.out.println("zhouby: irptChg " + irptChg);
		System.out.println("zhouby: iallowBegin " + iallowBegin);
		System.out.println("zhouby: iallowbChg " + iallowbChg);
		System.out.println("zhouby: iallowEnd " + iallowEnd);
		System.out.println("zhouby: iallowEChg " + iallowEChg);
		System.out.println("zhouby: opCode " + opCode);
		System.out.println("zhouby: opName " + opName);
*/
		String execResult = "上传结果未知！";
%>
		<script language="javascript">
				function goback(){
						window.location = 'fg443Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>';
				}
		</script>
		
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept"/>
<%
		/* 拼接文件名 */
    String filename = regionCode + sysAccept + ".txt";
    String sSaveName = request.getRealPath("/npage/tmp/") + "/" + filename;
		
		/* 准备上传至webloigc侧服务器 */
		SmartUpload mySmartUpload =new SmartUpload();
		mySmartUpload.initialize(pageContext);
		
		boolean flag = false;
		try {
				mySmartUpload.setAllowedFilesList("txt,TXT");//允许上传的类型
				mySmartUpload.upload();
				flag = true;
		} catch (Exception e){
%>
				<SCRIPT language=javascript>
						rdShowMessageDialog("只允许上传.txt类型文本文件！", 0);
						goback();
				</script>
<%
		}
		
		if (flag){
				try{ 
						com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
						if (myFile.isMissing()){
%>
								<SCRIPT language=javascript>
										rdShowMessageDialog("文件丢失或上传不成功！", 0);
										goback();
								</script>
<%
						}else{
								myFile.saveAs(sSaveName, SmartUpload.SAVE_PHYSICAL);
						}
				}catch (Exception e){
%>
						<SCRIPT language=javascript>
								rdShowMessageDialog("<%=e.toString()%>", 0);
								goback();
						</script>
<%
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
<%
						line = br.readLine();
				}
				br.close();
				fr.close();
		}
		/*
		iLoginAccept		流水		不用时默认传0
		iChnSource			渠道号		01-boss	02-网厅	03-掌上营业厅	04-短信营业厅	05-查询机	06-10086
		iOpCode				操作代码	不用时默认传空
		iloginNo            操作工号--	必填
		iloginPwd           员工密码--	必填	
		iPhoneNo			号码		不用时默认传空
		iUserPwd			号码密码	不用时默认传空
		iIpAddr
		ipowerRight		权限值
		ipowerChg			是否修改				0 - 不修改 1-修改
		irptRight			报表权限
		irptChg				是否修改				0 - 不修改 1-修改
		iallowBegin		登陆允许时间
		iallowbChg		是否修改				0 - 不修改 1-修改
		iallowEnd			允许结束时间
		iallowEChg		是否修改				0 - 不修改 1-修改
		iFileName			文件名
		*/
%>
		<wtc:service name="sG443Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg" outnum="6" >
	      <wtc:param value="<%=sysAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=loginNo%>"/>
	      <wtc:param value="<%=passWord%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=ip%>"/>
	      <wtc:param value="<%=ipowerRight%>"/>
	      <wtc:param value="<%=ipowerChg%>"/>
	      <wtc:param value="<%=irptRight%>"/>
	      <wtc:param value="<%=irptChg%>"/>
	      <wtc:param value="<%=iallowBegin%>"/>
	      <wtc:param value="<%=iallowbChg%>"/>
	      <wtc:param value="<%=iallowEnd%>"/>
	      <wtc:param value="<%=iallowEChg%>"/>
	      <wtc:param value="<%=filename%>"/>
	      <wtc:param value="<%=oaNumber%>" />
	      <wtc:param value="<%=oaTitle%>" />
		</wtc:service>
		<wtc:array id="result1" start="0" length="1" scope="end"/>
		<wtc:array id="result2" start="1" length="3" scope="end"/>
<%

if("000000".equals(Code)){
		execResult = result1[0][0];
%>
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
					<th>行号</th>
					<th>工号</th>
					<th>错误原因</th>
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
<%
} else {
%>
		<script language="javascript">
				rdShowMessageDialog("sG443Cfm服务调用失败！<%=Code%>, <%=Msg%>");
				goback();
		</script>
<%
}
%>
</html>