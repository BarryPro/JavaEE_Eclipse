<%
  /* 
   * 功能: 批量恢复客户语音功能 d948
   * 版本: 1.0
   * 日期: 2011/06/23
   * 作者: huangrong
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
String opCode = "d948";
String opName = "批量恢复客户语音功能";
String workno = (String)session.getAttribute("workNo");
String chnSource="01";
String groupId =(String)session.getAttribute("groupId");//机构代码
String loginPass =(String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");
String sSaveName = request.getParameter("sSaveName");
String remark = request.getParameter("remark"); //备注信息
String filename = request.getParameter("filename"); 
String seled = request.getParameter("seled"); 
//System.out.println("seed====="+seled);
String serverIp=realip.trim();
String total_no = "";//操作成功数量
int flag = 0;
%>
	<wtc:service name="sd948Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="3" >
		<wtc:param value=" "/>
		<wtc:param value="<%=chnSource%>"/>		
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=loginPass%>"/>			
		<wtc:param value=" "/>
		<wtc:param value=" "/>		
		<wtc:param value="<%=remark%>"/>									
		<wtc:param value="<%=serverIp%>"/>			
		<wtc:param value="<%=filename%>"/>
		<wtc:param value="<%=seled%>"/>						
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
String retcode = sReturnCode;
String retmsg = sErrorMessage;
   if(retcode.equals("000000")){
   %>
      <script language='javascript'>
      	  rdShowMessageDialog("操作成功！",2);
      	  window.location = "fd948main.jsp";
      </script>
      <%
   }else if(retcode.equals("999999")){
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	function goback(){
		window.location = "fd948main.jsp";
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
      	  window.location = "fd948main.jsp";
      </script>
<%
 }
%>




