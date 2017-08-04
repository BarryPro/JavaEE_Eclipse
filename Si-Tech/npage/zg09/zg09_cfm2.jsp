<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
String opCode = "zg09";
String opName = "集团自由划拨文件导入";
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//机构代码
String nopass =(String)session.getAttribute("password");
String regionCode = orgcode.substring(0,2);
String op_code = "zg09"  ;
String remark = request.getParameter("remark");
String sSaveName = request.getParameter("sSaveName");
String filename = request.getParameter("filename"); 
String contract_no = request.getParameter("contract_no"); 
//System.out.println("seed====="+seled);
//String serverIp=request.getServerName();
String serverIp=realip.trim();
System.out.println("serverIp:"+serverIp);
//System.out.println("3_SBillItem:"+billitem);
String total_fee = "";
String total_no = "";
	int flag = 0;
%>
	<wtc:service name="szg09cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="21" >
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=orgcode%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=sSaveName%>"/>
		<wtc:param value="<%=serverIp%>"/>
 		<wtc:param value="<%=contract_no%>"/>	
	</wtc:service>
	<wtc:array id="result" start="0" length="5" scope="end"/>

 
	<wtc:array id="wrong_msg" start="17" length="4" scope="end"/>
 

<%   
	String s_wrong_phone="";
	String s_wrong_msg="";
	String s_wrong_phone_1="";
	String s_wrong_msg_1="";
	sReturnCode = result[0][0];
	sErrorMessage = result[0][1];
	if(!sReturnCode.equals("000000")){
		flag = -1;
		System.out.println(" 错误信息 : " + sErrorMessage);
	}
		
	if (flag == 0)
	{	
		total_fee = result[0][2];
		total_no = result[0][3];
	}
	else
	{
		//System.out.println("failed, 请检查 !");
	}
	
%>
<HEAD><TITLE>黑龙江BOSS-集团自由划拨文件导入</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
 
function gohome()
{
	document.location.replace("zg09_1.jsp");
}

 
</script>
</HEAD>
<BODY>
<FORM action="zg09_1.jsp" method=post name=form>
	
   <%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
		  <tbody> 
		  <tr> 
		    <td class="blue">操作类型</td>
		    <td >
		         集团自由划拨文件导入
		    </td>
		    <td ></td>
		    <td class="blue">部门 <%=orgcode%></td>
		  </tr>
		  </tbody> 
		</table> 
		<table cellspacing="0">
		   <tbody> 
		    <tr > 
		      <td colspan="2">
		        <div align="center">集团自由划拨文件导入配置完成。
					
					<br> 					
					   <% if (flag == 0){%>成功数量：<%=total_no%>。
		           <% } else { %>
		              错误代码：'<%=sReturnCode%>'。<br>错误信息：'<%=sErrorMessage%>'。");
		           <% } %>
				   <!--
				   <br>失败的号码，请检查<a target="_blank" href="/npage/tmp/<%=filename%>.err"><%=filename%>.err</a>文件。
				   -->
					      
						  
					 </div>
		      </td>
		    </tr>
		    </tbody> 
		</table>
		<!--xl add -->
		<%
			if(wrong_msg.length>0)
			{
				%>
					<table cellspacing="0" id="tabList">
				
				<tr>
					<th nowrap>错误号码</th>
					<th nowrap>错误信息</th>
				</tr>
				<%
					if(wrong_msg.length>0)
					{
						System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA wrong_msg.length is "+wrong_msg.length);
						for(int i=0;i<wrong_msg.length;i++)
						{
							s_wrong_phone=wrong_msg[i][0];
							s_wrong_msg=wrong_msg[i][1];
							s_wrong_phone_1=wrong_msg[i][2];
							s_wrong_msg_1=wrong_msg[i][3];
							 
							
							%>
								<%
									if(s_wrong_phone!=null &&s_wrong_msg!=null)
									{	
											%>
											<tr>
									<td><%=s_wrong_phone%></td>
									<td><%=s_wrong_msg%></td>
											</tr>
											<%
									}
									if(s_wrong_phone_1!=null &&s_wrong_msg_1!=null)
									{	
											%>
											<tr>
									<td><%=s_wrong_phone_1%></td>
									<td><%=s_wrong_msg_1%></td>
											</tr>
											<%
									}
								%>
								 
								 
								 
							<%
							
							 
						}	
					}
				%>
				 
			</table>
				<%
			}
		%>
		<table cellspacing="0">
		  <tbody> 
		  <tr id="footer"> 
		    <td align=center bgcolor="F5F5F5" width="100%"> 
		      <input class="b_foot" name=sure   type=submit disabled value=确认 onclick="doCfm()">
		      <input class="b_foot" name=reset type=reset value=返回 onClick="gohome()">
		      &nbsp; </td>
		  </tr>
		  </tbody> 
		</table>
		<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>



