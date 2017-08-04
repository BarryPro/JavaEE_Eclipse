<%
  /*
   * 功能: m197·和家庭--爱家套餐业务办理查询 
   * 版本: 1.0
   * 日期: 2014/11/26 
   * 作者: diling
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String password = (String)session.getAttribute("password");
  String login_no = WtcUtil.repStr(request.getParameter("login_no"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String begin_time = WtcUtil.repStr(request.getParameter("begin_time"), "");
	String end_time = WtcUtil.repStr(request.getParameter("end_time"), "");
	String groupId = WtcUtil.repStr(request.getParameter("groupId"), "");
	String operChannel = WtcUtil.repStr(request.getParameter("operChannel"), "");
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
		
	<wtc:service name="sFamTVBusiQry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="13">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="1"/> <%/* 0-验证输入的有线电视卡号是否重复 1-查询相关信息*/%>
		<wtc:param value=""/>
		<wtc:param value="<%=begin_time%>"/>
		<wtc:param value="<%=end_time%>"/>
		<wtc:param value="<%=groupId%>"/>
		<wtc:param value="<%=operChannel%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set' >
				<tr>
					<th>地市名称</th>
					<th>区县名称</th>
					<th>营业厅名称</th>
					<th>营业员工号</th>
					<th>家长号码</th>
					<th>广电电视卡号</th>
					<th>操作名称</th>
					<th>原家长资费名称</th>
					<th>新家长资费名称</th>
					<th>操作时间</th>
					<th>资费生效时间</th>
					<th>资费结束时间</th>
					<th>省广电/移动</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='13'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
%>
					<tr align="center" id="row_<%=i%>">
						<td><%=ret[i][0]%></td>
						<td><%=ret[i][1]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
						<td><%=ret[i][4]%></td>
						<td><%=ret[i][5]%></td>
						<td><%=ret[i][6]%></td>
						<td><%=ret[i][7]%></td>
						<td><%=ret[i][8]%></td>
						<td><%=ret[i][9]%></td>
						<td><%=ret[i][10]%></td>
						<td><%=ret[i][11]%></td>
						<td><%=ret[i][12]%></td>
					</tr>
<%
					}
				}
%>
			</table>
		<%if(ret.length>0){%>
			<div id="footer">
        <input type="button" id="exclBtn" class="b_text" onClick="printTable(t1)" value="导出EXCEL">
        <input type="button" name="doClose" class="b_foot" value="关闭" onclick="removeCurrentTab();"> 
  		</div>
		<%}%>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />