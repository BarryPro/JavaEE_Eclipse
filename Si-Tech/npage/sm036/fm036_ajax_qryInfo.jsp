<%
  /*
   * 功能: 4G备卡卡号录入 m036
   * 版本: 1.0
   * 日期: 2014/1/13 
   * 作者: diling
   * 版权: si-tech
  */
%>
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
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sM036Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="4" >
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
				<div id="title_zi">4G备卡卡号录入查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th></th>
					<th>手机号码</th>
					<th>SIM卡类型</th>
					<th>SIM卡类型名称</th>
					<th>号码归属HLR</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='5'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					
					for(int i=0;i<ret.length;i++){
%>
					<tr align="center" id="row_<%=i%>">
						<td><input type="radio" id="qryRadio<%=i%>" name="qryRadio" value="" onclick="showSimNo()" v_hlrCode="<%=ret[i][3]%>" v_phoneNo="<%=ret[i][0]%>" v_simType="<%=ret[i][1]%>" ></td>
						<td><%=ret[i][0]%></td>
						<td><%=ret[i][1]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
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