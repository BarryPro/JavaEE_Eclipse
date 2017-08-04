<%
  /* 
   * 功能:营业厅与mac地址绑定配置批量导入的功能
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
String opCode = "8363";
String opName = "营业厅与mac地址绑定配置";
String workno = (String)session.getAttribute("workNo");
String chnSource="01";
String groupId =(String)session.getAttribute("groupId");//机构代码
String loginPass =(String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");
String sSaveName = request.getParameter("sSaveName");
String remark = request.getParameter("remark"); //备注信息
String filename = request.getParameter("filename"); 
String serverIp=realip.trim();
System.out.println("serverIp:"+serverIp);
String total_no = "";//操作成功数量
int flag = 0;
%>
	<wtc:service name="s8363Imp" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="1" >
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
		System.out.println("8363, 成功 !");
	}
	else
	{
		System.out.println("failed, 请检查 !");
		System.out.println("-------------8363--------s8363Imp服务");
	}

%>  	
<HEAD><TITLE>黑龙江BOSS-营业厅与mac地址绑定配置</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
function gohome()
{
	document.location.replace("f8363_import.jsp");
}

function seeInformation()
{
	var path = "<%=request.getContextPath()%>/npage/s8363/f8363error.jsp?fileName=<%=filename%>";
	window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
}
-->
</script>
</HEAD>
<BODY>
<FORM action="f8363_import.jsp" method=post name=form >
   <%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
		  <tbody> 
		  <tr> 
		    <td class="blue" width="10%">操作类型</td>
		    <td width="40%">营业厅与mac地址绑定配置</td>    
		  </tr>
		  </tbody> 
		</table>
		<table cellspacing="0">
		   <tbody> 
		    <tr > 
		      <td colspan="2">
		        <div align="center">营业厅与mac地址绑定配置。			
					  	<br> 					
<% 
						  	if (flag == 0){
%>
						  	成功数量：<%=total_no%>。
<% 
			           }else 
			           { 
%>
			           	错误代码：'<%=sReturnCode%>'。<br>错误信息：'<%=sErrorMessage%>'。
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




