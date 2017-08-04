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
<%@ include file="/npage/common/serverip.jsp" %>
<%
		String opCode="m376";
		String opName="强制开关机恢复(批量)";
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ipAddr = realip; 
    System.out.println("=========================ipAddr==================   "+ipAddr);
		String opNote = "";
		
		String workNos = "";
		String[] workNosArr = new String[]{""};
		String wayFlag = "";
		String filename = "";
		String execResult = "0";
		int count_row = 0;
		String print_query = "";
		String ywtypes = "";
		String divshowmsg="";
		
		String servicesname="";
		String sopcodes="";
		
		String zhengjianleixing="";
		String zhengjianhaoma="";
		String yonghuleixing = "";
		
		String haomaleixing = "";
		
		String gestoresName = "";
		String gestoresAddr = "";
		String gestoresIdType = "";
		String gestoresIccId = "";
		
		String ipt_conPhoneNo = "";
		String ipt_trnPhoneNo = "";

			/* 使用文件上传 */
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
			/* 拼接文件名 */
				String iErrorNo ="";
				String sErrorMessage = " ";
				String sysAccept = "";
				sysAccept = seq;
			    System.out.println("# fm091.jsp  @@@@@@@@@@     - 流水："+sysAccept);
			    filename = regionCode + sysAccept + ".txt";
			    
			    String path_name = request.getRealPath("/npage/tmp/");
			    
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
					window.location='f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
					</script>
<%
				}
				try{ 
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
					
					print_query = mySmartUpload.getRequest().getParameter("print_query");
					ywtypes = mySmartUpload.getRequest().getParameter("ywtypes");
					zhengjianleixing = mySmartUpload.getRequest().getParameter("zhengjianleixing");
					zhengjianhaoma = mySmartUpload.getRequest().getParameter("zhengjianhaoma");
					yonghuleixing = mySmartUpload.getRequest().getParameter("yonghuleixing");
					//关于物联卡功能优化的需求 2016-12-23  liangyl
					haomaleixing = mySmartUpload.getRequest().getParameter("haomaleixing");
					if("1".equals(haomaleixing)){
						gestoresName = mySmartUpload.getRequest().getParameter("gestoresName");
						gestoresAddr = mySmartUpload.getRequest().getParameter("gestoresAddr");
						gestoresIdType = mySmartUpload.getRequest().getParameter("gestoresIdType");
						gestoresIdType = gestoresIdType.split("\\|")[0];
						gestoresIccId = mySmartUpload.getRequest().getParameter("gestoresIccId");
					}
					
					ipt_conPhoneNo = mySmartUpload.getRequest().getParameter("ipt_conPhoneNo");
					ipt_trnPhoneNo = mySmartUpload.getRequest().getParameter("ipt_trnPhoneNo");
					
					if (myFile.isMissing()){
%>
					<SCRIPT language=javascript>
					alert("请先选择要上传的文件");
					window.location='f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
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
					window.location='f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
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
					count_row ++ ;
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
System.out.println("====wanghfa====fe121_sub.jsp====se121Cfm==== filename = " + filename);

System.out.println("====wanghfa====fe121_sub.jsp====se121Cfm==== count_row= " + count_row);

if(count_row>500){
%>
	<script language="JavaScript">
		rdShowMessageDialog("数据记录不能超过500条，请重新上传！");
		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
}else{
	
	if("0".equals(ywtypes)) {
		divshowmsg="强制开关机恢复(批量)";
		servicesname="sm376Recover";
		opNote = loginNo+"进行强制开关机恢复(批量)操作";
		sopcodes="2355";
	}else if("1".equals(ywtypes)) {
		divshowmsg="强制预销(批量)";
		servicesname="sm376Account";
		opNote = loginNo+"进行强制预销(批量)操作";
		sopcodes="1216";
	}else if("2".equals(ywtypes)) {
		divshowmsg="单位客户预销(批量)";
		servicesname="sm376Account";
		opNote = loginNo+"进行强制单位客户预销(批量)操作";
		sopcodes="m407";
	}else if("3".equals(ywtypes)) {
		divshowmsg="强制销户(批量)";
		servicesname="sm376Account";
		opNote = loginNo+"进行强制销户(批量)操作";
		sopcodes="1218";
	}


System.out.println("-------hejwa----------sopcodes------------------->"+sopcodes);
System.out.println("-------hejwa----------ywtypes-------------------->"+ywtypes);
System.out.println("-------hejwa----------divshowmsg----------------->"+divshowmsg);
System.out.println("-------hejwa----------servicesname--------------->"+servicesname);
System.out.println("-------hejwa----------ipt_trnPhoneNo------------->"+ipt_trnPhoneNo);
System.out.println("-------hejwa----------ipt_conPhoneNo------------->"+ipt_conPhoneNo);



%>
<wtc:service name="<%=servicesname%>" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3" >
        <wtc:param value="<%=sysAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=sopcodes%>"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=filename%>"/>
        <wtc:param value="<%=path_name%>"/>
        <wtc:param value="<%=ipAddr%>"/>
        <wtc:param value="<%=opNote%>"/>
        <wtc:param value="<%=print_query%>"/>

        <% 
	        if("2".equals(ywtypes)) {
				%>
						<wtc:param value="<%=zhengjianleixing%>"/>
        		<wtc:param value="<%=zhengjianhaoma%>"/>
        	  	<wtc:param value="<%=ipt_trnPhoneNo%>"/>	
       		 	<wtc:param value="<%=ipt_conPhoneNo%>"/>
       		 	<wtc:param value="<%=haomaleixing%>"/>
       		 	<%if("1".equals(haomaleixing)) { %>
	       		 	<wtc:param value="<%=gestoresName%>"/>
	        	  	<wtc:param value="<%=gestoresAddr%>"/>	
	       		 	<wtc:param value="<%=gestoresIdType%>"/>
	       		 	<wtc:param value="<%=gestoresIccId%>"/>
       		 	<%} %>
				<%
			}
			else if("3".equals(ywtypes)){
				%>
				<wtc:param value="<%=yonghuleixing%>"/>
				<%
			}
        %>
        

</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end" />
	<wtc:array id="result2" start="2" length="1" scope="end" />
		
<%
System.out.println("=========================errCode================================   "+errCode);

if(errCode.equals("000000")){

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	function goback(){
		window.location = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
</script>
</head>
<body>
<form name="form1" id="form1" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div>
	<div class="title">
		<div id="title_zi"><%=divshowmsg%>-操作结果</div>
	</div>
			<table>

			<tr>
				<td WIDTH = '20%' ALIGN = 'center' class = 'blue'>操作流水</td>
				<td><%=sysAccept%>&nbsp;&nbsp<font class="orange">此流水用于在<%if("2".equals(ywtypes)){%>m407<%}else if("3".equals(ywtypes)){%>1218<%}else{%>m376<%}%>结果查询  查询使用</font></td>
			</tr>

		</table>
		<table>
			<%if(errCode.equals("000000")){
				if(result2.length > 0){
				%>
			<tr>
				<td colspan="2">导入成功的号码个数：<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>手机号码</th>
				<th>失败原因</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>

		</table>
	<table cellspacing="0">
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
		rdShowMessageDialog("操作失败！错误代码<%=errCode%>,错误原因<%=errMsg%>.");
		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
}
}
%>