<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 查询审批信息
　 * 版本: v3.0
　 * 日期: 2011-3-30
　 * 作者: ningtn
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ page import="com.sitech.boss.util.page.*"%>		
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
 		String opCode = "d288";
 		String opName = "提醒短信审批";

		String regionCode  = (String)session.getAttribute("regCode");
		String sAuditAccept = WtcUtil.repNull(request.getParameter("sAuditAccept"));
		String release_action = WtcUtil.repNull(request.getParameter("release_action"));
		System.out.println("===ningtn===" + sAuditAccept + "|" + release_action);
%>
		<wtc:service  name="sd288QryList"  routerKey="region" 
			 routerValue="<%=regionCode%>" outnum="20" retcode="retCode1" retmsg="retMsg1" > 
			<wtc:param value="<%=sAuditAccept%>"/>
			<wtc:param value="<%=release_action%>"/>
		</wtc:service> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		if("000000".equals(retCode1)){
			System.out.println("=====sd288_msgInfo.jsp调用sd288QryList成功");
		}else{
			System.out.println("=====sd288_msgInfo.jsp调用sd288QryList失败" + retCode1);
%>
			<script language="javascript">
				rdShowMessageDialog("查询审批信息失败。<%=retCode1%>：<%=retCode1%>");
				removeCurrentTab();
			</script>
<%
		}
%>
<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	</head>
<body>
	<div id="Operation_Table">
		<table cellspacing="0">
			<tr align="center">
				<th nowrap>操作批次流水</th>
				<th nowrap>发布区域</th>
				<th nowrap>短信模板代码</th>
				<th nowrap>短信模板名称</th>
				<th nowrap>提示类型</th>
				<th nowrap>提示序号</th>
				<th nowrap>发布类型</th>
				<th nowrap>有效标志</th>
				<th nowrap>渠道类型</th>
			</tr>
			<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else{
				for(int kk = 0; kk < sVerifyTypeArr.length; kk++){
				
					for(int j = 0; j < sVerifyTypeArr[kk].length; j++){
						System.out.println("===ningtn=== " + j + "|" + sVerifyTypeArr[kk][j]);
					}
%>
					<tr align="center">
						<td><%=sAuditAccept%>&nbsp;</td>
						<td><%=sVerifyTypeArr[kk][5]%>&nbsp;</td>
						<td><%=sVerifyTypeArr[kk][1]%>&nbsp;</td>
						<td><%=sVerifyTypeArr[kk][0]%>&nbsp;</td>
						<td><%=sVerifyTypeArr[kk][3]%>&nbsp;</td>
						<td><%=sVerifyTypeArr[kk][4]%>&nbsp;</td>
						<td><%=sVerifyTypeArr[kk][6]%>&nbsp;</td>
						<td><%=sVerifyTypeArr[kk][18]%>&nbsp;</td>
						<td><%=sVerifyTypeArr[kk][19]%>&nbsp;</td>
					</tr>
<%
				}
			}
			%>
		</table>
 	</div>
</body>
</html>  