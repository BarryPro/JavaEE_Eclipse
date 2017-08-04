<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglm @ 20110225
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%

    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ip = request.getRemoteAddr();
    System.out.println("=========================ip==================   "+ip);
		String checkvalue = request.getParameter("checkvalue");
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		
		String power_code = request.getParameter("power_codess");
		String oaNumber = request.getParameter("oaNumber");//OA编号
		String oaTitle = request.getParameter("oaTitle");  //OA标题
		System.out.println("liangyl===oaNumber========================"+oaNumber);
		System.out.println("liangyl===oaTitle========================"+oaTitle);
		
		
		
		
		String workNos = "";
		String[] workNosArr = new String[]{""};
		String wayFlag = "";
		String filename = "";
		String execResult = "上传结果未知！";

			/* 使用文件上传 */
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
				 routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
			/* 拼接文件名 */
				String iErrorNo ="";
				String sErrorMessage = " ";
				String sysAccept = "";
				sysAccept = seq;
			    System.out.println("# fm091.jsp  @@@@@@@@@@     - 流水："+sysAccept);
			    filename = regionCode + sysAccept + ".txt";
			    String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
				System.out.println("sSaveName:"+sSaveName);
				/* 准备上传至webloigc侧服务器 */
				SmartUpload mySmartUpload =new SmartUpload();
				mySmartUpload.initialize(pageContext);
				try {
					mySmartUpload.setAllowedFilesList("txt");//此处的文件格式可以根据需要自己修改
					//上载文件 
					mySmartUpload.upload();
				} catch (Exception e){
%>
					<SCRIPT language=javascript>
					alert("只允许上传.txt类型文本文件");
					window.location= "fm153.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					</script>
<%
				}
				try{ 
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
					if (myFile.isMissing()){
%>
					<SCRIPT language=javascript>
					alert("请先选择要上传的文件");
					window.location= "fm153.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					</script>
<%
					}else{
						myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
					}
				}catch (Exception e){
					System.out.println(e.toString()); 
%>
					<SCRIPT language=javascript>
					alert("<%=e.toString()%>");
					window.location= "fm153.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
				paraAray2[0] = filename;
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
						<wtc:service name="sbatchWrite" routerKey="region" 
							 routerValue="<%=regionCode%>" 
									retcode="errCode2" retmsg="errMsg2"  outnum="2" >
						<wtc:param value="<%=paraAray2[0]%>"/>
						<wtc:param value="<%=paraAray2[1]%>"/>
						</wtc:service>
						<wtc:array id="resultArr" scope="end" />
<%
						phoneText="";
					}
				}while (line!=null);        
				br.close();
				fr.close();
				paraAray2[1] = phoneText;
%>
				<wtc:service name="sbatchWrite" routerKey="region" 
					 routerValue="<%=regionCode%>" outnum="2" >
				<wtc:param value="<%=paraAray2[0]%>"/>
				<wtc:param value="<%=paraAray2[1]%>"/>
				</wtc:service>
				<wtc:array id="resultArr3" scope="end" />

<wtc:service name="sm153Cfm" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="Code" retmsg="Msg" outnum="4" >
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=ip%>"/>
        <wtc:param value="<%=power_code%>"/>
        <wtc:param value="<%=checkvalue%>"/>
        <wtc:param value="<%=filename%>"/>
        <wtc:param value="<%=oaNumber%>" />
		<wtc:param value="<%=oaTitle%>" />
        

</wtc:service>
<wtc:array id="result1" start="0" length="1" scope="end"/>
<wtc:array id="result2" start="1" length="3" scope="end"/>
<%
System.out.println("=========================Code================================   "+Code);
String retcode = Code;
String retmsg = Msg;
if(retcode.equals("000000")){
execResult = result1[0][0];
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	function goback(){
		window.location= "fm153.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
		<div id="title_zi">错误信息</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th>行号</th>
			<th>传入工号</th>
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
		rdShowMessageDialog("操作失败！错误代码<%=retcode%>,错误原因<%=retmsg%>.");
		window.history.go(-1);
	</script>
	<%
}
%>