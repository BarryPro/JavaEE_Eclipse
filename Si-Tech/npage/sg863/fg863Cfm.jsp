<%
	/* 
	 * version v2.0
	 * 开发商: si-tech
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<%
		request.setCharacterEncoding("GBK");
		
		String opCode = "g863";
		String opName = "批量处理差异特服";
		String pcode = request.getParameter("pcode");
		
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String sSaveName = request.getParameter("sSaveName");
		String filename = request.getParameter("filename"); 
		String current_timeNAME3 = request.getParameter("current_timeNAME3");
		String serverIp=realip.trim();
		
		String longString = "";
						System.out.println("==============文件上传完成==========");
				/* 读取文件，拼接报文 */
				FileReader fr = new FileReader(sSaveName);
				BufferedReader br = new BufferedReader(fr);   
				String line = br.readLine();
				int index = 0;
				while(line != null && !line.trim().equals("")){
            longString += line;
            index ++;
						line = br.readLine();
				}
				br.close();
				fr.close();
				
				if (index > 5000){
				%>
				    <script language="javascript">
        				rdShowMessageDialog("单次提交内容不能超过5000行，请修改后重新上传！");
        				window.location='f<%=opCode%>Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>'; 
        		</script>
				<%
				return;
				}
		
		
%>
<SCRIPT language=javascript>
  function goback(){
    window.location='f<%=opCode%>Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>';  
  }
</script>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept"/>
		<wtc:service name="sG863Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg" outnum="4" >
	      <wtc:param value="<%=sysAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="g863"/>
	      <wtc:param value="<%=loginNo%>"/>
	      <wtc:param value="<%=passWord%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=pcode%>"/>
	      <wtc:param value="<%=sSaveName%>"/>
	      <wtc:param value="<%=serverIp%>"/>
		</wtc:service>
		<wtc:array id="result1" start="0" length="2" scope="end"/>
		
		<wtc:array id="result2" start="2" length="2" scope="end"/>
<%

String retcode = Code;
String retmsg = Msg;

if("000000".equals(Code)){
String current_timeNAME4=new SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
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
					<td width="100%"><%=result1[0][0]%>条已变更成功，其余号码处理结果如下:<%=result1[0][1]%>条处理失败</td>
				</tr>
			</table>
			
			<div class="title">
				<div id="title_zi">提示</div>
			</div>
			
			<table cellspacing="0">
				<tr>
					<th>序号</th>
					<th>行内容</th>
					<th>处理结果</th>
				</tr>
<%
		  	int retLength = result2.length;
		  	
		  	for(int i = 0; i < retLength; i++ ){
%>
					  <tr>
							<td><%=(i+1)%></td>
							<td><%=result2[i][0]%></td>
							<td><%=result2[i][1]%></td>
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
				rdShowMessageDialog("服务调用失败！<%=retcode%>, <%=retmsg%>");
				goback();
		</script>
<%
}
%>
</html>