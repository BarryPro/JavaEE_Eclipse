<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String region_code = WtcUtil.repStr(request.getParameter("region_code"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String regCode = (String)session.getAttribute("regCode");
	String loginNo=(String)session.getAttribute("workNo"); 
	String workPwd = (String)session.getAttribute("password");
	//out.print("diling--region_code="+region_code);
		if(region_code.equals("ALL")){
		region_code="";
	} 
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sm144Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=region_code%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end" />
<%
    if("000000".equals(retCode)){
%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">集团订单配送信息查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th></th>
					<th>手机号码</th>
					<th>号码状态</th>
					<th>地市名称</th>
					<th>收件人姓名</th>
					<th>收件人联系电话</th>
					<th>订单地址</th>

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
						<td><input type="radio" id="qryRadio<%=i%>" name="qryRadio" value="" onclick="showSimNo()" v_phoneNo="<%=ret[i][0]%>" ></td>
						<td><%=ret[i][0]%></td>
						<td><%if(ret[i][1].equals("0")){out.print("换卡不换号");}else {out.print("换号");}%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
						<td><%=ret[i][4]%></td>
						<td><%=ret[i][5]%></td>

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