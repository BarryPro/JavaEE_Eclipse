<%
  /* 
   * 功能:垃圾短信与网管黑名单综合受理批量导入的功能
   * 版本: 1.0
   * 日期: 2011/06/1
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
String opCode = "6945";
String opName = "垃圾短信与网管黑名单综合受理";
String workno = (String)session.getAttribute("workNo");
String chnSource="01";
String groupId =(String)session.getAttribute("groupId");//机构代码
String loginPass =(String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");
String sSaveName = request.getParameter("sSaveName");
String remark = request.getParameter("remark"); //备注信息
String delayType = request.getParameter("delayType"); //huangrong add 获取延期标志 2011-6-29
System.out.println("========================="+delayType);
String seled = request.getParameter("seled"); 
//System.out.println("seed====="+seled);
String filename = request.getParameter("filename"); 
String serverIp=realip.trim();
System.out.println("serverIp:"+serverIp);
String total_no = "";//操作成功数量
int flag = 0;
%>
	<wtc:service name="s6947Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="1" >
		<wtc:param value="0"/>
		<wtc:param value="<%=chnSource%>"/>		
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=loginPass%>"/>			
		<wtc:param value=" "/>
		<wtc:param value=" "/>						
		<wtc:param value="<%=sSaveName%>"/>
		<wtc:param value="<%=serverIp%>"/>			
		<wtc:param value="<%=remark%>"/>		
		<wtc:param value="<%=delayType%>"/>			<!--huangrong add 延期标志入参 2011-6-29-->	
			<wtc:param value="<%=seled%>"/>						
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%  
	if(!sReturnCode.equals("000000")){
		flag = -1;
		System.out.println(" 错误信息 : " + sErrorMessage);
	}
	if (flag == 0)
	{	
		total_no = result[0][0];
	}
	else
	{
		System.out.println("failed, 请检查 !");
	}
String groupNameSql = "select group_name from dchngroupmsg where group_id='"+groupId+"'";
String groupName="";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode" retmsg="retMsg">
   <wtc:sql><%=groupNameSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="groupNameStr" scope="end"/>
<%
  if(retCode.equals("000000"))
  {
  	groupName=groupNameStr[0][0];
  }	
	else
	{
		System.out.println("failed, 请检查 !");
	}
%>  	
<HEAD><TITLE>黑龙江BOSS-批量添加垃圾短信与网管黑名单综合受理功能</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
function gohome()
{
	document.location.replace("f6945_3.jsp");
}

function seeInformation()
{
	var path = "<%=request.getContextPath()%>/npage/s1210/s6945Error.jsp?fileName=<%=filename%>";
	window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
}
-->
</script>
</HEAD>
<BODY>
<FORM action="f6945_3.jsp" method=post name=form>
   <%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
		  <tbody> 
		  <tr> 
		    <td class="blue" width="10%">操作类型</td>
		    <td width="40%">批量垃圾短信与网管黑名单综合受理功能</td>
		    <td class="blue" width="10%">部门</td>
		    <td width="40%"><%=groupName%></td>		    
		  </tr>
		  </tbody> 
		</table>
		<table cellspacing="0">
		   <tbody> 
		    <tr > 
		      <td colspan="2">
		        <div align="center">批量添加垃圾短信与网管黑名单综合受理功能。			
					  	<br> 					
<% 
						  	if (flag == 0){
%>
						  	成功数量：<%=total_no%>。
<% 
			           }else 
			           { 
%>
			           	错误代码：'<%=sReturnCode%>'。<br>错误信息：'<%=sErrorMessage%>'。");
<%
			           } 
%>					   
					     <br><input class="b_foot_long" name="seeInfo" type="button" value="失败信息查看" onClick="seeInformation()">
					 </div>
		      </td>
		    </tr>
		    </tbody> 
		</table>
		<table cellspacing="0">
		  <tbody> 
		  <tr id="footer"> 
		    <td align=center bgcolor="F5F5F5" width="100%"> 
		      <input class="b_foot" name="confirm" disabled type="submit" value="确认">
		      &nbsp; 		      
		      <input class="b_foot" name="goBack" type="reset" value="返回" onClick="gohome()">
		      &nbsp; 
		    </td>
		  </tr>
		  </tbody> 
		</table>
		<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>




