<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/**********************************
liangyl@2016/4/29 10:48:10
***********************************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
		String opCode="m373";
		String opName="物联网休眠期办理";
	    String loginNo = (String)session.getAttribute("workNo");
	    String regionCode=(String)session.getAttribute("regCode");
	    String passWord = (String)session.getAttribute("password");
	    String ip = request.getRemoteAddr();
	    System.out.println("=========================ip==================   "+ip);
		String sleepTime = "0";
		String workNos = "";
		String[] workNosArr = new String[]{""};
		String wayFlag = "";
		String filename = "";
		String execResult = "上传结果未知！";

			/* 使用文件上传 */
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
			/* 拼接文件名 */
				String iErrorNo ="";
				String sErrorMessage = " ";
				String sysAccept = "";
				sysAccept = seq;
			    System.out.println("# fm373Cancel.jsp  @@@@@@@@@@     - 流水："+sysAccept);
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
					rdShowMessageDialog("只允许上传.txt类型文本文件",0);
					window.location='fm373Cancel.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
					</script>
<%
				}
				try{ 
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
					if (myFile.isMissing()){
%>
					<SCRIPT language=javascript>
					rdShowMessageDialog("请先选择要上传的文件",0);
					window.location='fm373Cancel.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
					</script>
<%
					}else{
						myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
					}
				}catch (Exception e){
					System.out.println(e.toString()); 
%>
					<SCRIPT language=javascript>
					rdShowMessageDialog("<%=e.toString()%>",0);
					window.location='fm373Cancel.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
					</script>
<%
				}
				System.out.println("==============文件上传完成==========");
				/* 读取文件，写入tuxedo侧服务器 */
				try {
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
<%
System.out.println("====liangyl====fm373Cancel_cfm.jsp====sm373Cfm==== filename = " + filename);
System.out.println("====liangyl====fm373Cancel_cfm.jsp====sm373Cfm==== ip = " + ip);
				} catch (Exception e){
					%>
										<SCRIPT language=javascript>
										rdShowMessageDialog("只允许上传.txt类型文本文件",0);
										window.location='fm373Cancel.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
										</script>
					<%
									} 
%>
<wtc:service name="sm373Cfm" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="Code" retmsg="Msg" outnum="4" >
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="m373"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="1"/>
        <wtc:param value="<%=filename%>"/>
        <wtc:param value="<%=sleepTime%>"/>
        <wtc:param value="<%=ip%>"/>
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
		window.location = "fm373Cancel.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
		rdShowMessageDialog("fm373Cancel：<%=retcode%>,<%=retmsg%>.");
		//window.history.go(-1);
		window.location.href="fm373Cancel.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
}
%>