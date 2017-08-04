<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
 version v2.0
开发商: si-tech
*create hejwa 2015-1-28 10:13:34
*
********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
    String loginNo    = (String)session.getAttribute("workNo");
    String passWord   = (String)session.getAttribute("password");

		String input_group_id    = (String)request.getParameter("input_group_id");  
		String opCode     = (String)request.getParameter("opCode");  
		String opName     = (String)request.getParameter("opName");  
	  
%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%			
				/* 拼接文件名 */
				String sysAccept = seq;
			  System.out.println("hejwa----sysAccept--->"+sysAccept);
			  String filename = regionCode + sysAccept + ".txt";
			  System.out.println("hejwa----filename--->"+filename);
			  String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
			  System.out.println("hejwa----sSaveName--->"+sSaveName);
				/* 准备上传至webloigc侧服务器 */
				SmartUpload mySmartUpload =new SmartUpload();
				System.out.println("------------1----------------------");
				mySmartUpload.initialize(pageContext);
				try {
					mySmartUpload.setAllowedFilesList("txt");//此处的文件格式可以根据需要自己修改
					System.out.println("------------2----------------------");
					//上载文件 
					mySmartUpload.upload();
					System.out.println("------------3----------------------");
				} catch (Exception e){
					e.printStackTrace();
%>
					<SCRIPT language=javascript>
					alert("只允许上传.txt类型文本文件");
					window.location='androidCrmAccessAdd_P.jsp';
					</script>
<%
				}
				try{ 
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
					System.out.println("------------4--------myFile.isMissing()--------------"+myFile.isMissing());
					if (myFile.isMissing()){
%>
					<SCRIPT language=javascript>
						alert("请先选择要上传的文件");
						window.location='androidCrmAccessAdd_P.jsp';
					</script>
<%
					}else{
						myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
						System.out.println("------------5----------------------");
					}
				}catch (Exception e){
					e.printStackTrace();
					System.out.println(e.toString()); 
%>
					<SCRIPT language=javascript>
					alert("<%=e.toString()%>");
					window.location='androidCrmAccessAdd_P.jsp';
					</script>
<%
				}
				System.out.println("==============文件上传完成==========");
				/* 读取文件，写入tuxedo侧服务器 */
				FileReader fr = new FileReader(sSaveName);
				BufferedReader br = new BufferedReader(fr);   
				String imei_text="";
				String line = null;
				String paraAray2[] = new String[2];
				paraAray2[0] = filename;
				paraAray2[1] = imei_text;
				do {
					line = br.readLine();
					if (line==null) continue;       
					if (line.trim().equals("")) continue;   
					imei_text+=line+"\n"; 
					System.out.println("==imei_text== " + imei_text);
					if (imei_text.length()>=1000){
						paraAray2[1] = imei_text;
%>
						<wtc:service name="sbatchWrite" routerKey="region" 
							 routerValue="<%=regionCode%>" 
									retcode="errCode2" retmsg="errMsg2"  outnum="2" >
						<wtc:param value="<%=paraAray2[0]%>"/>
						<wtc:param value="<%=paraAray2[1]%>"/>
						</wtc:service>
						<wtc:array id="resultArr" scope="end" />
<%
						imei_text="";
					}
				}while (line!=null);        
				br.close();
				fr.close();
				paraAray2[1] = imei_text;
%>
				<wtc:service name="sbatchWrite" routerKey="region" 
					 routerValue="<%=regionCode%>" outnum="2" >
				<wtc:param value="<%=paraAray2[0]%>"/>
				<wtc:param value="<%=paraAray2[1]%>"/>
				</wtc:service>
				<wtc:array id="resultArr3" scope="end" />
<%



	String paraAray[] = new String[9];
	paraAray[0] = sysAccept;//
	paraAray[1] = "01";//
	paraAray[2] = opCode;//
	paraAray[3] = loginNo;//
	paraAray[4] = passWord;//
	paraAray[5] = "";//
	paraAray[6] = "";//
	paraAray[7] = input_group_id;//
	paraAray[8] = filename;//
%>		
				 
	<wtc:service name="sm018BatCfm" outnum="4" retmsg="msg_sm018BatCfm" retcode="code_sm018BatCfm" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
 		<wtc:param value="<%=paraAray[8]%>" />	
	</wtc:service>
	<wtc:array id="result1"   start="0"  length="1" scope="end"/>
	<wtc:array id="result2"   start="1"  length="3" scope="end"/>
<%

String opr_info = ""; 
	
if(code_sm018BatCfm.equals("000000")){
	
	if(result1.length>0){
		opr_info = result1[0][0];
	}

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	function goback(){
		removeCurrentTab();
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
			<td width="100%"><%=opr_info%></td>
		</tr>
	</table>
	<div class="title">
		<div id="title_zi">错误信息</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th>行号</th>
			<th>数据</th>
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
  		<input type="button" name="back" class="b_foot" value="关闭" onClick="goback()"  >
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
		rdShowMessageDialog("sm018BatCfm <%=code_sm018BatCfm%>,<%=msg_sm018BatCfm%>.");
		window.location = "androidCrmAccessAdd_P.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
}
%>