<%
    /*************************************
    * 功  能: BOSS垃圾短信平台白名单查询 m151
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014-8-12
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("password");
	String opNote = "营业前台"+workNo+"进行了"+opName+"操作";
%>

	<wtc:service name="sm151Cfm" routerKey="region" routerValue="<%=regionCode%>" 
		retcode="retCode" retmsg="retMsg" outnum="5">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passWord%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">BOSS垃圾短信平台白名单查询结果</div>
			</div>
			<table cellspacing="0" vColorTr='set'>
				<tr>
					<th>归属地市</th>
					<th>号码状态</th>
					<th>添加白名单时间</th>
					<th>白名单到期时间</th>
					<th>操作工号</th>
					<th>操作	</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='6'>");
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
							<td>
							<input type="button" id="delBtn" name="delBtn" class="b_foot" value="删除"  onClick="subDelInfo()" />  
							</td>
						</tr>
<%
					}
				}
%>
			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />