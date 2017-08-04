<%
    /*************************************
    * 功  能: 工单采集信息查询  m196
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014/11/5
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String v_startTime = WtcUtil.repStr(request.getParameter("startTime"), "");
	String v_endTime = WtcUtil.repStr(request.getParameter("endTime"), "");
	String idIccid = WtcUtil.repStr(request.getParameter("idIccid"), "");
	String operNo = WtcUtil.repStr(request.getParameter("operNo"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String opNote = workNo+"进行了"+opCode+"[工单结果查询]操作";
	String startTime = v_startTime + "000000";
	String endTime = v_endTime + "000000";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="sM196Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="9">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=idIccid%>"/>
		<wtc:param value="<%=operNo%>"/>
		<wtc:param value="<%=startTime%>"/>
		<wtc:param value="<%=endTime%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">工单采集信息查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>客户姓名</th>
					<th>证件号码</th>
					<th>证件地址</th>
					<th>验证结果</th>
					<th>验证不通过类型</th>
					<th>验证结果文字描述</th>
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
						<td><%=ret[i][1]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
						<td><%=ret[i][5]%></td>
						<td><%if("".equals(ret[i][6])){%>无<%}else{%><%=ret[i][6]%><%}%></td>
						<td><%if("".equals(ret[i][7])){%>无<%}else{%><%=ret[i][7]%><%}%></td>
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