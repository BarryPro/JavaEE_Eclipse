
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
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

	<wtc:service name="sm139Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="20" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value=""/>
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
				<div id="title_zi">校园营销活动订单查询结果( 审核按钮和操作按钮同时置灰，表明此手机号码已经办理完业务；每个手机号码只能办理一个操作，即开户或换卡；审核失败的记录不再展示 )</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th>手机号码</th>
					<th>号码状态</th>
					<th>客户名称</th>
					<th>地市名称</th>
					<th>套餐信息</th>
					<th>配送信息</th>
					<th>图片</th>
					<th>审核结果</th>
					<th>操作</th>
					
					

					
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='7'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					
					for(int i=0;i<ret.length;i++){//空为未审核，0审核通过未办理业务
%>
					<tr align="center" id="row_<%=i%>">
						
						<td><%=ret[i][0]%></td>
						<td><%if(ret[i][1].equals("0")){out.print("换卡不换号");}else {out.print("换号");}%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
						<td><%if("0".equals(ret[i][16])){
										out.print("58元");
									}else if("1".equals(ret[i][16])){
										out.print("88元");
									}else if("2".equals(ret[i][16])){
										out.print("30元流量包");
									}
									%></td>
						<td><%=ret[i][17]%>&nbsp;&nbsp;<%=ret[i][18]%>&nbsp;&nbsp;<%=ret[i][19]%></td>
						<td><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='图片' onClick="getPhoto('<%=ret[i][5]%>','<%=ret[i][6]%>','<%=ret[i][15]%>')" ></td>
						
						<td align="left">
							<select id="selections<%=i%>" name="selections<%=i%>" <%if(ret[i][14].equals("1")){out.print(" disabled");}else { if(ret[i][4].equals("")){}else if(ret[i][4].equals("0")) {out.print(" disabled");}}%> onchange="changeSel(this)" line="<%=i%>">
							<option value="0">审核通过</option>
							<option value="1">审核不通过</option>
							</select>
							
							&nbsp;&nbsp;
							<input id="shenheinput<%=i%>" type="button" class="b_text" value="审核" onClick="shenhe('<%=ret[i][0]%>','<%=i%>','<%=ret[i][1]%>')" <%if(ret[i][14].equals("1")){out.print(" disabled");}else { if(ret[i][4].equals("")){}else if(ret[i][4].equals("0")) {out.print(" disabled");}}%>>
						</td>
						<td><input class="b_text" id="huanka<%=i%>" name="huanka<%=i%>" type="button" onClick="schangeCard('<%=ret[i][0]%>')" value="换卡"  <%if(ret[i][14].equals("1")){out.print(" disabled");}else { if(ret[i][4].equals("")){out.print(" disabled");} else if(ret[i][4].equals("0")) {if(ret[i][1].equals("0")){}else if(ret[i][1].equals("1")){out.print(" disabled");} }}%>>
							  <input class="b_text" id="kaihu<%=i%>" name="kaihu<%=i%>" type="button" onClick="sclickopr('<%=ret[i][0]%>','<%=ret[i][2]%>','<%=ret[i][7]%>','<%=ret[i][8]%>','<%=ret[i][9]%>','<%=ret[i][10]%>','<%=ret[i][11]%>','<%=ret[i][12]%>','<%=ret[i][13]%>')" value="开户"  <%if(ret[i][14].equals("1")){out.print(" disabled");}else { if(ret[i][4].equals("")){out.print(" disabled");} else if(ret[i][4].equals("0")) {if(ret[i][1].equals("0")){out.print(" disabled");}else if(ret[i][1].equals("1")){} }}%>>
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