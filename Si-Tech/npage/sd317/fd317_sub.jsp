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
		String opCode="d317";
		String opName="工号审核";
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ip = request.getRemoteAddr();
    System.out.println("=========================ip==================   "+ip);
		String selectGroupId = request.getParameter("groupId");
		System.out.println("=============selectGroupId==========   "+selectGroupId);
		String workNos = "";
		String[] workNosArr = new String[]{""};
		String wayFlag = "";
		String filename = "";
		if(selectGroupId != null && selectGroupId.length() > 0){
			/* 使用选择工号*/
			workNos = request.getParameter("val");
			System.out.println("=========================workNos==========   "+workNos);
			workNosArr = workNos.split(",");
			System.out.println("==========workNosArr.length============   "+workNosArr.length);
			if(workNosArr.length == 0){
				workNosArr = new String[]{""};
			}
			filename = "NoFile";
		}else{
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
			    System.out.println("# fd317_sub.jsp  @@@@@@@@@@     - 流水："+sysAccept);
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
					window.location='fd317.jsp';
					</script>
<%
				}
				try{ 
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
					if (myFile.isMissing()){
%>
					<SCRIPT language=javascript>
					alert("请先选择要上传的文件");
					window.location='fd317.jsp';
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
					window.location='fd317.jsp';
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
<%
		}
%>   
	  
<wtc:service name="sd317Cfm" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="Code" retmsg="Msg" outnum="3" >
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="d317"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=ip%>"/>
        <wtc:param value=""/>
        <wtc:params value="<%=workNosArr%>"/>
        <wtc:param value="<%=filename%>"/>
</wtc:service>
<wtc:array id="result"  scope="end"/>
<%
System.out.println("=========================Code================================   "+Code);
String retcode = Code;
String retmsg = Msg;
   if(retcode.equals("000000")){
   %>
      <script language='javascript'>
      	  rdShowMessageDialog("操作成功！",2);
      	  window.location = "fd317.jsp";
      </script>
      <%
   }else if(retcode.equals("d31799")){
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	function goback(){
		window.location = "fd317.jsp";
	}
</script>
</head>
<body>
<form name="form1" id="form1" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div>
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
  	int retLength = result.length;
  	for(int i = 0; i < retLength; i++ ){
	%>
			<tr>
				<td><%=result[i][0]%></td>
				<td><%=result[i][1]%></td>
				<td><%=result[i][2]%></td>
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
 }else{
%>
			<script language='javascript'>
      	  rdShowMessageDialog("错误信息：<%=retmsg%><br>错误代码：<%=retcode%>", 0);
      	  window.location = "fd317.jsp";
      </script>
<%
 }
%>

                                                         

   	
